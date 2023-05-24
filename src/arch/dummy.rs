use crate::{GuestPageTableTrait, HyperCraftHal};
use page_table::PagingIf;

pub fn init_hv_runtime() {
    todo!()
}

pub enum GprIndex {}

pub enum HyperCallMsg {}

pub struct NestedPageTable<I: PagingIf> {
    _marker: core::marker::PhantomData<I>,
}

pub struct VCpu<H: HyperCraftHal> {
    _marker: core::marker::PhantomData<H>,
}

impl<H: HyperCraftHal> VCpu<H> {
    pub fn vcpu_id(&self) -> usize {
        todo!()
    }
}

pub struct VM<H: HyperCraftHal> {
    _marker: core::marker::PhantomData<H>,
}

pub struct PerCpu<H: HyperCraftHal> {
    _marker: core::marker::PhantomData<H>,
}

pub struct VmExitInfo {}
