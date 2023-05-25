use alloc::boxed::Box;
use core::arch::global_asm;
use core::marker::PhantomData;
use core::mem::size_of;
use memoffset::offset_of;
use tock_registers::LocalRegisterCopy;

// use alloc::sync::Arc;
use riscv::register::{htinst, htval, hvip, scause, sstatus, stval};

use crate::arch::vmexit::PrivilegeLevel;
use crate::arch::{traps, RiscvCsrTrait, CSR};
use crate::{
    arch::sbi::SbiMessage, GuestPageTableTrait, GuestPhysAddr, GuestVirtAddr, HostPhysAddr,
    HyperCraftHal, VmExitInfo,
};

use super::csrs::defs::hstatus;
use super::regs::{GeneralPurposeRegisters, GprIndex};
// use super::Guest;

/// Hypervisor GPR and CSR state which must be saved/restored when entering/exiting virtualization.
#[derive(Default)]
#[repr(C)]
struct HypervisorCpuState {
    gprs: GeneralPurposeRegisters,
    sstatus: usize,
    hstatus: usize,
    scounteren: usize,
    stvec: usize,
    sscratch: usize,
}

/// Guest GPR and CSR state which must be saved/restored when exiting/entering virtualization.
#[derive(Default)]
#[repr(C)]
struct GuestCpuState {
    gprs: GeneralPurposeRegisters,
    sstatus: usize,
    hstatus: usize,
    scounteren: usize,
    sepc: usize,
}

/// The CSRs that are only in effect when virtualization is enabled (V=1) and must be saved and
/// restored whenever we switch between VMs.
#[derive(Default)]
#[repr(C)]
pub struct GuestVsCsrs {
    htimedelta: usize,
    vsstatus: usize,
    vsie: usize,
    vstvec: usize,
    vsscratch: usize,
    vsepc: usize,
    vscause: usize,
    vstval: usize,
    vsatp: usize,
    vstimecmp: usize,
}

/// Virtualized HS-level CSRs that are used to emulate (part of) the hypervisor extension for the
/// guest.
#[derive(Default)]
#[repr(C)]
pub struct GuestVirtualHsCsrs {
    hie: usize,
    hgeie: usize,
    hgatp: usize,
}

/// CSRs written on an exit from virtualization that are used by the hypervisor to determine the cause
/// of the trap.
#[derive(Default, Clone)]
#[repr(C)]
pub struct VmCpuTrapState {
    pub scause: usize,
    pub stval: usize,
    pub htval: usize,
    pub htinst: usize,
}

/// (v)CPU register state that must be saved or restored when entering/exiting a VM or switching
/// between VMs.
#[derive(Default)]
#[repr(C)]
pub struct VmCpuRegisters {
    // CPU state that's shared between our's and the guest's execution environment. Saved/restored
    // when entering/exiting a VM.
    hyp_regs: HypervisorCpuState,
    guest_regs: GuestCpuState,

    // CPU state that only applies when V=1, e.g. the VS-level CSRs. Saved/restored on activation of
    // the vCPU.
    vs_csrs: GuestVsCsrs,

    // Virtualized HS-level CPU state.
    virtual_hs_csrs: GuestVirtualHsCsrs,

    // Read on VM exit.
    trap_csrs: VmCpuTrapState,
}

#[allow(dead_code)]
const fn hyp_gpr_offset(index: GprIndex) -> usize {
    offset_of!(VmCpuRegisters, hyp_regs)
        + offset_of!(HypervisorCpuState, gprs)
        + (index as usize) * size_of::<u64>()
}

#[allow(dead_code)]
const fn guest_gpr_offset(index: GprIndex) -> usize {
    offset_of!(VmCpuRegisters, guest_regs)
        + offset_of!(GuestCpuState, gprs)
        + (index as usize) * size_of::<u64>()
}

#[allow(unused_macros)]
macro_rules! hyp_csr_offset {
    ($reg:tt) => {
        offset_of!(VmCpuRegisters, hyp_regs) + offset_of!(HypervisorCpuState, $reg)
    };
}

