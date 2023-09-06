use core::hint::spin_loop;

use crate::arch::psci::{power_arch_sys_reset, power_arch_sys_shutdown};

pub const GICD_BASE: usize = 0x08000000;
pub const GICC_BASE: usize = 0x08010000;
pub const GICH_BASE: usize = 0x08030000;
pub const GICV_BASE: usize = 0x08040000;

pub const UART_0_ADDR: usize = 0x9000000;
pub const UART_1_ADDR: usize = 0x9100000;
pub const UART_2_ADDR: usize = 0x9110000;

pub const PLATFORM_CPU_NUM_MAX: usize = 8;
pub const PLATFORM_VCPU_NUM_MAX: usize = 8;

pub fn sys_reboot() -> ! {
    info!("Hypervisor reset...");
    power_arch_sys_reset();
    loop {
        spin_loop();
    }
}

pub fn sys_shutdown() -> ! {
    info!("Hypervisor shutdown...");
    power_arch_sys_shutdown();
    loop {
        spin_loop();
    }
}
/* 
pub struct QemuPlatform;

impl PlatOperation for QemuPlatform {
    const UART_0_ADDR: usize = 0x9000000;
    const UART_1_ADDR: usize = 0x9100000;
    const UART_2_ADDR: usize = 0x9110000;

    const UART_0_INT: usize = 32 + 0x70;
    const UART_1_INT: usize = 32 + 0x72;

    const HYPERVISOR_UART_BASE: usize = Self::UART_0_ADDR;

    

    const SHARE_MEM_BASE: usize = 0x7_0000_0000;

    const DISK_PARTITION_0_START: usize = 0;
    const DISK_PARTITION_1_START: usize = 2097152;
    const DISK_PARTITION_2_START: usize = 10289152;

    const DISK_PARTITION_TOTAL_SIZE: usize = 18481152;
    const DISK_PARTITION_0_SIZE: usize = 524288;
    const DISK_PARTITION_1_SIZE: usize = 8192000;
    const DISK_PARTITION_2_SIZE: usize = 8192000;

    fn cpuid_to_cpuif(cpuid: usize) -> usize {
        cpuid
    }

    fn cpuif_to_cpuid(cpuif: usize) -> usize {
        cpuif
    }

    fn blk_init() {
        info!("Platform block driver init ok");
        crate::driver::virtio_blk_init();
    }

    fn blk_read(sector: usize, count: usize, buf: usize) {
        read(sector, count, buf);
    }

    fn blk_write(sector: usize, count: usize, buf: usize) {
        write(sector, count, buf);
    }
}

pub static PLAT_DESC: PlatformConfig = PlatformConfig {
    cpu_desc: PlatCpuConfig {
        num: 4,
        core_list: &[
            PlatCpuCoreConfig {
                name: ARM_CORTEX_A57,
                mpidr: 0,
                sched: RoundRobin,
            },
            PlatCpuCoreConfig {
                name: ARM_CORTEX_A57,
                mpidr: 1,
                sched: RoundRobin,
            },
            PlatCpuCoreConfig {
                name: ARM_CORTEX_A57,
                mpidr: 2,
                sched: RoundRobin,
            },
            PlatCpuCoreConfig {
                name: ARM_CORTEX_A57,
                mpidr: 3,
                sched: RoundRobin,
            },
        ],
    },
    mem_desc: PlatMemoryConfig {
        regions: &[
            // reserve 0x48000000 ~ 0x48100000 for QEMU dtb
            PlatMemRegion {
                base: 0x40000000,
                size: 0x08000000,
            },
            PlatMemRegion {
                base: 0x50000000,
                size: 0x1f0000000,
            },
        ],
        base: 0x40000000,
    },
    arch_desc: ArchDesc {
        gic_desc: GicDesc {
            gicd_addr: Platform::GICD_BASE,
            gicc_addr: Platform::GICC_BASE,
            gich_addr: Platform::GICH_BASE,
            gicv_addr: Platform::GICV_BASE,
            maintenance_int_id: 25,
        },
        smmu_desc: SmmuDesc {
            base: 0,
            interrupt_id: 0,
            global_mask: 0,
        },
    },
};
*/