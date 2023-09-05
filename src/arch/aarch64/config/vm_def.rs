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

/* 
use crate::board::*;
use crate::config::vm_cfg_add_vm_entry;
use crate::device::EmuDeviceType;
use crate::kernel::{INTERRUPT_IRQ_GUEST_TIMER, VmType};

use super::{
    PassthroughRegion, VmConfigEntry, VmCpuConfig, VMDtbDevConfigList, VmEmulatedDeviceConfig,
    VmEmulatedDeviceConfigList, VmImageConfig, VmMemoryConfig, VmPassthroughDeviceConfig, VmRegion, VmDtbDevConfig,
    AddrRegions, DtbDevType,
};
*/

use crate::arch::vmConfig::*;
use crate::arch::emu::*;
use crate::arch::GICV_BASE;
use crate::arch::interrupt::INTERRUPT_IRQ_GUEST_TIMER;

pub fn init_tmp_config_for_vm1() {
    info!("init_tmp_config_for_vm1");

    // #################### vm1 emu ######################
    let mut emu_dev_config: Vec<VmEmulatedDeviceConfig> = Vec::new();
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("intc@8000000")),
        base_ipa: 0x8000000,
        length: 0x1000,
        irq_id: 0,
        cfg_list: Vec::new(),
        emu_type: EmuDeviceType::EmuDeviceTGicd,
        mediated: false,
    });
    /*
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("virtio_blk@a000000")),
        base_ipa: 0xa000000,
        length: 0x1000,
        irq_id: 32 + 0x10,
        // cfg_list: vec![DISK_PARTITION_2_START, DISK_PARTITION_2_SIZE],
        // cfg_list: vec![0, 8388608],
        // cfg_list: vec![0, 67108864i], // 32G
        cfg_list: vec![0, 209715200], // 100G
        emu_type: EmuDeviceType::EmuDeviceTVirtioBlk,
        mediated: true,
    });
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("virtio_net@a001000")),
        base_ipa: 0xa001000,
        length: 0x1000,
        irq_id: 32 + 0x11,
        cfg_list: vec![0x74, 0x56, 0xaa, 0x0f, 0x47, 0xd1],
        emu_type: EmuDeviceType::EmuDeviceTVirtioNet,
        mediated: false,
    });
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("virtio_console@a002000")),
        base_ipa: 0xa002000,
        length: 0x1000,
        irq_id: 32 + 0x12,
        cfg_list: vec![0, 0xa002000],
        emu_type: EmuDeviceType::EmuDeviceTVirtioConsole,
        mediated: false,
    });
    */

    // vm1 passthrough
    let mut pt_dev_config: VmPassthroughDeviceConfig = VmPassthroughDeviceConfig::default();
    pt_dev_config.regions = vec![
        PassthroughRegion {
            ipa: 0x8010000,
            pa: GICV_BASE,
            length: 0x2000,
            dev_property: true,
        },
    ];
    // pt_dev_config.irqs = vec![UART_1_INT, INTERRUPT_IRQ_GUEST_TIMER];
    pt_dev_config.irqs = vec![INTERRUPT_IRQ_GUEST_TIMER];

    // vm1 vm_region
    let mut vm_region: Vec<VmRegion> = Vec::new();
    vm_region.push(VmRegion {
        ipa_start: 0x80000000,
        length: 0x40000000,
    });

    let mut vm_dtb_devs: Vec<VmDtbDevConfig> = vec![];
    vm_dtb_devs.push(VmDtbDevConfig {
        name: String::from("gicd"),
        dev_type: DtbDevType::DevGicd,
        irqs: vec![],
        addr_region: AddrRegions {
            ipa: 0x8000000,
            length: 0x1000,
        },
    });
    vm_dtb_devs.push(VmDtbDevConfig {
        name: String::from("gicc"),
        dev_type: DtbDevType::DevGicc,
        irqs: vec![],
        addr_region: AddrRegions {
            ipa: 0x8010000,
            length: 0x2000,
        },
    });
    // vm_dtb_devs.push(VmDtbDevConfig {
    //     name: String::from("serial"),
    //     dev_type: DtbDevType::DevSerial,
    //     irqs: vec![UART_1_INT],
    //     addr_region: AddrRegions {
    //         ipa: UART_1_ADDR,
    //         length: 0x1000,
    //     },
    // });

    // vm1 config
    let vm1_config = VmConfigEntry {
        id: 1,
        name: Some(String::from("guest-os-0")),
        // cmdline: "root=/dev/vda rw audit=0",
        cmdline: String::from("earlycon console=hvc0,115200n8 root=/dev/vda rw audit=0"),

        image: Arc::new(Mutex::new(VmImageConfig {
            kernel_img_name: Some("Image_vanilla"),
            kernel_load_ipa: 0x80080000,
            kernel_load_pa: 0,
            kernel_entry_point: 0x80080000,
            device_tree_load_ipa: 0x80000000,
            ramdisk_load_ipa: 0, //0x83000000,
            mediated_block_index: Some(0),
        })),
        memory: Arc::new(Mutex::new(VmMemoryConfig { region: vm_region })),
        cpu: Arc::new(Mutex::new(VmCpuConfig {
            num: 1,
            allocate_bitmap: 0b0010,
            master: 1,
        })),
        vm_emu_dev_confg: Arc::new(Mutex::new(VmEmulatedDeviceConfigList {
            emu_dev_list: emu_dev_config,
        })),
        vm_pt_dev_confg: Arc::new(Mutex::new(pt_dev_config)),
        vm_dtb_devs: Arc::new(Mutex::new(VMDtbDevConfigList {
            dtb_device_list: vm_dtb_devs,
        })),
    };
    info!("generate tmp_config for vm1");
    let _ = vm_cfg_add_vm_entry(vm1_config);
}

