use crate::{GuestPageTableTrait, HyperCraftHal};
use page_table::PagingIf;

/// Initialize the hypervisor runtime.
pub fn init_hv_runtime() {
    todo!()
}

/// General purpose register index.
pub enum GprIndex {}

/// Hypercall message.
pub enum HyperCallMsg {}

/// Nested page table define.
pub struct NestedPageTable<I: PagingIf> {
    _marker: core::marker::PhantomData<I>,
}

/// VCpu define.
pub struct VCpu<H: HyperCraftHal> {
    _marker: core::marker::PhantomData<H>,
}

impl<H: HyperCraftHal> VCpu<H> {
    /// Get the vcpu id.
    pub fn vcpu_id(&self) -> usize {
        todo!()
    }
}

/// VM define.
pub struct VM<H: HyperCraftHal> {
    _marker: core::marker::PhantomData<H>,
}

/// PerCpu define.
pub struct PerCpu<H: HyperCraftHal> {
    _marker: core::marker::PhantomData<H>,
}

/// VM exit information.
pub struct VmExitInfo {}
