// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use alloc::collections::BTreeMap;
use core::mem::size_of;

use spin::Mutex;

use crate::arch::config::*;
use crate::arch::manageVm::*;
use crate::arch::ipi::*;
use crate::arch::vm::*;
use crate::arch::utils::trace;
use crate::arch::interrupt::interrupt_vm_inject;
use crate::arch::ivc::ivc_update_mq;
use crate::arch::{current_cpu, active_vm, active_vm_id, memcpy_safe};
use crate::memory::PAGE_SIZE_4K;

pub static VM_STATE_FLAG: Mutex<usize> = Mutex::new(0);

pub static SHARE_MEM_LIST: Mutex<BTreeMap<usize, usize>> = Mutex::new(BTreeMap::new());

// If succeed, return 0.
const HVC_FINISH: usize = 0;

// share mem type
pub const LIVE_UPDATE_IMG: usize = 5;

// hvc_fid
// pub const HVC_SYS: usize = 0;
pub const HVC_VMM: usize = 1;
pub const HVC_IVC: usize = 2;
pub const HVC_MEDIATED: usize = 3;
pub const HVC_CONFIG: usize = 0x11;
pub const HVC_UNILIB: usize = 0x12;

// hvc_sys_event
/* 
pub const HVC_SYS_REBOOT: usize = 0;
pub const HVC_SYS_SHUTDOWN: usize = 1;
pub const HVC_SYS_UPDATE: usize = 3;
pub const HVC_SYS_TEST: usize = 4;
*/
// hvc_vmm_event
pub const HVC_VMM_LIST_VM: usize = 0;
pub const HVC_VMM_GET_VM_STATE: usize = 1;
pub const HVC_VMM_BOOT_VM: usize = 2;
pub const HVC_VMM_SHUTDOWN_VM: usize = 3;
pub const HVC_VMM_REBOOT_VM: usize = 4;
pub const HVC_VMM_GET_VM_DEF_CFG: usize = 5;
pub const HVC_VMM_GET_VM_CFG: usize = 6;
pub const HVC_VMM_SET_VM_CFG: usize = 7;
pub const HVC_VMM_GET_VM_ID: usize = 8;
pub const HVC_VMM_TRACE_VMEXIT: usize = 9;
pub const HVC_VMM_VM_REMOVE: usize = 16;

// hvc_ivc_event
pub const HVC_IVC_UPDATE_MQ: usize = 0;
pub const HVC_IVC_SEND_MSG: usize = 1;
pub const HVC_IVC_BROADCAST_MSG: usize = 2;
pub const HVC_IVC_INIT_KEEP_ALIVE: usize = 3;
pub const HVC_IVC_KEEP_ALIVE: usize = 4;
pub const HVC_IVC_ACK: usize = 5;
pub const HVC_IVC_GET_TIME: usize = 6;
pub const HVC_IVC_SHARE_MEM: usize = 7;
pub const HVC_IVC_SEND_SHAREMEM: usize = 0x10;
//共享内存通信
pub const HVC_IVC_GET_SHARED_MEM_IPA: usize = 0x11;
//用于VM获取共享内存IPA
pub const HVC_IVC_SEND_SHAREMEM_TEST_SPEED: usize = 0x12; //共享内存通信速度测试

// hvc_mediated_event
/*
pub const HVC_MEDIATED_DEV_APPEND: usize = 0x30;
pub const HVC_MEDIATED_DEV_NOTIFY: usize = 0x31;
pub const HVC_MEDIATED_DRV_NOTIFY: usize = 0x32;

pub const HVC_UNILIB_FS_INIT: usize = 0;
pub const HVC_UNILIB_FS_OPEN: usize = 1;
pub const HVC_UNILIB_FS_CLOSE: usize = 2;
pub const HVC_UNILIB_FS_READ: usize = 3;
pub const HVC_UNILIB_FS_WRITE: usize = 4;
pub const HVC_UNILIB_FS_LSEEK: usize = 5;
pub const HVC_UNILIB_FS_STAT: usize = 6;
pub const HVC_UNILIB_FS_UNLINK: usize = 7;
pub const HVC_UNILIB_FS_APPEND: usize = 0x10;
pub const HVC_UNILIB_FS_FINISHED: usize = 0x11;
*/

