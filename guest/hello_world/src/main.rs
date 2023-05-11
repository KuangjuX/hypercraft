#![no_std]
#![no_main]
#![feature(naked_functions, asm_const)]
#![allow(deprecated)]

#[no_mangle]
unsafe extern "C" fn hello_world() {
    sbi_rt::legacy::console_putchar('[' as usize);
    sbi_rt::legacy::console_putchar('G' as usize);
    sbi_rt::legacy::console_putchar('U' as usize);
    sbi_rt::legacy::console_putchar('E' as usize);
    sbi_rt::legacy::console_putchar('S' as usize);
    sbi_rt::legacy::console_putchar('T' as usize);
    sbi_rt::legacy::console_putchar(']' as usize);
    sbi_rt::legacy::console_putchar(' ' as usize);
    sbi_rt::legacy::console_putchar('h' as usize);
    sbi_rt::legacy::console_putchar('e' as usize);
    sbi_rt::legacy::console_putchar('l' as usize);
    sbi_rt::legacy::console_putchar('l' as usize);
    sbi_rt::legacy::console_putchar('o' as usize);
    sbi_rt::legacy::console_putchar(' ' as usize);
    sbi_rt::legacy::console_putchar('w' as usize);
    sbi_rt::legacy::console_putchar('o' as usize);
    sbi_rt::legacy::console_putchar('r' as usize);
    sbi_rt::legacy::console_putchar('l' as usize);
    sbi_rt::legacy::console_putchar('d' as usize);
    sbi_rt::legacy::console_putchar('\n' as usize);
}

const BOOT_STACK_SIZE: usize = 0x4000;

#[link_section = ".bss.stack"]
#[no_mangle]
/// hypervisor boot stack
static BOOT_STACK: [u8; BOOT_STACK_SIZE] = [0u8; BOOT_STACK_SIZE];

#[naked]
#[link_section = ".text.entry"]
#[no_mangle]
unsafe extern "C" fn _start() -> ! {
    core::arch::asm!(
        // prepare stack
        "la sp, {boot_stack}",
        "li t2, {boot_stack_size}",
        "addi t3, a0, 1",
        "mul t2, t2, t3",
        "add sp, sp, t2",
        "la t1, {guest_main}",
        "jr t1",
        boot_stack = sym BOOT_STACK,
        boot_stack_size = const BOOT_STACK_SIZE,
        guest_main = sym hello_world,
        options(noreturn)
    )
}

use core::panic::PanicInfo;

#[panic_handler]
/// panic handler
fn panic(_info: &PanicInfo) -> ! {
    sbi_rt::system_reset(sbi_rt::Shutdown, sbi_rt::SystemFailure);
    unreachable!()
}
