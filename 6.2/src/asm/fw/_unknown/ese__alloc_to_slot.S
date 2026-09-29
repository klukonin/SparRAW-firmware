/* ese__alloc_to_slot @ 0x8c7d4c, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations_from_beacon
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s0_w4, bits__set32_s4_w2, ese__peer_cid_by_aid, ese__slot_table_add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ese__alloc_to_slot
ese__alloc_to_slot:
	.global L_8c7d4c
L_8c7d4c:
	push_s blink
L_8c7d4e:
	bl L_8c01e0
L_8c7d52:
	sub_s sp,sp,0xc
L_8c7d54:
	mov_s r15,r1
L_8c7d56:
	ldb_s r1,[r2]
L_8c7d58:
	mov_s r14,r0
L_8c7d5a:
	bmsk_s r1,r1,0x3
L_8c7d5c:
	mov_s r0,sp
L_8c7d5e:
	bl.d L_8ed370
L_8c7d62:
	mov_s r13,r2
L_8c7d64:
	ldb_s r1,[r13]
L_8c7d66:
	lsr_s r1,r1,0x4
L_8c7d68:
	bmsk_s r1,r1,0x1
L_8c7d6a:
	bl L_8ed4fc
L_8c7d6e:
	ld_s r0,[sp,0x0]
L_8c7d70:
	mov_s r1,0x0
L_8c7d72:
	bclr_s r0,r0,0x6
L_8c7d74:
	st_s r0,[sp,0x0]
L_8c7d76:
	ld_s r3,[r14,0x10]
L_8c7d78:
	ldb_s r2,[r13,0x4]
L_8c7d7a:
	ldb_s r3,[r3,0x8]
L_8c7d7c:
	cmp_s r2,r3
L_8c7d7e:
	mov_s r12,0xff
L_8c7d80:
	cmp.ne r2,r12
L_8c7d84:
	mov.eq r1,0x1
L_8c7d88:
	bmsk_s r1,r1,0x0
L_8c7d8a:
	bclr_s r0,r0,0x7
L_8c7d8c:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8c7d8e:
	or_s r0,r0,r1
L_8c7d90:
	st_s r0,[sp,0x0]
L_8c7d92:
	ldb_s r1,[r13,0x4]
L_8c7d94:
	mov_s r0,r14
L_8c7d96:
	bl.d L_8cc9c8
L_8c7d9a:
	ldb_s r2,[r13,0x5]
L_8c7d9c:
	stb r0,[sp, 0x1]
L_8c7da0:
	ldb_s r0,[r13,0x4]
L_8c7da2:
	stb r0,[sp, 0x2]
L_8c7da6:
	ldb_s r0,[r13,0x5]
L_8c7da8:
	stb r0,[sp, 0x3]
L_8c7dac:
	ldb_s r1,[r13,0x7]
L_8c7dae:
	ldb_s r0,[r13,0x6]
L_8c7db0:
	asl_s r1,r1,0x8
L_8c7db2:
	or_s r0,r0,r1
L_8c7db4:
	ldb_s r1,[r13,0x8]
L_8c7db6:
	asl_s r1,r1,0x10
L_8c7db8:
	or_s r0,r0,r1
L_8c7dba:
	ldb_s r1,[r13,0x9]
L_8c7dbc:
	asl_s r1,r1,0x18
L_8c7dbe:
	or_s r0,r0,r1
L_8c7dc0:
	sub_s r0,r0,r15
L_8c7dc2:
	st_s r0,[sp,0x4]
L_8c7dc4:
	ldb_s r0,[r13,0xb]
L_8c7dc6:
	ldb_s r1,[r13,0xa]
L_8c7dc8:
	asl_s r0,r0,0x8
L_8c7dca:
	or_s r1,r1,r0
L_8c7dcc:
	stw r1,[sp, 0x8]
L_8c7dd0:
	mov_s r1,sp
L_8c7dd2:
	bl.d L_8e1d38
L_8c7dd6:
	ld_s r0,[r14]
L_8c7dd8:
	b.d L_8c024c
L_8c7ddc:
	add_s sp,sp,0xc
L_8c7dde:
	nop_s