#[allow(unused_macros)]
macro_rules! guest_csr_offset {
    ($reg:tt) => {
        offset_of!(VmCpuRegisters, guest_regs) + offset_of!(GuestCpuState, $reg)
    };
}

global_asm!(
    include_str!("guest.S"),
    hyp_ra = const hyp_gpr_offset(GprIndex::RA),
    hyp_gp = const hyp_gpr_offset(GprIndex::GP),
    hyp_tp = const hyp_gpr_offset(GprIndex::TP),
    hyp_s0 = const hyp_gpr_offset(GprIndex::S0),
    hyp_s1 = const hyp_gpr_offset(GprIndex::S1),
    hyp_a1 = const hyp_gpr_offset(GprIndex::A1),
    hyp_a2 = const hyp_gpr_offset(GprIndex::A2),
    hyp_a3 = const hyp_gpr_offset(GprIndex::A3),
    hyp_a4 = const hyp_gpr_offset(GprIndex::A4),
    hyp_a5 = const hyp_gpr_offset(GprIndex::A5),
    hyp_a6 = const hyp_gpr_offset(GprIndex::A6),
    hyp_a7 = const hyp_gpr_offset(GprIndex::A7),
    hyp_s2 = const hyp_gpr_offset(GprIndex::S2),
    hyp_s3 = const hyp_gpr_offset(GprIndex::S3),
    hyp_s4 = const hyp_gpr_offset(GprIndex::S4),
    hyp_s5 = const hyp_gpr_offset(GprIndex::S5),
    hyp_s6 = const hyp_gpr_offset(GprIndex::S6),
    hyp_s7 = const hyp_gpr_offset(GprIndex::S7),
    hyp_s8 = const hyp_gpr_offset(GprIndex::S8),
    hyp_s9 = const hyp_gpr_offset(GprIndex::S9),
    hyp_s10 = const hyp_gpr_offset(GprIndex::S10),
    hyp_s11 = const hyp_gpr_offset(GprIndex::S11),
    hyp_sp = const hyp_gpr_offset(GprIndex::SP),
    hyp_sstatus = const hyp_csr_offset!(sstatus),
    hyp_hstatus = const hyp_csr_offset!(hstatus),
    hyp_scounteren = const hyp_csr_offset!(scounteren),
    hyp_stvec = const hyp_csr_offset!(stvec),
    hyp_sscratch = const hyp_csr_offset!(sscratch),
    guest_ra = const guest_gpr_offset(GprIndex::RA),
    guest_gp = const guest_gpr_offset(GprIndex::GP),
    guest_tp = const guest_gpr_offset(GprIndex::TP),
    guest_s0 = const guest_gpr_offset(GprIndex::S0),
    guest_s1 = const guest_gpr_offset(GprIndex::S1),
    guest_a0 = const guest_gpr_offset(GprIndex::A0),
    guest_a1 = const guest_gpr_offset(GprIndex::A1),
    guest_a2 = const guest_gpr_offset(GprIndex::A2),
    guest_a3 = const guest_gpr_offset(GprIndex::A3),
    guest_a4 = const guest_gpr_offset(GprIndex::A4),
    guest_a5 = const guest_gpr_offset(GprIndex::A5),
    guest_a6 = const guest_gpr_offset(GprIndex::A6),
    guest_a7 = const guest_gpr_offset(GprIndex::A7),
    guest_s2 = const guest_gpr_offset(GprIndex::S2),
    guest_s3 = const guest_gpr_offset(GprIndex::S3),
    guest_s4 = const guest_gpr_offset(GprIndex::S4),
    guest_s5 = const guest_gpr_offset(GprIndex::S5),
    guest_s6 = const guest_gpr_offset(GprIndex::S6),
    guest_s7 = const guest_gpr_offset(GprIndex::S7),
    guest_s8 = const guest_gpr_offset(GprIndex::S8),
    guest_s9 = const guest_gpr_offset(GprIndex::S9),
    guest_s10 = const guest_gpr_offset(GprIndex::S10),
    guest_s11 = const guest_gpr_offset(GprIndex::S11),
    guest_t0 = const guest_gpr_offset(GprIndex::T0),
    guest_t1 = const guest_gpr_offset(GprIndex::T1),
    guest_t2 = const guest_gpr_offset(GprIndex::T2),
    guest_t3 = const guest_gpr_offset(GprIndex::T3),
    guest_t4 = const guest_gpr_offset(GprIndex::T4),
    guest_t5 = const guest_gpr_offset(GprIndex::T5),
    guest_t6 = const guest_gpr_offset(GprIndex::T6),
    guest_sp = const guest_gpr_offset(GprIndex::SP),

    guest_sstatus = const guest_csr_offset!(sstatus),
    guest_hstatus = const guest_csr_offset!(hstatus),
    guest_scounteren = const guest_csr_offset!(scounteren),
    guest_sepc = const guest_csr_offset!(sepc),

);

