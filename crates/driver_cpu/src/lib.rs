//! ref: https://github.com/rivosinc/salus/blob/main/drivers/src/cpu.rs

#![no_std]

use arrayvec::{ArrayString, ArrayVec};

const MAX_ISA_STRING_LEN: usize = 256;

/// The maximum number of CPUs we can support.
pub const MAX_CPUS: usize = 128;

/// Holds static global information about CPU features and topology.
#[derive(Debug)]
pub struct CpuInfo {
    // True if the AIA extension is supported.
    has_aia: bool,
    // True if the Sstc extension is supported.
    has_sstc: bool,
    // True if the Sscofpmf extension is supported.
    has_sscofpmf: bool,
    // True if the vector extension is supported
    has_vector: bool,
    // CPU timer frequency.
    timer_frequency: u32,
    // ISA string as reported in the device-tree. All CPUs are expected to have the same ISA.
    isa_string: ArrayString<MAX_ISA_STRING_LEN>,
    // Mapping of logical CPU index to hart IDs.
    hart_ids: ArrayVec<u32, MAX_CPUS>,
    // Mapping of logical CPU index to the CPU's 'interrupt-controller' phandle in the device-tree.
    intc_phandles: ArrayVec<u32, MAX_CPUS>,
}
