#![no_std]
#![allow(
    clippy::upper_case_acronyms,
    clippy::single_component_path_imports,
    dead_code,
    non_upper_case_globals,
    unused_imports
)]
#![deny(warnings)]
#![feature(naked_functions, asm_const)]

extern crate alloc;

#[macro_use]
extern crate log;

#[cfg(target_arch = "riscv64")]
#[path = "arch/riscv/mod.rs"]
mod arch;
mod hal;
mod memory;
mod percpu;
mod vcpus;

pub type HyperResult<T = ()> = Result<T, HyperError>;

pub use arch::{ArchGuestPageTable, GprIndex, Guest, HyperCallMsg, VCpu, VmExitInfo, VM};
pub use hal::HyperCraftHal;
pub use memory::{
    GuestPageNum, GuestPageTable, GuestPhysAddr, GuestPhysMemorySetTrait, GuestVirtAddr,
    HostPageNum, HostPhysAddr, HostVirtAddr,
};
pub use percpu::HyperCraftPerCpu;
pub use vcpus::VmCpus;

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
