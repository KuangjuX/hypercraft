//! reference: https://github.com/rivosinc/salus/blob/main/src/smp.rs
use core::arch::asm;

use alloc::{collections::VecDeque, vec::Vec};
use spin::{Mutex, Once};

use crate::{
    memory::PAGE_SIZE_4K, GuestPhysAddr, HostPhysAddr, HostVirtAddr, HyperCraftHal, HyperError,
    HyperResult, VCpu,
};

use super::detect::detect_h_extension;

/// Per-CPU data. A pointer to this struct is loaded into TP when a CPU starts. This structure
/// sits at the top of a secondary CPU's stack.
#[repr(C)]
pub struct PerCpu<H: HyperCraftHal> {
    cpu_id: usize,
    stack_top_addr: HostVirtAddr,
    marker: core::marker::PhantomData<H>,
    // TODO: `Mutex` is necessary?
    vcpu_queue: Mutex<VecDeque<usize>>,
}

/// The base address of the per-CPU memory region.
static PER_CPU_BASE: Once<HostPhysAddr> = Once::new();

impl<H: HyperCraftHal> PerCpu<H> {
    /// Initializes the `PerCpu` structures for each CPU. This (the boot CPU's) per-CPU
    /// area is initialized and loaded into TP as well.
    pub fn init(boot_hart_id: usize, stack_size: usize) -> HyperResult<()> {
        // TODO: get cpu info by device tree
        let cpu_nums: usize = 1;
        let pcpu_size = core::mem::size_of::<PerCpu<H>>() * cpu_nums;
        debug!("pcpu_size: {:#x}", pcpu_size);
        let pcpu_pages = H::alloc_pages((pcpu_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
            .ok_or(HyperError::NoMemory)?;
        debug!("pcpu_pages: {:#x}", pcpu_pages);
        PER_CPU_BASE.call_once(|| pcpu_pages);
        for cpu_id in 0..cpu_nums {
            let stack_top_addr = if cpu_id == boot_hart_id {
                let boot_stack_top = Self::boot_cpu_stack()?;
                debug!("boot_stack_top: {:#x}", boot_stack_top);
                boot_stack_top
            } else {
                H::alloc_pages((stack_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
                    .ok_or(HyperError::NoMemory)?
            };
            let pcpu: PerCpu<H> = PerCpu {
                cpu_id,
                stack_top_addr,
                marker: core::marker::PhantomData,
                vcpu_queue: Mutex::new(VecDeque::new()),
            };
            let ptr = Self::ptr_for_cpu(cpu_id);
            // Safety: ptr is guaranteed to be properly aligned and point to valid memory owned by
            // PerCpu. No other CPUs are alive at this point, so it cannot be concurrently modified
            // either.
            unsafe { core::ptr::write(ptr as *mut PerCpu<H>, pcpu) };
        }

        // Initialize TP register and set this CPU online to be consistent with secondary CPUs.
        Self::setup_this_cpu(boot_hart_id)?;

        Ok(())
    }

    /// Initializes the TP pointer to point to PerCpu data.
    pub fn setup_this_cpu(hart_id: usize) -> HyperResult<()> {
        // Load TP with address of pur PerCpu struct.
        let tp = Self::ptr_for_cpu(hart_id) as usize;
        unsafe {
            // Safe since we're the only users of TP.
            asm!("mv tp, {rs}", rs = in(reg) tp)
        };
        Ok(())
    }

    /// Create a `Vcpu`, set the entry point to `entry` and bind this vcpu into the current CPU.
    pub fn create_vcpu(&mut self, entry: GuestPhysAddr, vcpu_id: usize) -> HyperResult<VCpu<H>> {
        if !detect_h_extension() {
            Err(crate::HyperError::BadState)
        } else {
            self.vcpu_queue.lock().push_back(vcpu_id);
            Ok(VCpu::<H>::create(entry, vcpu_id))
        }
    }

    /// Returns this CPU's `PerCpu` structure.
    pub fn this_cpu() -> &'static mut PerCpu<H> {
        // Make sure PerCpu has been set up.
        assert!(PER_CPU_BASE.get().is_some());
        let tp: u64;
        unsafe { core::arch::asm!("mv {rd}, tp", rd = out(reg) tp) };
        let pcpu_ptr = tp as *mut PerCpu<H>;
        let pcpu = unsafe {
            // Safe since TP is set uo to point to a valid PerCpu
            pcpu_ptr.as_mut().unwrap()
        };
        pcpu
    }

    pub fn stack_top_addr(&self) -> HostVirtAddr {
        self.stack_top_addr
    }

    /// Returns a pointer to the `PerCpu` for the given CPU.
    fn ptr_for_cpu(cpu_id: usize) -> *const PerCpu<H> {
        let pcpu_addr = PER_CPU_BASE.get().unwrap() + cpu_id * core::mem::size_of::<PerCpu<H>>();
        pcpu_addr as *const PerCpu<H>
    }

    fn boot_cpu_stack() -> HyperResult<GuestPhysAddr> {
        // TODO: get boot stack information by interface
        extern "Rust" {
            fn BOOT_STACK();
        }
        Ok(BOOT_STACK as GuestPhysAddr)
    }
}

// PerCpu state obvioudly cannot be shared between threads.
impl<H: HyperCraftHal> !Sync for PerCpu<H> {}

// /// Boots secondary CPUs, using the HSM SBI call. Upon return, all secondary CPUs will have
// /// entered secondary_init().
// /// TODO: remove this function, use `percpu` instead.
// pub fn start_secondary_cpus<H: HyperCraftHal + 'static>(cpu_info: &CpuInfo) -> HyperResult<()> {
//     // TODO: remove _secondary_start
//     extern "C" {
//         fn _secondary_start();
//     }
//     let boot_cpu = PerCpu::<H>::this_cpu();
//     for i in 0..cpu_info.num_cpus() {
//         if i == boot_cpu.cpu_id {
//             continue;
//         }

//         // Start the hart with its stack physical address in A1.
//         // Safe since it is set up to point to a valid PerCpu struct in init().
//         let pcpu = unsafe { PerCpu::<H>::ptr_for_cpu(i).as_ref().unwrap() };
//         let stack_top_addr = pcpu.stack_top_addr();

//         // hsm call to start other hart
//         // a0: hartid
//         // a1: stack_top_addr
//         sbi_rt::hart_start(i, _secondary_start as usize, stack_top_addr);
//     }
//     Ok(())
// }
