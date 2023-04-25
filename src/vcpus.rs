use arrayvec::ArrayVec;

use crate::{HyperCraftHal, HyperError, HyperResult, VCpu};

/// The maximum number of CPUs we can support.
pub const MAX_CPUS: usize = 8;

pub const VM_CPUS_MAX: usize = MAX_CPUS;

#[derive(Default)]
pub struct VmCpus<H: HyperCraftHal> {
    inner: ArrayVec<Option<VCpu<H>>, VM_CPUS_MAX>,
}

impl<H: HyperCraftHal> VmCpus<H> {
    pub fn new() -> Self {
        let mut inner: ArrayVec<Option<VCpu<H>>, VM_CPUS_MAX> = ArrayVec::new_const();
        for _ in 0..VM_CPUS_MAX {
            inner.push(None);
        }
        Self { inner }
    }

    /// Adds the given vCPU to the set of vCPUs.
    pub fn add_vcpu(&mut self, vcpu: VCpu<H>) {
        let vcpu_id = vcpu.vcpu_id();
        self.inner[vcpu_id] = Some(vcpu);
    }

    /// Returns a reference to the vCPU with `vcpu_id` if it exists.
    pub fn get_vcpu(&mut self, vcpu_id: usize) -> HyperResult<&mut VCpu<H>> {
        let vcpu = self
            .inner
            .get_mut(vcpu_id)
            .ok_or(HyperError::NotFound)?
            .as_mut()
            .ok_or(HyperError::NotFound)?;
        Ok(vcpu)
    }
}
