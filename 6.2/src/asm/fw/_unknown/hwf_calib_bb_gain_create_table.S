/* hwf_calib_bb_gain_create_table @ 0x8d4ac8, 712 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_calib_bb_gain_create_table(): disabled
 *   hwf_calib_bb_gain_create_table() Non linearity in RX-VGA Table. row: %d
 * Зовут его: Calib__Measure_VGA_Gains
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, calib__keep_closest, fw_log_emit0, fw_log_emit1, hwd_abif_rx_table_config_vga_gain
 * Глобалы (через gp): 0x80021d
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib_bb_gain_create_table
hwf_calib_bb_gain_create_table:
	.global L_8d4ac8
L_8d4ac8:
	sub_s sp,sp,0x1c
L_8d4aca:
	push_s blink
L_8d4acc:
	bl L_8c01d0
L_8d4ad0:
	sub sp,sp,0x208
L_8d4ad4:
	st.as r2,[sp,0x8b]
L_8d4ad8:
	st.as r3,[sp,0x8c]
L_8d4adc:
	st.as r4,[sp,0x8d]
L_8d4ae0:
	mov_s r2,r0
L_8d4ae2:
	add2 r16,r0,0x17
L_8d4ae6:
	add r17,r0,0x3c
L_8d4aea:
	add r18,r0,0x1c
L_8d4aee:
	mov_s r0,0x8042c8
L_8d4af4:
	ld r0,[r0,0x468]
L_8d4afc:
	st.as r6,[sp,0x8f]
L_8d4b00:
	st.as r5,[sp,0x8e]
L_8d4b04:
	st.as r7,[sp,0x90]
L_8d4b08:
	brne r0,0x3,L_8d4b20
L_8d4b0c:
	ldb_s r0,[gp,0x99]
L_8d4b0e:
	breq_s r0,0,L_8d4b20
L_8d4b10:
	mov_s r1,0x101caf4
L_8d4b16:
	bl.d L_8dcba8
L_8d4b1a:
	mov_s r0,0x26
L_8d4b1c:
	b L_8d4d84
	.global L_8d4b20
L_8d4b20:
	mov lp_count,0x3f
L_8d4b24:
	mov_s r3,0x0
L_8d4b26:
	lp L_8d4b3a
L_8d4b2a:
	add3 r0,sp,r3
L_8d4b2e:
	st 0x7fffffff,[r0]
L_8d4b36:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8d4b38:
	extb_s r3,r3
	.global L_8d4b3a
L_8d4b3a:
	ldb r0,[sp,0x22c]
L_8d4b42:
	sub r19,r2,0x4
L_8d4b46:
	ld.as r3,[r19,r0]
L_8d4b4a:
	ldb r0,[sp,0x22d]
L_8d4b52:
	mov_s r15,sp
L_8d4b54:
	ld.as r0,[r18,r0]
L_8d4b58:
	add r15,r15,0x200
L_8d4b5c:
	add_s r0,r0,r3
L_8d4b5e:
	ldb r3,[sp,0x22e]
L_8d4b66:
	mov r10,0x8000
L_8d4b6e:
	ld.as r3,[r17,r3]
L_8d4b72:
	add_s r3,r3,r0
L_8d4b74:
	ldb r0,[sp,0x22f]
L_8d4b7c:
	ld.as r0,[r16,r0]
L_8d4b80:
	add_s r0,r0,r3
L_8d4b82:
	sub r11,r1,r0
L_8d4b86:
	ld_s r0,[r2]
L_8d4b88:
	ld_s r1,[r2,0x20]
L_8d4b8a:
	add_s r0,r0,r11
L_8d4b8c:
	add_s r1,r1,r0
L_8d4b8e:
	ld_s r0,[r2,0x40]
L_8d4b90:
	add_s r0,r0,r1
L_8d4b92:
	ld_s r1,[r2,0x60]
L_8d4b94:
	mov_s r2,0x0
L_8d4b96:
	add_s r1,r1,r0
L_8d4b98:
	add3 r0,sp,0x30
L_8d4b9c:
	stb r2,[r0, 0x7c]
L_8d4ba0:
	stb r2,[r0, 0x7d]
L_8d4ba4:
	st.as r1,[sp,0x7e]
L_8d4ba8:
	stb r2,[r0, 0x7e]
L_8d4bac:
	brlt.d r1,0x0,L_8d4bbc
L_8d4bb0:
	stb r2,[r0, 0x7f]
L_8d4bb4:
	add r0,r1,r10
L_8d4bb8:
	asr_s r0,r0,0x10
L_8d4bba:
	b_s L_8d4bc4
	.global L_8d4bbc
L_8d4bbc:
	sub r0,r10,r1
L_8d4bc0:
	asr_s r0,r0,0x10
L_8d4bc2:
	neg_s r0,r0
	.global L_8d4bc4
L_8d4bc4:
	add r6,r0,0x1
L_8d4bc8:
	ldb r0,[sp,0x233]
L_8d4bd0:
	cmp_s r0,0x1
L_8d4bd2:
	blt.d L_8d4d06
L_8d4bd6:
	mov r9,0x1
	.global L_8d4bda
L_8d4bda:
	ldb r0,[sp,0x232]
L_8d4be2:
	cmp_s r0,0x1
L_8d4be4:
	blt.d L_8d4cf0
L_8d4be8:
	mov r8,0x1
	.global L_8d4bec
L_8d4bec:
	ldb r0,[sp,0x231]
L_8d4bf4:
	brlt.d r0,0x1,L_8d4cda
L_8d4bf8:
	mov r7,0x1
	.global L_8d4bfc
L_8d4bfc:
	ldb r0,[sp,0x230]
L_8d4c04:
	brlt.d r0,0x1,L_8d4cc6
L_8d4c08:
	mov r5,0x1
	.global L_8d4c0c
L_8d4c0c:
	ld.as r1,[r19,r5]
L_8d4c10:
	ld.as r0,[r18,r7]
L_8d4c14:
	add_s r1,r1,r11
L_8d4c16:
	add_s r0,r0,r1
L_8d4c18:
	ld.as r1,[r17,r8]
L_8d4c1c:
	add_s r1,r1,r0
L_8d4c1e:
	ld.as r0,[r16,r9]
L_8d4c22:
	add r4,r0,r1
L_8d4c26:
	add r0,sp,r5
L_8d4c2a:
	ldb r0,[r0,0x233]
L_8d4c32:
	add r1,r4,r10
L_8d4c36:
	stb_s r0,[r15,0x4]
L_8d4c38:
	add r0,sp,r7
L_8d4c3c:
	ldb r0,[r0,0x23b]
L_8d4c44:
	asr_s r1,r1,0x10
L_8d4c46:
	stb_s r0,[r15,0x5]
L_8d4c48:
	add r0,sp,r8
L_8d4c4c:
	ldb r0,[r0,0x243]
L_8d4c54:
	sub r1,r1,r6
L_8d4c58:
	stb_s r0,[r15,0x6]
L_8d4c5a:
	add r0,sp,r9
L_8d4c5e:
	extb_s r1,r1
L_8d4c60:
	cmp_s r1,0x40
L_8d4c62:
	ldb r0,[r0,0x24b]
L_8d4c6a:
	bge.d L_8d4cb2
L_8d4c6e:
	stb_s r0,[r15,0x7]
L_8d4c70:
	rsub r0,r1,0x3e
L_8d4c74:
	max r0,r0,0x0
L_8d4c78:
	extb_s r0,r0
L_8d4c7a:
	mov_s r12,0x42
L_8d4c7c:
	rsub r2,r1,r12
L_8d4c80:
	min r2,r2,0x3e
L_8d4c84:
	extb_s r2,r2
L_8d4c86:
	brlt r2,r0,L_8d4cb2
L_8d4c8a:
	sub_s r2,r2,r0
L_8d4c8c:
	extb_s r2,r2
L_8d4c8e:
	add_s r13,r2,0x1
L_8d4c90:
	mov_s r14,r0
	.global L_8d4c92
L_8d4c92:
	mov_s r12,0x40
L_8d4c94:
	rsub r3,r14,r12
L_8d4c98:
	mov_s r0,sp
L_8d4c9a:
	ld_s r2,[r15,0x4]
L_8d4c9c:
	add_s r3,r3,r6
L_8d4c9e:
	add3_s r0,r0,r14
L_8d4ca0:
	mov_s r1,r4
L_8d4ca2:
	bl.d L_8d52d0
L_8d4ca6:
	asl_s r3,r3,0x10
L_8d4ca8:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d4caa:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d4cac:
	brhs.d r13,0x1,L_8d4c92
L_8d4cb0:
	extb_s r14,r14
	.global L_8d4cb2
L_8d4cb2:
	add r5,r5,0x1
L_8d4cb6:
	ldb r0,[sp,0x230]
L_8d4cbe:
	extb r5,r5
L_8d4cc2:
	brge r0,r5,L_8d4c0c
	.global L_8d4cc6
L_8d4cc6:
	add r7,r7,0x1
L_8d4cca:
	ldb r0,[sp,0x231]
L_8d4cd2:
	extb r7,r7
L_8d4cd6:
	brge r0,r7,L_8d4bfc
	.global L_8d4cda
L_8d4cda:
	add r8,r8,0x1
L_8d4cde:
	ldb r0,[sp,0x232]
L_8d4ce6:
	extb r8,r8
L_8d4cea:
	cmp_s r0,r8
L_8d4cec:
	bge L_8d4bec
	.global L_8d4cf0
L_8d4cf0:
	add r9,r9,0x1
L_8d4cf4:
	ldb r0,[sp,0x233]
L_8d4cfc:
	extb r9,r9
L_8d4d00:
	cmp_s r0,r9
L_8d4d02:
	bge L_8d4bda
	.global L_8d4d06
L_8d4d06:
	add3 r0,r6,0x8
L_8d4d0a:
	mov_s r1,0x800508
L_8d4d10:
	stb_s r0,[r1]
L_8d4d12:
	add3 r15,r15,r6
L_8d4d16:
	ld_s r0,[r15]
L_8d4d18:
	mov_s r13,0x3f
L_8d4d1a:
	st_s r0,[r1,0x4]
L_8d4d1c:
	mov_s r17,r13
L_8d4d1e:
	b_s L_8d4d24
	.global L_8d4d20
L_8d4d20:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d4d22:
	extb_s r13,r13
	.global L_8d4d24
L_8d4d24:
	brlt r13,0x1,L_8d4d84
L_8d4d28:
	add3 r0,sp,r13
L_8d4d2c:
	ld_s r1,[r0]
L_8d4d2e:
	cmp_s r1,0x7fffffff
L_8d4d34:
	mov.ne r17,r13
L_8d4d38:
	brge r13,0x3f,L_8d4d50
L_8d4d3c:
	ld_s r0,[r0,0x8]
L_8d4d3e:
	brge r1,r0,L_8d4d50
L_8d4d42:
	mov_s r1,0x101cb20
L_8d4d48:
	mov_s r0,0x16
L_8d4d4a:
	bl.d L_8dcc10
L_8d4d4e:
	mov_s r2,r13
	.global L_8d4d50
L_8d4d50:
	mov_s r14,0x1
L_8d4d52:
	mov_s r15,0x4
	.global L_8d4d54
L_8d4d54:
	add r0,sp,r14
L_8d4d58:
	add3 r16,r0,r17
L_8d4d5c:
	mov_s r0,r13
L_8d4d5e:
	mov_s r1,r14
L_8d4d60:
	mov_s r2,0x0
L_8d4d62:
	bl.d L_8cf418
L_8d4d66:
	ldb r3,[r16, 0x3]
L_8d4d6a:
	mov_s r0,r13
L_8d4d6c:
	mov_s r1,r14
L_8d4d6e:
	mov_s r2,0x1
L_8d4d70:
	bl.d L_8cf418
L_8d4d74:
	ldb r3,[r16, 0x3]
L_8d4d78:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d4d7a:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d4d7c:
	brhs.d r15,0x1,L_8d4d54
L_8d4d80:
	extb_s r14,r14
L_8d4d82:
	b_s L_8d4d20
	.global L_8d4d84
L_8d4d84:
	mov_s r12,0x20
L_8d4d86:
	b.d L_8c022e
L_8d4d8a:
	add sp,sp,0x208
L_8d4d8e:
	nop_s
