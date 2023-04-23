use crate::{HyperCraftHal, HyperResult};

pub type GuestPhysAddr = usize;
pub type GuestVirtAddr = usize;
pub type HostPhysAddr = usize;
pub type HostVirtAddr = usize;
pub type GuestPageNum = usize;
pub type HostPageNum = usize;

pub trait IntoRvmPageTableFlags: core::fmt::Debug {
    // TODO: cache policy
    fn is_read(&self) -> bool;
    fn is_write(&self) -> bool;
    fn is_execute(&self) -> bool;
    fn is_user(&self) -> bool;
}

pub trait GuestPageTable<H: HyperCraftHal> {
    fn new() -> Self;
    /// Map a guest physical frame starts from `gpa` to the host physical
    /// frame starts from of `hpa` with `flags`.
    fn map(
        &mut self,
        gpa: GuestPhysAddr,
        hpa: HostPhysAddr,
        flags: impl IntoRvmPageTableFlags,
    ) -> HyperResult;

    /// Unmap the guest physical frame `hpa`
    fn unmap(&mut self, gpa: GuestPhysAddr) -> HyperResult;

    /// Translate the host physical address which the guest physical frame of
    /// `gpa` maps to.
    fn translate(&self, gpa: GuestPhysAddr) -> HyperResult<HostPhysAddr>;

    /// Get guest page table token.
    fn token(&self) -> usize;
}

pub trait GuestPhysMemorySetTrait: core::fmt::Debug + Send + Sync {
    /// Physical address space size.
    fn size(&self) -> u64;

    /// Add a contiguous guest physical memory region and create mapping,
    /// with the target host physical address `hpa`(optional)
    fn map(&self, gpa: GuestPhysAddr, size: usize, hpa: Option<HostPhysAddr>) -> HyperResult;

    /// Remove a guest physical memory region, destroy the mapping.
    fn unmap(&self, gpa: GuestPhysAddr, size: usize) -> HyperResult;

    /// Read from guest address space.
    fn read_memory(&self, gpa: GuestPhysAddr, buf: &mut [u8]) -> HyperResult;

    /// Write to guest address space.
    fn write_memory(&self, gpa: GuestPhysAddr, buf: &[u8]) -> HyperResult;

    /// Called when accessed a non-maped guest physical address `gpa`.
    fn handle_page_fault(&self, gpa: GuestPhysAddr) -> HyperResult;

    /// Return page table token.
    fn token(&self) -> usize;
}
