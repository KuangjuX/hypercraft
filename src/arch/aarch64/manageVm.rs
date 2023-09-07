use alloc::vec::Vec;
use fdt::*;

use crate::arch::vm::*;
use crate::arch::vmConfig::*;
use crate::arch::ipi::*;
use crate::arch::hvc::*;
use crate::arch::{
    current_cpu, active_vm_id, active_vm, active_vcpu_id, memset_safe, memcpy_safe
};
use crate::arch::vcpu::{vcpu_alloc, vcpu_remove, vcpu_run, vcpu_arch_init};
use crate::arch::cpu::cpu_idle;
use crate::arch::utils::{bit_extract, trace};
use crate::arch::gic::{gicc_clear_current_irq, interrupt_arch_clear};
use crate::arch::timer::sleep;
use crate::arch::{PlatOperation, Platform};
use crate::arch::psci::power_arch_vm_shutdown_secondary_cores;
use crate::arch::interrupt::interrupt_vm_remove;
use crate::arch::emu::{emu_remove_dev, emu_register_dev};
use crate::arch::platform::PLATFORM_CPU_NUM_MAX;
use crate::arch::vgic::{emu_intc_handler, emu_intc_init};

use arm_gic::GIC_SGIS_NUM;

#[cfg(feature = "ramdisk")]
pub static CPIO_RAMDISK: &'static [u8] = include_bytes!("../../image/net_rootfs.cpio");
#[cfg(not(feature = "ramdisk"))]
pub static CPIO_RAMDISK: &'static [u8] = &[];

#[derive(Copy, Clone)]
pub enum VmmEvent {
    VmmBoot,
    VmmReboot,
    VmmShutdown,
    VmmAssignCpu,
    VmmRemoveCpu,
}


pub fn vmm_shutdown_secondary_vm() {
    info!("Shutting down all VMs...");
}

/* Generate VM structure and push it to VM.
 *
 * @param[in]  vm_id: new added VM id.
 */
pub fn vmm_push_vm(vm_id: usize) {
    info!("vmm_push_vm: add vm {} on cpu {}", vm_id, current_cpu().cpu_id);
    if push_vm(vm_id).is_err() {
        return;
    }
    let vm = vm(vm_id).unwrap();
    let vm_cfg = match vm_cfg_entry(vm_id) {
        Some(vm_cfg) => vm_cfg,
        None => {
            info!("vmm_push_vm: failed to find config for vm {}", vm_id);
            return;
        }
    };
    vm.set_config_entry(Some(vm_cfg));
}

pub fn vmm_alloc_vcpu(vm_id: usize) {
    let vm = match vm(vm_id) {
        None => {
            panic!(
                "vmm_alloc_vcpu: on core {}, VM [{}] is not added yet",
                current_cpu().cpu_id,
                vm_id
            );
        }
        Some(vm) => vm,
    };

    for i in 0..vm.config().cpu_num() {
        if let Some(vcpu) = vcpu_alloc() {
            vcpu.init(vm.clone(), i);
            vm.push_vcpu(vcpu.clone());
        } else {
            info!("failed to allocte vcpu");
            return;
        }
    }

    info!(
        "VM {} init cpu: cores=<{}>, allocat_bits=<0b{:b}>",
        vm.id(),
        vm.config().cpu_num(),
        vm.config().cpu_allocated_bitmap()
    );
}

/* Finish cpu assignment before set up VM config.
 * Only VM0 will go through this function.
 *
 * @param[in] vm_id: new added VM id.
 */
