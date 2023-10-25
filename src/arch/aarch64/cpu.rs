use alloc::collections::VecDeque;
use core::arch::asm;

use spin::{Mutex, Once};

use crate::{HyperCraftHal, HyperResult, HyperError, HostPhysAddr, HostVirtAddr, GuestPhysAddr};
use crate::arch::vcpu::VCpu;
use crate::arch::ContextFrame;
use crate::traits::ContextFrameTrait;

/// need to move to a suitable file?
const PAGE_SIZE_4K: usize = 0x1000;

pub const CPU_MASTER: usize = 0;
pub const CPU_STACK_SIZE: usize = PAGE_SIZE_4K * 128;
pub const CONTEXT_GPR_NUM: usize = 31;
pub const PTE_PER_PAGE: usize = 512;

/// Per-CPU data. A pointer to this struct is loaded into TP when a CPU starts. This structure
/// sits at the top of a secondary CPU's stack.
#[repr(C)]
#[repr(align(4096))]
pub struct PerCpu<H:HyperCraftHal>{   //stack_top_addr has no use yet?
    /// per cpu id
    pub cpu_id: usize,
    stack_top_addr: HostVirtAddr,
    /// save for correspond vcpus
    pub vcpu_queue: Mutex<VecDeque<usize>>,
    marker: core::marker::PhantomData<H>,
}

/// The base address of the per-CPU memory region.
static PER_CPU_BASE: Once<HostPhysAddr> = Once::new();

impl <H: HyperCraftHal> PerCpu<H> {
    const fn new(cpu_id: usize, stack_top_addr: HostVirtAddr) -> Self {
        Self {
            cpu_id: cpu_id,
            stack_top_addr: stack_top_addr,
            vcpu_queue: Mutex::new(VecDeque::new()),
            marker: core::marker::PhantomData,
        }
    }

    /// Initializes the `PerCpu` structures for each CPU. This (the boot CPU's) per-CPU
    /// area is initialized and loaded into TPIDR_EL1 as well.
    pub fn init(boot_id: usize, stack_size: usize) -> HyperResult<()> {
        let cpu_nums: usize = 1;
        let pcpu_size = core::mem::size_of::<PerCpu<H>>() * cpu_nums;
        debug!("pcpu_size: {:#x}", pcpu_size);
        let pcpu_pages = H::alloc_pages((pcpu_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
            .ok_or(HyperError::NoMemory)?;
        debug!("pcpu_pages: {:#x}", pcpu_pages);
        PER_CPU_BASE.call_once(|| pcpu_pages);
        for cpu_id in 0..cpu_nums {
            let stack_top_addr = if cpu_id == boot_id {
                let boot_stack_top = Self::boot_cpu_stack()?;
                debug!("boot_stack_top: {:#x}", boot_stack_top);
                boot_stack_top
            } else {
                H::alloc_pages((stack_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
                    .ok_or(HyperError::NoMemory)?
            };
            let pcpu: PerCpu<H> = Self::new(cpu_id, stack_top_addr);
            let ptr = Self::ptr_for_cpu(cpu_id);
            // Safety: ptr is guaranteed to be properly aligned and point to valid memory owned by
            // PerCpu. No other CPUs are alive at this point, so it cannot be concurrently modified
            // either.
            unsafe { core::ptr::write(ptr as *mut PerCpu<H>, pcpu) };
        }

        // Initialize TP register and set this CPU online to be consistent with secondary CPUs.
        Self::setup_this_cpu(boot_id)?;

        Ok(())
    }

    /// Initializes the TP pointer to point to PerCpu data.
    pub fn setup_this_cpu(cpu_id: usize) -> HyperResult<()> {
        // Load TP with address of pur PerCpu struct.
        let tp = Self::ptr_for_cpu(cpu_id) as usize;

        unsafe {
            asm!("msr TPIDR_EL1, {}", in(reg) tp)
            // Safe since we're the only users of TP.
            // asm!("mv tp, {rs}", rs = in(reg) tp)
        };
        Ok(())
    }

    /// Returns this CPU's `PerCpu` structure.
    pub fn this_cpu() -> &'static mut PerCpu<H> {
        // Make sure PerCpu has been set up.
        assert!(PER_CPU_BASE.get().is_some());
        let tp: u64;
        unsafe { core::arch::asm!("mrs {}, TPIDR_EL1", out(reg) tp) };
        let pcpu_ptr = tp as *mut PerCpu<H>;
        let pcpu = unsafe {
            // Safe since TP is set uo to point to a valid PerCpu
            pcpu_ptr.as_mut().unwrap()
        };
        pcpu
    }

    /// Create a `Vcpu`, set the entry point to `entry` and bind this vcpu into the current CPU.
    pub fn create_vcpu(&mut self, vcpu_id: usize) -> HyperResult<VCpu<H>> {
        self.vcpu_queue.lock().push_back(vcpu_id);
        let vcpu = VCpu::<H>::new(vcpu_id);
        let result = Ok(vcpu);
        result
    }

    /// Get stack top addr.
    fn stack_top_addr(&self) -> HostVirtAddr {
        self.stack_top_addr
    }

    /// Returns a pointer to the `PerCpu` for the given CPU.
    fn ptr_for_cpu(cpu_id: usize) -> *const PerCpu<H> {
        let pcpu_addr = PER_CPU_BASE.get().unwrap() + cpu_id * core::mem::size_of::<PerCpu<H>>();
        pcpu_addr as *const PerCpu<H>
    }

    fn boot_cpu_stack() -> HyperResult<GuestPhysAddr> {
        // TODO: get boot stack information by interface
        // extern "Rust" {
        //     fn BOOT_STACK();
        // }
        // Ok(BOOT_STACK as GuestPhysAddr)
        Ok(0 as GuestPhysAddr)
    }

}

/*
pub fn current_cpu() -> &'static mut Cpu {
    // Make sure PerCpu has been set up.
    assert!(PER_CPU_BASE.get().is_some());
    let tp: u64;
    unsafe { core::arch::asm!("mrs {}, TPIDR_EL2", out(reg) tp) };
    let pcpu_ptr = tp as *mut Cpu<dyn HyperCraftHal>;
    let pcpu = unsafe {
        // Safe since TP is set uo to point to a valid PerCpu
        pcpu_ptr.as_mut().unwrap()
    };
    pcpu
}

 
#[def_percpu]
pub static mut CPU: Cpu = Cpu::new(0);  // hard code for one cpu

pub fn current_cpu() -> &'static mut Cpu {
    unsafe {
        let ptr: *const Cpu = CPU.current_ptr();
        mem::transmute::<*const Cpu, &'static mut Cpu>(ptr)
    }
}

pub fn init_cpu() {
    cpu_interface_init();

    let current_cpu = current_cpu();
    let state = CpuState::CpuIdle;
    let sp = current_cpu().stack.as_ptr() as usize + CPU_STACK_SIZE;
    let size = core::mem::size_of::<ContextFrame>();
    let context_addr = (sp - size) as *mut _;
    CPU.with_current(|c| {
        c.cpu_state = state;
        c.context_addr = context_addr;
    });

    info!("Core {} init ok", current_cpu.cpu_id);
}
*/