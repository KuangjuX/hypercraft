use riscv::register::mcause::Interrupt;

use crate::{GuestPhysAddr, GuestVirtAddr};
use tock_registers::LocalRegisterCopy;

use super::{csrs::defs::hstatus, sbi::SbiMessage};

/// The privilege level at the time a trap occurred, as reported in sstatus.SPP or hstatus.SPVP.
#[derive(Copy, Clone, Debug)]
#[repr(u64)]
pub enum PrivilegeLevel {
    User = 0,
    Supervisor = 1,
}

impl PrivilegeLevel {
    pub fn from_hstatus(csr: usize) -> Self {
        let val = LocalRegisterCopy::<usize, hstatus::Register>::new(csr);
        match val.read(hstatus::spvp) {
            0 => Self::User,
            1 => Self::Supervisor,
            _ => unreachable!(), // Field is only 1-bit wide.
        }
    }
}

#[derive(Debug, Clone, Copy)]
/// Identifies the reason for a trap taken from a vCPU.
pub enum VmExitInfo {
    /// ECALLs from VS mode.
    Ecall(Option<SbiMessage>),
    /// G-stage page faluts
    PageFault {
        fault_addr: GuestPhysAddr,
        falut_pc: GuestVirtAddr,
        inst: u32,
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
