#![no_std]
#![allow(clippy::upper_case_acronyms, dead_code, non_upper_case_globals)]
#![deny(warnings)]
#![feature(naked_functions, asm_const)]

extern crate alloc;

// #[macro_use]
// extern crate log;

#[cfg(target_arch = "riscv64")]
#[path = "arch/riscv/mod.rs"]
mod arch;
mod hal;
mod memory;

pub type HyperResult<T = ()> = Result<T, HyperError>;

pub use arch::{ArchGuestPageTable, GprIndex, Guest, VCpu};
pub use hal::HyperCraftHal;
pub use memory::{
    GuestPageNum, GuestPageTable, GuestPhysAddr, GuestPhysMemorySetTrait, HostPageNum,
    HostPhysAddr, HostVirtAddr,
};

#[derive(Debug, PartialEq)]
pub enum HyperError {
    Internal,
    NotSupported,
    NoMemory,
    InvalidParam,
    OutOfRange,
    BadState,
    NotFound,
}
