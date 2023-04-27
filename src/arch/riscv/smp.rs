use spin::Once;

use crate::{
    memory::PAGE_SIZE_4K, HostPhysAddr, HostVirtAddr, HyperCraftHal, HyperError, HyperResult,
};

/// Per-CPU data. A pointer to this struct is loaded into TP when a CPU starts. This structure
/// sits at the top of a secondary CPU's stack.
#[repr(C)]
pub struct PerCpu<H: HyperCraftHal> {
    cpu_id: usize,
    stack_top_addr: HostVirtAddr,
    marker: core::marker::PhantomData<H>,
}

/// The base address of the per-CPU memory region.
static PER_CPU_BASE: Once<HostPhysAddr> = Once::new();

impl<H: HyperCraftHal> PerCpu<H> {
    /// Initializes the `PerCpu` structures for each CPU. This (the boot CPU's) per-CPU
    /// area is initialized and loaded into TP as well.
    pub fn init(boot_hart_id: usize, stack_size: usize) -> HyperResult<()> {
        // TODO: get cpu info by device tree
        let cpu_nums: usize = 2;
        let pcpu_size = core::mem::size_of::<PerCpu<H>>() * cpu_nums;
        let pcpu_pages = H::alloc_pages((pcpu_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
            .ok_or(HyperError::NoMemory)?;
        PER_CPU_BASE.call_once(|| pcpu_pages);
        for cpu_id in 0..cpu_nums {
            let stack_top_addr = if cpu_id == boot_hart_id {
                0
            } else {
                H::alloc_pages((stack_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
                    .ok_or(HyperError::NoMemory)?
            };
            let pcpu: PerCpu<H> = PerCpu {
                cpu_id,
                stack_top_addr,
                marker: core::marker::PhantomData,
            };
            let ptr = Self::ptr_for_cpu(cpu_id);
            // Safety: ptr is guaranteed to be properly aligned and point to valid memory owned by
            // PerCpu. No other CPUs are alive at this point, so it cannot be concurrently modified
            // either.
            unsafe { core::ptr::write(ptr as *mut PerCpu<H>, pcpu) };
        }

        Ok(())
    }

    /// Returns this CPU's `PerCpu` structure.
    pub fn this_cpu() -> &'static PerCpu<H> {
        // Make sure PerCpu has been set up.
        assert!(PER_CPU_BASE.get().is_some());
        let tp: u64;
        unsafe { core::arch::asm!("mv {rd}, tp", rd = out(reg) tp) };
        let pcpu_ptr = tp as *const PerCpu<H>;
        let pcpu = unsafe {
            // Safe since TP is set uo to point to a valid PerCpu
            pcpu_ptr.as_ref().unwrap()
        };
        pcpu
    }

    fn ptr_for_cpu(cpu_id: usize) -> *const PerCpu<H> {
        let pcpu_addr = PER_CPU_BASE.get().unwrap() + cpu_id * core::mem::size_of::<PerCpu<H>>();
        pcpu_addr as *const PerCpu<H>
    }
}
