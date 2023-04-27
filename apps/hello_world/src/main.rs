#![no_std]
#![no_main]
#![feature(panic_info_message, naked_functions, asm_const, alloc_error_handler)]

use hyp_alloc::{frame_alloc, frame_dealloc, PhysPageNum};
use hypercraft::{
    Guest, GuestPhysAddr, HostPhysAddr, HyperCraftHal, HyperCraftPerCpu, VCpu, VmCpus, VmExitInfo,
    VM,
};
use riscv::register::sepc;
use sbi::shutdown;
use sbi_rt::system_reset;

use crate::sbi::{console_putchar, SBI_CONSOLE_PUTCHAR};

#[macro_use]
extern crate log;

#[macro_use]
mod console;
#[macro_use]
mod logging;
mod hyp_alloc;
mod lang_items;
mod sbi;

extern crate alloc;

#[link_section = ".guest_text.text"]
#[no_mangle]
unsafe extern "C" fn hello_world() {
    println!("Hello World!");
    panic!()
}

#[naked]
#[link_section = ".guest_text.entry"]
#[no_mangle]
unsafe extern "C" fn setup_guest() {
    core::arch::asm!(
        // prepare stack
        "la sp, {boot_stack}",
        "li t2, {boot_stack_size}",
        "addi t3, a0, 1",
        "mul t2, t2, t3",
        "add sp, sp, t2",
        "la t1, {guest_main}",
        "jr t1",
        boot_stack = sym GUEST_STACK,
        boot_stack_size = const BOOT_STACK_SIZE,
        guest_main = sym hello_world,
        options(noreturn)
    )
}

const PAGE_SIZE: usize = 0x1000;
/// hypervisor boot stack size
const BOOT_STACK_SIZE: usize = 16 * PAGE_SIZE;

/// Guest start address
const GUEST_START: usize = 0x9000_0000;

#[link_section = ".bss.stack"]
/// hypervisor boot stack
static BOOT_STACK: [u8; BOOT_STACK_SIZE] = [0u8; BOOT_STACK_SIZE];

#[link_section = ".gstack"]
static GUEST_STACK: [u8; BOOT_STACK_SIZE] = [0u8; BOOT_STACK_SIZE];

///# Safety
///
/// hypervisor entry point
#[link_section = ".text.entry"]
#[export_name = "_start"]
#[naked]
pub unsafe extern "C" fn start() -> ! {
    core::arch::asm!(
        // prepare stack
        "la sp, {boot_stack}",
        "li t2, {boot_stack_size}",
        "addi t3, a0, 1",
        "mul t2, t2, t3",
        "add sp, sp, t2",
        // enter hentry
        "call hentry",
        boot_stack = sym BOOT_STACK,
        boot_stack_size = const BOOT_STACK_SIZE,
        options(noreturn)
    )
}

pub struct HyperCraftHalImpl;

impl HyperCraftHal for HyperCraftHalImpl {
    fn alloc_page() -> Option<HostPhysAddr> {
        let ppn = frame_alloc().unwrap().ppn;
        Some(ppn.0 << 12)
    }

    fn alloc_16_page() -> Option<hypercraft::HostPageNum> {
        None
    }

    fn dealloc_page(pa: HostPhysAddr) {
        frame_dealloc(PhysPageNum(pa >> 12));
    }

    fn dealloc_16_page(ppn: hypercraft::HostPageNum) {}

    fn vmexit_handler(vcpu: &mut hypercraft::VCpu<Self>, vm_exit_info: VmExitInfo) {
        match vm_exit_info {
            VmExitInfo::Ecall(sbi_msg) => {
                if let Some(sbi_msg) = sbi_msg {
                    match sbi_msg {
                        hypercraft::HyperCallMsg::PutChar(c) => {
                            console_putchar(c);
                            vcpu.advance_pc(4);
                        }
                        hypercraft::HyperCallMsg::Reset(reset) => shutdown(),
                        _ => todo!(),
                    }
                } else {
                    panic!()
                }
            }
            _ => todo!(),
        }
    }
}

/// clear BSS segment
fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    unsafe {
        core::slice::from_raw_parts_mut(sbss as usize as *mut u8, ebss as usize - sbss as usize)
            .fill(0);
    }
}

#[no_mangle]
fn hentry(hart_id: usize) -> ! {
    clear_bss();
    hyp_alloc::heap_init();
    logging::init();
    println!("Booting on CPU{} (hart {})", hart_id, hart_id);
    // println!("setup_guest addr: {:#x}", setup_guest as usize);
    // println!("hello_world addr: {:#x}", hello_world as usize);
    // println!("guest_stack addr: {:#x}", GUEST_STACK.as_ptr() as usize);
    assert_eq!(setup_guest as usize, 0x9000_0000);
    assert_eq!(hello_world as usize, 0x9000_1000);
    assert_eq!(GUEST_STACK.as_ptr() as usize, 0x9020_0000);

    // create vcpu
    let percpu = HyperCraftPerCpu::<HyperCraftHalImpl>::new(0);
    let mut vcpu = percpu.create_vcpu(GUEST_START).unwrap();
    let mut vcpus = VmCpus::new();
    // add vcpu into vm
    vcpus.add_vcpu(vcpu);
    let mut vm = VM::new(vcpus).unwrap();

    // vm run
    vm.run(0);

    unreachable!();
}
