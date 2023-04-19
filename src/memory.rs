use crate::HyperResult;

pub type GuestPhysAddr = usize;
pub type HostPhysAddr = usize;
pub type HostVirtAddr = usize;

pub trait IntoRvmPageTableFlags: core::fmt::Debug {
    // TODO: cache policy
    fn is_read(&self) -> bool;
    fn is_write(&self) -> bool;
    fn is_execute(&self) -> bool;
    fn is_user(&self) -> bool;
}

pub trait GuestPageTable {
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
