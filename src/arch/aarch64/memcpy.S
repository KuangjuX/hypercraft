/*
 * memcpy - copy memory area
 *
 * Copyright (c) 2012-2020, Arm Limited.
 * SPDX-License-Identifier: MIT
 */

/* Assumptions:
 *
 * ARMv8-a, AArch64, unaligned accesses.
 *
 */

/* This implementation of memcpy uses unaligned accesses and branchless
   sequences to keep the code small, simple and improve performance.

   Copies are split into 3 main cases: small copies of up to 32 bytes, medium
   copies of up to 128 bytes, and large copies.  The overhead of the overlap
   check is negligible since it is only required for large copies.

   Large copies use a software pipelined loop processing 64 bytes per iteration.
   The destination pointer is 16-byte aligned to minimize unaligned accesses.
   The loop tail is handled by always copying 64 bytes from the end.
*/

.text
.global memcpy
// .type memcpy,%function
memcpy:
	add     x4, x1, x2
	add     x5, x0, x2
	cmp     x2, 128
	b.hi    .Lcopy_long
	cmp     x2, 32
	b.hi    .Lcopy32_128

	/* Small copies: 0..32 bytes.  */
	cmp     x2, 16
	b.lo    .Lcopy16
	ldp     x6, x7, [x1]
	ldp     x12, x13, [x4, -16]
	stp     x6, x7, [x0]
	stp     x12, x13, [x5, -16]
	ret

	/* Copy 8-15 bytes.  */
.Lcopy16:
	tbz     x2, 3, .Lcopy8
	ldr     x6, [x1]
	ldr     x7, [x4, -8]
	str     x6, [x0]
	str     x7, [x5, -8]
	ret

	.p2align 3
	/* Copy 4-7 bytes.  */
.Lcopy8:
	tbz     x2, 2, .Lcopy4
	ldr     w6, [x1]
	ldr     w8, [x4, -4]
	str     w6, [x0]
	str     w8, [x5, -4]
	ret

	/* Copy 0..3 bytes using a branchless sequence.  */
.Lcopy4:
	cbz     x2, .Lcopy0
	lsr     x14, x2, 1
	ldrb    w6, [x1]
	ldrb    w10, [x4, -1]
	ldrb    w8, [x1, x14]
	strb    w6, [x0]
	strb    w8, [x0, x14]
	strb    w10, [x5, -1]
.Lcopy0:
	ret

	.p2align 4
	/* Medium copies: 33..128 bytes.  */
.Lcopy32_128:
	ldp     x6, x7, [x1]
	ldp     x8, x9, [x1, 16]
	ldp     x10, x11, [x4, -32]
	ldp     x12, x13, [x4, -16]
	cmp     x2, 64
	b.hi    .Lcopy128
	stp     x6, x7, [x0]
	stp     x8, x9, [x0, 16]
	stp     x10, x11, [x5, -32]
	stp     x12, x13, [x5, -16]
	ret

	.p2align 4
	/* Copy 65..128 bytes.  */
.Lcopy128:
	ldp     x14, x15, [x1, 32]
	ldp     x16, x17, [x1, 48]
	cmp     x2, 96
	b.ls    .Lcopy96
	ldp     x2, x3, [x4, -64]
	ldp     x1, x4, [x4, -48]
	stp     x2, x3, [x5, -64]
	stp     x1, x4, [x5, -48]
.Lcopy96:
	stp     x6, x7, [x0]
	stp     x8, x9, [x0, 16]
	stp     x14, x15, [x0, 32]
	stp     x16, x17, [x0, 48]
	stp     x10, x11, [x5, -32]
	stp     x12, x13, [x5, -16]
	ret

	.p2align 4
	/* Copy more than 128 bytes.  */
.Lcopy_long:

	/* Copy 16 bytes and then align x3 to 16-byte alignment.  */

	ldp     x12, x13, [x1]
	and     x14, x0, 15
	bic     x3, x0, 15
	sub     x1, x1, x14
	add     x2, x2, x14      /* x2 is now 16 too large.  */
	ldp     x6, x7, [x1, 16]
	stp     x12, x13, [x0]
	ldp     x8, x9, [x1, 32]
	ldp     x10, x11, [x1, 48]
	ldp     x12, x13, [x1, 64]!
	subs    x2, x2, 128 + 16  /* Test and readjust x2.  */
	b.ls    .Lcopy64_from_end

.Lloop64:
	stp     x6, x7, [x3, 16]
	ldp     x6, x7, [x1, 16]
	stp     x8, x9, [x3, 32]
	ldp     x8, x9, [x1, 32]
	stp     x10, x11, [x3, 48]
	ldp     x10, x11, [x1, 48]
	stp     x12, x13, [x3, 64]!
	ldp     x12, x13, [x1, 64]!
	subs    x2, x2, 64
	b.hi    .Lloop64

	/* Write the last iteration and copy 64 bytes from the end.  */
.Lcopy64_from_end:
	ldp     x14, x15, [x4, -64]
	stp     x6, x7, [x3, 16]
	ldp     x6, x7, [x4, -48]
	stp     x8, x9, [x3, 32]
	ldp     x8, x9, [x4, -32]
	stp     x10, x11, [x3, 48]
	ldp     x10, x11, [x4, -16]
	stp     x12, x13, [x3, 64]
	stp     x14, x15, [x5, -64]
	stp     x6, x7, [x5, -48]
	stp     x8, x9, [x5, -32]
	stp     x10, x11, [x5, -16]
	ret

.size memcpy,.-memcpy
