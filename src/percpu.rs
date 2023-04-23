use core::marker::PhantomData;

use crate::{GuestPhysAddr, HyperCraftHal, HyperResult, VCpu};

pub struct HyperCraftPerCpu<H: HyperCraftHal> {
    _cpu_id: usize,
    marker: PhantomData<H>,
}

impl<H: HyperCraftHal> HyperCraftPerCpu<H> {
    /// Create an uninitialized instance
    pub fn new(cpu_id: usize) -> Self {
        Self {
            _cpu_id: cpu_id,
            marker: PhantomData,
        }
    }

    pub fn create_vcpu(&self, entry: GuestPhysAddr) -> HyperResult<VCpu<H>> {
        Ok(VCpu::create(entry))
    }
}
