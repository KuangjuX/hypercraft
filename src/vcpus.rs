use alloc::boxed::Box;
use arrayvec::ArrayVec;
use spin::Once;

use crate::arch::{VCpu, VM};
use crate::{GuestPageTableTrait, HyperCraftHal, HyperError, HyperResult,};


/// The maximum number of CPUs we can support.
pub const MAX_CPUS: usize = 8;

pub const VM_CPUS_MAX: usize = MAX_CPUS;

/// The set of vCPUs in a VM.
#[derive(Default)]
pub struct VmCpus<H: HyperCraftHal> {
    inner: [Once<VCpu<H>>; VM_CPUS_MAX],
    marker: core::marker::PhantomData<H>,
}

impl<H: HyperCraftHal> VmCpus<H> {
    /// Creates a new vCPU tracking structure.
    pub fn new() -> Self {
        Self {
            inner: [Once::INIT; VM_CPUS_MAX],
            marker: core::marker::PhantomData,
        }
    }

    /// Adds the given vCPU to the set of vCPUs.
    pub fn add_vcpu(&mut self, vcpu: VCpu<H>) -> HyperResult<()> {
        let vcpu_id = vcpu.vcpu_id();
        let once_entry = self.inner.get(vcpu_id).ok_or(HyperError::BadState)?;

        once_entry.call_once(|| vcpu);
        Ok(())
    }

    /// Returns a reference to the vCPU with `vcpu_id` if it exists.
    pub fn get_vcpu(&mut self, vcpu_id: usize) -> HyperResult<&mut VCpu<H>> {
        let vcpu = self
            .inner
            .get_mut(vcpu_id)
            .and_then(|once| once.get_mut())
            .ok_or(HyperError::NotFound)?;
        Ok(vcpu)
    }
}

// Safety: Each VCpu is wrapped with a Mutex to provide safe concurrent access to VCpu.
unsafe impl<H: HyperCraftHal> Sync for VmCpus<H> {}
unsafe impl<H: HyperCraftHal> Send for VmCpus<H> {}
