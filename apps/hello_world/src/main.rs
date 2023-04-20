#![no_std]
#![no_main]

#[macro_use]
mod console;
mod sbi;

unsafe extern "C" fn hello_world() {}
