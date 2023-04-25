use crate::{HyperCraftHal, HyperResult, VmCpus};

/// A VM that is being run.
pub struct VM<H: HyperCraftHal> {
    vcpus: VmCpus<H>,
}

impl<H: HyperCraftHal> VM<H> {
    pub fn new(vcpus: VmCpus<H>) -> HyperResult<Self> {
        Ok(Self { vcpus })
    }

    /// Run the host VM's vCPU with ID `vcpu_id`. Does not return.
    pub fn run(&mut self, vcpu_id: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        loop {
            let vm_exit_info = vcpu.run();

            H::vmexit_handler(vcpu, vm_exit_info);
        }
    }
}
