// Copyright (c) 2023 Beihang University, Huawei Technologies Co.,Ltd. All rights reserved.
// Rust-Shyper is licensed under Mulan PSL v2.
// You can use this software according to the terms and conditions of the Mulan PSL v2.
// You may obtain a copy of Mulan PSL v2 at:
//          http://license.coscl.org.cn/MulanPSL2
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
// EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
// MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
// See the Mulan PSL v2 for more details.

use crate::arch::psci::*;
use super::platform_qemu::PLAT_DESC;

pub const PLATFORM_CPU_NUM_MAX: usize = 8;
pub const PLATFORM_VCPU_NUM_MAX: usize = 8;
pub const ARM_CORTEX_A57: u8 = 0;

#[repr(C)]
pub enum SchedRule {
    RoundRobin,
    None,
}

#[repr(C)]
pub struct PlatMemRegion {
    pub base: usize,
    pub size: usize,
}

#[repr(C)]
pub struct PlatMemoryConfig {
    pub base: usize,
    pub regions: &'static [PlatMemRegion],
}

pub struct PlatCpuCoreConfig {
    pub name: u8,
    pub mpidr: usize,
    pub sched: SchedRule,
}

#[repr(C)]
pub struct PlatCpuConfig {
    pub num: usize,
    pub core_list: &'static [PlatCpuCoreConfig],
}

#[repr(C)]
pub struct PlatformConfig {
    pub cpu_desc: PlatCpuConfig,
    pub mem_desc: PlatMemoryConfig,
}

pub trait PlatOperation {
    // must offer UART_0 and UART_1 address
    const UART_0_ADDR: usize;
    const UART_1_ADDR: usize;
    const UART_2_ADDR: usize = usize::MAX;

    // must offer hypervisor used uart
    const HYPERVISOR_UART_BASE: usize;

    const UART_0_INT: usize = usize::MAX;
    const UART_1_INT: usize = usize::MAX;
    const UART_2_INT: usize = usize::MAX;

    // must offer interrupt controller
    const GICD_BASE: usize;
    const GICC_BASE: usize;
    const GICH_BASE: usize;
    const GICV_BASE: usize;

    const DISK_PARTITION_0_START: usize = usize::MAX;
    const DISK_PARTITION_1_START: usize = usize::MAX;
    const DISK_PARTITION_2_START: usize = usize::MAX;
    const DISK_PARTITION_3_START: usize = usize::MAX;
    const DISK_PARTITION_4_START: usize = usize::MAX;

    const DISK_PARTITION_TOTAL_SIZE: usize = usize::MAX;
    const DISK_PARTITION_0_SIZE: usize = usize::MAX;
    const DISK_PARTITION_1_SIZE: usize = usize::MAX;
    const DISK_PARTITION_2_SIZE: usize = usize::MAX;
    const DISK_PARTITION_3_SIZE: usize = usize::MAX;
    const DISK_PARTITION_4_SIZE: usize = usize::MAX;

    const SHARE_MEM_BASE: usize;

    fn cpu_on(arch_core_id: usize, entry: usize, ctx: usize) {
        power_arch_cpu_on(arch_core_id, entry, ctx);
    }

    fn cpu_shutdown() {
        power_arch_cpu_shutdown();
    }

    fn power_on_secondary_cores() {
        extern "C" {
            fn _image_start();
        }
        for i in 1..PLAT_DESC.cpu_desc.num {
            Self::cpu_on(PLAT_DESC.cpu_desc.core_list[i].mpidr, _image_start as usize, 0);
        }
    }

    fn sys_reboot() -> ! {
        info!("Hypervisor reset...");
        power_arch_sys_reset();
        loop {
            core::hint::spin_loop();
        }
    }

    fn sys_shutdown() -> ! {
        info!("Hypervisor shutdown...");
        power_arch_sys_shutdown();
        loop {
            core::hint::spin_loop();
        }
    }

    fn cpuid_to_cpuinterface(cpuid: usize) -> usize;

    fn cpuinterface_to_cpuid(cpuinterface: usize) -> usize;

    // fn blk_init();

    // fn blk_read(sector: usize, count: usize, buf: usize);

    // fn blk_write(sector: usize, count: usize, buf: usize);
}
