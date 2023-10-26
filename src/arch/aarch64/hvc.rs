
use aarch64_cpu::{asm, asm::barrier, registers::*};
use tock_registers::interfaces::{ReadWriteable, Readable, Writeable};

use crate::arch::vcpu::VmCpuRegisters;
use crate::msr;

pub const HVC_SYS: usize = 0;

/// HVC SYS event
pub const HVC_SYS_BOOT: usize = 0;

#[repr(C)]
pub struct HvcDefaultMsg {
    pub fid: usize,
    pub event: usize,
}

#[inline(never)]
pub fn hvc_guest_handler(
    hvc_type: usize,
    event: usize,
    x0: usize,
    x1: usize,
    _x2: usize,
    _x3: usize,
    _x4: usize,
    _x5: usize,
    _x6: usize,
) -> Result<usize, ()> {
    match hvc_type {
        HVC_SYS => hvc_sys_handler(event, x0, x1),
        _ => {
            info!("hvc_guest_handler: unknown hvc type {} event {}", hvc_type, event);
            Err(())
        }
    }
}

pub fn run_guest_by_trap2el2(token: usize, regs_addr: usize) -> usize {
    // mode is in x7. hvc_type: HVC_SYS; event: HVC_SYS_BOOT
    hvc_call(token, regs_addr, 0, 0, 0, 0, 0, 0)
}

#[inline(never)]
fn hvc_sys_handler(event: usize, root_paddr: usize, vm_ctx_addr: usize) -> Result<usize, ()> {
    match event {
        HVC_SYS_BOOT => {
            init_hv(root_paddr, vm_ctx_addr);
            Ok(0)
        }

        _ => Err(()),
    }
}

#[inline(never)]
/// hvc handler for initial hv
/// x0: root_paddr, x1: vm regs context addr
fn init_hv(root_paddr: usize, vm_ctx_addr: usize) {
    // cptr_el2: Condtrols trapping to EL2 for accesses to the CPACR, Trace functionality 
    //           an registers associated with floating-point and Advanced SIMD execution.

    // ldr x2, =(0x30c51835)  // do not set sctlr_el2 as this value, some fields have no use.
    unsafe {
        core::arch::asm!("
            mov x3, xzr           // Trap nothing from EL1 to El2.
            msr cptr_el2, x3"
        );
    }
        // init_page_table(root_paddr);
    msr!(VTTBR_EL2, root_paddr);
        // init_sysregs();
    unsafe {
        core::arch::asm!("
            tlbi	alle2         // Flush tlb
            dsb	nsh
            isb"
        );
    }
    
    let regs: &VmCpuRegisters = unsafe{core::mem::transmute(vm_ctx_addr)};
    // set vm system related register
    regs.vm_system_regs.ext_regs_restore();
}

fn init_sysregs() {
    use aarch64_cpu::{
        asm::barrier,
        registers::{HCR_EL2, SCTLR_EL2},
    };
    HCR_EL2.write(    
        HCR_EL2::VM::Enable
            + HCR_EL2::RW::EL1IsAarch64,
    );  // Make irq and fiq do not route to el2
    SCTLR_EL2.modify(SCTLR_EL2::M::Enable 
                    + SCTLR_EL2::C::Cacheable 
                    + SCTLR_EL2::I::Cacheable); // other fields need? EIS, EOS?
    barrier::isb(barrier::SY);
}

fn init_page_table(vttbr: usize) {
    use aarch64_cpu::registers::{VTCR_EL2, VTTBR_EL2};
    /* 
    VTCR_EL2.write(
        VTCR_EL2::PS::PA_36B_64GB   //0b001 36 bits, 64GB.
            + VTCR_EL2::TG0::Granule4KB
            + VTCR_EL2::SH0::Inner
            + VTCR_EL2::ORGN0::NormalWBRAWA
            + VTCR_EL2::IRGN0::NormalWBRAWA
            + VTCR_EL2::SL0.val(0b01)
            + VTCR_EL2::T0SZ.val(64 - 36),
    );
    */
    msr!(VTTBR_EL2, vttbr);
}

/* 
// really need init MAIR_EL2 and TCR_EL2 ??
// MAIR_EL2: Provides the memory attribute encodings corresponding to the possible 
//           AttrIndx values in a Long-descriptor format translation table entry for 
//           stage 1 translations at EL2.
// TCR_EL2: When the Effective value of HCR_EL2.E2H is 0, this register controls stage 1 
//          of the EL2 translation regime, that supports a single VA range, translated 
//          using TTBR0_EL2.
unsafe fn init_hv_mmu(token: usize) {
    MAIR_EL2.write(
        MAIR_EL2::Attr0_Device::nonGathering_nonReordering_noEarlyWriteAck
            + MAIR_EL2::Attr1_Normal_Outer::WriteBack_NonTransient_ReadWriteAlloc
            + MAIR_EL2::Attr1_Normal_Inner::WriteBack_NonTransient_ReadWriteAlloc
            + MAIR_EL2::Attr2_Normal_Outer::NonCacheable
            + MAIR_EL2::Attr2_Normal_Inner::NonCacheable,
    );

    TCR_EL2.write(
        TCR_EL2::PS::Bits_48
            + TCR_EL2::SH0::Inner
            + TCR_EL2::TG0::KiB_4
            + TCR_EL2::ORGN0::WriteBack_ReadAlloc_WriteAlloc_Cacheable
            + TCR_EL2::IRGN0::WriteBack_ReadAlloc_WriteAlloc_Cacheable
            + TCR_EL2::T0SZ.val(64 - 39),
    );

    // barrier::isb(barrier::SY);
    // SCTLR_EL2.modify(SCTLR_EL2::M::Enable + SCTLR_EL2::C::Cacheable + SCTLR_EL2::I::Cacheable);
    // barrier::isb(barrier::SY);

}
*/

#[inline(never)]
fn hvc_call(
    x0: usize, 
    x1: usize, 
    x2: usize, 
    x3: usize, 
    x4: usize,
    x5: usize,
    x6: usize,
    x7: usize,
) -> usize {
    let r0;
    #[cfg(target_arch = "aarch64")]
    unsafe {
        core::arch::asm!(
            "hvc #0",
            inout("x0") x0 => r0,
            inout("x1") x1 => _,
            inout("x2") x2 => _,
            inout("x3") x3 => _,
            inout("x4") x4 => _,
            inout("x5") x5 => _,
            inout("x6") x6 => _,
            inout("x7") x7 => _,
            options(nomem, nostack)
        );
    }
    r0
}
