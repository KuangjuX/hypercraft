use crate::{GuestPhysAddr, HyperCraftHal, HyperResult, VCpu};

pub trait Cpu<H: HyperCraftHal> {
    /// create virtual cpu in current cpu.
    fn create_vcpu(&mut self, entry: GuestPhysAddr) -> HyperResult<VCpu<H>>;
}
