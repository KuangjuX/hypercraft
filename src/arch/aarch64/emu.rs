// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use alloc::sync::Arc;
use alloc::vec::Vec;
use core::fmt::{Display, Formatter};

use spin::Mutex;

use crate::arch::Vgic;
use crate::device::{
    virtio_blk_notify_handler, virtio_console_notify_handler, virtio_mediated_blk_notify_handler,
    virtio_net_notify_handler, VirtioMmio,
};
use crate::kernel::current_cpu;
use crate::lib::in_range;

pub const EMU_DEV_NUM_MAX: usize = 32;
pub static EMU_DEVS_LIST: Mutex<Vec<EmuDevEntry>> = Mutex::new(Vec::new());

#[derive(Clone)]
pub enum EmuDevs {
    Vgic(Arc<Vgic>),
    VirtioBlk(VirtioMmio),
    VirtioNet(VirtioMmio),
    VirtioConsole(VirtioMmio),
    None,
}

impl EmuDevs {
    pub fn migrate_emu_devs(&mut self, src_dev: EmuDevs) {
        match self {
            EmuDevs::Vgic(vgic) => {
                if let EmuDevs::Vgic(src_vgic) = src_dev {
                    vgic.save_vgic(src_vgic);
                } else {
                    println!("EmuDevs::migrate_save: illegal src dev type for vgic");
                }
            }
            EmuDevs::VirtioBlk(mmio) => {
                if let EmuDevs::VirtioBlk(src_mmio) = src_dev {
                    mmio.save_mmio(
                        src_mmio.clone(),
                        if src_mmio.dev().mediated() {
                            Some(virtio_mediated_blk_notify_handler)
                        } else {
                            Some(virtio_blk_notify_handler)
                        },
                    );
                } else {
                    println!("EmuDevs::migrate_save: illegal src dev type for virtio blk");
                }
            }
            EmuDevs::VirtioNet(mmio) => {
                if let EmuDevs::VirtioNet(src_mmio) = src_dev {
                    mmio.save_mmio(src_mmio, Some(virtio_net_notify_handler));
                } else {
                    println!("EmuDevs::migrate_save: illegal src dev type for virtio net");
                }
            }
            EmuDevs::VirtioConsole(mmio) => {
                if let EmuDevs::VirtioConsole(src_mmio) = src_dev {
                    mmio.save_mmio(src_mmio, Some(virtio_console_notify_handler));
                } else {
                    println!("EmuDevs::migrate_save: illegal src dev type for virtio console");
                }
            }
            EmuDevs::None => {}
        }
    }
}

pub struct EmuContext {
    pub address: usize,
    pub width: usize,
    pub write: bool,
    pub sign_ext: bool,
    pub reg: usize,
    pub reg_width: usize,
}

pub struct EmuDevEntry {
    pub emu_type: EmuDeviceType,
    pub vm_id: usize,
    pub id: usize,
    pub ipa: usize,
    pub size: usize,
    pub handler: EmuDevHandler,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum EmuDeviceType {
    EmuDeviceTConsole = 0,
    EmuDeviceTGicd = 1,
    EmuDeviceTGPPT = 2,
    EmuDeviceTVirtioBlk = 3,
    EmuDeviceTVirtioNet = 4,
    EmuDeviceTVirtioConsole = 5,
    EmuDeviceTShyper = 6,
    EmuDeviceTVirtioBlkMediated = 7,
    EmuDeviceTIOMMU = 8,
}

impl Display for EmuDeviceType {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        match self {
            EmuDeviceType::EmuDeviceTConsole => write!(f, "console"),
            EmuDeviceType::EmuDeviceTGicd => write!(f, "interrupt controller"),
            EmuDeviceType::EmuDeviceTGPPT => write!(f, "partial passthrough interrupt controller"),
            EmuDeviceType::EmuDeviceTVirtioBlk => write!(f, "virtio block"),
            EmuDeviceType::EmuDeviceTVirtioNet => write!(f, "virtio net"),
            EmuDeviceType::EmuDeviceTVirtioConsole => write!(f, "virtio console"),
            EmuDeviceType::EmuDeviceTShyper => write!(f, "device shyper"),
            EmuDeviceType::EmuDeviceTVirtioBlkMediated => write!(f, "medaited virtio block"),
            EmuDeviceType::EmuDeviceTIOMMU => write!(f, "IOMMU"),
        }
    }
}

