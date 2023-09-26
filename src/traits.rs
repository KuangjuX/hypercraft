#[cfg(target_arch = "riscv64")]
use crate::{GprIndex, VmExitInfo,};

use crate::arch::VCpu;
use crate::{
    GuestPageTableTrait, GuestPhysAddr, HyperCraftHal, HyperResult, VmCpus,
};

#[cfg(target_arch = "riscv64")]
/// Trait for VCpu struct.
pub trait VCpuTrait {
    /// Create a new vCPU
    fn new(vcpu_id: usize, entry: GuestPhysAddr) -> Self;

    /// Runs this vCPU until traps.
    fn run(&mut self) -> VmExitInfo;

    /// Gets one of the vCPU's general purpose registers.
    fn get_gpr(&self, index: GprIndex);

    /// Set one of the vCPU's general purpose register.
    fn set_gpr(&mut self, index: GprIndex, val: usize);

    /// Gets the vCPU's id.
    fn vcpu_id(&self) -> usize;
}

/// Trait for PerCpu struct.
pub trait PerCpuTrait<H: HyperCraftHal> {
    /// Initializes the `PerCpu` structures for each CPU. This (the boot CPU's) per-CPU
    /// area is initialized and loaded into TP as well.
    fn init(boot_hart_id: usize, stack_size: usize) -> HyperResult<()>;

    /// Initializes the `thread` pointer to point to PerCpu data.
    fn setup_this_cpu(hart_id: usize) -> HyperResult<()>;

    /// Create a `VCpu`, set the entry point to `entry` and bind this vcpu into the current CPU.
    fn create_vcpu(&mut self, vcpu_id: usize, entry: GuestPhysAddr) -> HyperResult<VCpu<H>>;

    /// Returns this CPU's `PerCpu` structure.
    fn this_cpu() -> &'static mut Self;
}

/// Trait for VM struct.
pub trait VmTrait<H: HyperCraftHal, G: GuestPageTableTrait> {
    /// Create a new VM with `vcpus` vCPUs and `gpt` as the guest page table.
    fn new(vcpus: VmCpus<H>, gpt: G) -> HyperResult<Self>
    where
        Self: Sized;

    /// Initialize `VCpu` by `vcpu_id`.
    fn init_vcpu(&mut self, vcpu_id: usize);

    /// Run the host VM's vCPU with ID `vcpu_id`. Does not return.
    fn run(&mut self, vcpu_id: usize);
}

/// Trait for NestedPageTable struct.
pub trait VmExitInfoTrait {
    /// Parse VM exit information from registers.
    fn from_regs(args: &[usize]) -> HyperResult<Self>
    where
        Self: Sized;
}

pub trait ContextFrameTrait {
    fn new(pc: usize, sp: usize, arg: usize) -> Self;
    fn exception_pc(&self) -> usize;
    fn set_exception_pc(&mut self, pc: usize);
    fn stack_pointer(&self) -> usize;
    fn set_stack_pointer(&mut self, sp: usize);
    fn set_argument(&mut self, arg: usize);
    fn set_gpr(&mut self, index: usize, val: usize);
    fn gpr(&self, index: usize) -> usize;
}
