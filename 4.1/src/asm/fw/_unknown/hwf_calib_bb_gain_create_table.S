/* hwf_calib_bb_gain_create_table @ 0x8d1c1c, 672 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_calib_bb_gain_create_table() Non linearity in RX-VGA Table. row: %d
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_calib_bb_gain_alg
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, calib_bb_gain__pick_closest, fw_log__emit1, hwd_abif_rx_table_config_vga_gain
 */
	.section .text.hwf_calib_bb_gain_create_table,"ax",@progbits
	.global hwf_calib_bb_gain_create_table
hwf_calib_bb_gain_create_table:
	.global L_8d1c1c
L_8d1c1c:
	sub_s sp,sp,0x1c
L_8d1c1e:
	push_s blink
L_8d1c20:
	bl.d L_8c02b0
L_8d1c24:
	mov lp_count,0x3f
L_8d1c28:
	sub sp,sp,0x208
L_8d1c2c:
	st.as r2,[sp,0x8b]
L_8d1c30:
	st.as r3,[sp,0x8c]
L_8d1c34:
	st.as r4,[sp,0x8d]
L_8d1c38:
	st.as r5,[sp,0x8e]
L_8d1c3c:
	st.as r6,[sp,0x8f]
L_8d1c40:
	st.as r7,[sp,0x90]
L_8d1c44:
	add2 r16,r0,0x17
L_8d1c48:
	add r17,r0,0x3c
L_8d1c4c:
	add r18,r0,0x1c
L_8d1c50:
	mov_s r3,0x0
L_8d1c52:
	lp L_8d1c66
L_8d1c56:
	add3 r2,sp,r3
L_8d1c5a:
	st 0x7fffffff,[r2]
L_8d1c62:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8d1c64:
	extb_s r3,r3
	.global L_8d1c66
L_8d1c66:
	ldb r2,[sp,0x22c]
L_8d1c6e:
	sub r19,r0,0x4
L_8d1c72:
	ld.as r3,[r19,r2]
L_8d1c76:
	ldb r2,[sp,0x22d]
L_8d1c7e:
	mov_s r15,sp
L_8d1c80:
	ld.as r2,[r18,r2]
L_8d1c84:
	add r15,r15,0x200
L_8d1c88:
	add_s r2,r2,r3
L_8d1c8a:
	ldb r3,[sp,0x22e]
L_8d1c92:
	mov r10,0x8000
L_8d1c9a:
	ld.as r3,[r17,r3]
L_8d1c9e:
	add_s r3,r3,r2
L_8d1ca0:
	ldb r2,[sp,0x22f]
L_8d1ca8:
	ld.as r2,[r16,r2]
L_8d1cac:
	add_s r2,r2,r3
L_8d1cae:
	sub r11,r1,r2
L_8d1cb2:
	ld_s r2,[r0]
L_8d1cb4:
	ld_s r1,[r0,0x20]
L_8d1cb6:
	add_s r2,r2,r11
L_8d1cb8:
	add_s r1,r1,r2
L_8d1cba:
	ld_s r2,[r0,0x40]
L_8d1cbc:
	add_s r2,r2,r1
L_8d1cbe:
	ld_s r1,[r0,0x60]
L_8d1cc0:
	add3 r0,sp,0x30
L_8d1cc4:
	add_s r1,r1,r2
L_8d1cc6:
	mov_s r2,0x0
L_8d1cc8:
	stb r2,[r0, 0x7c]
L_8d1ccc:
	stb r2,[r0, 0x7d]
L_8d1cd0:
	st.as r1,[sp,0x7e]
L_8d1cd4:
	stb r2,[r0, 0x7e]
L_8d1cd8:
	brlt.d r1,0x0,L_8d1ce8
L_8d1cdc:
	stb r2,[r0, 0x7f]
L_8d1ce0:
	add r0,r1,r10
L_8d1ce4:
	asr_s r0,r0,0x10
L_8d1ce6:
	b_s L_8d1cf0
	.global L_8d1ce8