pub fn vmm_set_up_cpu(vm_id: usize) {
    info!("vmm_set_up_cpu: set up vm {} on cpu {}", vm_id, current_cpu().cpu_id);
    let vm = match vm(vm_id) {
        None => {
            panic!(
                "vmm_set_up_cpu: on core {}, VM [{}] is not added yet",
                current_cpu().cpu_id,
                vm_id
            );
        }
        Some(vm) => vm,
    };

    vmm_alloc_vcpu(vm_id);

    let mut cpu_allocate_bitmap = vm.config().cpu_allocated_bitmap();
    let mut target_cpu_id = 0;
    let mut cpu_num = 0;
    while cpu_allocate_bitmap != 0 && target_cpu_id < PLATFORM_CPU_NUM_MAX {
        if cpu_allocate_bitmap & 1 != 0 {
            info!("vmm_set_up_cpu: vm {} physical cpu id {}", vm_id, target_cpu_id);
            cpu_num += 1;

            if target_cpu_id != current_cpu().cpu_id {
                let m = IpiVmmMsg {
                    vmid: vm_id,
                    event: VmmEvent::VmmAssignCpu,
                };
                if !ipi_send_msg(target_cpu_id, IpiType::IpiTVMM, IpiInnerMsg::VmmMsg(m)) {
                    info!("vmm_set_up_cpu: failed to send ipi to Core {}", target_cpu_id);
                }
            } else {
                vmm_cpu_assign_vcpu(vm_id);
            }
        }
        cpu_allocate_bitmap >>= 1;
        target_cpu_id += 1;
    }
    info!(
        "vmm_set_up_cpu: vm {} total physical cpu num {} bitmap {:#b}",
        vm_id,
        cpu_num,
        vm.config().cpu_allocated_bitmap()
    );

    // Waiting till others set up.
    info!(
        "vmm_set_up_cpu: on core {}, waiting VM [{}] to be set up",
        current_cpu().cpu_id,
        vm_id
    );
    while !vm.ready() {
        sleep(10);
    }
    info!("vmm_set_up_cpu: VM [{}] is ready", vm_id);
}

/* Init VM before boot.
 * Only VM0 will call this function.
 *
 * @param[in] vm_id: target VM id to boot.
 */
pub fn vmm_init_gvm(vm_id: usize) {
    // Before boot, we need to set up the VM config.
    if current_cpu().cpu_id == 0 || (active_vm_id() == 0 && active_vm_id() != vm_id) {
        vmm_push_vm(vm_id);

        vmm_set_up_cpu(vm_id);

        vmm_setup_config(vm_id);
    } else {
        error!(
            "VM[{}] Core {} should not init VM [{}]",
            active_vm_id(),
            current_cpu().cpu_id,
            vm_id
        );
    }
}

/* Boot Guest VM.
 *
 * @param[in] vm_id: target VM id to boot.
 */
pub fn vmm_boot_vm(vm_id: usize) {
    let phys_id = vm_interface_get_cpu_id(vm_id);
    // info!(
    //     "vmm_boot_vm: current_cpu {} target vm {} get phys_id {}",
    //     current_cpu().cpu_id,
    //     vm_id,
    //     phys_id
    // );
    if phys_id != current_cpu().cpu_id {
        let m = IpiVmmMsg {
            vmid: vm_id,
            event: VmmEvent::VmmBoot,
        };
        if !ipi_send_msg(phys_id, IpiType::IpiTVMM, IpiInnerMsg::VmmMsg(m)) {
            info!("vmm_boot_vm: failed to send ipi to Core {}", phys_id);
        }
    } else {
        match current_cpu().vcpu_array.pop_vcpu_through_vmid(vm_id) {
            None => {
                panic!(
                    "vmm_boot_vm: VM[{}] does not have vcpu on Core {}",
                    vm_id,
                    current_cpu().cpu_id
                );
            }
            Some(vcpu) => {
                gicc_clear_current_irq(true);
                // TODO: try to use `wakeup` (still bugs when booting multi-shared-core VM using wakeup)
                current_cpu().scheduler().yield_to(vcpu);
                vmm_boot();
            }
        };
    }
}

/**
 * Reboot target vm according to arguments
 *
 * @param arg force ~ (31, 16) ~ [soft shutdown or hard shutdown]
 *            vmid ~ (15, 0) ~ [target vm id]
 */
