#![no_std]
#![allow(clippy::upper_case_acronyms)]
#![deny(warnings)]

// #[macro_use]
// extern crate alloc;

// #[macro_use]
// extern crate log;

#[cfg(target_arch = "riscv")]
#[path = "arch/riscv/mod.rs"]
mod arch;
mod memory;

pub type HyperResult<T = ()> = Result<T, HyperError>;

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