L_8d1ce8:
	sub r0,r10,r1
L_8d1cec:
	asr_s r0,r0,0x10
L_8d1cee:
	neg_s r0,r0
	.global L_8d1cf0
L_8d1cf0:
	add r7,r0,0x1
L_8d1cf4:
	ldb r0,[sp,0x233]
L_8d1cfc:
	cmp_s r0,0x1
L_8d1cfe:
	blt.d L_8d1e32
L_8d1d02:
	mov r9,0x1
	.global L_8d1d06
L_8d1d06:
	ldb r0,[sp,0x232]
L_8d1d0e:
	cmp_s r0,0x1
L_8d1d10:
	blt.d L_8d1e1c
L_8d1d14:
	mov r8,0x1
	.global L_8d1d18
L_8d1d18:
	ldb r0,[sp,0x231]
L_8d1d20:
	brlt.d r0,0x1,L_8d1e06
L_8d1d24:
	mov r5,0x1
	.global L_8d1d28
L_8d1d28:
	ldb r0,[sp,0x230]
L_8d1d30:
	brlt.d r0,0x1,L_8d1df2
L_8d1d34:
	mov r6,0x1
	.global L_8d1d38
L_8d1d38:
	ld.as r1,[r19,r6]
L_8d1d3c:
	ld.as r0,[r18,r5]
L_8d1d40:
	add_s r1,r1,r11
L_8d1d42:
	add_s r0,r0,r1
L_8d1d44:
	ld.as r1,[r17,r8]
L_8d1d48:
	add_s r1,r1,r0
L_8d1d4a:
	ld.as r0,[r16,r9]
L_8d1d4e:
	add r4,r0,r1
L_8d1d52:
	add r0,sp,r6
L_8d1d56:
	ldb r0,[r0,0x233]
L_8d1d5e:
	stb_s r0,[r15,0x4]
L_8d1d60:
	add r0,sp,r5
L_8d1d64:
	ldb r0,[r0,0x23b]
L_8d1d6c:
	stb_s r0,[r15,0x5]
L_8d1d6e:
	add r0,sp,r8
L_8d1d72:
	ldb r0,[r0,0x243]
L_8d1d7a:
	stb_s r0,[r15,0x6]
L_8d1d7c:
	add r0,sp,r9
L_8d1d80:
	ldb r0,[r0,0x24b]
L_8d1d88:
	stb_s r0,[r15,0x7]
L_8d1d8a:
	add r0,r4,r10
L_8d1d8e:
	asr_s r0,r0,0x10
L_8d1d90:
	sub r1,r0,r7
L_8d1d94:
	extb_s r1,r1
L_8d1d96:
	cmp_s r1,0x40
L_8d1d98:
	bge L_8d1dde
L_8d1d9c:
	rsub r0,r1,0x3e
L_8d1da0:
	max r0,r0,0x0
L_8d1da4:
	extb_s r0,r0
L_8d1da6:
	mov_s r12,0x42
L_8d1da8:
	rsub r2,r1,r12
L_8d1dac:
	min r2,r2,0x3e
L_8d1db0:
	extb_s r2,r2
L_8d1db2:
	brlt r2,r0,L_8d1dde
L_8d1db6:
	sub_s r2,r2,r0
L_8d1db8:
	extb_s r2,r2
L_8d1dba:
	add_s r14,r2,0x1
L_8d1dbc:
	mov_s r13,r0
	.global L_8d1dbe
L_8d1dbe:
	mov_s r12,0x40
L_8d1dc0:
	rsub r3,r13,r12
L_8d1dc4:
	mov_s r0,sp
L_8d1dc6:
	ld_s r2,[r15,0x4]
L_8d1dc8:
	add_s r3,r3,r7
L_8d1dca:
	add3_s r0,r0,r13
L_8d1dcc:
	mov_s r1,r4
L_8d1dce:
	bl.d L_8d2484
L_8d1dd2:
	asl_s r3,r3,0x10
