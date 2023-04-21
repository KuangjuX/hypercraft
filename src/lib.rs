#![no_std]
#![allow(clippy::upper_case_acronyms, dead_code)]
#![deny(warnings)]

extern crate alloc;

// #[macro_use]
// extern crate log;

#[cfg(target_arch = "riscv64")]
#[path = "arch/riscv/mod.rs"]
mod arch;
mod hal;
mod memory;

pub type HyperResult<T = ()> = Result<T, HyperError>;

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
