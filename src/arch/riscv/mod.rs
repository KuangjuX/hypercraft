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

use self::csrs::{hcounteren, hedeleg, hideleg, hvip, traps};

/// Initialize (H)S-level CSRs to a reasonable state.
pub unsafe fn setup_csrs() {
    // Delegate some synchronous exceptions.
    hedeleg::write(
        traps::exception::INST_ADDR_MISALIGN
            | traps::exception::BREAKPOINT
            | traps::exception::ENV_CALL_FROM_U_OR_VU
            | traps::exception::INST_PAGE_FAULT
            | traps::exception::LOAD_PAGE_FAULT
            | traps::exception::STORE_PAGE_FAULT,
    );

    // Delegate all interupts.
    hideleg::write(
        traps::interrupt::VIRTUAL_SUPERVISOR_TIMER
            | traps::interrupt::VIRTUAL_SUPERVISOR_EXTERNAL
            | traps::interrupt::VIRTUAL_SUPERVISOR_SOFT,
    );

    hvip::read_and_clear_bits(
        traps::interrupt::VIRTUAL_SUPERVISOR_TIMER
            | traps::interrupt::VIRTUAL_SUPERVISOR_EXTERNAL
            | traps::interrupt::VIRTUAL_SUPERVISOR_SOFT,
    );

    // clear all interrupts.
    hcounteren::write(0xffff_ffff);
}