pub fn vmm_reboot_vm(arg: usize) {
    let vm_id = bit_extract(arg, 0, 16);
    let force = bit_extract(arg, 16, 16) != 0;
    let cur_vm = active_vm().unwrap();

    info!("vmm_reboot VM [{}] force:{}", vm_id, force);

    if force {
        if cur_vm.id() == vm_id {
            vmm_reboot();
        } else {
            let cpu_trgt = vm_interface_get_cpu_id(vm_id);
            let m = IpiVmmMsg {
                vmid: vm_id,
                event: VmmEvent::VmmReboot,
            };
            if !ipi_send_msg(cpu_trgt, IpiType::IpiTVMM, IpiInnerMsg::VmmMsg(m)) {
                info!("vmm_reboot_vm: failed to send ipi to Core {}", cpu_trgt);
            }
        }
        return;
    }

    let msg = HvcManageMsg {
        fid: HVC_VMM,
        event: HVC_VMM_REBOOT_VM,
        vm_id,
    };
    if !hvc_send_msg_to_vm(vm_id, &HvcGuestMsg::Manage(msg)) {
        info!("vmm_reboot_vm: failed to notify VM 0");
    }
}

/* Reset vm os at current core.
 *
 * @param[in] vm : target VM structure to be reboot.
 */
pub fn vmm_reboot() {
    let vm = active_vm().unwrap();
    // If running MVM, reboot the whole system.
    if vm.id() == 0 {
        vmm_shutdown_secondary_vm();
        sys_reboot();
    }

    // Reset GVM.
    let vcpu = current_cpu().active_vcpu.clone().unwrap();
    info!("VM [{}] reset...", vm.id());
    power_arch_vm_shutdown_secondary_cores(vm.clone());
    info!(
        "Core {} (VM [{}] vcpu {}) shutdown ok",
        current_cpu().cpu_id,
        vm.id(),
        active_vcpu_id()
    );

    // Clear memory region.
    for idx in 0..vm.mem_region_num() {
        info!(
            "Core {} (VM [{}] vcpu {}) reset mem region start {:x} size {:x}",
            current_cpu().cpu_id,
            vm.id(),
            active_vcpu_id(),
            vm.pa_start(idx),
            vm.pa_length(idx)
        );
        memset_safe(vm.pa_start(idx) as *mut u8, 0, vm.pa_length(idx));
    }

    // Reset image.
    if !vmm_init_image(vm.clone()) {
        panic!("vmm_reboot: vmm_init_image failed");
    }

    // Reset ivc arg.
    vm_interface_set_ivc_arg(vm.id(), 0);
    vm_interface_set_ivc_arg_ptr(vm.id(), 0);

    interrupt_arch_clear();
    vcpu_arch_init(vm.clone(), vm.vcpu(0).unwrap());
    vcpu.reset_context();

    vmm_load_image_from_mvm(vm);
}

pub fn vmm_load_image_from_mvm(vm: Vm) {
    let vm_id = vm.id();
    let msg = HvcManageMsg {
        fid: HVC_CONFIG,
        event: HVC_CONFIG_UPLOAD_KERNEL_IMAGE,
        vm_id,
    };
    // info!("mediated_blk_write send msg to vm0");
    if !hvc_send_msg_to_vm(0, &HvcGuestMsg::Manage(msg)) {
        info!("vmm_load_image_from_mvm: failed to notify VM 0");
    }
}

/* Get current VM id.
 *
 * @param[in] id_ipa : vm id ipa.
 */
pub fn get_vm_id(id_ipa: usize) -> bool {
    let vm = active_vm().unwrap();
    let id_pa = vm_ipa2pa(vm.clone(), id_ipa);
    if id_pa == 0 {
        info!("illegal id_pa {:x}", id_pa);
        return false;
    }
    unsafe {
        *(id_pa as *mut usize) = vm.id();
    }
    true
}

#[repr(C)]
struct VMInfo {
    pub id: u32,
    pub vm_name: [u8; NAME_MAX_LEN],
    pub vm_type: u32,
    pub vm_state: u32,
}

