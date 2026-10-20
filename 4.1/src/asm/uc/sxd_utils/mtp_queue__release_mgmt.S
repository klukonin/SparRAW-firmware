/* mtp_queue__release_mgmt @ 0x937b84, 768 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Error: MTP Queue is empty
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/sxd_utils.h
 *   Released one management frame due to no PEER availability for sta_id=%d
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/txrx_funcs.h
 * Зовут его: tx_mtp_queue_gate, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r17_to_r13_ret_uc, __st_r17_to_r13_uc, get_tx_eligibility__precheck, mac__program_tx_with_qid, tbl_801754__byte_by_index, uc_sysassert
 * Глобалы (через gp): 0x800540, 0x800604, 0x800610, 0x800614
 */
	.section .text.mtp_queue__release_mgmt,"ax",@progbits
	.global mtp_queue__release_mgmt
mtp_queue__release_mgmt:
	.global L_937b84
L_937b84:
	push_s blink
L_937b86:
	bl L_920208
L_937b8a:
	mov_s r14,r0
L_937b8c:
	mov_s r17,r1
L_937b8e:
	mov.f r0,r2
L_937b92:
	mov_s r13,0x0
L_937b94:
	mov.ne r0,0x1
L_937b98:
	asl_s r0,r0
L_937b9a:
	cmp_s r3,0x0
L_937b9c:
	ld_s r15,[r14,0x4]
L_937b9e:
	ld_s r1,[r14]
L_937ba0:
	beq_s L_937c7e
L_937ba2:
	mov_s r2,0x8016d8
L_937ba8:
	asl_s r0,r1,0x2
L_937baa:
	add1_s r0,r0,r0
L_937bac:
	ld_s r0,[r2,r0]
L_937bae:
	asl_s r15,r15,0x10
L_937bb0:
	sub.f r0,r0,0x0
L_937bb4:
	mov.ne r0,0x1
L_937bb8:
	extb.f 0x0,r0
L_937bbc:
	bset_s r15,r15,0x2
L_937bbe:
	beq_s L_937bcc
L_937bc0:
	bl.d L_92c1ec
L_937bc4:
	mov_s r0,r1
L_937bc6:
	asl_s r0,r0,0x8
L_937bc8:
	or r13,r0,0x3
	.global L_937bcc
L_937bcc:
	mov_s r0,0x1b001111
L_937bd2:
	mov_s r32,r0
L_937bd4:
	st.ab r0,[r25,0x4]
L_937bd8:
	bclr r25,r25,0xa
L_937bdc:
	bset_s r15,r15,0x19
L_937bde:
	bset_s r15,r15,0x1a
L_937be0:
	bset_s r15,r15,0x1c
L_937be2:
	mov_s r32,r15
L_937be4:
	st.ab r15,[r25,0x4]
L_937be8:
	bclr r25,r25,0xa
L_937bec:
	or r13,r13,0x17000000
L_937bf4:
	mov_s r32,r13
L_937bf6:
	st.ab r13,[r25,0x4]
L_937bfa:
	bclr r25,r25,0xa
L_937bfe:
	nop_s
L_937c00:
	nop_s
L_937c02:
	nop_s
	.global L_937c04
L_937c04:
	mov_s r0,r43
L_937c06:
	bbit0 r0,0x1f,L_937c04
L_937c0a:
	mov_s r0,r51
L_937c0c:
	bmsk r1,r0,0x3
L_937c10:
	st.as r1,[gp,0x3a]
L_937c14:
	lsr_s r0,r0,0x4
L_937c16:
	st.as r0,[gp,0x3b]
L_937c1a:
	lsr r0,r43,0x10
L_937c1e:
	bmsk r1,r0,0x4
L_937c22:
	st r1,[r17]
	.global L_937c26
L_937c26:
	mov_s r0,r45
L_937c28:
	bbit0 r0,0x1f,L_937c26
L_937c2c:
	lsr r0,r45
L_937c30:
	bxor r0,r0,0x0
L_937c34:
	ld_s r1,[r14,0x14]
L_937c36:
	extb r2,r45
L_937c3a:
	and_s r1,r1,r2
L_937c3c:
	cmp_s r1,0x0
L_937c3e:
	mov r16,0x1
L_937c42:
	sub.ne r16,r16,r16
L_937c46:
	bbit1 r0,0x0,L_937cca
L_937c4a:
	mov_s r2,0x80209c
L_937c50:
	ldb_s r0,[r2,0xa]
L_937c52:
	mov_s r1,0x1000520
L_937c58:
	btst_s r0,0x0
L_937c5a:
	beq L_937e6a
L_937c5e:
	bmsk_s r1,r1,0x13
L_937c60:
	ld_s r0,[r2]
