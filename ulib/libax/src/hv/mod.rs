use axhal::mem::PhysAddr;
// use when creating vm
use axhal::mem::{phys_to_virt, virt_to_phys};
use axlog::debug;
pub use hvruntime::{GuestPageTable, HyperCraftHalImpl};
pub use hypercraft::GuestPageTableTrait;
use hypercraft::HyperCraftHal;
pub use hypercraft::HyperError as Error;
pub use hypercraft::HyperResult as Result;
pub use hypercraft::{HyperCallMsg, PerCpu, VCpu, VmCpus, VmExitInfo, VM};

// pub fn create_vcpu<H: HyperCraftHal>(
//     per_cpu: &mut PerCpu<H>,
//     entry: usize,
//     vcpu_id: usize,
// ) -> Result<VCpu<H>> {
//     let entry_virt = phys_to_virt(entry.into());
//     debug!("entry_virt: {:#x}", usize::from(entry_virt));
//     let vcpu = per_cpu.create_vcpu(entry_virt.into(), vcpu_id)?;
//     Ok(vcpu)
// }
