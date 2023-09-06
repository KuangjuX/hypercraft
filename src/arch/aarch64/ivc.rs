
use crate::arch::{current_cpu, active_vm, PageSize};
use crate::arch::vm::*;

pub fn ivc_update_mq(receive_ipa: usize, cfg_ipa: usize) -> bool {
    let vm = active_vm().unwrap();
    let vm_id = vm.id();
    let receive_pa = vm_ipa2pa(vm.clone(), receive_ipa);
    let cfg_pa = vm_ipa2pa(vm, cfg_ipa);

    if receive_pa == 0 {
        info!("ivc_update_mq: invalid receive_pa");
        return false;
    }

    vm_interface_set_ivc_arg(vm_id, cfg_pa);
    vm_interface_set_ivc_arg_ptr(vm_id, cfg_pa - PageSize::Size4K as usize  / VM_NUM_MAX);

    let idx = 0;
    let val = vm_id;
    current_cpu().set_gpr(idx, val);
    true
}