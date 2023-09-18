use crate::{HyperCraftHal, GuestPageTableTrait, VmCpus, HyperResult};
use crate::arch::cpu::current_cpu;


#[repr(align(4096))]
pub struct VM<H: HyperCraftHal, G: GuestPageTableTrait> {
    vcpus: VmCpus<H>,
    gpt: G,
}

impl <H: HyperCraftHal, G: GuestPageTableTrait> VM<H, G> {
    pub fn new(vcpus: VmCpus<H>, gpt: G)-> HyperResult<Self> {
        Ok(Self { 
            vcpus: vcpus, 
            gpt: gpt, }
        )
    }

    pub fn init_vm_vcpu(&self, vcpu_id:usize, kernel_entry_point: usize, device_tree_ipa: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        vcpu.init(kernel_entry_point, device_tree_ipa);
    }

    pub fn run(&self, vcpu_id: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        
    }

    fn get_gpt_root_addr(&self) -> usize {
        self.gpt.token()
    }
}