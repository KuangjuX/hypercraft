mod csrs;
mod detect;
mod ept;
mod guest;
mod regs;
mod sbi;
mod smp;
mod vcpu;
mod vm;
mod vm_pages;
mod vmexit;

use detect::detect_h_extension;
pub use ept::NestedPageTable;
pub use guest::Guest;
pub use regs::GprIndex;
pub use sbi::SbiMessage as HyperCallMsg;
pub use smp::PerCpu;
pub use vcpu::VCpu;
pub use vm::VM;
pub use vmexit::VmExitInfo;

use self::csrs::{traps, Hcounteren, Hedeleg, Hideleg, RiscvCsrTrait, HVIP};

/// Initialize (H)S-level CSRs to a reasonable state.
pub unsafe fn setup_csrs() {
    // Delegate some synchronous exceptions.
    let hedeleg = Hedeleg::new();
    hedeleg.write_value(
        traps::exception::INST_ADDR_MISALIGN
            | traps::exception::BREAKPOINT
            | traps::exception::ENV_CALL_FROM_U_OR_VU
            | traps::exception::INST_PAGE_FAULT
            | traps::exception::LOAD_PAGE_FAULT
            | traps::exception::STORE_PAGE_FAULT,
    );

    // Delegate all interupts.
    let hideleg = Hideleg::new();
    hideleg.write_value(
        traps::interrupt::VIRTUAL_SUPERVISOR_TIMER
            | traps::interrupt::VIRTUAL_SUPERVISOR_EXTERNAL
            | traps::interrupt::VIRTUAL_SUPERVISOR_SOFT,
    );

    let hvip = HVIP::new();
    hvip.write_value(
        traps::interrupt::VIRTUAL_SUPERVISOR_TIMER
            | traps::interrupt::VIRTUAL_SUPERVISOR_EXTERNAL
            | traps::interrupt::VIRTUAL_SUPERVISOR_SOFT,
    );

    // clear all interrupts.
    let hcounteren = Hcounteren::new();
    hcounteren.write_value(0xffff_ffff_ffff_ffff);
}
