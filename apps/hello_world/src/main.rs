#![no_std]
#![no_main]
#![feature(panic_info_message, naked_functions, asm_const, alloc_error_handler)]

use hyp_alloc::{frame_alloc, frame_dealloc, PhysPageNum};
use hypercraft::{Guest, GuestPhysAddr, HostPhysAddr, HyperCraftHal, VCpu};

#[macro_use]
mod console;
mod hyp_alloc;
mod lang_items;
mod sbi;

extern crate alloc;

unsafe extern "C" fn hello_world() {
    println!("Hello World!")
}

#[naked]
unsafe extern "C" fn setup_guest() {
    core::arch::asm!(
        // prepare stack
        "la sp, {boot_stack}",
        "li t2, {boot_stack_size}",
        "addi t3, a0, 1",
        "mul t2, t2, t3",
        "add sp, sp, t2",
        "li t1, {guest_main}",
        "jr t1",
        boot_stack = sym GUEST_STACK,
        boot_stack_size = const BOOT_STACK_SIZE,
        guest_main = const 0x9000_1000_usize,
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

    fn vmexit_handler(vcpu: &mut hypercraft::VCpu<Self>) {
        use riscv::register::scause::*;
        match vcpu.trap_cause() {
            Some(Trap::Exception(Exception::VirtualSupervisorEnvCall)) => {
                panic!()
            }
            _ => panic!(),
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
fn hentry() -> ! {
    clear_bss();
    hyp_alloc::heap_init();
    println!("Starting virtualization...");
    // Copy BIOS and guest image
    unsafe {
        core::ptr::copy(
            setup_guest as usize as *const u8,
            0x9000_0000 as *mut u8,
            0x1000,
        );

        core::ptr::copy(
            hello_world as usize as *const u8,
            0x9000_1000 as *mut u8,
            0x1000,
        );
    }
    // create vcpu
    let mut vcpu = VCpu::<HyperCraftHalImpl>::create(0x9000_0000);

    // run vcpu
    vcpu.run();

    unreachable!();
}