// hvc_config_event
pub const HVC_CONFIG_ADD_VM: usize = 0;
pub const HVC_CONFIG_DELETE_VM: usize = 1;
pub const HVC_CONFIG_CPU: usize = 2;
pub const HVC_CONFIG_MEMORY_REGION: usize = 3;
pub const HVC_CONFIG_EMULATED_DEVICE: usize = 4;
pub const HVC_CONFIG_PASSTHROUGH_DEVICE_REGION: usize = 5;
pub const HVC_CONFIG_PASSTHROUGH_DEVICE_IRQS: usize = 6;
pub const HVC_CONFIG_PASSTHROUGH_DEVICE_STREAMS_IDS: usize = 7;
pub const HVC_CONFIG_DTB_DEVICE: usize = 8;
pub const HVC_CONFIG_UPLOAD_KERNEL_IMAGE: usize = 9;

// Only for qemu
pub const HVC_IRQ: usize = 32 + 0x20;

#[repr(C)]
pub enum HvcGuestMsg {
    Default(HvcDefaultMsg),
    Manage(HvcManageMsg),
    UniLib(HvcUniLibMsg),
}

#[repr(C)]
pub struct HvcDefaultMsg {
    pub fid: usize,
    pub event: usize,
}

#[repr(C)]
pub struct HvcManageMsg {
    pub fid: usize,
    pub event: usize,
    pub vm_id: usize,
}

#[repr(C)]
pub struct HvcUniLibMsg {
    pub fid: usize,
    pub event: usize,
    pub vm_id: usize,
    pub arg_1: usize,
    pub arg_2: usize,
    pub arg_3: usize,
}

pub fn add_share_mem(mem_type: usize, base: usize) {
    let mut list = SHARE_MEM_LIST.lock();
    list.insert(mem_type, base);
}

pub fn get_share_mem(mem_type: usize) -> usize {
    let list = SHARE_MEM_LIST.lock();
    match list.get(&mem_type) {
        None => {
            panic!("there is not {} type share memory", mem_type);
        }
        Some(tup) => *tup,
    }
}

pub fn hvc_guest_handler(
    hvc_type: usize,
    event: usize,
    x0: usize,
    x1: usize,
    x2: usize,
    x3: usize,
    x4: usize,
    x5: usize,
    x6: usize,
) -> Result<usize, ()> {
    match hvc_type {
        // HVC_SYS => hvc_sys_handler(event, x0),
        HVC_VMM => hvc_vmm_handler(event, x0, x1),
        HVC_IVC => hvc_ivc_handler(event, x0, x1),
        //HVC_MEDIATED => hvc_mediated_handler(event, x0, x1),
        HVC_CONFIG => hvc_config_handler(event, x0, x1, x2, x3, x4, x5, x6),
        //HVC_UNILIB => hvc_unilib_handler(event, x0, x1, x2),
        _ => {
            info!("hvc_guest_handler: unknown hvc type {} event {}", hvc_type, event);
            Err(())
        }
    }
}

fn hvc_config_handler(
    event: usize,
    x0: usize,
    x1: usize,
    x2: usize,
    x3: usize,
    x4: usize,
    x5: usize,
    x6: usize,
) -> Result<usize, ()> {
    match event {
        HVC_CONFIG_ADD_VM => vm_cfg_add_vm(x0),
        HVC_CONFIG_DELETE_VM => vm_cfg_del_vm(x0),
        HVC_CONFIG_CPU => vm_cfg_set_cpu(x0, x1, x2, x3),
        HVC_CONFIG_MEMORY_REGION => vm_cfg_add_mem_region(x0, x1, x2),
        HVC_CONFIG_EMULATED_DEVICE => vm_cfg_add_emu_dev(x0, x1, x2, x3, x4, x5, x6),
        HVC_CONFIG_PASSTHROUGH_DEVICE_REGION => vm_cfg_add_passthrough_device_region(x0, x1, x2, x3),
        HVC_CONFIG_PASSTHROUGH_DEVICE_IRQS => vm_cfg_add_passthrough_device_irqs(x0, x1, x2),
        HVC_CONFIG_PASSTHROUGH_DEVICE_STREAMS_IDS => vm_cfg_add_passthrough_device_streams_ids(x0, x1, x2),
        HVC_CONFIG_DTB_DEVICE => vm_cfg_add_dtb_dev(x0, x1, x2, x3, x4, x5, x6),
        HVC_CONFIG_UPLOAD_KERNEL_IMAGE => vm_cfg_upload_kernel_image(x0, x1, x2, x3, x4),
        _ => {
            info!("hvc_config_handler unknown event {}", event);
            Err(())
        }
    }
}
/*
fn hvc_sys_handler(event: usize, x0: usize) -> Result<usize, ()> {
    match event {
        
        HVC_SYS_UPDATE => {
            mem_heap_region_reserve(UPDATE_IMG_BASE_ADDR, x0);
            update_request();
            Ok(0)
        }
        
        HVC_SYS_TEST => {
            let vm = active_vm().unwrap();
            crate::device::virtio_net_announce(vm);
            Ok(0)
        }

        _ => Err(()),
    }
}
*/
fn hvc_vmm_handler(event: usize, x0: usize, _x1: usize) -> Result<usize, ()> {
    match event {
        HVC_VMM_LIST_VM => vmm_list_vm(x0),
        HVC_VMM_GET_VM_STATE => {
            todo!();
        }
        HVC_VMM_BOOT_VM => {
            vmm_boot_vm(x0);
            Ok(HVC_FINISH)
        }
        HVC_VMM_SHUTDOWN_VM => {
            todo!();
        }
        HVC_VMM_REBOOT_VM => {
            vmm_reboot_vm(x0);
            Ok(HVC_FINISH)
        }
        HVC_VMM_GET_VM_ID => {
            get_vm_id(x0);
            Ok(HVC_FINISH)
        }
        HVC_VMM_VM_REMOVE => {
            vmm_remove_vm(x0);
            *VM_STATE_FLAG.lock() = 0;
            Ok(HVC_FINISH)
        }
        _ => {
            info!("hvc_vmm unknown event {}", event);
            Err(())
        }
    }
}