#[repr(C)]
struct VMInfoList {
    pub vm_num: usize,
    pub info_list: [VMInfo; VM_NUM_MAX],
}

/* List VM info in hypervisor.
 *
 * @param[in] vm_info_ipa : vm info list ipa.
 */
pub fn vmm_list_vm(vm_info_ipa: usize) -> Result<usize, ()> {
    #[cfg(feature = "update")]
    info!("Rust-Shyper list vm");
    let vm_info_pa = vm_ipa2pa(active_vm().unwrap(), vm_info_ipa);
    if vm_info_pa == 0 {
        info!("illegal vm_info_ipa {:x}", vm_info_ipa);
        return Err(());
    }

    let vm_info = unsafe { &mut *(vm_info_pa as *mut VMInfoList) };

    // Get VM num.
    vm_info.vm_num = vm_num();

    for (idx, vmid) in vm_id_list().iter().enumerate() {
        let vm_cfg = match vm_cfg_entry(*vmid) {
            Some(vm_cfg) => vm_cfg,
            None => {
                info!("Failed to get VM config entry for VM[{}]", *vmid);
                continue;
            }
        };
        // Get VM State.
        let vm_state = vm_interface_get_state(*vmid);

        vm_info.info_list[idx].id = *vmid as u32;
        vm_info.info_list[idx].vm_state = vm_state as u32;

        let vm_name_u8: Vec<u8> = vm_cfg.vm_name().as_bytes().to_vec();
        memcpy_safe(
            vm_info.info_list[idx].vm_name.as_ptr() as *const _ as *const u8,
            vm_name_u8.as_ptr(),
            NAME_MAX_LEN,
        );
        vm_info.info_list[idx].vm_name[vm_name_u8.len()] = 0;
    }
    Ok(0)
}

pub fn vmm_ipi_handler(msg: &IpiMessage) {
    match msg.ipi_message {
        IpiInnerMsg::VmmMsg(vmm) => match vmm.event {
            VmmEvent::VmmBoot => {
                vmm_boot_vm(vmm.vmid);
            }
            VmmEvent::VmmReboot => {
                vmm_reboot();
            }
            VmmEvent::VmmAssignCpu => {
                info!(
                    "vmm_ipi_handler: core {} receive assign vcpu request for vm[{}]",
                    current_cpu().cpu_id,
                    vmm.vmid
                );
                vmm_cpu_assign_vcpu(vmm.vmid);
            }
            VmmEvent::VmmRemoveCpu => {
                info!(
                    "vmm_ipi_handler: core {} remove vcpu for vm[{}]",
                    current_cpu().cpu_id,
                    vmm.vmid
                );
                vmm_cpu_remove_vcpu(vmm.vmid);
            }
            _ => {
                todo!();
            }
        },
        _ => {
            info!("vmm_ipi_handler: illegal ipi type");
            return;
        }
    }
}

pub fn vmm_remove_vm(vm_id: usize) {
    if vm_id == 0 {
        warn!("Rust-Shyper do not support remove vm0");
        return;
    }

    let vm = match vm(vm_id) {
        None => {
            info!("vmm_remove_vm: vm[{}] not exist", vm_id);
            return;
        }
        Some(vm) => vm,
    };

    // vcpu
    vmm_remove_vcpu(vm.clone());
    // reset vm interface
    vm_interface_reset(vm_id);
    // free mem
    for idx in 0..vm.region_num() {
        memset_safe(vm.pa_start(idx) as *mut u8, 0, vm.pa_length(idx));
        mem_vm_region_free(vm.pa_start(idx), vm.pa_length(idx));
    }
    // emu dev
    vmm_remove_emulated_device(vm.clone());
    // passthrough dev
    vmm_remove_passthrough_device(vm.clone());
    // clear async task list
    remove_vm_async_task(vm_id);
    // async used info
    remove_async_used_info(vm_id);
    // remove vm: page table / mmio / vgic will be removed with struct vm
    vmm_remove_vm_list(vm_id);
    // remove vm cfg
    vm_cfg_remove_vm_entry(vm_id);
    // remove vm unilib
    // crate::lib::unilib::unilib_fs_remove(vm_id);
    info!("remove vm[{}] successfully", vm_id);
}

