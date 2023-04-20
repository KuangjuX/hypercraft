use crate::{HostPageNum, HostPhysAddr};

pub fn alloc_frame() -> Option<HostPhysAddr> {
    unsafe { hypercraft_alloc_frame() }
}

pub fn dealloc_frame(pa: HostPhysAddr) {
    unsafe { hypercraft_dealloc_frame(pa) }
}

#[cfg(target_arch = "riscv64")]
pub fn alloc_16_page() -> Option<HostPageNum> {
    unsafe { hypercraft_alloc_16_page() }
}

#[cfg(target_arch = "riscv64")]
pub fn dealloc_16_page(_ppn: HostPageNum) {
    unsafe { hypercraft_dealloc_16_page(_ppn) }
}

extern "Rust" {
    fn hypercraft_alloc_frame() -> Option<HostPhysAddr>;
    fn hypercraft_dealloc_frame(_pa: HostPhysAddr);
    #[cfg(target_arch = "riscv64")]
    fn hypercraft_alloc_16_page() -> Option<HostPageNum>;
    #[cfg(target_arch = "riscv64")]
    fn hypercraft_dealloc_16_page(_ppn: HostPageNum);
}