L_937c62:
	or r1,r1,0xa0600000
L_937c6a:
	extb_s r13,r0
L_937c6c:
	mov_s r3,0x8020b0
L_937c72:
	add2_s r3,r3,r13
L_937c74:
	st_s r1,[r3]
L_937c76:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937c78:
	b.d L_937e6a
L_937c7c:
	st_s r0,[r2]
	.global L_937c7e
L_937c7e:
	ld_s r2,[r14,0x8]
L_937c80:
	asl_s r15,r15,0x10
L_937c82:
	brne r0,0x2,L_937c90
L_937c86:
	or r15,r15,0x103
	.global L_937c8a
L_937c8a:
	asl r13,r2,0x10
L_937c8e:
	b_s L_937c9a
	.global L_937c90
L_937c90:
	cmp_s r0,0x1
L_937c92:
	or.eq r15,r15,0x3
L_937c96:
	beq_s L_937c8a
L_937c98:
	bset_s r15,r15,0x0
	.global L_937c9a
L_937c9a:
	ld_s r0,[gp,0xdc]
L_937c9c:
	btst_s r0,0x1
L_937c9e:
	beq_s L_937bcc
L_937ca0:
	asl_s r0,r1,0x2
L_937ca2:
	add1_s r0,r0,r0
L_937ca4:
	mov_s r2,0x8016d8
L_937caa:
	ld_s r0,[r2,r0]
L_937cac:
	sub.f r0,r0,0x0
L_937cb0:
	mov.ne r0,0x1
L_937cb4:
	extb.f 0x0,r0
L_937cb8:
	beq_s L_937bcc
L_937cba:
	bl.d L_92c1ec
L_937cbe:
	mov_s r0,r1
L_937cc0:
	asl_s r0,r0,0x8
L_937cc2:
	or r0,r0,0x3
L_937cc6:
	or_s r13,r13,r0
L_937cc8:
	b_s L_937bcc
	.global L_937cca
L_937cca:
	lsr r13,r43,0x8
L_937cce:
	bmsk_s r13,r13,0x3
L_937cd0:
	cmp_s r13,0x8
L_937cd2:
	bcc.d L_937e70
L_937cd6:
	st_s r13,[r14]
	.global L_937cd8
L_937cd8:
	asl_s r1,r13,0x3
L_937cda:
	add3_s r1,r1,r1
L_937cdc:
	add_s r1,r1,0x801190
L_937ce2:
	ld_s r2,[r1,0xc]
L_937ce4:
	mov_s r0,0x801418
L_937cea:
	st r2,[r17, 0x4]
L_937cee:
	ld_s r2,[r1,0x8]
L_937cf0:
	st r2,[r17, 0x8]
L_937cf4:
	ld_s r1,[r1,0x4]
L_937cf6:
	st_s r1,[r0,0x8]
L_937cf8:
	ld_s r0,[gp,0x18]
L_937cfa:
	bbit1 r0,0x0,L_937d00
L_937cfe:
	st_s r1,[r14,0x28]
	.global L_937d00
L_937d00:
	ld_s r0,[r14,0x4]
L_937d02:
	mov_s r1,0x1
L_937d04:
	brne r0,0x1a,L_937d0e
L_937d08:
	ld_s r0,[gp,0xe8]
L_937d0a:
	btst_s r0,0x2
L_937d0c:
	sub_s.ne r1,r1,r1
	.global L_937d0e
L_937d0e:
	lsr r0,r43,0x4
L_937d12:
	bmsk_s r0,r0,0x3
L_937d14:
	cmp_s r1,0x0
L_937d16:
	st_s r0,[r14,0x24]
L_937d18:
	mov_s r15,0x1
L_937d1a:
	beq_s L_937e5a
L_937d1c:
	ld_s r0,[r14,0x4]
L_937d1e:
	cmp_s r0,0x1a
L_937d20:
	bne_s L_937e5a
L_937d22:
	mov_s r0,0x801ed0
L_937d28:
	mov_s r1,0x1a
L_937d2a:
	bl.d L_9264f0
L_937d2e:
	mov_s r2,r13
L_937d30:
	mov.f r15,r0
L_937d34:
	bne_s L_937e5a
L_937d36:
	mov_s r0,0x886500
L_937d3c:
	ld_s r0,[r0,0x6c]
L_937d3e:
	bmsk.f 0x0,r0,0x3
L_937d42:
	ld r17,[r14, 0x4]
L_937d46:
	beq_s L_937d5a
L_937d48:
	mov_s r0,blink
L_937d4a:
	mov_s r2,0x10004e4
L_937d50:
	mov_s r1,0x3
L_937d52:
	bl.d L_925548
L_937d56:
	mov r3,0x154
	.global L_937d5a
