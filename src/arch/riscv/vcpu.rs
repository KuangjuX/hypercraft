use core::arch::asm;
use core::marker::PhantomData;
use core::mem::size_of;
use memoffset::offset_of;

use alloc::sync::Arc;
use riscv::register::{hstatus, sstatus};

use crate::HyperCraftHal;

use super::regs::{GeneralPurposeRegisters, GprIndex};
use super::Guest;

/// Hypervisor GPR and CSR state which must be saved/restored when entering/exiting virtualization.
#[derive(Default)]
#[repr(C)]
struct HypervisorCpuState {
    gprs: GeneralPurposeRegisters,
    sstatus: u64,
    hstatus: u64,
    scounteren: u64,
    stvec: u64,
    sscratch: u64,
}

/// Guest GPR and CSR state which must be saved/restored when exiting/entering virtualization.
#[derive(Default)]
#[repr(C)]
struct GuestCpuState {
    gprs: GeneralPurposeRegisters,
    sstatus: u64,
    hstatus: u64,
    scounteren: u64,
    sepc: u64,
}

/// The CSRs that are only in effect when virtualization is enabled (V=1) and must be saved and
/// restored whenever we switch between VMs.
#[derive(Default)]
#[repr(C)]
pub struct GuestVsCsrs {
    htimedelta: u64,
    vsstatus: u64,
    vsie: u64,
    vstvec: u64,
    vsscratch: u64,
    vsepc: u64,
    vscause: u64,
    vstval: u64,
    vsatp: u64,
    vstimecmp: u64,
}

/// Virtualized HS-level CSRs that are used to emulate (part of) the hypervisor extension for the
/// guest.
#[derive(Default)]
#[repr(C)]
pub struct GuestVirtualHsCsrs {
    hie: u64,
    hgeie: u64,
    hgatp: u64,
}

/// CSRs written on an exit from virtualization that are used by the hypervisor to determine the cause
/// of the trap.
#[derive(Default, Clone)]
#[repr(C)]
pub struct VmCpuTrapState {
    pub scause: u64,
    pub stval: u64,
    pub htval: u64,
    pub htinst: u64,
}

