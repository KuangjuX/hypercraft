// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use alloc::string::String;
use alloc::sync::Arc;
use alloc::vec::Vec;

use spin::Mutex;

// use crate::board::*;
use crate::arch::vmConfig::*;
use crate::arch::vm::*;
use crate::arch::emu::EmuDeviceType;
use crate::arch::hvc::HVC_IRQ;

use crate::arch::{Platform, PlatOperation};
//::{GICD_BASE, GICV_BASE, GICC_BASE, UART_0_ADDR};

/* 
use super::{
    VmConfigEntry, VmCpuConfig, VmEmulatedDeviceConfig, VmImageConfig, VmMemoryConfig, VmPassthroughDeviceConfig,
    VmRegion, vm_cfg_set_config_name, PassthroughRegion, vm_cfg_add_vm_entry, VmEmulatedDeviceConfigList,
    VMDtbDevConfigList,
};
*/
#[rustfmt::skip]
pub fn mvm_config_init() {
    vm_cfg_set_config_name("qemu-default");

    // vm0 emu
    let emu_dev_config = vec![
        VmEmulatedDeviceConfig {
            name: Some(String::from("vgicd")),
            base_ipa: Platform::GICD_BASE,
            length: 0x1000,
            irq_id: 0,
            cfg_list: Vec::new(),
            emu_type: EmuDeviceType::EmuDeviceTGicd,
            mediated: false,
        },
        /* 
        VmEmulatedDeviceConfig {
            name: Some(String::from("virtio-nic0")),
            base_ipa: 0xa001000,
            length: 0x1000,
            irq_id: 32 + 0x11,
            cfg_list: vec![0x74, 0x56, 0xaa, 0x0f, 0x47, 0xd0],
            emu_type: EmuDeviceType::EmuDeviceTVirtioNet,
            mediated: false,
        },
        */
        VmEmulatedDeviceConfig {
            name: Some(String::from("shyper")),
            base_ipa: 0,
            length: 0,
            irq_id: HVC_IRQ,
            cfg_list: Vec::new(),
            emu_type: EmuDeviceType::EmuDeviceTShyper,
            mediated: false,
        }
        
    ];

    // vm0 passthrough
    let mut pt_dev_config: VmPassthroughDeviceConfig = VmPassthroughDeviceConfig::default();
    pt_dev_config.regions = vec![
        PassthroughRegion { ipa: Platform::UART_0_ADDR, pa: Platform::UART_0_ADDR, length: 0x1000, dev_property: true },
        PassthroughRegion { ipa: Platform::GICC_BASE, pa: Platform::GICV_BASE, length: 0x2000, dev_property: true },
        // pass-througn virtio blk/net
        PassthroughRegion { ipa: 0x0a003000, pa: 0x0a003000, length: 0x1000, dev_property: true },
    ];
    pt_dev_config.irqs = vec![33, 27, 32 + 0x28, 32 + 0x29];
    pt_dev_config.streams_ids = vec![];

    // vm0 vm_region
    let vm_region = vec![
        VmRegion {
            ipa_start: 0x50000000,
            length: 0x80000000,
        }
    ];

    // vm0 config
    let mvm_config_entry = VmConfigEntry {
        id: 0,
        name: Some(String::from("supervisor")),
        cmdline: String::from("earlycon console=ttyAMA0 root=/dev/vda rw audit=0 default_hugepagesz=32M hugepagesz=32M hugepages=4\0"),
        image: Arc::new(Mutex::new(VmImageConfig {
            kernel_img_name: Some("Image"),
            kernel_load_ipa: 0x80080000,
            kernel_load_pa: 0,
            kernel_entry_point: 0x80080000,
            // device_tree_filename: Some("qemu1.bin"),
            device_tree_load_ipa: 0x80000000,
            // ramdisk_filename: Some("initrd.gz"),
            // ramdisk_load_ipa: 0x53000000,
            ramdisk_load_ipa: 0,
            mediated_block_index: None,
        })),
        cpu: Arc::new(Mutex::new(VmCpuConfig {
            num: 4,
            allocate_bitmap: 0b1111,
            master: -1,
        })),
        memory: Arc::new(Mutex::new(VmMemoryConfig {
            region: vm_region,
        })),
        vm_emu_dev_confg: Arc::new(Mutex::new(VmEmulatedDeviceConfigList { emu_dev_list: emu_dev_config })),
        vm_pt_dev_confg: Arc::new(Mutex::new(pt_dev_config)),
        vm_dtb_devs: Arc::new(Mutex::new(VMDtbDevConfigList::default())),
    };
    let _ = vm_cfg_add_vm_entry(mvm_config_entry);
}

