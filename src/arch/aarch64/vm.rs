use crate::{HyperCraftHal, GuestPageTableTrait, VmCpus, HyperResult};


#[repr(align(4096))]
pub struct VM<H: HyperCraftHal, G: GuestPageTableTrait> {
    vcpus: VmCpus<H>,
    gpt: G,
    vm_id: usize,
}

impl <H: HyperCraftHal, G: GuestPageTableTrait> VM<H, G> {
    pub fn new(vcpus: VmCpus<H>, gpt: G, id: usize)-> HyperResult<Self> {
        Ok(Self { 
                vcpus: vcpus, 
                gpt: gpt, 
                vm_id: id
            }
        )
    }

    pub fn init_vm_vcpu(&self, vcpu_id:usize, kernel_entry_point: usize, device_tree_ipa: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        vcpu.init(kernel_entry_point, device_tree_ipa);
    }

    pub fn run(&self, vcpu_id: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        vcpu.run(self.get_vttbr_token());
    }

    fn get_vttbr_token(&self) -> usize {
        (self.vm_id << 48) | self.gpt.token()
    }
}