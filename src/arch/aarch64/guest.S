.global context_vm_entry
context_vm_entry:
    mov sp, x0
context_pop:
    ldr x0, [sp, #(31 * 8)] // spsr
    ldr x1, [sp, #(32 * 8)] // elr
    msr spsr_el2, x0
    msr elr_el2, x1
    ldp x0, x1,  [sp, #(0 * 16)]
    ldp x2, x3,  [sp, #(1 * 16)]
    ldp x4, x5,  [sp, #(2 * 16)]
    ldp x6, x7,  [sp, #(3 * 16)]
    ldp x8, x9,  [sp, #(4 * 16)]
    ldp x10,x11, [sp, #(5 * 16)]
    ldp x12,x13, [sp, #(6 * 16)]
    ldp x14,x15, [sp, #(7 * 16)]
    ldp x16,x17, [sp, #(8 * 16)]
    ldp x18,x19, [sp, #(9 * 16)]
    ldp x20,x21, [sp, #(10 * 16)]
    ldp x22,x23, [sp, #(11 * 16)]
    ldp x24,x25, [sp, #(12 * 16)]
    ldp x26,x27, [sp, #(13 * 16)]
    ldp x28,x29, [sp, #(14 * 16)]
    ldr x30,     [sp, #(15 * 16)]
    add	sp, sp, #(0x110)
    eret