fn hvc_ivc_handler(event: usize, x0: usize, x1: usize) -> Result<usize, ()> {
    match event {
        HVC_IVC_UPDATE_MQ => {
            if ivc_update_mq(x0, x1) {
                Ok(HVC_FINISH)
            } else {
                Err(())
            }
        }
        HVC_IVC_SHARE_MEM => {
            let vm = active_vm().unwrap();
            let base = vm.share_mem_base();
            /*
            if x0 == LIVE_UPDATE_IMG {
                // hard code for pa 0x8a000000, x1 should be 0x8000000
                vm.pt_map_range(base, x1, 0x8a000000, PTE_S2_NORMAL, true);
            }
            */
            vm.add_share_mem_base(x1);
            add_share_mem(x0, base);
            info!(
                "VM{} add share mem type 0x{:x} base 0x{:x} len 0x{:x}",
                active_vm_id(),
                x0,
                base,
                x1
            );
            Ok(base)
        }
        _ => {
            info!("hvc_ivc_handler: unknown event {}", event);
            Err(())
        }
    }
}

/*
fn hvc_mediated_handler(event: usize, x0: usize, x1: usize) -> Result<usize, ()> {
    match event {
        HVC_MEDIATED_DEV_APPEND => mediated_dev_append(x0, x1),
        HVC_MEDIATED_DEV_NOTIFY => mediated_blk_notify_handler(x0),
        _ => {
            info!("unknown mediated event {}", event);
            return Err(());
        }
    }
}

fn hvc_unilib_handler(event: usize, x0: usize, x1: usize, x2: usize) -> Result<usize, ()> {
    match event {
        HVC_UNILIB_FS_INIT => unilib_fs_init(),
        HVC_UNILIB_FS_OPEN => unilib_fs_open(x0, x1, x2),
        HVC_UNILIB_FS_CLOSE => unilib_fs_close(x0),
        HVC_UNILIB_FS_READ => unilib_fs_read(x0, x1, x2),
        HVC_UNILIB_FS_WRITE => unilib_fs_write(x0, x1, x2),
        HVC_UNILIB_FS_LSEEK => unilib_fs_lseek(x0, x1, x2),
        HVC_UNILIB_FS_STAT => unilib_fs_stat(),
        HVC_UNILIB_FS_UNLINK => unilib_fs_unlink(x0, x1),
        HVC_UNILIB_FS_APPEND => unilib_fs_append(x0),
        HVC_UNILIB_FS_FINISHED => unilib_fs_finished(x0),
        _ => {
            info!("unknown mediated event {}", event);
            return Err(());
        }
    }
}
*/

