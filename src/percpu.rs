use core::marker::PhantomData;

use crate::{arch, GuestPhysAddr, HyperCraftHal, HyperResult, VCpu};

pub fn has_hardware_support() -> bool {
    arch::has_hardware_support()
}

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
        if !has_hardware_support() {
            Err(crate::HyperError::BadState)
        } else {
            Ok(VCpu::<H>::create(entry))
        }
    }
}
