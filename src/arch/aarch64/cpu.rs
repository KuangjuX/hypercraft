use alloc::vec::Vec;
use spin::Mutex;

use crate::arch::ipi::{IpiMessage, IPI_HANDLER_LIST};
use crate::arch::vcpu::Vcpu;
use crate::arch::vcpu_array::VcpuArray;
use crate::arch::vm::Vm;

use crate::arch::ContextFrame;
use crate::HyperCraftHal;
use crate::traits::ContextFrameTrait;

/// need to move to a suitable file?
const PAGE_SIZE_4K: usize = 0x1000;

pub const PLATFORM_CPU_NUM_MAX: usize = 8; 
pub const CPU_MASTER: usize = 0;
pub const CPU_STACK_SIZE: usize = PAGE_SIZE_4K * 128;
pub const CONTEXT_GPR_NUM: usize = 31;

/*#[repr(C)]
#[repr(align(4096))]
#[derive(Copy, Clone, Debug, Eq)]
pub struct CpuPt {
    pub lvl1: [usize; PTE_PER_PAGE],
    pub lvl2: [usize; PTE_PER_PAGE],
    pub lvl3: [usize; PTE_PER_PAGE],
}

impl PartialEq for CpuPt {
    fn eq(&self, other: &Self) -> bool {
        self.lvl1 == other.lvl1 && self.lvl2 == other.lvl2 && self.lvl3 == other.lvl3
    }
}*/

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
    let mut cpu_interface_list = CPU_INTERFACE_LIST.lock();
    for _ in 0..PLATFORM_CPU_NUM_MAX {
        cpu_interface_list.push(CpuInterface::default());
    }
}

#[repr(C)]
#[repr(align(4096))]
pub struct Cpu{
    pub cpu_id: usize,
    stack: [u8; CPU_STACK_SIZE],
    pub context_addr: Option<usize>,

    pub active_vcpu: Option<Vcpu>,
    vcpu_array: VcpuArray,

    // pub sched: SchedType, todo
    current_irq: usize,
    // pub cpu_pt: CpuPt,
}

impl Cpu{
    const fn default() -> Self {
        Cpu {
            cpu_id: 0,
            stack: [0; CPU_STACK_SIZE],
            context_addr: None,

            active_vcpu: None,
            vcpu_array: VcpuArray::new(),
            
            current_irq: 0,
            /*sched: SchedType::None,
            cpu_pt: CpuPt {
                lvl1: [0; PTE_PER_PAGE],
                lvl2: [0; PTE_PER_PAGE],
                lvl3: [0; PTE_PER_PAGE],
            },*/
        }
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
                if context_addr < 0x1000 {
                    panic!("illegal context addr {:x}", context_addr);
                }
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
                if context_addr < 0x1000 {
                    panic!("illegal context addr {:x}", context_addr);
                }
                let context = context_addr as *mut ContextFrame;
                unsafe { (*context).set_exception_pc(val) }
            }
            None => {}
        }
    }
/* 
    pub fn set_active_vcpu(&mut self, active_vcpu: Option<Vcpu>) {
        self.active_vcpu = active_vcpu.clone();
        match active_vcpu {
            None => {}
            Some(vcpu) => {
                vcpu.set_state(VcpuState::VcpuAct);
            }
        }
    }

    pub fn schedule_to(&mut self, next_vcpu: Vcpu) {
        if let Some(prev_vcpu) = &self.active_vcpu {
            if prev_vcpu.vm_id() != next_vcpu.vm_id() {
                // println!(
                //     "next vm{} vcpu {}, prev vm{} vcpu {}",
                //     next_vcpu.vm_id(),
                //     next_vcpu.id(),
                //     prev_vcpu.vm_id(),
                //     prev_vcpu.id()
                // );
                prev_vcpu.set_state(VcpuState::VcpuPend);
                prev_vcpu.context_vm_store();
            }
        }
        // NOTE: Must set active first and then restore context!!!
        //      because context restore while inject pending interrupt for VM
        //      and will judge if current active vcpu
        self.set_active_vcpu(Some(next_vcpu.clone()));
        next_vcpu.context_vm_restore();
        // restore vm's Stage2 MMU context
        let vttbr = (next_vcpu.vm_id() << 48) | next_vcpu.vm_pt_dir();
        // println!("vttbr {:#x}", vttbr);
        // TODO: replace the arch related expr
        unsafe {
            core::arch::asm!("msr VTTBR_EL2, {0}", "isb", in(reg) vttbr);
        }
    }

    pub fn scheduler(&mut self) -> &mut impl Scheduler {
        match &mut self.sched {
            SchedType::None => panic!("scheduler is None"),
            SchedType::SchedRR(rr) => rr,
        }
    }

    pub fn assigned(&self) -> bool {
        self.vcpu_array.vcpu_num() != 0
    }
*/
}

#[no_mangle]
#[link_section = ".cpu_private"]
pub static mut CPU: Cpu = Cpu::default();

pub fn current_cpu() -> &'static mut Cpu {
    unsafe { &mut CPU }
}

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
    match active_vm() {
        Some(vm) => vm.ncpu(),
        None => 0,
    }
}
/* 
pub fn cpu_init() {
    let cpu_id = current_cpu().id;
    if cpu_id == 0 {
        use crate::arch::power_arch_init;
        use crate::board::{Platform, PlatOperation};
        Platform::power_on_secondary_cores();
        power_arch_init();
        cpu_if_init();
    }

    let state = CpuState::CpuIdle;
    current_cpu().cpu_state = state;
    let sp = current_cpu().stack.as_ptr() as usize + CPU_STACK_SIZE;
    let size = core::mem::size_of::<ContextFrame>();
    current_cpu().set_ctx((sp - size) as *mut _);
    println!("Core {} init ok", cpu_id);

    crate::lib::barrier();
    // println!("after barrier cpu init");
    use crate::board::PLAT_DESC;
    if cpu_id == 0 {
        println!("Bring up {} cores", PLAT_DESC.cpu_desc.num);
        println!("Cpu init ok");
    }
}

pub fn cpu_idle() -> ! {
    let state = CpuState::CpuIdle;
    current_cpu().cpu_state = state;
    cpu_interrupt_unmask();
    loop {
        // TODO: replace it with an Arch function `arch_idle`
        cortex_a::asm::wfi();
    }
}
*/
pub static mut CPU_LIST: [Cpu; PLATFORM_CPU_NUM_MAX] = [const { Cpu::default() }; PLATFORM_CPU_NUM_MAX];

/*
#[no_mangle]
// #[link_section = ".text.boot"]
pub extern "C" fn cpu_map_self(cpu_id: usize) -> usize {
    let mut cpu = unsafe { &mut CPU_LIST[cpu_id] };
    (*cpu).id = cpu_id;

    let lvl1_addr = pt_map_banked_cpu(cpu);

    lvl1_addr
}
*/