use riscv::register::mcause::Interrupt;

use crate::{GuestPhysAddr, GuestVirtAddr};

use super::sbi::SbiMessage;

/// The privilege level at the time a trap occurred, as reported in sstatus.SPP or hstatus.SPVP.
#[derive(Copy, Clone, Debug)]
#[repr(u64)]
pub enum PrivilegeLevel {
    User = 0,
    Supervisor = 1,
}

/// Identifies the reason for a trap taken from a vCPU.
pub enum VmExitInfo {
    /// ECALLs from VS mode.
    Ecall(Option<SbiMessage>),
    /// G-stage page faluts
    PageFault {
        fault_addr: GuestPhysAddr,
        falut_pc: GuestVirtAddr,
        priv_level: PrivilegeLevel,
    },
    /// Instruction emulation trap
    VirtualInstruction {
        fault_pc: GuestVirtAddr,
        priv_level: PrivilegeLevel,
    },
    /// An interrupt intended for the vCPU's host.
    HostInterruot(Interrupt),
    /// An interrupt for the running vCPU that can't be delegated and must be injected. The
    /// interrupt is injected the vCPU is run.
    InterruptEmulation,
}
