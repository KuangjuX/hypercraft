#![no_std]
#![no_main]

#[link_section = ".text.text"]
#[no_mangle]
unsafe extern "C" fn hello_world() {
    println!("Hello World!");
}

#[naked]
#[link_section = ".text.entry"]
#[export_name = "_start"]
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
