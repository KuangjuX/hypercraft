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

    pub fn run(&self, vcpu_id: usize) {
        let vcpu = self.vcpus.get_vcpu(vcpu_id).unwrap();
        
    }
}