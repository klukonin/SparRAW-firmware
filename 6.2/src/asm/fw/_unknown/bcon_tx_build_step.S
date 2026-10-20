/* bcon_tx_build_step @ 0x8c4c20, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: add_bcon, mid__reset_bss_defaults
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bcon__bits_set16_s6_w7, bcon__bits_set16_s7_w3, bcon__bits_set16_s7_w6, bcon__bits_set8_s5_w3, bits__set16_s6_w6, bits__set8_s0_w2, bits__set8_s2_w4, bss_bi_ctrl_PCP_ready_set
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bcon_tx_build_step
bcon_tx_build_step:
	.global L_8c4c20
L_8c4c20:
	push_s blink
L_8c4c22:
	bl.d L_8c01e4
L_8c4c26:
	mov_s r2,r0
L_8c4c28:
	mov_s r3,r1
L_8c4c2a:
	mov_s r14,0x0
L_8c4c2c:
	add3 r13,r0,0x20
L_8c4c30:
	add r0,r13,0xb
L_8c4c34:
	mov_s r1,r14
L_8c4c36:
	bl L_8ed268
L_8c4c3a:
	bl L_8ed22c
L_8c4c3e:
	add_s r0,r13,0x7
L_8c4c40:
	mov_s r1,0x1
L_8c4c42:
	bl L_8ed1f0
L_8c4c46:
	ldb_s r0,[r13,0x7]
L_8c4c48:
	bclr_s r0,r0,0x6
L_8c4c4a:
	bclr r1,r0,0x0
L_8c4c4e:
	ld_s r0,[r2,0x8]
L_8c4c50:
	stb_s r1,[r13,0x7]
L_8c4c52:
	cmp_s r0,0x2
L_8c4c54:
	cmp.ne r0,0x3
L_8c4c58:
	mov.ne r0,r14
L_8c4c5c:
	bne_s L_8c4c60
L_8c4c5e:
	mov_s r0,0x1
	.global L_8c4c60
L_8c4c60:
	extb.f 0x0,r0
L_8c4c64:
	mov_s r0,0x1
L_8c4c66:
	sub_s.ne r0,r0,r0
L_8c4c68:
	asl_s r0,r0
L_8c4c6a:
	bclr_s r1,r1,0x1
L_8c4c6c:
	or_s r1,r1,r0
L_8c4c6e:
	ldb_s r0,[r13,0x9]
L_8c4c70:
	stb_s r1,[r13,0x7]
L_8c4c72:
	bclr_s r0,r0,0x5
L_8c4c74:
	stb_s r0,[r13,0x9]
L_8c4c76:
	mov_s r0,0x857280
L_8c4c7c:
	ldb_s r0,[r0,0xe]
L_8c4c7e:
	cmp_s r0,0x0
L_8c4c80:
	mov_s r1,0x3
L_8c4c82:
	mov.le r1,0xf
L_8c4c86:
	bmsk_s r1,r1,0x3
L_8c4c88:
	add r0,r13,0x8
L_8c4c8c:
	bl.d L_8ed268
L_8c4c90:
	cmp_s r3,0x0
L_8c4c92:
	ldb_s r0,[r13,0x8]
L_8c4c94:
	mov_s r1,0x0
L_8c4c96:
	bset_s r0,r0,0x6
L_8c4c98:
	stb_s r0,[r13,0x8]
L_8c4c9a:
	add r0,r13,0xb
L_8c4c9e:
	bl L_8ed1d8
L_8c4ca2:
	add r0,r13,0xa
L_8c4ca6:
	mov_s r1,0x4
L_8c4ca8:
	bl L_8ed2b0
L_8c4cac:
	add r0,r13,0x8
L_8c4cb0:
	mov_s r1,0x0
L_8c4cb2:
	bl L_8ed208
L_8c4cb6:
	add_s r0,r13,0x7
L_8c4cb8:
	bl L_8ed268
L_8c4cbc:
	mov.ne r0,r2
L_8c4cc0:
	bl.ne.d L_8c4be8
L_8c4cc4:
	mov.ne r1,0x1
L_8c4cc8:
	add r0,r13,0x9
L_8c4ccc:
	mov_s r1,0x1
L_8c4cce:
	bl L_8ed1e4
L_8c4cd2:
	b L_8c0254
L_8c4cd6:
	nop_s
