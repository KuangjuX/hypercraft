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

use crate::arch::vgic::Vgic;
use crate::arch::utils::in_range;

use crate::arch::current_cpu;

pub const EMU_DEV_NUM_MAX: usize = 32;
pub static EMU_DEVS_LIST: Mutex<Vec<EmuDevEntry>> = Mutex::new(Vec::new());

#[derive(Clone)]
pub enum EmuDevs {
    Vgic(Arc<Vgic>),
    None,
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
    EmuDeviceTGicd = 1,
    EmuDeviceTShyper = 6,
}

impl Display for EmuDeviceType {
    fn fmt(&self, f: &mut Formatter<'_>) -> core::fmt::Result {
        match self {
            EmuDeviceType::EmuDeviceTGicd => write!(f, "interrupt controller"),
            EmuDeviceType::EmuDeviceTShyper => write!(f, "device shyper"),
        }
    }
}

impl EmuDeviceType {
    pub fn removable(&self) -> bool {
        match *self {
            EmuDeviceType::EmuDeviceTGicd => true,
            _ => false,
        }
    }
}

impl EmuDeviceType {
    pub fn from_usize(value: usize) -> EmuDeviceType {
        match value {
            1 => EmuDeviceType::EmuDeviceTGicd,
            6 => EmuDeviceType::EmuDeviceTShyper,
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
            let handler = emu_dev.handler;
            let id = emu_dev.id;
            drop(emu_devs_list);
            return handler(id, emu_ctx);
        }
    }
    info!(
        "emu_handler: no emul handler for Core {} data abort ipa 0x{:x}",
        current_cpu().cpu_id,
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
