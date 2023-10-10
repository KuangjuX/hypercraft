use crate::{HyperCraftHal, GuestPageTableTrait, VmCpus, HyperResult};

/// The guest VM
#[repr(align(4096))]
pub struct VM<H: HyperCraftHal, G: GuestPageTableTrait> {
    /// The vcpus belong to VM
    vcpus: VmCpus<H>,
    /// The guest page table of VM
    gpt: G,
    /// VM id
    vm_id: usize,
}

impl <H: HyperCraftHal, G: GuestPageTableTrait> VM<H, G> {
    /// Create a new VM
    pub fn new(vcpus: VmCpus<H>, gpt: G, id: usize)-> HyperResult<Self> {
        Ok(Self { 
                vcpus: vcpus, 
                gpt: gpt, 
                vm_id: id
            }
        )
    }

    /// Init VM vcpu by vcpu id. Set kernel entry point.
    pub fn init_vm_vcpu(&mut self, vcpu_id:usize, kernel_entry_point: usize, device_tree_ipa: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        vcpu.init(kernel_entry_point, device_tree_ipa);
    }

    /// Run this VM.
    pub fn run(&mut self, vcpu_id: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        let vttbr_token = (self.vm_id << 48) | self.gpt.token();
        debug!("vttbr_token: 0x{:X}", self.gpt.token());
        vcpu.run(vttbr_token);
    }
}
