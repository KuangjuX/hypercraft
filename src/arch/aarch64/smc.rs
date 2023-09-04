use core::arch::asm;

#[inline(never)]
pub fn smc_call(x0: usize, x1: usize, x2: usize, x3: usize) -> (usize, usize, usize, usize) {
    #[cfg(target_arch = "aarch64")]
    unsafe {
        let r0;
        let r1;
        let r2;
        let r3;
        asm!(
            "smc #0",
            inout("x0") x0 => r0,
            inout("x1") x1 => r1,
            inout("x2") x2 => r2,
            inout("x3") x3 => r3,
            options(nomem, nostack)
        );
        (r0, r1, r2, r3)
    }

    #[cfg(not(target_arch = "aarch64"))]
    unimplemented!();
}