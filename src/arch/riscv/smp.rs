use spin::Once;

use crate::HostPhysAddr;

/// Per-CPU data. A pointer to this struct is loaded into TP when a CPU starts. This structure
/// sits at the top of a secondary CPU's stack.
#[repr(C)]
pub struct PerCpu {
    cpu_id: usize,
}

/// The base address of the per-CPU memory region.
static PER_CPU_BASE: Once<HostPhysAddr> = Once::new();

impl PerCpu {
    /// Returns this CPU's `PerCpu` structure.
    pub fn this_cpu() -> &'static PerCpu {
        // Make sure PerCpu has been set up.
        assert!(PER_CPU_BASE.get().is_some());
        let tp: u64;
        unsafe { core::arch::asm!("mv {rd}, tp", rd = out(reg) tp) };
        let pcpu_ptr = tp as *const PerCpu;
        let pcpu = unsafe {
            // Safe since TP is set uo to point to a valid PerCpu
            pcpu_ptr.as_ref().unwrap()
        };
        pcpu
    }
}
