/* tx_rate_select_and_program @ 0x9329fc, 1028 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/sxd_utils.h
 * Зовут его: tx_initiator_flow
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, direct_tx__program_cmd34, mac__build_tx_common_params, mac__cmd_29000001, mac__load_tx_vector, mac__program_tx_with_qid, mac__program_tx_with_rate, mac__select_all_sectors_and_wait, mac__select_sector_and_wait_b, mac__set_rf_chain_state, set_reg_88606c
 * Глобалы (через gp): 0x800604, 0x800608, 0x800610, 0x800614
 */
	.section .text.tx_rate_select_and_program,"ax",@progbits
	.global tx_rate_select_and_program
tx_rate_select_and_program:
	.global L_9329fc
L_9329fc:
	push_s blink
L_9329fe:
	bl.d L_920210
L_932a02:
	mov_s r1,0x2
L_932a04:
	st.as r1,[gp,0x37]
L_932a08:
	mov_s r1,0x801dd4
L_932a0e:
	ld_s r2,[r1,0xc]
L_932a10:
	mov_s r0,0x0
L_932a12:
	st.as r0,[gp,0x38]
L_932a16:
	brne_s r2,0,L_932a22
L_932a18:
	mov_s r0,0x80102c
L_932a1e:
	ldb_s r2,[r0,0x8]
L_932a20:
	st_s r2,[r1,0xc]
	.global L_932a22
L_932a22:
	norm r0,r2
L_932a26:
	rsub r13,r0,0x1e
L_932a2a:
	breq_s r2,0,L_932a3e
L_932a2c:
	asl_s r0,r13,0x3
L_932a2e:
	add3_s r0,r0,r0
L_932a30:
	mov_s r2,0x801198
L_932a36:
	ld_s r0,[r2,r0]
L_932a38:
	lsr_s r0,r0,0x8
L_932a3a:
	bmsk_s r0,r0,0xe
L_932a3c:
	b_s L_932a40
	.global L_932a3e
L_932a3e:
	mov_s r0,0x1
	.global L_932a40
L_932a40:
	st_s r0,[r1,0x10]
L_932a42:
	ld_s r0,[gp,-0xc4]
L_932a44:
	asl_s r0,r0,0x10
L_932a46:
	bset r14,r0,0x0
L_932a4a:
	mov_s r0,0x1b001111
L_932a50:
	mov_s r32,r0
L_932a52:
	st.ab r0,[r25,0x4]
L_932a56:
	bclr r25,r25,0xa
L_932a5a:
	bset_s r14,r14,0x19
L_932a5c:
	bset_s r14,r14,0x1a
L_932a5e:
	bset_s r14,r14,0x1c
L_932a60:
	mov_s r32,r14
L_932a62:
	st.ab r14,[r25,0x4]
L_932a66:
	bclr r25,r25,0xa
L_932a6a:
	mov_s r0,0x17
L_932a6c:
	asl_s r0,r0,0x18
L_932a6e:
	mov_s r32,r0
L_932a70:
	st.ab r0,[r25,0x4]
L_932a74:
	bclr r25,r25,0xa
L_932a78:
	nop_s
L_932a7a:
	nop_s
L_932a7c:
	nop_s
	.global L_932a7e
L_932a7e:
	mov_s r0,r43
L_932a80:
	bbit0 r0,0x1f,L_932a7e
L_932a84:
	mov_s r0,r51
L_932a86:
	bmsk r1,r0,0x3
L_932a8a:
	lsr_s r0,r0,0x4
L_932a8c:
	st.as r0,[gp,0x3b]
L_932a90:
	ld_s r0,[gp,-0x44]
L_932a92:
	st.as r1,[gp,0x3a]
L_932a96:
	and r0,r0,0xfff0ffff
L_932a9e:
	bset r1,r0,0x13
L_932aa2:
	st.as r1,[gp,-0x11]
L_932aa6:
	or r0,r0,0x1d080000
L_932aae:
	mov_s r32,r0
L_932ab0:
	st.ab r0,[r25,0x4]
L_932ab4:
	bclr r25,r25,0xa
L_932ab8:
	nop_s
L_932aba:
	nop_s
L_932abc:
	nop_s
	.global L_932abe
L_932abe:
	mov_s r0,r47
L_932ac0:
	bbit0 r0,0x1f,L_932abe
L_932ac4:
	extw r14,r47
L_932ac8:
	ld_s r0,[gp,-0x44]
L_932aca:
	and r0,r0,0xffff0fff