extern "C" {
    fn _run_guest(state: *mut VmCpuRegisters);
}

pub enum VmCpuStatus {
    /// The vCPU is not powered on.
    PoweredOff,
    /// The vCPU is available to be run.
    Runnable,
    /// The vCPU has benn claimed exclusively for running on a (physical) CPU.
    Running,
}

#[derive(Default)]
/// A virtual CPU within a guest
pub struct VCpu<H: HyperCraftHal> {
    vcpu_id: usize,
    regs: VmCpuRegisters,
    // gpt: G,
    // pub guest: Arc<Guest>,
    marker: PhantomData<H>,
}

impl<H: HyperCraftHal> VCpu<H> {
    /// Create a new vCPU
    pub fn new(vcpu_id: usize, entry: GuestPhysAddr) -> Self {
        let mut regs = VmCpuRegisters::default();
        // Set hstatus
        let mut hstatus = LocalRegisterCopy::<usize, hstatus::Register>::new(
            riscv::register::hstatus::read().bits(),
        );
        hstatus.modify(hstatus::spv::Supervisor);
        // Set SPVP bit in order to accessing VS-mode memory from HS-mode.
        hstatus.modify(hstatus::spvp::Supervisor);
        CSR.hstatus.write_value(hstatus.get());
        regs.guest_regs.hstatus = hstatus.get();

        // Set sstatus
        let mut sstatus = sstatus::read();
        sstatus.set_spp(sstatus::SPP::Supervisor);
        regs.guest_regs.sstatus = sstatus.bits();

        regs.guest_regs.gprs.set_reg(GprIndex::A0, 0);
        regs.guest_regs.gprs.set_reg(GprIndex::A1, 0x9000_0000);

        // Set entry
        regs.guest_regs.sepc = entry;
        Self {
            vcpu_id,
            regs,
            // gpt,
            marker: PhantomData,
        }
    }

    /// Initialize nested mmu.
    pub fn init_page_map(&mut self, token: usize) {
        // Set hgatp
        // TODO: Sv39 currently, but should be configurable
        self.regs.virtual_hs_csrs.hgatp = token;
        unsafe {
            core::arch::asm!(
                "csrw hgatp, {hgatp}",
                hgatp = in(reg) self.regs.virtual_hs_csrs.hgatp,
            );
            core::arch::riscv64::hfence_gvma_all();
        }
    }

    /// Restore vCPU registers from the guest's GPRs
    pub fn restore_gprs(&mut self, gprs: &GeneralPurposeRegisters) {
        for index in 0..32 {
            self.regs.guest_regs.gprs.set_reg(
                GprIndex::from_raw(index).unwrap(),
                gprs.reg(GprIndex::from_raw(index).unwrap()),
            )
        }
    }

    /// Save vCPU registers to the guest's GPRs
    pub fn save_gprs(&self, gprs: &mut GeneralPurposeRegisters) {
        for index in 0..32 {
            gprs.set_reg(
                GprIndex::from_raw(index).unwrap(),
                self.regs
                    .guest_regs
                    .gprs
                    .reg(GprIndex::from_raw(index).unwrap()),
            );
        }
    }

