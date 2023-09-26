use page_table::{PageTable64, PagingMetaData};
use page_table_entry::aarch64::A64PTE;

/// Metadata of AArch64 hypervisor page tables (ipa to hpa).
#[derive(Copy, Clone)]
pub struct A64HVPagingMetaData;

impl PagingMetaData for A64HVPagingMetaData {
    const LEVELS: usize = 3;
    const PA_MAX_BITS: usize = 48;  // In Armv8.0-A, the maximum size for a physical address is 48 bits.

                                    // The size of the IPA space can be configured in the same way as the 
    const VA_MAX_BITS: usize = 36;  //  virtual address space. VTCR_EL2.T0SZ controls the size.
}
/// According to rust shyper, AArch64 translation table.
pub type NestedPageTable<I> = PageTable64<A64HVPagingMetaData, A64PTE, I>;
