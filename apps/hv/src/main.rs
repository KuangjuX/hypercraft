#![no_std]
#![no_main]

extern crate alloc;

#[no_mangle]
fn main() {
    libax::println!("Hello, world!")
}
