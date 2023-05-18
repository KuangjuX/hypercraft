mod csrs;
mod detect;
mod devices;
mod ept;
mod regs;
mod sbi;
mod smp;
mod vcpu;
mod vm;
mod vm_pages;
mod vmexit;

use detect::detect_h_extension;
pub use ept::NestedPageTable;
pub use regs::GprIndex;
pub use sbi::SbiMessage as HyperCallMsg;
pub use smp::PerCpu;
pub use vcpu::VCpu;
pub use vm::VM;
pub use vmexit::VmExitInfo;

use self::csrs::{traps, ReadWriteCsr, RiscvCsrTrait, CSR};
use self::devices::plic::PlicState;
use self::vcpu::VmCpuRegisters;

pub fn init_hv_runtime() {
    unsafe {
        setup_csrs();
    }
}

/// Initialize (H)S-level CSRs to a reasonable state.
unsafe fn setup_csrs() {
    // Delegate some synchronous exceptions.
    CSR.hedeleg.write_value(
        traps::exception::INST_ADDR_MISALIGN
            | traps::exception::BREAKPOINT
            | traps::exception::ENV_CALL_FROM_U_OR_VU
            | traps::exception::INST_PAGE_FAULT
            | traps::exception::LOAD_PAGE_FAULT
            | traps::exception::STORE_PAGE_FAULT
            | traps::exception::ILLEGAL_INST,
    );

    // Delegate all interupts.
    CSR.hideleg.write_value(
        traps::interrupt::VIRTUAL_SUPERVISOR_TIMER
            | traps::interrupt::VIRTUAL_SUPERVISOR_EXTERNAL
            | traps::interrupt::VIRTUAL_SUPERVISOR_SOFT,
    );

    // Clear all interrupts.
    CSR.hvip.read_and_clear_bits(
        traps::interrupt::VIRTUAL_SUPERVISOR_TIMER
            | traps::interrupt::VIRTUAL_SUPERVISOR_EXTERNAL
            | traps::interrupt::VIRTUAL_SUPERVISOR_SOFT,
    );

    // clear all interrupts.
    CSR.hcounteren.write_value(0xffff_ffff);

    // enable interrupt
    CSR.sie.read_and_set_bits(
        traps::interrupt::SUPERVISOR_EXTERNAL
            | traps::interrupt::SUPERVISOR_SOFT
            | traps::interrupt::SUPERVISOR_TIMER,
    );
}
