/* macq_desc__read_typed @ 0x8c4f1c, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ie__scan_buf_10, qh__write_by_flags_fw
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bits__set32_s0_w2, bits__set32_s2_w2, bits__set32_s4_w3, bits__set32_s4_w5, macq_desc__release_window, macq_desc__wait_window_free
 * Глобалы (через gp): 0x800236
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__read_typed
macq_desc__read_typed:
	.global L_8c4f1c
L_8c4f1c:
	push_s blink
L_8c4f1e:
	bl.d L_8c01d4
L_8c4f22:
	mov_s r7,r0
L_8c4f24:
	sub_s sp,sp,0x8
L_8c4f26:
	mov_s r14,r1
L_8c4f28:
	mov_s r13,r2
L_8c4f2a:
	mov_s r15,0x0
L_8c4f2c:
	stw r15,[sp, 0x4]
L_8c4f30:
	stw r15,[sp, 0x6]
L_8c4f34:
	bmsk r1,r13,0x2
L_8c4f38:
	add_s r0,sp,0x4
L_8c4f3a:
	bl.d L_8ed514
L_8c4f3e:
	st_s r15,[sp,0x0]
L_8c4f40:
	mov_s r1,r15
L_8c4f42:
	bl.d L_8ed358
L_8c4f46:
	mov r17,r6
L_8c4f4a:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8c4f4c:
	mov r16,r4
L_8c4f50:
	brhs.d r13,0x6,L_8c4f80
L_8c4f54:
	mov_s r2,r5
L_8c4f56:
	ldb.x r13,[0x8021d8,r13]
L_8c4f5e:
	add r0,pcl,0xa
L_8c4f62:
	add1_s r0,r0,r13
L_8c4f64:
	j_s [r0]
L_8c4f66:
	bmsk r1,r3,0x1
L_8c4f6a:
	mov_s r0,sp
L_8c4f6c:
	bl.d L_8ed4cc
L_8c4f70:
	mov_s r15,0x1
L_8c4f72:
	bmsk r1,r14,0x4
L_8c4f76:
	bl L_8ed52c
L_8c4f7a:
	b_s L_8c4f80
L_8c4f7c:
	st r16,[sp]
	.global L_8c4f80
L_8c4f80:
	bl.d L_8c50e4
L_8c4f84:
	mov_s r13,0x0
L_8c4f86:
	ldw r0,[sp, 0x4]
L_8c4f8a:
	mov_s r3,0x886600
L_8c4f90:
	asl_s r0,r0,0x10
L_8c4f92:
	st_s r0,[r3,0xc]
L_8c4f94:
	brlo r2,0x1,L_8c5004
L_8c4f98:
	mov_s r14,r7
	.global L_8c4f9a
L_8c4f9a:
	mov_s r18,r2
L_8c4f9c:
	add r1,r13,r16
L_8c4fa0:
	cmp_s r15,0x0
L_8c4fa2:
	bmsk.ne r1,r1,0x1
L_8c4fa6:
	mov.ne r0,sp
L_8c4faa:
	bl.ne L_8ed358
L_8c4fae:
	bne_s L_8c4fb2
L_8c4fb0:
	st_s r1,[sp,0x0]
	.global L_8c4fb2
L_8c4fb2:
	ld_s r0,[sp,0x0]
L_8c4fb4:
	st_s r0,[r3,0x10]
L_8c4fb6:
	ldb_s r0,[gp,0xb2]
L_8c4fb8:
	brne_s r0,0,L_8c4fc4
L_8c4fba:
	st 0xc0000000,[r3, 0x8]
L_8c4fc2:
	b_s L_8c4fcc
	.global L_8c4fc4
L_8c4fc4:
	st 0x40000000,[r3, 0x8]
	.global L_8c4fcc
L_8c4fcc:
	sync
	.global L_8c4fd0
L_8c4fd0:
	mov_s r3,0x886600
L_8c4fd6:
	ld_s r0,[r3,0x8]
L_8c4fd8:
	bbit1 r0,0x1d,L_8c4fd0
L_8c4fdc:
	mov_s r0,0x0
L_8c4fde:
	cmp r17,0x0
L_8c4fe2:
	mov.hi lp_count,r17
L_8c4fe6:
	lphi L_8c4ffa
L_8c4fea:
	mov_s r1,0x886614
L_8c4ff0:
	ld.as r1,[r1,r0]
L_8c4ff4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c4ff6:
	st.ab r1,[r14,0x4]
	.global L_8c4ffa
L_8c4ffa:
	sub r2,r18,0x1
L_8c4ffe:
	/* brhs.d r2,0x1,0x008c4f9a */
	.byte 0x9f,0x0a,0x75,0x80
L_8c5002:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c5004
L_8c5004:
	bl L_8c5238
L_8c5008:
	b.d L_8c0234
L_8c500c:
	add_s sp,sp,0x8
L_8c500e:
	nop_s
