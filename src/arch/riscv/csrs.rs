use defs::*;
use tock_registers::{register_bitfields, RegisterLongName};

pub type Hedeleg = ReadWriteCsr<hedeleg::Register, { CSR_HEDELEG }>;
pub type Hideleg = ReadWriteCsr<hideleg::Register, { CSR_HIDELEG }>;
pub type Hcounteren = ReadWriteCsr<hcounteren::Register, { CSR_HCOUNTEREN }>;
pub type HVIP = ReadWriteCsr<hvip::Register, { CSR_HVIP }>;

/// Trait defining the possible operations on a RISC-V CSR.
pub trait RiscvCsrTrait {
    type R: RegisterLongName;
    /// Reads the value of the CSR.
    fn get_value(&self) -> usize;

    /// Writes the value of the CSR.
    fn write_value(&self, value: usize);

    /// Atomicllt swaps the value of CSRs.
    fn atomic_replace(&self, value: usize) -> usize;

    /// Atomically read a CSR and set bits specified in a bitmask
    fn read_and_set_bits(&self, bitmasks: usize) -> usize;

    /// Atomically read a CSR and set bits specified in a bitmask
    fn read_and_clear_bits(&self, bitmasks: usize) -> usize;
}

/// Read/Write register.
pub struct ReadWriteCsr<R: RegisterLongName, const V: u16> {
    associated_register: core::marker::PhantomData<R>,
}

impl<R: RegisterLongName, const V: u16> ReadWriteCsr<R, V> {
    pub const fn new() -> Self {
        Self {
            associated_register: core::marker::PhantomData,
        }
    }
}

impl<R: RegisterLongName, const V: u16> RiscvCsrTrait for ReadWriteCsr<R, V> {
    type R = R;

    fn get_value(&self) -> usize {
        let r: usize;
        unsafe {
            core::arch::asm!("csrr {rd}, {csr}", rd = out(reg) r, csr = const V);
        }
        r
    }

    fn write_value(&self, value: usize) {
        unsafe {
            core::arch::asm!("csrw {csr}, {rs}", csr = const V, rs = in(reg) value);
        }
    }

    fn atomic_replace(&self, value: usize) -> usize {
        let r: usize;
        unsafe {
            core::arch::asm!("csrrw {rd}, {csr}, {rs}", rd = out(reg) r, csr = const V, rs = in(reg) value);
        }
        r
    }

    fn read_and_set_bits(&self, bitmask: usize) -> usize {
        let r: usize;
        unsafe {
            core::arch::asm!("csrrs {rd}, {csr}, {rs}", rd = out(reg) r, csr = const V, rs = in(reg) bitmask);
        }
        r
    }

    fn read_and_clear_bits(&self, bitmask: usize) -> usize {
        let r: usize;
        unsafe {
            core::arch::asm!("csrrc {rd}, {csr}, {rs}", rd = out(reg) r, csr = const V, rs = in(reg) bitmask);
        }
        r
    }
}

pub mod defs {
    use tock_registers::register_bitfields;
    pub const CSR_HSTATUS: u16 = 0x600;
    pub const CSR_HEDELEG: u16 = 0x602;
    pub const CSR_HIDELEG: u16 = 0x603;
    pub const CSR_HIE: u16 = 0x604;
    pub const CSR_HTIMEDELTA: u16 = 0x605;
    pub const CSR_HCOUNTEREN: u16 = 0x606;
    pub const CSR_HGEIE: u16 = 0x607;
    pub const CSR_HVICTL: u16 = 0x609;
    pub const CSR_HENVCFG: u16 = 0x60a;
    pub const CSR_HTVAL: u16 = 0x643;
    pub const CSR_HIP: u16 = 0x644;
    pub const CSR_HVIP: u16 = 0x645;
    pub const CSR_HTINST: u16 = 0x64a;
    pub const CSR_HGATP: u16 = 0x680;
    pub const CSR_HCONTEXT: u16 = 0x6a8;
    pub const CSR_HGEIP: u16 = 0xe12;

