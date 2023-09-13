use alloc::{vec::Vec, collections::VecDeque};
use core::arch::asm;

use page_table::PagingIf;
use spin::{Mutex, Once};

use percpu_macros::def_percpu;

use crate::{HyperCraftHal, HyperResult, HyperError, HostPhysAddr};
use crate::arch::ipi::{IpiMessage, IPI_HANDLER_LIST};
use crate::arch::vcpu::Vcpu;
use crate::arch::vm::Vm;
use crate::arch::interrupt::cpu_interrupt_unmask;
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

pub struct CpuInterface {
    pub msg_queue: Vec<IpiMessage>,
}

impl CpuInterface {
    pub fn default() -> CpuInterface {
        CpuInterface { msg_queue: Vec::new() }
    }

    pub fn push(&mut self, ipi_msg: IpiMessage) {
        self.msg_queue.push(ipi_msg);
    }

    pub fn pop(&mut self) -> Option<IpiMessage> {
        self.msg_queue.pop()
    }
}

pub static CPU_INTERFACE_LIST: Mutex<Vec<CpuInterface>> = Mutex::new(Vec::new());

fn cpu_interface_init() {
    // Suppose only one cpu now. Ipi related, this function is not used now.
    let mut cpu_interface_list = CPU_INTERFACE_LIST.lock();
    cpu_interface_list.push(CpuInterface::default());
}

#[repr(C)]
#[repr(align(4096))]
pub struct Cpu{
    pub cpu_id: usize,
    pub cpu_state: CpuState,
    pub context_addr: Option<usize>,

    pub stack: [u8; CPU_STACK_SIZE],

    pub active_vcpu: Option<Vcpu>,
    pub vcpu_queue: Mutex<VecDeque<usize>>,

    pub current_irq: usize,
}

/// The base address of the per-CPU memory region.
static PER_CPU_BASE: Once<HostPhysAddr> = Once::new();

impl Cpu {
    const fn new(cpu_id: usize) -> Self {
        Cpu {
            cpu_id: cpu_id,
            cpu_state: CpuState::CpuInactive,
            context_addr: None,
            stack: [0; CPU_STACK_SIZE],
            active_vcpu: None,
            vcpu_queue: Mutex::new(VecDeque::new()),
            current_irq: 0,
        }
    }

    pub fn init(boot_id: usize, stack_size: usize, hypercrafthal: &dyn HyperCraftHal) -> HyperResult<()> {
        let cpu_nums: usize = 1;
        let pcpu_size = core::mem::size_of::<Cpu>() * cpu_nums;
        debug!("pcpu_size: {:#x}", pcpu_size);
        let pcpu_pages = hypercrafthal.alloc_pages((pcpu_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
            .ok_or(HyperError::NoMemory)?;
        debug!("pcpu_pages: {:#x}", pcpu_pages);
        PER_CPU_BASE.call_once(|| pcpu_pages);
        for cpu_id in 0..cpu_nums {
            if cpu_id != boot_id {
                hypercrafthal.alloc_pages((stack_size + PAGE_SIZE_4K - 1) / PAGE_SIZE_4K)
                    .ok_or(HyperError::NoMemory)?
            }
            let pcpu: Cpu = Self::new(cpu_id);
            let ptr = Self::ptr_for_cpu(cpu_id);
            // Safety: ptr is guaranteed to be properly aligned and point to valid memory owned by
            // PerCpu. No other CPUs are alive at this point, so it cannot be concurrently modified
            // either.
            unsafe { core::ptr::write(ptr as *mut Cpu, pcpu) };
        }

        // Initialize TP register and set this CPU online to be consistent with secondary CPUs.
        Self::setup_this_cpu(boot_id)?;

        Ok(())
    }

    /// Returns a pointer to the `PerCpu` for the given CPU.
    fn ptr_for_cpu(cpu_id: usize) -> *const Cpu {
        let pcpu_addr = PER_CPU_BASE.get().unwrap() + cpu_id * core::mem::size_of::<Cpu>();
        pcpu_addr as *const Cpu
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

    pub fn set_context_addr(&mut self, context: *mut ContextFrame) {
        self.context_addr = Some(context as usize);
    }

    pub fn clear_context_addr(&mut self) {
        self.context_addr = None;
    }

    pub fn set_gpr(&self, idx: usize, val: usize) {
        if idx >= CONTEXT_GPR_NUM {
            return;
        }
        match self.context_addr {
            Some(context_addr) => {
                let context = context_addr as *mut ContextFrame;
                unsafe {
                    (*context).set_gpr(idx, val);
                }
            }
            None => {}
        }
    }

    pub fn get_gpr(&self, idx: usize) -> usize {
        if idx >= CONTEXT_GPR_NUM {
            return 0;
        }
        match self.context_addr {
            Some(context_addr) => {
                if context_addr < 0x1000 {
                    panic!("illegal context addr {:x}", context_addr);
                }
                let context = context_addr as *mut ContextFrame;
                unsafe { (*context).gpr(idx) }
            }
            None => 0,
        }
    }

    pub fn get_elr(&self) -> usize {
        match self.context_addr {
            Some(context_addr) => {
                if context_addr < 0x1000 {
                    panic!("illegal context addr {:x}", context_addr);
                }
                let context = context_addr as *mut ContextFrame;
                unsafe { (*context).exception_pc() }
            }
            None => 0,
        }
    }

    pub fn get_spsr(&self) -> usize {
        match self.context_addr {
            Some(context_addr) => {
                if context_addr < 0x1000 {
                    panic!("illegal context addr {:x}", context_addr);
                }
                let context = context_addr as *mut ContextFrame;
                unsafe { (*context).spsr as usize }
            }
            None => 0,
        }
    }

    pub fn set_elr(&self, val: usize) {
        match self.context_addr {
            Some(context_addr) => {
                let context = context_addr as *mut ContextFrame;
                unsafe { (*context).set_exception_pc(val) }
            }
            None => {}
        }
    }

}


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

/* 
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

pub fn active_vcpu_id() -> usize {
    let active_vcpu = current_cpu().active_vcpu.clone().unwrap();
    active_vcpu.id()
}

pub fn active_vm_id() -> usize {
    let vm = active_vm().unwrap();
    vm.id()
}

pub fn active_vm() -> Option<Vm> {
    match current_cpu().active_vcpu.clone() {
        None => {
            return None;
        }
        Some(active_vcpu) => {
            return active_vcpu.vm();
        }
    }
}

pub fn active_vm_ncpu() -> usize {
    /* 
    match active_vm() {
        Some(vm) => vm.ncpu(),
        None => 0,
    }
    */
    0   // only one cpu
}