fn vmm_remove_vm_list(vm_id: usize) {
    let vm = remove_vm(vm_id);
    vm.clear_list();
}

pub fn vmm_cpu_remove_vcpu(vmid: usize) {
    let vcpu = current_cpu().vcpu_array.remove_vcpu(vmid);
    if let Some(vcpu) = vcpu {
        // remove vcpu from scheduler
        current_cpu().scheduler().sleep(vcpu);
    }
    if current_cpu().vcpu_array.vcpu_num() == 0 {
        gicc_clear_current_irq(true);
        cpu_idle();
    }
}

fn vmm_remove_vcpu(vm: Vm) {
    for idx in 0..vm.cpu_num() {
        let vcpu = vm.vcpu(idx).unwrap();
        // remove vcpu from VCPU_LIST
        vcpu_remove(vcpu.clone());
        if vcpu.phys_id() == current_cpu().cpu_id {
            vmm_cpu_remove_vcpu(vm.id());
        } else {
            let m = IpiVmmMsg {
                vmid: vm.id(),
                event: VmmEvent::VmmRemoveCpu,
            };
            if !ipi_send_msg(vcpu.phys_id(), IpiType::IpiTVMM, IpiInnerMsg::VmmMsg(m)) {
                warn!("vmm_remove_vcpu: failed to send ipi to Core {}", vcpu.phys_id());
            }
        }
    }
}

fn vmm_remove_emulated_device(vm: Vm) {
    let config = vm.config().emulated_device_list();
    for (idx, emu_dev) in config.iter().enumerate() {
        // mmio / vgic will be removed with struct vm
        if !emu_dev.emu_type.removable() {
            warn!("vmm_remove_emulated_device: cannot remove device {}", emu_dev.emu_type);
            return;
        }
        emu_remove_dev(vm.id(), idx, emu_dev.base_ipa, emu_dev.length);
        // info!(
        //     "VM[{}] removes emulated device: id=<{}>, name=\"{}\", ipa=<0x{:x}>",
        //     vm.id(),
        //     idx,
        //     emu_dev.emu_type,
        //     emu_dev.base_ipa
        // );
    }
}

fn vmm_remove_passthrough_device(vm: Vm) {
    for irq in vm.config().passthrough_device_irqs() {
        if irq > GIC_SGIS_NUM {
            interrupt_vm_remove(vm.clone(), irq);
            // info!("VM[{}] remove irq {}", vm.id(), irq);
        }
    }
}

pub fn vmm_cpu_assign_vcpu(vm_id: usize) {
    let cpu_id = current_cpu().cpu_id;
    if current_cpu().assigned() {
        debug!("vmm_cpu_assign_vcpu vm[{}] cpu {} is assigned", vm_id, cpu_id);
    }

    // let cpu_config = vm(vm_id).config().cpu;
    let vm = vm(vm_id).unwrap();
    let cfg_master = vm.config().cpu_master();
    let cfg_cpu_num = vm.config().cpu_num();
    let cfg_cpu_allocate_bitmap = vm.config().cpu_allocated_bitmap();

    if cfg_cpu_num != cfg_cpu_allocate_bitmap.count_ones() as usize {
        panic!(
            "vmm_cpu_assign_vcpu: VM[{}] cpu_num {} not match cpu_allocated_bitmap {:#b}",
            vm_id, cfg_cpu_num, cfg_cpu_allocate_bitmap
        );
    }

    info!(
        "vmm_cpu_assign_vcpu: vm[{}] cpu {} cfg_master {} cfg_cpu_num {} cfg_cpu_allocate_bitmap {:#b}",
        vm_id, cpu_id, cfg_master, cfg_cpu_num, cfg_cpu_allocate_bitmap
    );

    // Judge if current cpu is allocated.
    if (cfg_cpu_allocate_bitmap & (1 << cpu_id)) != 0 {
        let vcpu = match vm.select_vcpu2assign(cpu_id) {
            None => panic!("core {} vm {} cannot find proper vcpu to assign", cpu_id, vm_id),
            Some(vcpu) => vcpu,
        };
        if vcpu.id() == 0 {
            info!("* Core {} is assigned => vm {}, vcpu {}", cpu_id, vm_id, vcpu.id());
        } else {
            info!("Core {} is assigned => vm {}, vcpu {}", cpu_id, vm_id, vcpu.id());
        }
        current_cpu().vcpu_array.append_vcpu(vcpu);
    }

    if cfg_cpu_num == vm.cpu_num() {
        vm.set_ready(true);
    }
}

