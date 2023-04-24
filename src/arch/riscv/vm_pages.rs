use arrayvec::ArrayVec;

use crate::GuestPhysAddr;

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
