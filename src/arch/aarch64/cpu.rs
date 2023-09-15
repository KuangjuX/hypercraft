use alloc::{vec::Vec, collections::VecDeque};
use core::arch::asm;

use page_table::PagingIf;
use spin::{Mutex, Once};

use percpu_macros::def_percpu;

use crate::{HyperCraftHal, HyperResult, HyperError, HostPhysAddr, HostVirtAddr, GuestPhysAddr};
use crate::arch::vcpu::Vcpu;
use crate::arch::vm::Vm;
use crate::arch::ContextFrame;

use crate::traits::ContextFrameTrait;

/// need to move to a suitable file?
const PAGE_SIZE_4K: usize = 0x1000;

pub const CPU_MASTER: usize = 0;
pub const CPU_STACK_SIZE: usize = PAGE_SIZE_4K * 128;
pub const CONTEXT_GPR_NUM: usize = 31;
pub const PTE_PER_PAGE: usize = 512;

#[derive(Copy, Clone, Debug, Eq)]
pub enum CpuState {
    CpuInactive = 0,
    CpuIdle = 1,
    CpuRun = 2,
}

impl PartialEq for CpuState {
    fn eq(&self, other: &Self) -> bool {
        *self as usize == *other as usize
    }
}

#[repr(C)]
#[repr(align(4096))]
pub struct Cpu<H:HyperCraftHal>{   //stack_top_addr has no use yet?
    pub cpu_id: usize,
    // stack_top_addr: HostVirtAddr,
    pub active_vcpu: Option<Vcpu>,
    pub vcpu_queue: Mutex<VecDeque<usize>>,
    stack_top_addr: HostVirtAddr,
    pub current_irq: usize,
    marker: core::marker::PhantomData<H>,
}

/// The base address of the per-CPU memory region.
static PER_CPU_BASE: Once<HostPhysAddr> = Once::new();

impl <H: HyperCraftHal> Cpu<H> {
    const fn new(cpu_id: usize, stack_top_addr: HostVirtAddr) -> Self {
        Self {
            cpu_id: cpu_id,
            active_vcpu: None,
            stack_top_addr: stack_top_addr,
            vcpu_queue: Mutex::new(VecDeque::new()),
            current_irq: 0,
            marker: core::marker::PhantomData,
        }
    }

    pub fn init(boot_id: usize, stack_size: usize) -> HyperResult<()> {
        let cpu_nums: usize = 1;
        let pcpu_size = core::mem::size_of::<Cpu<H>>() * cpu_nums;
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
            let pcpu: Cpu<H> = Self::new(cpu_id, stack_top_addr);
            let ptr = Self::ptr_for_cpu(cpu_id);
            // Safety: ptr is guaranteed to be properly aligned and point to valid memory owned by
            // PerCpu. No other CPUs are alive at this point, so it cannot be concurrently modified
            // either.
            unsafe { core::ptr::write(ptr as *mut Cpu<H>, pcpu) };
        }

        // Initialize TP register and set this CPU online to be consistent with secondary CPUs.
        Self::setup_this_cpu(boot_id)?;

        Ok(())
    }

    /// Returns a pointer to the `PerCpu` for the given CPU.
    fn ptr_for_cpu(cpu_id: usize) -> *const Cpu<H> {
        let pcpu_addr = PER_CPU_BASE.get().unwrap() + cpu_id * core::mem::size_of::<Cpu<H>>();
        pcpu_addr as *const Cpu<H>
    }

    /// Initializes the TP pointer to point to PerCpu data.
    pub fn setup_this_cpu(boot_id: usize) -> HyperResult<()> {
        // Load TP with address of pur PerCpu struct.
        let tp = Self::ptr_for_cpu(boot_id) as usize;
        unsafe {
            asm!("msr TPIDR_EL2, {}", in(reg) tp)
            // Safe since we're the only users of TP.
            // asm!("mv tp, {rs}", rs = in(reg) tp)
        };
        Ok(())
    }

    pub fn create_vcpu(&mut self, vcpu_id: usize) -> HyperResult<Vcpu> {
        self.vcpu_queue.lock().push_back(vcpu_id);
        let vcpu = Vcpu::new(vcpu_id, self.cpu_id);
        let result = Ok(vcpu);
        result
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