L_932ad2:
	bset r1,r0,0xd
L_932ad6:
	bset_s r1,r1,0xf
L_932ad8:
	or r0,r0,0x1d00a000
L_932ae0:
	st.as r1,[gp,-0x11]
L_932ae4:
	mov_s r32,r0
L_932ae6:
	st.ab r0,[r25,0x4]
L_932aea:
	bclr r25,r25,0xa
L_932aee:
	bl L_931980
L_932af2:
	bl L_931640
L_932af6:
	mov_s r1,r40
L_932af8:
	mov_s r0,r42
L_932afa:
	bbit1 r0,0xe,L_932b02
L_932afe:
	bbit1 r1,0x18,L_932b30
	.global L_932b02
L_932b02:
	mov_s r0,r45
L_932b04:
	bbit0 r0,0x1f,L_932b02
L_932b08:
	mov_s r0,0x29000002
L_932b0e:
	mov_s r32,r0
L_932b10:
	st.ab r0,[r25,0x4]
L_932b14:
	bclr r25,r25,0xa
L_932b18:
	mov_s r1,0x801dd4
L_932b1e:
	ldb_s r0,[r1]
L_932b20:
	st.as 0x800,[gp,0x38]
L_932b28:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932b2a:
	b.d L_932dfa
L_932b2e:
	stb_s r0,[r1]
	.global L_932b30
L_932b30:
	mov_s r0,0x801dd4
L_932b36:
	ld_s r2,[r0,0x10]
L_932b38:
	ld_s r0,[gp,-0x10]
L_932b3a:
	asl_s r2,r2,0x8
L_932b3c:
	or r1,r0,0x30
L_932b40:
	mov_s r0,0x5
L_932b42:
	or_s r1,r1,r2
L_932b44:
	mov_s r2,0x0
L_932b46:
	bl.d L_92bb2c
L_932b4a:
	mov_s r3,r2
L_932b4c:
	/* add_s r14,0x3 */
	.byte 0x03,0xe6
L_932b4e:
	bset_s r14,r14,0x18
L_932b50:
	bset_s r14,r14,0x1a
L_932b52:
	bset_s r14,r14,0x1c
L_932b54:
	mov_s r32,r14
L_932b56:
	st.ab r14,[r25,0x4]
L_932b5a:
	bclr r25,r25,0xa
L_932b5e:
	mov_s r0,0x14000007
L_932b64:
	mov_s r32,r0
L_932b66:
	st.ab r0,[r25,0x4]
L_932b6a:
	bclr r25,r25,0xa
L_932b6e:
	mov_s r0,0x10
L_932b70:
	bl.d L_924ea8
L_932b74:
	mov_s r1,r0
L_932b76:
	bl.d L_92a318
L_932b7a:
	mov_s r0,0x0
	.global L_932b7c
L_932b7c:
	mov_s r0,r43
L_932b7e:
	bbit0 r0,0x1f,L_932b7c
L_932b82:
	mov_s r0,r51
L_932b84:
	bmsk r1,r0,0x3
L_932b88:
	st.as r1,[gp,0x3a]
L_932b8c:
	lsr_s r0,r0,0x4
L_932b8e:
	st.as r0,[gp,0x3b]
	.global L_932b92
L_932b92:
	mov_s r0,r45
L_932b94:
	bbit0 r0,0x1f,L_932b92
L_932b98:
	mov_s r0,0x18001000
L_932b9e:
	mov_s r32,r0
L_932ba0:
	st.ab r0,[r25,0x4]
L_932ba4:
	bclr r25,r25,0xa
L_932ba8:
	mov_s r0,r13
L_932baa:
	mov_s r1,0x6
L_932bac:
	bl.d L_9332d4
L_932bb0:
	mov_s r2,0x5
L_932bb2:
	mov_s r0,0x2008000
L_932bb8:
	mov_s r32,r0
L_932bba:
	st.ab r0,[r25,0x4]
L_932bbe:
	bclr r25,r25,0xa
L_932bc2:
	mov_s r0,0x19000001
L_932bc8:
	mov_s r32,r0
L_932bca:
	st.ab r0,[r25,0x4]
L_932bce:
	bclr r25,r25,0xa
L_932bd2:
	bl.d L_931664
L_932bd6:
	mov_s r0,0x6
L_932bd8:
	mov_s r1,0x801390
L_932bde:
	ldb r0,[r1, 0x87]
L_932be2:
	breq_s r0,0,L_932bf0
