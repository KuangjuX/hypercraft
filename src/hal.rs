use crate::{HostPageNum, HostPhysAddr, VmExitInfo};

/// The interfaces which the underlginh software(kernel or hypervisor) must implement.
pub trait HyperCraftHal: Sized {
    /// Allocates a 4K-sized contiguous physical page, returns its physical address.
    fn alloc_page() -> Option<HostPhysAddr>;
    /// Deallocates the given physical page.
    fn dealloc_page(pa: HostPhysAddr);
    /// Allocates a 16K-sized & 16K-align physical page, uesd in root page table.
    #[cfg(target_arch = "riscv64")]
    fn alloc_16_page() -> Option<HostPageNum>;
    /// Deallocates the given 16K-sized physical page.
    #[cfg(target_arch = "riscv64")]
    fn dealloc_16_page(ppn: HostPageNum);
    /// VM-Exit handler
    fn vmexit_handler(vcpu: &mut crate::VCpu<Self>, vm_exit_info: VmExitInfo);
}