pub fn hvc_send_msg_to_vm(vm_id: usize, guest_msg: &HvcGuestMsg) -> bool {
    let mut target_addr = 0;
    let mut arg_ptr_addr = vm_interface_ivc_arg_ptr(vm_id);
    let arg_addr = vm_interface_ivc_arg(vm_id);

    if arg_ptr_addr != 0 {
        arg_ptr_addr += PAGE_SIZE_4K as usize / VM_NUM_MAX;
        if arg_ptr_addr - arg_addr >= PAGE_SIZE_4K as usize  {
            vm_interface_set_ivc_arg_ptr(vm_id, arg_addr);
            target_addr = arg_addr;
        } else {
            vm_interface_set_ivc_arg_ptr(vm_id, arg_ptr_addr);
            target_addr = arg_ptr_addr;
        }
    }

    if target_addr == 0 {
        info!("hvc_send_msg_to_vm: target VM{} interface is not prepared", vm_id);
        return false;
    }

    if trace() && (target_addr < 0x1000 || (guest_msg as *const _ as usize) < 0x1000) {
        panic!(
            "illegal des addr {:x}, src addr {:x}",
            target_addr, guest_msg as *const _ as usize
        );
    }
    let (fid, event) = match guest_msg {
        HvcGuestMsg::Default(msg) => {
            memcpy_safe(
                target_addr as *const u8,
                msg as *const _ as *const u8,
                size_of::<HvcDefaultMsg>(),
            );
            (msg.fid, msg.event)
        }
        HvcGuestMsg::Manage(msg) => {
            memcpy_safe(
                target_addr as *const u8,
                msg as *const _ as *const u8,
                size_of::<HvcManageMsg>(),
            );
            (msg.fid, msg.event)
        }
        HvcGuestMsg::UniLib(msg) => {
            memcpy_safe(
                target_addr as *const u8,
                msg as *const _ as *const u8,
                size_of::<HvcUniLibMsg>(),
            );
            (msg.fid, msg.event)
        }
    };

    let cpu_trgt = vm_interface_get_cpu_id(vm_id);
    if cpu_trgt != current_cpu().cpu_id {
        // info!("cpu {} send hvc msg to cpu {}", current_cpu().id, cpu_trgt);
        let ipi_msg = IpiHvcMsg {
            src_vmid: 0,
            trgt_vmid: vm_id,
            fid,
            event,
        };
        if !ipi_send_msg(cpu_trgt, IpiType::IpiTHvc, IpiInnerMsg::HvcMsg(ipi_msg)) {
            info!(
                "hvc_send_msg_to_vm: Failed to send ipi message, target {} type {:#?}",
                cpu_trgt,
                IpiType::IpiTHvc
            );
        }
    } else {
        hvc_guest_notify(vm_id);
    }

    true
}

// notify current cpu's vcpu
pub fn hvc_guest_notify(vm_id: usize) {
    let vm = vm(vm_id).unwrap();
    match current_cpu().vcpu_array.pop_vcpu_through_vmid(vm_id) {
        None => {
            info!(
                "hvc_guest_notify: Core {} failed to find vcpu of VM {}",
                current_cpu().cpu_id,
                vm_id
            );
        }
        Some(vcpu) => {
            interrupt_vm_inject(vm, vcpu, HVC_IRQ);
        }
    };
}

pub fn hvc_ipi_handler(msg: &IpiMessage) {
    match &msg.ipi_message {
        IpiInnerMsg::HvcMsg(msg) => {
            if current_cpu().vcpu_array.pop_vcpu_through_vmid(msg.trgt_vmid).is_none() {
                info!(
                    "hvc_ipi_handler: Core {} failed to find vcpu of VM {}",
                    current_cpu().cpu_id,
                    msg.trgt_vmid
                );
                return;
            }

            match msg.fid {
                /*
                HVC_MEDIATED => {
                    hvc_guest_notify(msg.trgt_vmid);
                }
                */
                HVC_VMM => match msg.event {
                    _ => {}
                },
                HVC_CONFIG => match msg.event {
                    HVC_CONFIG_UPLOAD_KERNEL_IMAGE => {
                        hvc_guest_notify(msg.trgt_vmid);
                    }
                    _ => {
                        todo!();
                    }
                },
                /* 
                HVC_UNILIB => {
                    hvc_guest_notify(msg.trgt_vmid);
                }
                */
                _ => {
                    todo!();
                }
            }
        }
        _ => {
            info!("vgic_ipi_handler: illegal ipi");
            return;
        }
    }
}


pub fn hvc_init() {
    if !ipi_register(IpiType::IpiTHvc, hvc_ipi_handler) {
        panic!("hvc_init: failed to register hvc ipi {}", IpiType::IpiTHvc as usize)
    }
}

pub fn send_hvc_ipi(src_vmid: usize, trgt_vmid: usize, fid: usize, event: usize, trgt_cpuid: usize) {
    let ipi_msg = IpiHvcMsg {
        src_vmid,
        trgt_vmid,
        fid,
        event,
    };
    if !ipi_send_msg(trgt_cpuid, IpiType::IpiTHvc, IpiInnerMsg::HvcMsg(ipi_msg)) {
        info!(
            "send_hvc_ipi: Failed to send ipi message, target {} type {:#?}",
            0,
            IpiType::IpiTHvc
        );
    }
}

