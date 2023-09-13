
use aarch64_cpu::{asm, asm::barrier, registers::*};


pub const HVC_SYS: usize = 0;

/// HVC SYS event
pub const HVC_SYS_SET_EL2: usize = 0;

#[repr(C)]
pub struct HvcDefaultMsg {
    pub fid: usize,
    pub event: usize,
}

pub fn hvc_guest_handler(
    hvc_type: usize,
    event: usize,
    x0: usize,
    x1: usize,
    x2: usize,
    x3: usize,
    x4: usize,
    x5: usize,
    x6: usize,
) -> Result<usize, ()> {
    match hvc_type {
        HVC_SYS => hvc_sys_handler(event, x0, x1),
        _ => {
            info!("hvc_guest_handler: unknown hvc type {} event {}", hvc_type, event);
            Err(())
        }
    }
}

fn hvc_sys_handler(event: usize, x0: usize, x1: usize) -> Result<usize, ()> {
    match event {
        HVC_SYS_SET_EL2 => {
            init_hv(x0, x1);
            Ok(0)
        }

        _ => Err(()),
    }
}

fn init_hv(x0: usize, x1: usize) {
    // cptr_el2: Controls trapping to EL2 for accesses to the CPACR, Trace functionality 
    //           and registers associated with floating-point and Advanced SIMD execution.

    // hcr_el2 set to 0x80000019 (do not trap smc?)
    // hcr_el2[31]: Register width control for lower Exception levels. 
    //             1 value: EL1 is AArch64. EL0 is determined by the register width 
    //             described in the current processing state when executing at EL0.
    // hcr_el2[4]: Physical IRQ routing.
    //             1 value: Physical IRQ while executing at EL2 or lower are taken 
    //             in EL2 unless routed by SCTLR_EL3.IRQ bit to EL3. Virtual IRQ interrupt is enabled.
    // hcr_el2[3]: Physical FIQ routing.
    //             1 value: Physical FIQ while executing at EL2 or lower are taken 
    //             in EL2 unless routed by SCTLR_EL3.FIQ bit to EL3. Virtual FIQ interrupt is enabled.
    // hcr_el2[0]: Enables second stage of translation.
    //             1 value: Enables second stage translation for execution in EL1 and EL0.
    core::arch::asm!("
        mov x3, xzr           // Trap nothing from EL1 to El2.
        msr cptr_el2, x3

        bl {init_hv_mmu}      // x0 contains root_paddr

        ldr x2, =(0x80000019) 
        msr hcr_el2, x2       // Set hcr_el2 for hypervisor control.

        mov x2, 1
        msr spsel, x2         // Use SP_ELx for Exception level ELx.

        msr vbar_el2, x1      // x1 contains exception vector base

        ldr x2, =(0x30c51835)  // Set system control register for EL2.
        msr sctlr_el2, x2

        tlbi	alle2         // Flush tlb
	    dsb	nsh
	    isb
    ", init_hv_mmu = sym init_hv_mmu, 
    )
}

unsafe fn init_hv_mmu(root_paddr: usize) {
    MAIR_EL2.write(
        MAIR_EL2::Attr0_Device::nonGathering_nonReordering_noEarlyWriteAck
            + MAIR_EL2::Attr1_Normal_Outer::WriteBack_NonTransient_ReadWriteAlloc
            + MAIR_EL2::Attr1_Normal_Inner::WriteBack_NonTransient_ReadWriteAlloc
            + MAIR_EL2::Attr2_Normal_Outer::NonCacheable
            + MAIR_EL2::Attr2_Normal_Inner::NonCacheable,
    );

    TCR_EL2.write(
        TCR_EL2::PS::Bits_48
            + TCR_EL2::SH0::Inner
            + TCR_EL2::TG0::KiB_4
            + TCR_EL2::ORGN0::WriteBack_ReadAlloc_WriteAlloc_Cacheable
            + TCR_EL2::IRGN0::WriteBack_ReadAlloc_WriteAlloc_Cacheable
            + TCR_EL2::T0SZ.val(64 - 39),
    );

    // barrier::isb(barrier::SY);
    // SCTLR_EL2.modify(SCTLR_EL2::M::Enable + SCTLR_EL2::C::Cacheable + SCTLR_EL2::I::Cacheable);
    // barrier::isb(barrier::SY);

    TTBR0_EL2.set(root_paddr as *const _ as u64);
}