L_937d5a:
	mov_s r0,0x1c000006
L_937d60:
	mov_s r32,r0
L_937d62:
	st.ab r0,[r25,0x4]
L_937d66:
	bclr r25,r25,0xa
L_937d6a:
	asl r0,r17,0x4
L_937d6e:
	or r0,r0,0x46005008
L_937d76:
	mov_s r32,r0
L_937d78:
	st.ab r0,[r25,0x4]
L_937d7c:
	bclr r25,r25,0xa
L_937d80:
	mov_s r1,0x801458
L_937d86:
	ld_s r0,[r1,0x14]
L_937d88:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937d8a:
	st_s r0,[r1,0x14]
	.global L_937d8c
L_937d8c:
	mov_s r0,r53
L_937d8e:
	bbit0 r0,0x2,L_937d8c
L_937d92:
	ld_s r0,[gp,-0x44]
L_937d94:
	and r0,r0,0xfff0ffff
L_937d9c:
	bset r1,r0,0x10
L_937da0:
	or r0,r0,0x1d010000
L_937da8:
	st.as r1,[gp,-0x11]
L_937dac:
	mov_s r32,r0
L_937dae:
	st.ab r0,[r25,0x4]
L_937db2:
	bclr r25,r25,0xa
L_937db6:
	nop_s
L_937db8:
	nop_s
L_937dba:
	nop_s
	.global L_937dbc
L_937dbc:
	mov_s r0,r47
L_937dbe:
	bbit1 r0,0x0,L_937dbc
L_937dc2:
	asl r1,r13,0x8
L_937dc6:
	bset_s r1,r1,0x1a
L_937dc8:
	bset_s r1,r1,0x1e
L_937dca:
	or r0,r17,r1
L_937dce:
	bset_s r0,r0,0x13
L_937dd0:
	bset_s r0,r0,0x15
L_937dd2:
	mov_s r32,r0
L_937dd4:
	st.ab r0,[r25,0x4]
L_937dd8:
	bclr r25,r25,0xa
L_937ddc:
	mov_s r0,0x45000001
L_937de2:
	mov_s r32,r0
L_937de4:
	st.ab r0,[r25,0x4]
L_937de8:
	bclr r25,r25,0xa
L_937dec:
	mov_s r0,0x460001f1
L_937df2:
	mov_s r32,r0
L_937df4:
	st.ab r0,[r25,0x4]
L_937df8:
	bclr r25,r25,0xa
L_937dfc:
	mov_s r2,0x80209c
L_937e02:
	ldb_s r0,[r2,0xa]
L_937e04:
	mov r4,0x100053c
L_937e0c:
	bbit0 r0,0x2,L_937e38
L_937e10:
	ld_s r0,[r2]
L_937e12:
	mov_s r1,0x8020b0
L_937e18:
	add_s r3,r0,0x1
L_937e1a:
	extb_s r3,r3
L_937e1c:
	add2 r3,r1,r3
L_937e20:
	st_s r13,[r3]
L_937e22:
	bmsk r3,r4,0x13
L_937e26:
	or r3,r3,0xa6600000
L_937e2e:
	extb_s r13,r0
L_937e30:
	add2_s r1,r1,r13
L_937e32:
	st_s r3,[r1]
L_937e34:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_937e36:
	st_s r0,[r2]
	.global L_937e38
L_937e38:
	bl.d L_92a36c
L_937e3c:
	ld_s r0,[r14,0x4]
	.global L_937e3e
L_937e3e:
	mov_s r0,r43
L_937e40:
	bbit0 r0,0x1f,L_937e3e
L_937e44:
	mov_s r0,r51
L_937e46:
	bmsk r1,r0,0x3
L_937e4a:
	st.as r1,[gp,0x3a]
L_937e4e:
	lsr_s r0,r0,0x4
L_937e50:
	st.as r0,[gp,0x3b]
	.global L_937e54
L_937e54:
	mov_s r0,r45
L_937e56:
	bbit0 r0,0x1f,L_937e54
	.global L_937e5a
L_937e5a:
	mov_s r0,0x0
L_937e5c:
	cmp_s r15,0x0
L_937e5e:
	cmp.ne r16,0x0
L_937e62:
	mov.ne r0,0x1
L_937e66:
	extb r16,r0
	.global L_937e6a
L_937e6a:
	b.d L_92026c
L_937e6e:
	mov_s r0,r16
	.global L_937e70
L_937e70:
	mov_s r0,blink
L_937e72:
	mov_s r2,0x1000584
L_937e78:
	mov_s r1,0x8
L_937e7a:
	bl.d L_925548
L_937e7e:
	mov_s r3,0xdd
L_937e80:
	b L_937cd8