pub fn init_tmp_config_for_vm2() {
    info!("init_tmp_config_for_vm2");

    // #################### vm2 emu ######################
    let mut emu_dev_config: Vec<VmEmulatedDeviceConfig> = Vec::new();
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("intc@8000000")),
        base_ipa: 0x8000000,
        length: 0x1000,
        irq_id: 0,
        cfg_list: Vec::new(),
        emu_type: EmuDeviceType::EmuDeviceTGicd,
        mediated: false,
    });
    /*
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("virtio_blk@a000000")),
        base_ipa: 0xa000000,
        length: 0x1000,
        irq_id: 32 + 0x10,
        cfg_list: vec![0, 209715200], // 100G
        emu_type: EmuDeviceType::EmuDeviceTVirtioBlk,
        mediated: true,
    });
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("virtio_net@a001000")),
        base_ipa: 0xa001000,
        length: 0x1000,
        irq_id: 32 + 0x11,
        cfg_list: vec![0x74, 0x56, 0xaa, 0x0f, 0x47, 0xd2],
        emu_type: EmuDeviceType::EmuDeviceTVirtioNet,
        mediated: false,
    });
    emu_dev_config.push(VmEmulatedDeviceConfig {
        name: Some(String::from("virtio_console@a003000")),
        base_ipa: 0xa003000,
        length: 0x1000,
        irq_id: 32 + 0x12,
        cfg_list: vec![0, 0xa003000],
        emu_type: EmuDeviceType::EmuDeviceTVirtioConsole,
        mediated: false,
    });
    */
    // vm2 passthrough
    let mut pt_dev_config: VmPassthroughDeviceConfig = VmPassthroughDeviceConfig::default();
    pt_dev_config.regions = vec![
        // PassthroughRegion {
        //     ipa: UART_1_ADDR,
        //     pa: UART_1_ADDR,
        //     length: 0x1000,
        //     dev_property: true,
        // },
        PassthroughRegion {
            ipa: 0x8010000,
            pa: GICV_BASE,
            length: 0x2000,
            dev_property: true,
        },
    ];
    // pt_dev_config.irqs = vec![UART_1_INT, INTERRUPT_IRQ_GUEST_TIMER];
    pt_dev_config.irqs = vec![INTERRUPT_IRQ_GUEST_TIMER];

    // vm2 vm_region
    let mut vm_region: Vec<VmRegion> = Vec::new();
    vm_region.push(VmRegion {
        ipa_start: 0x80000000,
        length: 0x40000000,
    });

    let mut vm_dtb_devs: Vec<VmDtbDevConfig> = vec![];
    vm_dtb_devs.push(VmDtbDevConfig {
        name: String::from("gicd"),
        dev_type: DtbDevType::DevGicd,
        irqs: vec![],
        addr_region: AddrRegions {
            ipa: 0x8000000,
            length: 0x1000,
        },
    });
    vm_dtb_devs.push(VmDtbDevConfig {
        name: String::from("gicc"),
        dev_type: DtbDevType::DevGicc,
        irqs: vec![],
        addr_region: AddrRegions {
            ipa: 0x8010000,
            length: 0x2000,
        },
    });
    // vm_dtb_devs.push(VmDtbDevConfig {
    //     name: String::from("serial"),
    //     dev_type: DtbDevType::DevSerial,
    //     irqs: vec![UART_1_INT],
    //     addr_region: AddrRegions {
    //         ipa: UART_1_ADDR,
    //         length: 0x1000,
    //     },
    // });

    // vm2 config
    let vm2_config = VmConfigEntry {
        id: 2,
        name: Some(String::from("guest-os-1")),
        // cmdline: "root=/dev/vda rw audit=0",
        cmdline: String::from("earlycon console=ttyS0,115200n8 root=/dev/vda rw audit=0"),

        image: Arc::new(Mutex::new(VmImageConfig {
            kernel_img_name: Some("Image_vanilla"),
            kernel_load_ipa: 0x80080000,
            kernel_load_pa: 0,
            kernel_entry_point: 0x80080000,
            device_tree_load_ipa: 0x80000000,
            ramdisk_load_ipa: 0, //0x83000000,
            mediated_block_index: Some(1),
        })),
        memory: Arc::new(Mutex::new(VmMemoryConfig { region: vm_region })),
        cpu: Arc::new(Mutex::new(VmCpuConfig {
            num: 1,
            allocate_bitmap: 0b0100,
            master: 2,
        })),
        vm_emu_dev_confg: Arc::new(Mutex::new(VmEmulatedDeviceConfigList {
            emu_dev_list: emu_dev_config,
        })),
        vm_pt_dev_confg: Arc::new(Mutex::new(pt_dev_config)),
        vm_dtb_devs: Arc::new(Mutex::new(VMDtbDevConfigList {
            dtb_device_list: vm_dtb_devs,
        })),
    };
    let _ = vm_cfg_add_vm_entry(vm2_config);
}