    /// Runs this vCPU until traps.
    pub fn run(&mut self) -> VmExitInfo {
        let regs = &mut self.regs;
        unsafe {
            // Safe to run the guest as it only touches memory assigned to it by being owned
            // by its page table
            _run_guest(regs);
        }
        // Save off the trap information
        regs.trap_csrs.scause = scause::read().bits();
        regs.trap_csrs.stval = stval::read();
        regs.trap_csrs.htval = htval::read();
        regs.trap_csrs.htinst = htinst::read();

        let scause = scause::read();
        use scause::{Exception, Interrupt, Trap};
        match scause.cause() {
            Trap::Exception(Exception::VirtualSupervisorEnvCall) => {
                let sbi_msg = SbiMessage::from_regs(regs.guest_regs.gprs.a_regs()).ok();
                VmExitInfo::Ecall(sbi_msg)
            }
            Trap::Interrupt(Interrupt::SupervisorTimer) => VmExitInfo::TimerInterruptEmulation,
            Trap::Interrupt(Interrupt::SupervisorExternal) => {
                VmExitInfo::ExternalInterruptEmulation
            }
            Trap::Exception(Exception::LoadGuestPageFault)
            | Trap::Exception(Exception::StoreGuestPageFault) => {
                let fault_addr = regs.trap_csrs.htval << 2 | regs.trap_csrs.stval & 0x3;
                // debug!(
                //     "fault_addr: {:#x}, htval: {:#x}, stval: {:#x}, sepc: {:#x}, scause: {:?}",
                //     fault_addr,
                //     regs.trap_csrs.htval,
                //     regs.trap_csrs.stval,
                //     regs.guest_regs.sepc,
                //     scause.cause()
                // );
                VmExitInfo::PageFault {
                    fault_addr,
                    // Note that this address is not necessarily guest virtual as the guest may or
                    // may not have 1st-stage translation enabled in VSATP. We still use GuestVirtAddr
                    // here though to distinguish it from addresses (e.g. in HTVAL, or passed via a
                    // TEECALL) which are exclusively guest-physical. Furthermore we only access guest
                    // instructions via the HLVX instruction, which will take the VSATP translation
                    // mode into account.
                    falut_pc: regs.guest_regs.sepc,
                    inst: regs.trap_csrs.htinst as u32,
                    priv_level: PrivilegeLevel::from_hstatus(regs.guest_regs.hstatus),
                }
            }
            _ => {
                panic!(
                    "Unhandled trap: {:?}, sepc: {:#x}, stval: {:#x}",
                    scause.cause(),
                    regs.guest_regs.sepc,
                    regs.trap_csrs.stval
                );
            }
        }
    }

    /// Gets one of the vCPU's general purpose registers.
    pub fn get_gpr(&self, index: GprIndex) -> usize {
        self.regs.guest_regs.gprs.reg(index)
    }

    /// Set one of the vCPU's general purpose register.
    pub fn set_gpr(&mut self, index: GprIndex, val: usize) {
        self.regs.guest_regs.gprs.set_reg(index, val);
    }

    /// Advance guest pc by `instr_len` bytes
    pub fn advance_pc(&mut self, instr_len: usize) {
        self.regs.guest_regs.sepc += instr_len
    }

    /// Gets the vCPU's id.
    pub fn vcpu_id(&self) -> usize {
        self.vcpu_id
    }

    /// Gets the vCPU's registers.
    pub fn regs(&mut self) -> &mut VmCpuRegisters {
        &mut self.regs
    }
}

// Private methods implements
impl<H: HyperCraftHal> VCpu<H> {
    /// Delivers the given exception to the vCPU, setting its register state
    /// to handle the trap the next time it is run.
    fn inject_exception(&mut self) {
        unsafe {
            core::arch::asm!(
                "csrw vsepc, {hyp_sepc}",
                "csrw vscause, {hyp_scause}",
                "csrr {guest_sepc}, vstvec",
                hyp_sepc = in(reg) self.regs.guest_regs.sepc,
                hyp_scause = in(reg) self.regs.trap_csrs.scause,
                guest_sepc = out(reg) self.regs.guest_regs.sepc,
            );
        }
    }
}
