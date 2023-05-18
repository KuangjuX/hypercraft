use core::arch::global_asm;

use arrayvec::ArrayVec;
use riscv_decode::Instruction;

use crate::{GuestPhysAddr, HyperError, HyperResult};
global_asm!(include_str!("mem_extable.S"));

extern "C" {
    fn _copy_to_guest(dest_gpa: usize, src: *const u8, len: usize) -> usize;
    fn _copy_from_guest(dest: *mut u8, src_gpa: usize, len: usize) -> usize;
    fn _fetch_guest_instruction(gva: usize, raw_inst: *mut u32) -> isize;
}

// Types of regions in a VM's guest physical address space.
#[derive(Copy, Clone, Debug, PartialEq, Eq)]
enum VmRegionType {
    // Memory that is private to this VM.
    Confidential,
    // Memory that is shared with the parent
    Shared,
    // Emulated MMIO region; accesses always cause a fault that is forwarded to the VM's host.
    Mmio,
    // IMSIC interrupt file pages.
    Imsic,
    // PCI BAR pages.
    Pci,
    // Memory that is private to this VM and marked removable.
    ConfidentialRemovable,
    // Memory that is shared with the host and marked removable.
    SharedRemovable,
}

/// A contiguous region of guest physical address space.
#[derive(Clone, Debug)]
pub struct VmRegion {
    start: GuestPhysAddr,
    end: GuestPhysAddr,
    region_type: VmRegionType,
}

/// The maximum number of distinct memory regions we support in `VmRegionList`.
const MAX_MEM_REGIONS: usize = 128;

/// The regions of guest physical address space for a VM. Used to track which parts of the address
/// space are designated for a particular purpose. Pages may only be inserted into a VM's address
/// space if the mapping falls within a region of the proper type.
pub struct VmRegionList {
    regions: ArrayVec<VmRegion, MAX_MEM_REGIONS>,
}

/// Represents the activate VM address space. Used to directly access a guest's memory.
#[derive(Default)]
pub struct VmPages;

impl VmPages {
    /// Fetches and decodes the instruction at `pc` in the guest's virtual address.
    pub fn fetch_guest_instruction(&self, pc: GuestPhysAddr) -> HyperResult<u32> {
        let mut raw_inst = 0u32;
        // Safety: _fetch_guest_instruction internally detects and handles an invalid guest virtual
        // address in `pc' and will only write up to 4 bytes to `raw_inst`.
        let ret = unsafe { _fetch_guest_instruction(pc, &mut raw_inst) };
        if ret < 0 {
            return Err(HyperError::FetchFault);
        }
        // let inst = riscv_decode::decode(raw_inst).map_err(|_| HyperError::DecodeError)?;
        Ok(raw_inst)
    }
}