L_932be4:
	bl.d L_926d08
L_932be8:
	add2 r0,r1,0x1d
L_932bec:
	bl L_926cf8
	.global L_932bf0
L_932bf0:
	mov_s r0,0x0
L_932bf2:
	bl.d L_9317fc
L_932bf6:
	bset_s r0,r0,0xf
L_932bf8:
	bl.d L_9316a8
L_932bfc:
	mov_s r0,0x6
L_932bfe:
	mov_s r1,0x801dd4
L_932c04:
	ldb_s r0,[r1,0x3]
L_932c06:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932c08:
	stb_s r0,[r1,0x3]
L_932c0a:
	mov_s r0,0x14
L_932c0c:
	asl_s r0,r0,0x18
L_932c0e:
	mov_s r32,r0
L_932c10:
	st.ab r0,[r25,0x4]
L_932c14:
	bclr r25,r25,0xa
L_932c18:
	ld_s r0,[gp,-0xc4]
L_932c1a:
	asl_s r0,r0,0x10
L_932c1c:
	bset r14,r0,0x0
L_932c20:
	mov_s r0,0x1b001111
L_932c26:
	mov_s r32,r0
L_932c28:
	st.ab r0,[r25,0x4]
L_932c2c:
	bclr r25,r25,0xa
L_932c30:
	bset_s r14,r14,0x19
L_932c32:
	bset_s r14,r14,0x1a
L_932c34:
	bset_s r14,r14,0x1c
L_932c36:
	mov_s r32,r14
L_932c38:
	st.ab r14,[r25,0x4]
L_932c3c:
	bclr r25,r25,0xa
L_932c40:
	mov_s r0,0x17
L_932c42:
	asl_s r0,r0,0x18
L_932c44:
	mov_s r32,r0
L_932c46:
	st.ab r0,[r25,0x4]
L_932c4a:
	bclr r25,r25,0xa
L_932c4e:
	nop_s
L_932c50:
	nop_s
L_932c52:
	nop_s
	.global L_932c54
L_932c54:
	mov_s r0,r43
L_932c56:
	bbit0 r0,0x1f,L_932c54
L_932c5a:
	mov_s r0,r51
L_932c5c:
	bmsk r1,r0,0x3
L_932c60:
	lsr_s r0,r0,0x4
L_932c62:
	st.as r0,[gp,0x3b]
L_932c66:
	mov_s r0,0x801dd4
L_932c6c:
	ld_s r2,[r0,0x10]
L_932c6e:
	ld_s r0,[gp,-0x10]
L_932c70:
	st.as r1,[gp,0x3a]
L_932c74:
	or r1,r0,0x30
L_932c78:
	asl_s r2,r2,0x8
L_932c7a:
	mov_s r0,0x1
L_932c7c:
	or_s r1,r1,r2
L_932c7e:
	mov_s r2,r0
L_932c80:
	bl.d L_92bb2c
L_932c84:
	mov_s r3,0x0
L_932c86:
	mov_s r0,0x2008000
L_932c8c:
	mov_s r32,r0
L_932c8e:
	st.ab r0,[r25,0x4]
L_932c92:
	bclr r25,r25,0xa
L_932c96:
	mov_s r0,0x19000001
L_932c9c:
	mov_s r32,r0
L_932c9e:
	st.ab r0,[r25,0x4]
L_932ca2:
	bclr r25,r25,0xa
	.global L_932ca6
L_932ca6:
	mov_s r0,r45
L_932ca8:
	bbit0 r0,0x1f,L_932ca6
L_932cac:
	mov_s r0,0x18001000
L_932cb2:
	mov_s r32,r0
L_932cb4:
	st.ab r0,[r25,0x4]
L_932cb8:
	bclr r25,r25,0xa
L_932cbc:
	bl.d L_931664
L_932cc0:
	mov_s r0,0x6
L_932cc2:
	mov_s r14,0x801dd4
L_932cc8:
	ldb_s r0,[r14,0x4]
L_932cca:
	mov_s r1,0x80087c
L_932cd0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932cd2:
	stb_s r0,[r14,0x4]
L_932cd4:
	mov_s r15,0x1
L_932cd6:
	mov_s r0,r15
L_932cd8:
	bl.d L_92b934
L_932cdc:
	ld_s r1,[r1]
L_932cde:
	mov_s r0,0x0
L_932ce0:
	bl.d L_9317fc
L_932ce4:
	bset_s r0,r0,0xf
L_932ce6:
	ldb_s r0,[r14,0x2]
