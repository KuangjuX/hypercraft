use alloc::sync::Arc;
use riscv::register::hstatus::{self, Hstatus};
use riscv::register::sstatus::{self, Sstatus, SPP};

use super::Guest;

pub struct TrapContext {
    /// general regs[0..31]
    pub x: [usize; 32],
    /// CSR sstatus
    pub sstatus: Sstatus,
    /// CSR sepc
    pub sepc: usize,
    /// CSR hgatp
    pub hgatp: usize,
    /// CSR hstatus
    pub hstatus: Hstatus,
    /// kernel stack
    pub kernel_sp: usize,
    /// Addr of trap_handler function
    pub trap_handler: usize,
}

pub struct VCpu {
    pub trap_cx: TrapContext,
    pub guest: Arc<Guest>,
}

impl VCpu {
    pub fn new(
        entry: usize,
        sp: usize,
        hgatp: usize,
        kernel_sp: usize,
        trap_handler: usize,
        guest: Arc<Guest>,
    ) -> Self {
        let mut sstatus = sstatus::read();
        sstatus.set_spp(SPP::Supervisor);
        let mut hstatus = hstatus::read();
        hstatus.set_spv(true);
        let mut trap_cx = TrapContext {
            x: [0; 32],
            sstatus,
            sepc: entry,
            hgatp,
            hstatus,
            kernel_sp,
            trap_handler,
        };
        trap_cx.x[2] = sp;
        Self { trap_cx, guest }
    }

    pub fn vcpu_run(&mut self) {}
}