pub fn vmm_boot() {
    if current_cpu().assigned() && active_vcpu_id() == 0 {
        // active_vm().unwrap().set_migration_state(false);
        info!("Core {} start running", current_cpu().cpu_id);
        vcpu_run(false);
    } else {
        // If there is no available vm(vcpu), just go idle
        info!("Core {} idle", current_cpu().cpu_id);
        cpu_idle();
    }
}

pub fn vmm_load_image(vm: Vm, bin: &[u8]) {
    let size = bin.len();
    let config = vm.config();
    let load_ipa = config.kernel_load_ipa();
    for (idx, region) in config.memory_region().iter().enumerate() {
        if load_ipa < region.ipa_start || load_ipa + size > region.ipa_start + region.length {
            continue;
        }

        let offset = load_ipa - region.ipa_start;
        info!(
            "VM {} loads kernel: ipa=<0x{:x}>, pa=<0x{:x}>, size=<{}K>",
            vm.id(),
            load_ipa,
            vm.pa_start(idx) + offset,
            size / 1024
        );
        if trace() && vm.pa_start(idx) + offset < 0x1000 {
            panic!("illegal addr {:x}", vm.pa_start(idx) + offset);
        }
        let dst = unsafe { core::slice::from_raw_parts_mut((vm.pa_start(idx) + offset) as *mut u8, size) };
        dst.clone_from_slice(bin);
        return;
    }
    panic!("vmm_load_image: Image config conflicts with memory config");
}

