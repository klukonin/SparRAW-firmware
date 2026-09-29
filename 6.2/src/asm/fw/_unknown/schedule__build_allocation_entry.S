/* schedule__build_allocation_entry @ 0x8c2cf8, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w4, bits__set32_s4_w2, ese__peer_cid_by_aid, ese__slot_table_add, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global schedule__build_allocation_entry
schedule__build_allocation_entry:
	.global L_8c2cf8
L_8c2cf8:
	push_s blink
L_8c2cfa:
	bl L_8c01dc
L_8c2cfe:
	sub_s sp,sp,0xc
L_8c2d00:
	mov_s r14,r0
L_8c2d02:
	mov_s r15,r1
L_8c2d04:
	mov_s r16,r2
L_8c2d06:
	mov_s r13,r3
L_8c2d08:
	mov_s r0,sp
L_8c2d0a:
	bl.d L_8c1cd8
L_8c2d0e:
	mov_s r1,0xc
L_8c2d10:
	bmsk r1,r16,0x3
L_8c2d14:
	mov_s r0,sp
L_8c2d16:
	bl L_8ed370
L_8c2d1a:
	ldb_s r1,[r13,0x5]
L_8c2d1c:
	bmsk_s r1,r1,0x1
L_8c2d1e:
	bl L_8ed4fc
L_8c2d22:
	ld_s r0,[sp,0x0]
L_8c2d24:
	mov_s r1,0x0
L_8c2d26:
	bclr_s r0,r0,0x6
L_8c2d28:
	st_s r0,[sp,0x0]
L_8c2d2a:
	ld_s r3,[r14,0x10]
L_8c2d2c:
	ldb_s r2,[r13,0xe]
L_8c2d2e:
	ldb_s r3,[r3,0x8]
L_8c2d30:
	cmp_s r2,r3
L_8c2d32:
	mov_s r12,0xff
L_8c2d34:
	cmp.ne r2,r12
L_8c2d38:
	mov.eq r1,0x1
L_8c2d3c:
	bmsk_s r1,r1,0x0
L_8c2d3e:
	bclr_s r0,r0,0x7
L_8c2d40:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8c2d42:
	or_s r0,r0,r1
L_8c2d44:
	st_s r0,[sp,0x0]
L_8c2d46:
	ldb_s r1,[r13,0xe]
L_8c2d48:
	mov_s r0,r14
L_8c2d4a:
	bl.d L_8cc9c8
L_8c2d4e:
	ldb_s r2,[r13,0xf]
L_8c2d50:
	stb r0,[sp, 0x1]
L_8c2d54:
	ldb_s r0,[r13,0xe]
L_8c2d56:
	mov_s r1,sp
L_8c2d58:
	stb r0,[sp, 0x2]
L_8c2d5c:
	ldb_s r0,[r13,0xf]
L_8c2d5e:
	st_s r15,[sp,0x4]
L_8c2d60:
	stb r0,[sp, 0x3]
L_8c2d64:
	ldw_s r0,[r13,0x6]
L_8c2d66:
	stw r0,[sp, 0x8]
L_8c2d6a:
	bl.d L_8e1d38
L_8c2d6e:
	ld_s r0,[r14]
L_8c2d70:
	b.d L_8c0244
L_8c2d74:
	add_s sp,sp,0xc
L_8c2d76:
	nop_s
