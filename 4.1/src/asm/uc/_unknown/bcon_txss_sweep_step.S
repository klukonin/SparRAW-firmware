/* bcon_txss_sweep_step @ 0x935a4c, 904 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, txss__tx_sector_frame
 * Зовёт сам: __ld_r17_to_r13_ret_uc, __st_r17_to_r13_uc, bcon_sweep__next_sector, get_g_80087c, mac__build_tx_common_params, mac__cmd_29000001, mac__program_tx_beacon, mac__program_tx_common, mac__select_all_sectors_and_wait, mac__select_sector_and_wait_a, mac__select_sector_and_wait_b, uc_spin_until_event
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.bcon_txss_sweep_step,"ax",@progbits
	.global bcon_txss_sweep_step
bcon_txss_sweep_step:
	.global L_935a4c
L_935a4c:
	push_s blink
L_935a4e:
	bl L_920208
L_935a52:
	mov_s r16,r1
L_935a54:
	st.a r2,[sp,-0x14]
L_935a58:
	mov_s r14,r3
L_935a5a:
	mov r17,r4
L_935a5e:
	mov_s r13,r5
L_935a60:
	mov_s r15,0x1
L_935a62:
	breq r1,0x1,L_935a8e
L_935a66:
	mov_s r0,0x801cbc
L_935a6c:
	ld_s r0,[r0,0x2c]
L_935a6e:
	bset_s r0,r0,0x18
L_935a70:
	bset_s r0,r0,0x1a
L_935a72:
	bset_s r0,r0,0x1c
L_935a74:
	mov_s r32,r0
L_935a76:
	st.ab r0,[r25,0x4]
L_935a7a:
	bclr r25,r25,0xa
L_935a7e:
	mov_s r0,0x14000007
L_935a84:
	mov_s r32,r0
L_935a86:
	st.ab r0,[r25,0x4]
L_935a8a:
	bclr r25,r25,0xa
	.global L_935a8e
L_935a8e:
	mov_s r0,0x801c9c
L_935a94:
	ldb_s r3,[r0,0xc]
L_935a96:
	or r2,r17,0x2d000000
L_935a9e:
	ldb_s r1,[r0,0xd]
L_935aa0:
	asl_s r3,r3
L_935aa2:
	ldb_s r0,[r0,0xe]
L_935aa4:
	or_s r2,r2,r3
L_935aa6:
	asl_s r1,r1,0xa
L_935aa8:
	or_s r1,r1,r2
L_935aaa:
	asl_s r0,r0,0x10
L_935aac:
	or_s r0,r0,r1
L_935aae:
	mov_s r32,r0
L_935ab0:
	st.ab r0,[r25,0x4]
L_935ab4:
	bclr r25,r25,0xa
L_935ab8:
	cmp_s r14,0x0
L_935aba:
	jlne [r14]
L_935abe:
	mov_s r0,0x0
L_935ac0:
	cmp r16,0x5
L_935ac4:
	st_s r0,[sp,0x4]
L_935ac6:
	st_s r0,[sp,0x8]
L_935ac8:
	bne_s L_935be6
L_935aca:
	brne_s r13,0,L_935ad2
L_935acc:
	bl L_92a2d4
L_935ad0:
	b_s L_935ad6
	.global L_935ad2
L_935ad2:
	bl L_92a3c0
	.global L_935ad6
L_935ad6:
	ld_s r0,[gp,-0x44]
L_935ad8:
	and r0,r0,0xffff0fff
L_935ae0:
	bset r1,r0,0xd
L_935ae4:
	bset_s r1,r1,0xf
L_935ae6:
	or r0,r0,0x1d00a000
L_935aee:
	st.as r1,[gp,-0x11]
L_935af2:
	mov_s r32,r0
L_935af4:
	st.ab r0,[r25,0x4]
L_935af8:
	bclr r25,r25,0xa
L_935afc:
	bl L_931980
L_935b00:
	bl L_931640
L_935b04:
	mov_s r1,r40
L_935b06:
	mov_s r0,r42
L_935b08:
	bbit1 r0,0xe,L_935b10
L_935b0c:
	bbit1 r1,0x18,L_935b2c
	.global L_935b10
L_935b10:
	mov_s r0,0x29000002
L_935b16:
	mov_s r32,r0
L_935b18:
	st.ab r0,[r25,0x4]
L_935b1c:
	bclr r25,r25,0xa
	.global L_935b20
L_935b20:
	mov_s r0,r45
L_935b22:
	bbit0 r0,0x1f,L_935b20
L_935b26:
	b.d L_935dcc
L_935b2a:
	mov_s r0,0x0
	.global L_935b2c
L_935b2c:
	mov_s r0,0x801c9c
L_935b32:
	ldb_s r2,[r0,0xd]
L_935b34:
	ld_s r0,[gp,-0x10]
L_935b36:
	asl_s r2,r2,0x8
L_935b38:
	or r1,r0,0x30
L_935b3c:
	or_s r1,r1,r2
L_935b3e:
	ld_s r2,[sp,0x4]
L_935b40:
	mov_s r0,r16
L_935b42:
	bl.d L_92bb2c
L_935b46:
	ld_s r3,[sp,0x8]
L_935b48:
	bl.d L_931664
L_935b4c:
	mov_s r0,0x6
L_935b4e:
	brne_s r13,0,L_935b6e
L_935b50:
	mov_s r0,0x14000005
L_935b56:
	mov_s r32,r0
L_935b58:
	st.ab r0,[r25,0x4]
L_935b5c:
	bclr r25,r25,0xa
L_935b60:
	mov_s r0,0x80
L_935b62:
	bset_s r0,r0,0x19
L_935b64:
	mov_s r32,r0
L_935b66:
	st.ab r0,[r25,0x4]
L_935b6a:
	bclr r25,r25,0xa
	.global L_935b6e
L_935b6e:
	mov_s r0,0x2008000
L_935b74:
	mov_s r32,r0
L_935b76:
	st.ab r0,[r25,0x4]
L_935b7a:
	bclr r25,r25,0xa
L_935b7e:
	ld_s r0,[gp,0xdc]
L_935b80:
	and r1,r0,0x10
L_935b84:
	mov_s r0,0x0
L_935b86:
	or.f 0x0,r1,r0
L_935b8a:
	beq_s L_935bac
L_935b8c:
	ld_s r0,[gp,0xe8]
L_935b8e:
	ld.as r1,[gp,0x3b]
L_935b92:
	bic r0,r0,-0x3
L_935b96:
	cmp_s r0,0x2
L_935b98:
	mov_s r0,0x1
L_935b9a:
	sub_s.ne r0,r0,r0
L_935b9c:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_935b9e:
	or r0,r0,0x19800830
L_935ba6:
	asl_s r1,r1,0xe
L_935ba8:
	or_s r0,r0,r1
L_935baa:
	b_s L_935bb2
	.global L_935bac
L_935bac:
	mov_s r0,0x19000001
	.global L_935bb2
L_935bb2:
	mov_s r32,r0
L_935bb4:
	st.ab r0,[r25,0x4]
L_935bb8:
	bclr r25,r25,0xa
	.global L_935bbc
L_935bbc:
	mov_s r0,r45
L_935bbe:
	bbit0 r0,0x1f,L_935bbc
L_935bc2:
	ld_s r0,[gp,0xdc]
L_935bc4:
	and r1,r0,0x10
L_935bc8:
	mov_s r0,0x0
L_935bca:
	or.f 0x0,r1,r0
L_935bce:
	mov_s r0,0x18
L_935bd0:
	asl.ne r0,r0,0x18
L_935bd4:
	mov.eq r0,0x18001000
L_935bdc:
	mov_s r32,r0
L_935bde:
	st.ab r0,[r25,0x4]
L_935be2:
	bclr r25,r25,0xa
	.global L_935be6
L_935be6:
	mov_s r0,r45
L_935be8:
	bbit0 r0,0x1f,L_935be6
	.global L_935bec
L_935bec:
	cmp_s r15,0x1
L_935bee:
	mov.eq r15,0x0
L_935bf2:
	beq_s L_935c94
L_935bf4:
	brne_s r13,0,L_935bfc
L_935bf6:
	bl L_92a2d4
L_935bfa:
	b_s L_935c00
	.global L_935bfc
L_935bfc:
	bl L_92a3c0
	.global L_935c00
L_935c00:
	mov_s r0,r43
L_935c02:
	bbit0 r0,0x1f,L_935c00
L_935c06:
	mov_s r0,r51
L_935c08:
	bmsk r1,r0,0x3
L_935c0c:
	st.as r1,[gp,0x3a]
L_935c10:
	lsr_s r0,r0,0x4
L_935c12:
	st.as r0,[gp,0x3b]
L_935c16:
	bl.d L_931664
L_935c1a:
	mov_s r0,0x6
L_935c1c:
	mov_s r0,0x2008000
L_935c22:
	mov_s r32,r0
L_935c24:
	st.ab r0,[r25,0x4]
L_935c28:
	bclr r25,r25,0xa
L_935c2c:
	ld_s r0,[gp,0xdc]
L_935c2e:
	and r1,r0,0x10
L_935c32:
	mov_s r0,0x0
L_935c34:
	or.f 0x0,r1,r0
L_935c38:
	beq_s L_935c5a
L_935c3a:
	ld_s r0,[gp,0xe8]
L_935c3c:
	ld.as r1,[gp,0x3b]
L_935c40:
	bic r0,r0,-0x3
L_935c44:
	cmp_s r0,0x2
L_935c46:
	mov_s r0,0x1
L_935c48:
	sub_s.ne r0,r0,r0
L_935c4a:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_935c4c:
	or r0,r0,0x19800830
L_935c54:
	asl_s r1,r1,0xe
L_935c56:
	or_s r0,r0,r1
L_935c58:
	b_s L_935c60
	.global L_935c5a
L_935c5a:
	mov_s r0,0x19000001
	.global L_935c60
L_935c60:
	mov_s r32,r0
L_935c62:
	st.ab r0,[r25,0x4]
L_935c66:
	bclr r25,r25,0xa
	.global L_935c6a
L_935c6a:
	mov_s r0,r45
L_935c6c:
	bbit0 r0,0x1f,L_935c6a
L_935c70:
	ld_s r0,[gp,0xdc]
L_935c72:
	and r1,r0,0x10
L_935c76:
	mov_s r0,0x0
L_935c78:
	or.f 0x0,r1,r0
L_935c7c:
	mov_s r0,0x18
L_935c7e:
	asl.ne r0,r0,0x18
L_935c82:
	mov.eq r0,0x18001000
L_935c8a:
	mov_s r32,r0
L_935c8c:
	st.ab r0,[r25,0x4]
L_935c90:
	bclr r25,r25,0xa
	.global L_935c94
L_935c94:
	bl.d L_930e94
L_935c98:
	ld_s r0,[sp,0x0]
L_935c9a:
	cmp_s r0,0x0
L_935c9c:
	beq_s L_935dbe
L_935c9e:
	mov_s r0,0x3c000200
L_935ca4:
	mov_s r32,r0
L_935ca6:
	st.ab r0,[r25,0x4]
L_935caa:
	bclr r25,r25,0xa
L_935cae:
	mov_s r0,0x38000200
L_935cb4:
	mov_s r32,r0
L_935cb6:
	st.ab r0,[r25,0x4]
L_935cba:
	bclr r25,r25,0xa
L_935cbe:
	mov_s r0,0x36000038
L_935cc4:
	mov_s r32,r0
L_935cc6:
	st.ab r0,[r25,0x4]
L_935cca:
	bclr r25,r25,0xa
L_935cce:
	mov_s r0,0x6000103
L_935cd4:
	mov_s r32,r0
L_935cd6:
	st.ab r0,[r25,0x4]
L_935cda:
	bclr r25,r25,0xa
L_935cde:
	mov_s r0,0x0
L_935ce0:
	bl.d L_9317fc
L_935ce4:
	bset_s r0,r0,0xf
L_935ce6:
	mov_s r1,0x801c9c
L_935cec:
	ldb_s r3,[r1,0xc]
L_935cee:
	or r2,r17,0x2d000000
L_935cf6:
	ldb_s r0,[r1,0xd]
L_935cf8:
	asl_s r3,r3
L_935cfa:
	ldb_s r1,[r1,0xe]
L_935cfc:
	or_s r2,r2,r3
L_935cfe:
	asl_s r0,r0,0xa
L_935d00:
	or_s r0,r0,r2
L_935d02:
	asl_s r1,r1,0x10
L_935d04:
	or_s r0,r0,r1
L_935d06:
	mov_s r32,r0
L_935d08:
	st.ab r0,[r25,0x4]
L_935d0c:
	bclr r25,r25,0xa
L_935d10:
	breq_s r13,0,L_935d3a
L_935d12:
	mov_s r0,0x801cbc
L_935d18:
	ld_s r0,[r0,0x2c]
L_935d1a:
	bset_s r0,r0,0x18
L_935d1c:
	bset_s r0,r0,0x1a
L_935d1e:
	bset_s r0,r0,0x1c
L_935d20:
	mov_s r32,r0
L_935d22:
	st.ab r0,[r25,0x4]
L_935d26:
	bclr r25,r25,0xa
L_935d2a:
	mov_s r0,0x14000007
L_935d30:
	mov_s r32,r0
L_935d32:
	st.ab r0,[r25,0x4]
L_935d36:
	bclr r25,r25,0xa
	.global L_935d3a
L_935d3a:
	cmp_s r14,0x0
L_935d3c:
	jlne [r14]
L_935d40:
	mov_s r0,0x801c9c
L_935d46:
	ldb_s r1,[r0,0xd]
L_935d48:
	ld_s r0,[gp,-0x10]
L_935d4a:
	asl_s r1,r1,0x8
L_935d4c:
	or r0,r0,0x30
L_935d50:
	or r16,r1,r0
L_935d54:
	bl.d L_931338
L_935d58:
	mov_s r0,0x5
L_935d5a:
	or r0,r16,0x3f000000
L_935d62:
	mov_s r32,r0
L_935d64:
	st.ab r0,[r25,0x4]
L_935d68:
	bclr r25,r25,0xa
L_935d6c:
	ld_s r0,[sp,0x4]
L_935d6e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_935d70:
	or r0,r0,0x3e000000
L_935d78:
	mov_s r32,r0
L_935d7a:
	st.ab r0,[r25,0x4]
L_935d7e:
	bclr r25,r25,0xa
L_935d82:
	mov_s r0,0x37000020
L_935d88:
	mov_s r32,r0
L_935d8a:
	st.ab r0,[r25,0x4]
L_935d8e:
	bclr r25,r25,0xa
L_935d92:
	mov_s r1,0x801458
L_935d98:
	ld_s r0,[r1,0xc]
L_935d9a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935d9c:
	st_s r0,[r1,0xc]
L_935d9e:
	mov_s r0,0x80088c
L_935da4:
	ldb r1,[r0, 0x50]
L_935da8:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_935daa:
	add2_s r1,r1,r1
L_935dac:
	add_s r1,r1,0x8008ac
L_935db2:
	ldb_s r0,[r1,0x4]
L_935db4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935db6:
	extb_s r0,r0
L_935db8:
	b.d L_935bec
L_935dbc:
	stb_s r0,[r1,0x4]
	.global L_935dbe
L_935dbe:
	bl L_930f34
L_935dc2:
	mov_s r0,0x0
L_935dc4:
	bl.d L_9317fc
L_935dc8:
	bset_s r0,r0,0xf
L_935dca:
	mov_s r0,0x1
	.global L_935dcc
L_935dcc:
	b.d L_92026c
L_935dd0:
	add_s sp,sp,0x14
L_935dd2:
	nop_s