L_8d1dd4:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d1dd6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d1dd8:
	brhs.d r14,0x1,L_8d1dbe
L_8d1ddc:
	extb_s r13,r13
	.global L_8d1dde
L_8d1dde:
	add r6,r6,0x1
L_8d1de2:
	ldb r0,[sp,0x230]
L_8d1dea:
	extb r6,r6
L_8d1dee:
	brge r0,r6,L_8d1d38
	.global L_8d1df2
L_8d1df2:
	add r5,r5,0x1
L_8d1df6:
	ldb r0,[sp,0x231]
L_8d1dfe:
	extb r5,r5
L_8d1e02:
	brge r0,r5,L_8d1d28
	.global L_8d1e06
L_8d1e06:
	add r8,r8,0x1
L_8d1e0a:
	ldb r0,[sp,0x232]
L_8d1e12:
	extb r8,r8
L_8d1e16:
	cmp_s r0,r8
L_8d1e18:
	bge L_8d1d18
	.global L_8d1e1c
L_8d1e1c:
	add r9,r9,0x1
L_8d1e20:
	ldb r0,[sp,0x233]
L_8d1e28:
	extb r9,r9
L_8d1e2c:
	cmp_s r0,r9
L_8d1e2e:
	bge L_8d1d06
	.global L_8d1e32
L_8d1e32:
	add3 r0,r7,0x8
L_8d1e36:
	mov_s r1,0x8004d8
L_8d1e3c:
	stb_s r0,[r1]
L_8d1e3e:
	add3 r15,r15,r7
L_8d1e42:
	ld_s r0,[r15]
L_8d1e44:
	mov_s r13,0x3f
L_8d1e46:
	st_s r0,[r1,0x4]
L_8d1e48:
	mov_s r17,r13
L_8d1e4a:
	b_s L_8d1e50
	.global L_8d1e4c
L_8d1e4c:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d1e4e:
	extb_s r13,r13
	.global L_8d1e50
L_8d1e50:
	brlt r13,0x1,L_8d1eb2
L_8d1e54:
	add3 r0,sp,r13
L_8d1e58:
	ld_s r1,[r0]
L_8d1e5a:
	cmp_s r1,0x7fffffff
L_8d1e60:
	mov.ne r17,r13
L_8d1e64:
	brge r13,0x3f,L_8d1e7e
L_8d1e68:
	ld_s r0,[r0,0x8]
L_8d1e6a:
	brge r1,r0,L_8d1e7e
L_8d1e6e:
	mov_s r2,0x1017c80
L_8d1e74:
	mov_s r0,0x6
L_8d1e76:
	mov_s r1,0x1
L_8d1e78:
	bl.d L_8edfcc
L_8d1e7c:
	mov_s r3,r13
	.global L_8d1e7e
L_8d1e7e:
	mov_s r14,0x1
L_8d1e80:
	mov_s r15,0x4
	.global L_8d1e82
L_8d1e82:
	add r0,sp,r14
L_8d1e86:
	add3 r16,r0,r17
L_8d1e8a:
	mov_s r0,r13
L_8d1e8c:
	mov_s r1,r14
L_8d1e8e:
	mov_s r2,0x0
L_8d1e90:
	bl.d L_8cc4a0
L_8d1e94:
	ldb r3,[r16, 0x3]
L_8d1e98:
	mov_s r0,r13
L_8d1e9a:
	mov_s r1,r14
L_8d1e9c:
	mov_s r2,0x1
L_8d1e9e:
	bl.d L_8cc4a0
L_8d1ea2:
	ldb r3,[r16, 0x3]
L_8d1ea6:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d1ea8:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d1eaa:
	brhs.d r15,0x1,L_8d1e82
L_8d1eae:
	extb_s r14,r14
L_8d1eb0:
	b_s L_8d1e4c
	.global L_8d1eb2
L_8d1eb2:
	mov_s r12,0x20
L_8d1eb4:
	b.d L_8c030e
L_8d1eb8:
	add sp,sp,0x208
