//! HyperCraft is a VMM crate.

#![no_std]
#![allow(
    clippy::upper_case_acronyms,
    clippy::single_component_path_imports,
    clippy::collapsible_match,
    clippy::default_constructed_unit_structs,
    dead_code,
    non_upper_case_globals,
    unused_imports,
    unused_assignments
)]
#![deny(missing_docs, warnings)]
#![feature(naked_functions, asm_const, negative_impls, stdsimd, inline_const)]

#[macro_use]
extern crate log;
#[macro_use]
extern crate alloc;

#[cfg(target_arch = "aarch64")]
#[path = "arch/aarch64/mod.rs"]
mod arch;
#[cfg(target_arch = "riscv64")]
#[path = "arch/riscv/mod.rs"]
mod arch;
#[cfg(target_arch = "x86_64")]
#[path = "arch/dummy.rs"]
mod arch;

mod hal;
mod memory;
mod traits;
mod vcpus;

/// HyperCraft Result Define.
pub type HyperResult<T = ()> = Result<T, HyperError>;


#[cfg(target_arch = "riscv64")]
pub use arch::{
    init_hv_runtime, GprIndex, HyperCallMsg, VmExitInfo,
};

pub use arch::{
    NestedPageTable, PerCpu, VCpu, VM,
};

pub use hal::HyperCraftHal;
pub use memory::{
    GuestPageNum, GuestPageTableTrait, GuestPhysAddr, GuestVirtAddr, HostPageNum, HostPhysAddr,
    HostVirtAddr,
};
pub use vcpus::VmCpus;

#[cfg(target_arch = "aarch64")]
pub use arch::lower_aarch64_synchronous;

/// The error type for hypervisor operation failures.
#[derive(Debug, PartialEq)]
pub enum HyperError {
    /// Internal error.
    Internal,
    /// No supported error.
    NotSupported,
    /// No memory error.
    NoMemory,
    /// Invalid parameter error.
    InvalidParam,
    /// Invalid instruction error.
    InvalidInstruction,
    /// Memory out of range error.
    OutOfRange,
    /// Bad state error.
    BadState,
    /// Not found error.
    NotFound,
    /// Fetch instruction error.
    FetchFault,
    /// Page fault error.
    PageFault,
    /// Decode error.
    DecodeError,
}
