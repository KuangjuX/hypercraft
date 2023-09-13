use spin::Mutex;
use spinlock::SpinNoIrq;

use arm_gic::gic_v2::{GicDistributor, GicHypervisorInterface, GicCpuInterface};
use arm_gic::GIC_LIST_REGS_NUM;

use crate::arch::current_cpu;
use crate::arch::utils::bit_extract;

pub static GICD: Option<&SpinNoIrq<GicDistributor>> = None;
pub static GICC: Option<&GicCpuInterface> = None;
pub static GICH: Option<&GicHypervisorInterface> = None;

pub const GICD_BASE: usize = 0x08000000;
pub const GICC_BASE: usize = 0x08010000;
pub const GICH_BASE: usize = 0x08030000;
pub const GICV_BASE: usize = 0x08040000;


// GICC BITS
pub const GICC_CTLR_EN_BIT: usize = 0x1;
pub const GICC_CTLR_EOIMODENS_BIT: usize = 1 << 9;

pub static GIC_LRS_NUM: Mutex<usize> = Mutex::new(0);


#[repr(C)]
#[derive(Debug, Clone)]
pub struct GicState {
    pub saved_hcr: u32,
    saved_eisr: [u32; GIC_LIST_REGS_NUM / 32],
    saved_elrsr: [u32; GIC_LIST_REGS_NUM / 32],
    saved_apr: u32,
    pub saved_lr: [u32; GIC_LIST_REGS_NUM],
    pub saved_ctlr: u32,
}
impl GicState {
    pub fn default() -> GicState {
        GicState {
            saved_hcr: 0,
            saved_eisr: [0; GIC_LIST_REGS_NUM / 32],
            saved_elrsr: [0; GIC_LIST_REGS_NUM / 32],
            saved_apr: 0,
            saved_lr: [0; GIC_LIST_REGS_NUM],
            saved_ctlr: 0,
        }
    }

    pub fn save_state(&mut self) { 
        if let Some(gich) = GICH {
            self.saved_hcr = gich.get_hcr();
            self.saved_apr = gich.get_apr();
            for i in 0..(GIC_LIST_REGS_NUM / 32) {
                self.saved_eisr[i] = gich.get_eisr_by_idx(i);
                self.saved_elrsr[i] = gich.get_elrsr_by_idx(i);
            }
            for i in 0..gich.get_lrs_num() {
                if self.saved_elrsr[0] & 1 << i == 0 {
                    self.saved_lr[i] = gich.get_lr_by_idx(i);
                } else {
                    self.saved_lr[i] = 0;
                }
            }
        } else {
            warn!("No available gich in save_state!")
        }
        if let Some(gicc) = GICC {
            self.saved_ctlr = gicc.get_ctlr();
        }else {
            warn!("No available gicc in save_state!")
        }
    }

    pub fn restore_state(&self) {
        if let Some(gich) = GICH {
            gich.set_hcr(self.saved_hcr);
            gich.set_apr(self.saved_apr);
            for i in 0..gich.get_lrs_num() {
                gich.set_lr_by_idx(i, self.saved_lr[i]);
            }
        } else {
            warn!("No available gich in restore_state!")
        }
        if let Some(gicc) = GICC {
            gicc.set_ctlr(self.saved_ctlr);
        }else {
            warn!("No available gicc in restore_state!")
        }
    }

}

#[repr(C)]
#[repr(align(16))]
#[derive(Debug, Copy, Clone, Default)]
pub struct GicIrqState {
    pub id: u64,
    pub enable: u8,
    pub pend: u8,
    pub active: u8,
    pub priority: u8,
    pub target: u8,
}

pub fn gicc_get_current_irq() -> (usize, usize) {
    if let Some(gicc) = GICC {
        let iar = gicc.get_iar();
        let irq = iar as usize;
        current_cpu().current_irq = irq;
        let id = bit_extract(iar as usize, 0, 10);
        let src = bit_extract(iar as usize, 10, 3);
        (id, src)
    } else {
        warn!("No available gicc for gicc_get_current_irq");
        (usize::MAX, usize::MAX)
    }
}

pub fn gicc_clear_current_irq(for_hypervisor: bool) {
    let irq = current_cpu().current_irq as u32;
    if irq == 0 {
        return;
    }
    if GICC.is_none() {
        warn!("No available GICC in gicc_clear_current_irq");
        return;
    }
    let gicc = GICC.unwrap();
    // let gicc = &GICC;
    gicc.set_eoi(irq);
    // gicc.EOIR.set(irq);
    if for_hypervisor {
        gicc.set_dir(irq);
    }
    let irq = 0;
    current_cpu().current_irq = irq;
}

pub fn gic_cpu_reset() {
    if GICC.is_none() {
        warn!("No available GICC in gic_cpu_reset");
        return;
    }
    if GICH.is_none() {
        warn!("No available GICH in gic_cpu_reset");
        return;
    }
    let gicc = GICC.unwrap();
    let gich = GICH.unwrap();
    gicc.init();
    gich.init();
}

pub fn gic_lrs() -> usize {
    *GIC_LRS_NUM.lock()
}

pub fn interrupt_arch_clear() {
    gic_cpu_reset();
    gicc_clear_current_irq(true);
}

pub fn interrupt_arch_enable(int_id: usize, en: bool) {
    if GICD.is_none() {
        warn!("No available GICH in interrupt_arch_enable");
        return;
    }

    let gicd = GICD.unwrap();
    let cpu_id = current_cpu().cpu_id;
    if en {
        gicd.lock().set_priority(int_id, 0x7f);
        gicd.lock().set_target_cpu(int_id, 1 << cpu_id);

        gicd.lock().set_enable(int_id, en);
    } else {
        gicd.lock().set_enable(int_id, en);
    }
}

#[derive(Copy, Clone, Debug)]
pub enum IrqState {
    IrqSInactive,
    IrqSPend,
    IrqSActive,
    IrqSPendActive,
}

impl IrqState {
    pub fn num_to_state(num: usize) -> IrqState {
        match num {
            0 => IrqState::IrqSInactive,
            1 => IrqState::IrqSPend,
            2 => IrqState::IrqSActive,
            3 => IrqState::IrqSPendActive,
            _ => panic!("num_to_state: illegal irq state"),
        }
    }

    pub fn to_num(&self) -> usize {
        match self {
            IrqState::IrqSInactive => 0,
            IrqState::IrqSPend => 1,
            IrqState::IrqSActive => 2,
            IrqState::IrqSPendActive => 3,
        }
    }
}