pub fn vmm_init_image(vm: Vm) -> bool {
    let vm_id = vm.id();
    let config = vm.config();

    if config.kernel_load_ipa() == 0 {
        info!("vmm_init_image: kernel load ipa is null");
        return false;
    }

    vm.set_entry_point(config.kernel_entry_point());

    // Only load MVM kernel image "L4T" from binding.
    // Load GVM kernel image from shyper-cli, you may check it for more information.
    if config.os_type == VmType::VmTOs {
        match vm.config().kernel_img_name() {
            Some(name) => {
                /* 
                #[cfg(feature = "tx2")]
                if name == "L4T" {
                    info!("MVM {} loading Image", vm.id());
                    vmm_load_image(vm.clone(), include_bytes!("../../image/L4T"));
                } else if name == "Image_vanilla" {
                    info!("VM {} loading default Linux Image", vm.id());
                    #[cfg(feature = "static-config")]
                    vmm_load_image(vm.clone(), include_bytes!("../../image/Image_vanilla"));
                    #[cfg(not(feature = "static-config"))]
                    info!("*** Please enable feature `static-config`");
                } else {
                    warn!("Image {} is not supported", name);
                }
                #[cfg(feature = "pi4")]
                if name.is_empty() {
                    panic!("kernel image name empty")
                } else {
                    vmm_load_image(vm.clone(), include_bytes!("../../image/Image_pi4_5.4.83_tlb"));
                }
                #[cfg(feature = "qemu")]
                */
                if name.is_empty() {
                    panic!("kernel image name empty")
                } else {
                    // vmm_load_image(vm.clone(), include_bytes!("../../image/Image_vanilla"));
                    // set the right image path.
                    vmm_load_image(vm.clone(), include_bytes!("./image/Image_vanilla"));
                }
            }
            None => {
                // nothing to do, its a dynamic configuration
            }
        }
    }

    if config.device_tree_load_ipa() != 0 {
        // Init dtb for Linux.
        if vm_id == 0 {
            // Init dtb for MVM.
            use crate::SYSTEM_FDT;
            let offset = config.device_tree_load_ipa() - config.memory_region()[0].ipa_start;
            info!("MVM[{}] dtb addr 0x{:x}", vm_id, vm.pa_start(0) + offset);
            vm.set_dtb((vm.pa_start(0) + offset) as *mut fdt::myctypes::c_void);
            unsafe {
                let src = SYSTEM_FDT.get().unwrap();
                let len = src.len();
                let dst = core::slice::from_raw_parts_mut((vm.pa_start(0) + offset) as *mut u8, len);
                dst.clone_from_slice(&src);
                vmm_setup_fdt(vm.clone());
            }
        } else {
            // Init dtb for GVM.
            match create_fdt(config.clone()) {
                Ok(dtb) => {
                    let offset = config.device_tree_load_ipa() - vm.config().memory_region()[0].ipa_start;
                    info!("GVM[{}] dtb addr 0x{:x}", vm.id(), vm.pa_start(0) + offset);
                    memcpy_safe((vm.pa_start(0) + offset) as *const u8, dtb.as_ptr(), dtb.len());
                }
                _ => {
                    panic!("vmm_setup_config: create fdt for vm{} fail", vm.id());
                }
            }
        }
    } else {
        info!(
            "VM {} id {} device tree load ipa is not set",
            vm_id,
            vm.config().vm_name()
        );
    }

    // ...
    // Todo: support loading ramdisk from MVM shyper-cli.
    // ...
    if config.ramdisk_load_ipa() != 0 {
        info!("VM {} use ramdisk CPIO_RAMDISK", vm_id);
        let offset = config.ramdisk_load_ipa() - config.memory_region()[0].ipa_start;
        let len = CPIO_RAMDISK.len();
        let dst = unsafe { core::slice::from_raw_parts_mut((vm.pa_start(0) + offset) as *mut u8, len) };
        dst.clone_from_slice(CPIO_RAMDISK);
    }

    true
}


fn vmm_init_emulated_device(vm: Vm) -> bool {
    let config = vm.config().emulated_device_list();

    for (idx, emu_dev) in config.iter().enumerate() {
        match emu_dev.emu_type {
            EmuDeviceTGicd => {
                vm.set_intc_dev_id(idx);
                emu_register_dev(
                    EmuDeviceTGicd,
                    vm.id(),
                    idx,
                    emu_dev.base_ipa,
                    emu_dev.length,
                    emu_intc_handler,
                );
                emu_intc_init(vm.clone(), idx);
            }
            EmuDeviceTShyper => {
                if !shyper_init(vm.clone(), emu_dev.base_ipa, emu_dev.length) {
                    return false;
                }
            }
            _ => {
                warn!("vmm_init_emulated_device: unknown emulated device");
                return false;
            }
        }
        info!(
            "VM {} registers emulated device: id=<{}>, name=\"{}\", ipa=<0x{:x}>",
            vm.id(),
            idx,
            emu_dev.emu_type,
            emu_dev.base_ipa
        );
    }

    true
}