impl EmuDeviceType {
    pub fn removable(&self) -> bool {
        match *self {
            EmuDeviceType::EmuDeviceTGicd
            | EmuDeviceType::EmuDeviceTGPPT
            | EmuDeviceType::EmuDeviceTVirtioBlk
            | EmuDeviceType::EmuDeviceTVirtioNet
            | EmuDeviceType::EmuDeviceTVirtioConsole => true,
            _ => false,
        }
    }
}

impl EmuDeviceType {
    pub fn from_usize(value: usize) -> EmuDeviceType {
        match value {
            0 => EmuDeviceType::EmuDeviceTConsole,
            1 => EmuDeviceType::EmuDeviceTGicd,
            2 => EmuDeviceType::EmuDeviceTGPPT,
            3 => EmuDeviceType::EmuDeviceTVirtioBlk,
            4 => EmuDeviceType::EmuDeviceTVirtioNet,
            5 => EmuDeviceType::EmuDeviceTVirtioConsole,
            6 => EmuDeviceType::EmuDeviceTShyper,
            7 => EmuDeviceType::EmuDeviceTVirtioBlkMediated,
            8 => EmuDeviceType::EmuDeviceTIOMMU,
            _ => panic!("Unknown  EmuDeviceType value: {}", value),
        }
    }
}

pub type EmuDevHandler = fn(usize, &EmuContext) -> bool;

// TO CHECK
pub fn emu_handler(emu_ctx: &EmuContext) -> bool {
    let ipa = emu_ctx.address;
    let emu_devs_list = EMU_DEVS_LIST.lock();

    for emu_dev in &*emu_devs_list {
        let active_vcpu = current_cpu().active_vcpu.clone().unwrap();
        if active_vcpu.vm_id() == emu_dev.vm_id && in_range(ipa, emu_dev.ipa, emu_dev.size - 1) {
            // if current_cpu().id == 2 {
            //     println!("emu dev {:#?} handler", emu_dev.emu_type);
            // }
            let handler = emu_dev.handler;
            let id = emu_dev.id;
            drop(emu_devs_list);
            return handler(id, emu_ctx);
        }
    }
    println!(
        "emu_handler: no emul handler for Core {} data abort ipa 0x{:x}",
        current_cpu().id,
        ipa
    );
    return false;
}

pub fn emu_register_dev(
    emu_type: EmuDeviceType,
    vm_id: usize,
    dev_id: usize,
    address: usize,
    size: usize,
    handler: EmuDevHandler,
) {
    let mut emu_devs_list = EMU_DEVS_LIST.lock();
    if emu_devs_list.len() >= EMU_DEV_NUM_MAX {
        panic!("emu_register_dev: can't register more devs");
    }

    for emu_dev in &*emu_devs_list {
        if vm_id != emu_dev.vm_id {
            continue;
        }
        if in_range(address, emu_dev.ipa, emu_dev.size - 1) || in_range(emu_dev.ipa, address, size - 1) {
            panic!("emu_register_dev: duplicated emul address region: prev address 0x{:x} size 0x{:x}, next address 0x{:x} size 0x{:x}", emu_dev.ipa, emu_dev.size, address, size);
        }
    }

    emu_devs_list.push(EmuDevEntry {
        emu_type,
        vm_id,
        id: dev_id,
        ipa: address,
        size,
        handler,
    });
}

pub fn emu_remove_dev(vm_id: usize, dev_id: usize, address: usize, size: usize) {
    let mut emu_devs_list = EMU_DEVS_LIST.lock();
    for (idx, emu_dev) in emu_devs_list.iter().enumerate() {
        if vm_id == emu_dev.vm_id && emu_dev.ipa == address && emu_dev.id == dev_id && emu_dev.size == size {
            emu_devs_list.remove(idx);
            return;
        }
    }
    panic!(
        "emu_remove_dev: emu dev not exist address 0x{:x} size 0x{:x}",
        address, size
    );
}