/// (v)CPU register state that must be saved or restored when entering/exiting a VM or switching
/// between VMs.
#[derive(Default)]
#[repr(C)]
struct VmCpuRegisters {
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

pub struct VCpu<H: HyperCraftHal> {
    regs: VmCpuRegisters,
    pub guest: Arc<Guest>,
    marker: PhantomData<H>,
}

const hyp_ra: usize = hyp_gpr_offset(GprIndex::RA);
const hyp_gp: usize = hyp_gpr_offset(GprIndex::GP);
const hyp_tp: usize = hyp_gpr_offset(GprIndex::TP);
const hyp_s0: usize = hyp_gpr_offset(GprIndex::S0);
const hyp_s1: usize = hyp_gpr_offset(GprIndex::S1);
const hyp_a1: usize = hyp_gpr_offset(GprIndex::A1);
const hyp_a2: usize = hyp_gpr_offset(GprIndex::A2);
const hyp_a3: usize = hyp_gpr_offset(GprIndex::A3);
const hyp_a4: usize = hyp_gpr_offset(GprIndex::A4);
const hyp_a5: usize = hyp_gpr_offset(GprIndex::A5);
const hyp_a6: usize = hyp_gpr_offset(GprIndex::A6);
const hyp_a7: usize = hyp_gpr_offset(GprIndex::A7);
const hyp_s2: usize = hyp_gpr_offset(GprIndex::S2);
const hyp_s3: usize = hyp_gpr_offset(GprIndex::S3);
const hyp_s4: usize = hyp_gpr_offset(GprIndex::S4);
const hyp_s5: usize = hyp_gpr_offset(GprIndex::S5);
const hyp_s6: usize = hyp_gpr_offset(GprIndex::S6);
const hyp_s7: usize = hyp_gpr_offset(GprIndex::S7);
const hyp_s8: usize = hyp_gpr_offset(GprIndex::S8);
const hyp_s9: usize = hyp_gpr_offset(GprIndex::S9);
const hyp_s10: usize = hyp_gpr_offset(GprIndex::S10);
const hyp_s11: usize = hyp_gpr_offset(GprIndex::S11);
const hyp_sp: usize = hyp_gpr_offset(GprIndex::SP);

const hyp_sstatus: usize = hyp_csr_offset!(sstatus);
const hyp_hstatus: usize = hyp_csr_offset!(hstatus);
const hyp_scounteren: usize = hyp_csr_offset!(scounteren);
const hyp_stvec: usize = hyp_csr_offset!(stvec);
const hyp_sscratch: usize = hyp_csr_offset!(sscratch);

const guest_ra: usize = guest_gpr_offset(GprIndex::RA);
const guest_gp: usize = guest_gpr_offset(GprIndex::GP);
const guest_tp: usize = guest_gpr_offset(GprIndex::TP);
const guest_s0: usize = guest_gpr_offset(GprIndex::S0);
const guest_s1: usize = guest_gpr_offset(GprIndex::S1);
const guest_a0: usize = guest_gpr_offset(GprIndex::A0);
const guest_a1: usize = guest_gpr_offset(GprIndex::A1);
const guest_a2: usize = guest_gpr_offset(GprIndex::A2);
const guest_a3: usize = guest_gpr_offset(GprIndex::A3);
const guest_a4: usize = guest_gpr_offset(GprIndex::A4);
const guest_a5: usize = guest_gpr_offset(GprIndex::A5);
const guest_a6: usize = guest_gpr_offset(GprIndex::A6);
const guest_a7: usize = guest_gpr_offset(GprIndex::A7);
const guest_s2: usize = guest_gpr_offset(GprIndex::S2);
const guest_s3: usize = guest_gpr_offset(GprIndex::S3);
const guest_s4: usize = guest_gpr_offset(GprIndex::S4);
const guest_s5: usize = guest_gpr_offset(GprIndex::S5);
const guest_s6: usize = guest_gpr_offset(GprIndex::S6);
const guest_s7: usize = guest_gpr_offset(GprIndex::S7);
const guest_s8: usize = guest_gpr_offset(GprIndex::S8);
const guest_s9: usize = guest_gpr_offset(GprIndex::S9);
const guest_s10: usize = guest_gpr_offset(GprIndex::S10);
const guest_s11: usize = guest_gpr_offset(GprIndex::S11);
const guest_t0: usize = guest_gpr_offset(GprIndex::T0);
const guest_t1: usize = guest_gpr_offset(GprIndex::T1);
const guest_t2: usize = guest_gpr_offset(GprIndex::T2);
const guest_t3: usize = guest_gpr_offset(GprIndex::T3);
const guest_t4: usize = guest_gpr_offset(GprIndex::T4);
const guest_t5: usize = guest_gpr_offset(GprIndex::T5);
const guest_t6: usize = guest_gpr_offset(GprIndex::T6);
const guest_sp: usize = guest_gpr_offset(GprIndex::SP);

const guest_sstatus: usize = guest_csr_offset!(sstatus);
const guest_hstatus: usize = guest_csr_offset!(hstatus);
const guest_scounteren: usize = guest_csr_offset!(scounteren);
const guest_sepc: usize = guest_csr_offset!(sepc);

impl<H: HyperCraftHal> VCpu<H> {
    pub fn vcpu_create(
        _entry: usize,
        _sp: usize,
        _hgatp: usize,
        _kernel_sp: usize,
        _trap_handler: usize,
        guest: Arc<Guest>,
    ) -> Self {
        let mut regs = VmCpuRegisters::default();
        // Set hstatus
        let mut hstatus = hstatus::read();
        hstatus.set_spv(true);
        regs.guest_regs.hstatus = hstatus.bits() as u64;

        // Set sstatus
        let mut sstatus = sstatus::read();
        sstatus.set_spp(sstatus::SPP::Supervisor);
        regs.guest_regs.sstatus = sstatus.bits() as u64;
        Self {
            regs,
            guest,
            marker: PhantomData,
        }
    }