fn vmm_init_memory(vm: Vm) -> bool {
    let result = mem_page_alloc();
    let vm_id = vm.id();
    let config = vm.config();
    let mut vm_mem_size: usize = 0; // size for pages

    if let Ok(pt_dir_frame) = result {
        vm.set_pt(pt_dir_frame);
        vm.set_mem_region_num(config.memory_region().len());
    } else {
        info!("vmm_init_memory: page alloc failed");
        return false;
    }

    for vm_region in config.memory_region() {
        let pa = mem_vm_region_alloc(vm_region.length);
        vm_mem_size += vm_region.length;

        if pa == 0 {
            info!("vmm_init_memory: vm memory region is not large enough");
            return false;
        }

        info!(
            "VM {} memory region: ipa=<0x{:x}>, pa=<0x{:x}>, size=<0x{:x}>",
            vm_id, vm_region.ipa_start, pa, vm_region.length
        );
        vm.pt_map_range(vm_region.ipa_start, vm_region.length, pa, PTE_S2_NORMAL, vm_id == 0);

        vm.add_region(VmPa {
            pa_start: pa,
            pa_length: vm_region.length,
            offset: vm_region.ipa_start as isize - pa as isize,
        });
    }
    vm_if_init_mem_map(vm_id, (vm_mem_size + PAGE_SIZE - 1) / PAGE_SIZE);

    true
}

pub fn vmm_setup_config(vm_id: usize) {
    let vm = match vm(vm_id) {
        Some(vm) => vm,
        None => {
            panic!("vmm_setup_config vm id {} doesn't exist", vm_id);
        }
    };

    let config = match vm_cfg_entry(vm_id) {
        Some(config) => config,
        None => {
            panic!("vmm_setup_config vm id {} config doesn't exist", vm_id);
        }
    };

    info!(
        "vmm_setup_config VM[{}] name {:?} current core {}",
        vm_id,
        config.name.unwrap(),
        current_cpu().cpu_id
    );

    if vm_id >= VM_NUM_MAX {
        panic!("vmm_setup_config: out of vm");
    }
    if !vmm_init_memory(vm.clone()) {
        panic!("vmm_setup_config: vmm_init_memory failed");
    }

    if !vmm_init_image(vm.clone()) {
        panic!("vmm_setup_config: vmm_init_image failed");
    }

    if !vmm_init_emulated_device(vm.clone()) {
        panic!("vmm_setup_config: vmm_init_emulated_device failed");
    }
    /*
    if !vmm_init_passthrough_device(vm.clone()) {
        panic!("vmm_setup_config: vmm_init_passthrough_device failed");
    }
    if !vmm_init_iommu_device(vm.clone()) {
        panic!("vmm_setup_config: vmm_init_iommu_device failed");
    }
    */
    add_async_used_info(vm_id);
    info!("VM {} id {} init ok", vm.id(), vm.config().name.unwrap());
}

pub unsafe fn vmm_setup_fdt(vm: Vm) {
    use fdt::*;
    let config = vm.config();
    match vm.dtb() {
        Some(dtb) => {
            let mut memory_region = Vec::new();
            for r in config.memory_region() {
                memory_region.push(region {
                    ipa_start: r.ipa_start as u64,
                    length: r.length as u64,
                });
            }
            fdt_set_memory(dtb, memory_region.len() as u64, memory_region.as_ptr(), "memory@50000000\0".as_ptr());
            // FDT+TIMER
            fdt_add_timer(dtb, 0x8);
            // FDT+BOOTCMD
            fdt_set_bootcmd(dtb, config.cmdline.as_ptr());
            
            if config.emulated_device_list().len() > 0 {
                for emu_cfg in config.emulated_device_list() {
                    match emu_cfg.emu_type {
                        EmuDeviceTGicd => {
                            fdt_setup_gic(
                                dtb,
                                Platform::GICD_BASE as u64,
                                Platform::GICC_BASE as u64,
                                emu_cfg.name.unwrap().as_ptr(),
                            );
                        }
                        EmuDeviceTShyper => {
                            fdt_add_vm_service(
                                dtb,
                                emu_cfg.irq_id as u32 - 0x20,
                                emu_cfg.base_ipa as u64,
                                emu_cfg.length as u64,
                            );
                        }
                        _ => {
                            todo!();
                        }
                    }
                }
            }
            info!("after dtb size {}", fdt_size(dtb));
        }
        None => {
            info!("None dtb");
        }
    }
}