L_932ce8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932cea:
	stb_s r0,[r14,0x2]
L_932cec:
	bl.d L_9316a8
L_932cf0:
	mov_s r0,0x6
L_932cf2:
	mov_s r0,0x800668
L_932cf8:
	st_s r15,[r0]
L_932cfa:
	ld_s r0,[r14,0xc]
L_932cfc:
	bclr.f r0,r0,r13
L_932d00:
	st_s r0,[r14,0xc]
L_932d02:
	bne_s L_932dfa
L_932d04:
	bl.d L_933414
L_932d08:
	mov_s r0,r15
L_932d0a:
	mov_s r13,r0
L_932d0c:
	ld_s r0,[gp,-0xc4]
L_932d0e:
	st_s r0,[r13,0x4]
L_932d10:
	mov_s r0,0x886500
L_932d16:
	ld_s r0,[r0,0x6c]
L_932d18:
	bmsk.f 0x0,r0,0x3
L_932d1c:
	beq_s L_932d30
L_932d1e:
	mov_s r0,blink
L_932d20:
	mov_s r2,0x1002578
L_932d26:
	mov_s r1,0x3
L_932d28:
	bl.d L_925548
L_932d2c:
	mov r3,0x154
	.global L_932d30
L_932d30:
	mov_s r0,0x1c000006
L_932d36:
	mov_s r32,r0
L_932d38:
	st.ab r0,[r25,0x4]
L_932d3c:
	bclr r25,r25,0xa
L_932d40:
	ld_s r0,[gp,-0xc4]
L_932d42:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_932d44:
	or r0,r0,0x46000008
L_932d4c:
	mov_s r32,r0
L_932d4e:
	st.ab r0,[r25,0x4]
L_932d52:
	bclr r25,r25,0xa
L_932d56:
	mov_s r1,0x801458
L_932d5c:
	ld_s r0,[r1,0x14]
L_932d5e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932d60:
	st_s r0,[r1,0x14]
	.global L_932d62
L_932d62:
	mov_s r0,r53
L_932d64:
	bbit0 r0,0x2,L_932d62
L_932d68:
	ld_s r0,[gp,-0x44]
L_932d6a:
	and r0,r0,0xfff0ffff
L_932d72:
	bset r1,r0,0x10
L_932d76:
	or r0,r0,0x1d010000
L_932d7e:
	st.as r1,[gp,-0x11]
L_932d82:
	mov_s r32,r0
L_932d84:
	st.ab r0,[r25,0x4]
L_932d88:
	bclr r25,r25,0xa
L_932d8c:
	nop_s
L_932d8e:
	nop_s
L_932d90:
	nop_s
	.global L_932d92
L_932d92:
	mov_s r0,r47
L_932d94:
	bbit1 r0,0x0,L_932d92
L_932d98:
	ld_s r0,[gp,-0xc4]
L_932d9a:
	or r0,r0,0x44280800
L_932da2:
	mov_s r32,r0
L_932da4:
	st.ab r0,[r25,0x4]
L_932da8:
	bclr r25,r25,0xa
L_932dac:
	mov_s r0,0x45000001
L_932db2:
	mov_s r32,r0
L_932db4:
	st.ab r0,[r25,0x4]
L_932db8:
	bclr r25,r25,0xa
L_932dbc:
	mov_s r0,0x460001f1
L_932dc2:
	mov_s r32,r0
L_932dc4:
	st.ab r0,[r25,0x4]
L_932dc8:
	bclr r25,r25,0xa
L_932dcc:
	bl.d L_92a36c
L_932dd0:
	ld_s r0,[r13,0x4]
	.global L_932dd2
L_932dd2:
	mov_s r0,r43
L_932dd4:
	bbit0 r0,0x1f,L_932dd2
L_932dd8:
	mov_s r0,r51
L_932dda:
	bmsk r1,r0,0x3
L_932dde:
	st.as r1,[gp,0x3a]
L_932de2:
	lsr_s r0,r0,0x4
L_932de4:
	st.as r0,[gp,0x3b]
	.global L_932de8
L_932de8:
	mov_s r0,r45
L_932dea:
	bbit0 r0,0x1f,L_932de8
L_932dee:
	mov_s r1,0x801dd4
L_932df4:
	ldb_s r0,[r1,0x1]
L_932df6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_932df8:
	stb_s r0,[r1,0x1]
	.global L_932dfa
L_932dfa:
	b L_92027c
L_932dfe:
	nop_s
