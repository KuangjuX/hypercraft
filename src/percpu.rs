use crate::{GuestPageTableTrait, GuestPhysAddr, HyperCraftHal, HyperResult, VCpu};

pub trait Cpu<H: HyperCraftHal, G: GuestPageTableTrait> {
    /// create virtual cpu in current physical cpu
    fn create_vcpu(&mut self, entry: GuestPhysAddr) -> HyperResult<VCpu<H, G>>;
}
