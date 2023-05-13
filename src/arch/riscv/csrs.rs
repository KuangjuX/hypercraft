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

pub mod hedeleg {
    use core::arch::asm;

    pub unsafe fn write(hedeleg: usize) {
        asm!(
            "csrw hedeleg, {}",
            in(reg) hedeleg
        )
    }
}

pub mod hideleg {
    use core::arch::asm;
    pub unsafe fn write(hideleg: usize) {
        asm!(
            "csrw hideleg, {}",
            in(reg) hideleg
        )
    }
}

pub mod hcounteren {
    use core::arch::asm;

    pub unsafe fn write(hcounteren: u32) {
        asm!(
            "csrw hcounteren, {}",
            in(reg) hcounteren
        )
    }
}

pub mod hvip {
    pub unsafe fn write(hvip: usize) {
        core::arch::asm!(
            "csrw hvip, {}",
            in(reg) hvip
        )
    }

    pub unsafe fn read_and_clear_bits(bitmask: usize) -> usize {
        let r: usize;
        core::arch::asm!(
            "csrrc {rd}, hvip, {rs1}",
            rd = out(reg) r,
            rs1 = in(reg) bitmask
        );
        r
    }
}

pub mod sip {
    /// software interrupts pending
    pub const SSIP: usize = 1 << 1;
    /// timer interrupts pending
    pub const STIP: usize = 1 << 5;
    /// external interrupts pending
    pub const SEIP: usize = 1 << 9;
}