    // Hypervisor exception delegation register.
    register_bitfields![u64,
    pub hedeleg [
        instr_misaligned OFFSET(0) NUMBITS(1) [],
        instr_fault OFFSET(1) NUMBITS(1) [],
        illegal_instr OFFSET(2) NUMBITS(1) [],
        breakpoint OFFSET(3) NUMBITS(1) [],
        load_misaligned OFFSET(4) NUMBITS(1) [],
        load_fault OFFSET(5) NUMBITS(1) [],
        store_misaligned OFFSET(6) NUMBITS(1) [],
        store_fault OFFSET(7) NUMBITS(1) [],
        u_ecall OFFSET(8) NUMBITS(1) [],
        instr_page_fault OFFSET(12) NUMBITS(1) [],
        load_page_fault OFFSET(13) NUMBITS(1) [],
        store_page_fault OFFSET(15) NUMBITS(1) [],
    ]
    ];

    // Hypervisor interrupt delegation register.
    register_bitfields![u64,
    pub hideleg [
        vssoft OFFSET(2) NUMBITS(1) [],
        vstimer OFFSET(6) NUMBITS(1) [],
        vsext OFFSET(10) NUMBITS(1) [],
    ]
    ];

    // Hypervisor interrupt enable register.
    register_bitfields![u64,
    pub hie [
        vssoft OFFSET(2) NUMBITS(1) [],
        vstimer OFFSET(6) NUMBITS(1) [],
        vsext OFFSET(10) NUMBITS(1) [],
        sgext OFFSET(12) NUMBITS(1) [],
    ]
    ];

    // VS-mode counter availability control.
    register_bitfields![u64,
    pub hcounteren [
        cycle OFFSET(0) NUMBITS(1) [],
        time OFFSET(1) NUMBITS(1) [],
        instret OFFSET(2) NUMBITS(1) [],
        hpm OFFSET(3) NUMBITS(29) [],
    ]
    ];

    // Hypervisor virtual interrupt pending.
    register_bitfields![u64,
    pub hvip [
        vssoft OFFSET(2) NUMBITS(1) [],
        vstimer OFFSET(6) NUMBITS(1) [],
        vsext OFFSET(10) NUMBITS(1) [],
    ]
    ];
}

pub mod traps {
    pub mod interrupt {
        pub const USER_SOFT: usize = 1 << 0;
        pub const SUPERVISOR_SOFT: usize = 1 << 1;
        pub const VIRTUAL_SUPERVISOR_SOFT: usize = 1 << 2;
        pub const MACHINE_SOFT: usize = 1 << 3;
        pub const USER_TIMER: usize = 1 << 4;
        pub const SUPERVISOR_TIMER: usize = 1 << 5;
        pub const VIRTUAL_SUPERVISOR_TIMER: usize = 1 << 6;
        pub const MACHINE_TIMER: usize = 1 << 7;
        pub const USER_EXTERNAL: usize = 1 << 8;
        pub const SUPERVISOR_EXTERNAL: usize = 1 << 9;
        pub const VIRTUAL_SUPERVISOR_EXTERNAL: usize = 1 << 10;
        pub const MACHINEL_EXTERNAL: usize = 1 << 11;
        pub const SUPERVISOR_GUEST_EXTERNEL: usize = 1 << 12;
    }

    pub mod exception {
        pub const INST_ADDR_MISALIGN: usize = 1 << 0;
        pub const INST_ACCESSS_FAULT: usize = 1 << 1;
        pub const ILLEGAL_INST: usize = 1 << 2;
        pub const BREAKPOINT: usize = 1 << 3;
        pub const LOAD_ADDR_MISALIGNED: usize = 1 << 4;
        pub const LOAD_ACCESS_FAULT: usize = 1 << 5;
        pub const STORE_ADDR_MISALIGNED: usize = 1 << 6;
        pub const STORE_ACCESS_FAULT: usize = 1 << 7;
        pub const ENV_CALL_FROM_U_OR_VU: usize = 1 << 8;
        pub const ENV_CALL_FROM_HS: usize = 1 << 9;
        pub const ENV_CALL_FROM_VS: usize = 1 << 10;
        pub const ENV_CALL_FROM_M: usize = 1 << 11;
        pub const INST_PAGE_FAULT: usize = 1 << 12;
        pub const LOAD_PAGE_FAULT: usize = 1 << 13;
        pub const STORE_PAGE_FAULT: usize = 1 << 15;
        pub const INST_GUEST_PAGE_FAULT: usize = 1 << 20;
        pub const LOAD_GUEST_PAGE_FAULT: usize = 1 << 21;
        pub const VIRTUAL_INST: usize = 1 << 22;
        pub const STORE_GUEST_PAGE_FAULT: usize = 1 << 23;
    }
}
