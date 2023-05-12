use page_table::{PageTable64, PagingMetaData};
use page_table_entry::riscv::Rv64PTE;

pub struct Sv39GuestMetaData;

impl PagingMetaData for Sv39GuestMetaData {
    const LEVELS: usize = 3;
    const PA_MAX_BITS: usize = 56;
    // G-stage root page table: 16KiB
    const VA_MAX_BITS: usize = 41;
}

pub type NestedPageTable<I> = PageTable64<Sv39GuestMetaData, Rv64PTE, I>;
