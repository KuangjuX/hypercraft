use cortex_a::registers::DAIF;
use tock_registers::interfaces::*;
use spin::Mutex;

use crate::arch::vm::Vm;
use crate::arch::vcpu::{Vcpu, VcpuState};
use crate::arch::current_cpu;
use crate::arch::vgic::vgic_set_hw_int;
use crate::arch::gic::{interrupt_arch_clear, interrupt_arch_enable};
use crate::arch::utils::{BitMap, BitAlloc256, BitAlloc4K, BitAlloc};

use arm_gic::GIC_PRIVATE_INT_NUM;

pub const INTERRUPT_IRQ_GUEST_TIMER: usize = 27;

pub static INTERRUPT_GLB_BITMAP: Mutex<BitMap<BitAlloc256>> = Mutex::new(BitAlloc4K::default());

pub fn interrupt_vm_inject(vm: Vm, vcpu: Vcpu, int_id: usize) {
    if vcpu.phys_id() != current_cpu().cpu_id {
        info!(
            "interrupt_vm_inject: Core {} failed to find target (VCPU {} VM {})",
            current_cpu().cpu_id,
            vcpu.id(),
            vm.id()
        );
        return;
    }

    let vgic = vm.vgic();
    if let Some(cur_vcpu) = current_cpu().active_vcpu.clone() {
        if cur_vcpu.vm_id() == vcpu.vm_id() {
            vgic.inject(vcpu, int_id);
            return;
        }
    }
    vcpu.push_int(int_id);
}

pub fn interrupt_arch_vm_register(vm: Vm, id: usize) {
    vgic_set_hw_int(vm, id);
}

pub fn interrupt_vm_register(vm: Vm, id: usize) -> bool {

    let mut glb_bitmap_lock = INTERRUPT_GLB_BITMAP.lock();
    if glb_bitmap_lock.get(id) != 0 && id >= GIC_PRIVATE_INT_NUM {
        info!("interrupt_vm_register: VM {} interrupts conflict, id = {}", vm.id(), id);
        return false;
    }

    interrupt_arch_vm_register(vm.clone(), id);
    vm.set_int_bit_map(id);
    // glb_bitmap_lock.set(id);
    true
}

pub fn interrupt_vm_remove(_vm: Vm, id: usize) {
    let mut glb_bitmap_lock = INTERRUPT_GLB_BITMAP.lock();
    // vgic and vm will be removed with struct vm
    glb_bitmap_lock.clear(id);
    // todo: for interrupt 16~31, need to check by vm config
    if id >= GIC_PRIVATE_INT_NUM {
        interrupt_cpu_enable(id, false);
    }
}

/// Mask (disable) interrupt from perspective of CPU
#[inline(always)]
pub fn cpu_interrupt_mask() {
    DAIF.write(DAIF::I::Masked)
}

/// Unmask (enable) interrupt from perspective of CPU
#[inline(always)]
pub fn cpu_interrupt_unmask() {
    DAIF.write(DAIF::I::Unmasked)
}

pub fn cpu_daif() -> u64 {
    DAIF.read(DAIF::I)
}

pub fn interrupt_cpu_enable(int_id: usize, en: bool) {
    interrupt_arch_enable(int_id, en);
}


pub fn interrupt_handler(int_id: usize) -> bool {
    if int_id >= 16 && int_id < 32 {
        if let Some(vcpu) = &current_cpu().active_vcpu {
            if let Some(active_vm) = vcpu.vm() {
                if active_vm.has_interrupt(int_id) {
                    interrupt_vm_inject(active_vm, vcpu.clone(), int_id);
                    return false;
                } else {
                    return true;
                }
            }
        }
    }
    for vcpu in current_cpu().vcpu_array.iter() {
        if let Some(vcpu) = vcpu {
            match vcpu.vm() {
                Some(vm) => {
                    if vm.has_interrupt(int_id) {
                        if vcpu.state() as usize == VcpuState::VcpuInv as usize {
                            return true;
                        }

                        interrupt_vm_inject(vm, vcpu.clone(), int_id);
                        return false;
                    }
                }
                None => {}
            }
        }
    }
    info!(
        "interrupt_handler: core {} receive unsupported int {}",
        current_cpu().cpu_id,
        int_id
    );
    true
}
