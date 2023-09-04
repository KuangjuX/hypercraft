use cortex_a::registers::DAIF;
use tock_registers::interfaces::*;

use crate::arch::vm::Vm;
use crate::arch::vcpu::{Vcpu, VcpuState};
use crate::arch::cpu::current_cpu;

pub fn interrupt_vm_inject(vm: Vm, vcpu: Vcpu, int_id: usize) {
    let vgic = vm.vgic();
    // println!("int {}, cur vcpu vm {}, trgt vcpu vm {}", int_id, active_vm_id(), vcpu.vm_id());
    // restore_vcpu_gic(current_cpu().active_vcpu.clone(), vcpu.clone());
    if let Some(cur_vcpu) = current_cpu().active_vcpu.clone() {
        if cur_vcpu.vm_id() == vcpu.vm_id() {
            vgic.inject(vcpu, int_id);
            return;
        }
    }
    vcpu.push_int(int_id);
    // save_vcpu_gic(current_cpu().active_vcpu.clone(), vcpu.clone());
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