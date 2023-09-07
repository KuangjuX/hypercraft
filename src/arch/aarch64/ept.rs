use page_table::{PageTable64, PagingMetaData};
use page_table_entry::aarch64::A64PTE;

/// Metadata of AArch64 hypervisor page tables (ipa to hpa).
#[derive(Copy, Clone)]
pub struct A64HVPagingMetaData;

impl PagingMetaData for A64HVPagingMetaData {
    const LEVELS: usize = 3;
    const PA_MAX_BITS: usize = 48;
    const VA_MAX_BITS: usize = 48;
}
/// According to rust shyper, AArch64 translation table.
pub type A64HVPageTable<I> = PageTable64<A64HVPagingMetaData, A64PTE, I>;