    pub fn vcpu_run(&mut self) -> ! {
        unsafe { self.vm_enter() }
    }

    #[naked]
    unsafe extern "C" fn vm_enter(&mut self) -> ! {
        asm!(
            // Save hypervisor state
            // Save hypervisor GPRs(except T0-T6 and a0, which is GuestInfo and stashed in sscratch)
            "sd   ra, ({hyp_ra})(a0)",
            "sd   gp, ({hyp_gp})(a0)",
            "sd   tp, ({hyp_tp})(a0)",
            "sd   s0, ({hyp_s0})(a0)",
            "sd   s1, ({hyp_s1})(a0)",
            "sd   a1, ({hyp_a1})(a0)",
            "sd   a2, ({hyp_a2})(a0)",
            "sd   a3, ({hyp_a3})(a0)",
            "sd   a4, ({hyp_a4})(a0)",
            "sd   a5, ({hyp_a5})(a0)",
            "sd   a6, ({hyp_a6})(a0)",
            "sd   a7, ({hyp_a7})(a0)",
            "sd   s2, ({hyp_s2})(a0)",
            "sd   s3, ({hyp_s3})(a0)",
            "sd   s4, ({hyp_s4})(a0)",
            "sd   s5, ({hyp_s5})(a0)",
            "sd   s6, ({hyp_s6})(a0)",
            "sd   s7, ({hyp_s7})(a0)",
            "sd   s8, ({hyp_s8})(a0)",
            "sd   s9, ({hyp_s9})(a0)",
            "sd   s10, ({hyp_s10})(a0)",
            "sd   s11, ({hyp_s11})(a0)",
            "sd   sp, ({hyp_sp})(a0)",

            // Swap in guests CSRs
            "ld    t1, ({guest_sstatus})(a0)",
            "csrrw t1, sstatus, t1",
            "sd    t1, ({hyp_sstatus})(a0)",

            "ld    t1, ({guest_hstatus})(a0)",
            "csrrw t1, hstatus, t1",
            "sd    t1, ({hyp_hstatus})(a0)",

            "ld    t1, ({guest_scounteren})(a0)",
            "csrrw t1, scounteren, t1",
            "sd    t1, ({hyp_scounteren})(a0)",

            "ld    t1, ({guest_sepc})(a0)",
            "csrw  sepc, t1",

            // Set stvec to that hypervisor resumes after sret when the guest exits.
            // "la    t1, _guest_exit",
            // "csrrw t1, stvec, t1",
            // "sd    t1, ({hyp_stvec})(a0)",


            hyp_ra = const hyp_ra,
            hyp_gp = const hyp_gp,
            hyp_tp = const hyp_tp,
            hyp_s0 = const hyp_s0,
            hyp_s1 = const hyp_s1,
            hyp_a1 = const hyp_a1,
            hyp_a2 = const hyp_a2,
            hyp_a3 = const hyp_a3,
            hyp_a4 = const hyp_a4,
            hyp_a5 = const hyp_a5,
            hyp_a6 = const hyp_a6,
            hyp_a7 = const hyp_a7,
            hyp_s2 = const hyp_s2,
            hyp_s3 = const hyp_s3,
            hyp_s4 = const hyp_s4,
            hyp_s5 = const hyp_s5,
            hyp_s6 = const hyp_s6,
            hyp_s7 = const hyp_s7,
            hyp_s8 = const hyp_s8,
            hyp_s9 = const hyp_s9,
            hyp_s10 = const hyp_s10,
            hyp_s11 = const hyp_s11,
            hyp_sp = const hyp_s4,

            guest_sstatus = const guest_sstatus,
            hyp_sstatus = const hyp_sstatus,
            guest_hstatus = const guest_hstatus,
            hyp_hstatus = const hyp_hstatus,
            guest_scounteren = const guest_scounteren,
            hyp_scounteren = const hyp_scounteren,
            guest_sepc = const guest_sepc,
            options(noreturn)
        );
    }

    #[naked]
    unsafe extern "C" fn vm_exit(&mut self) -> ! {
        asm!("li a0, 0", options(noreturn));
    }
}
