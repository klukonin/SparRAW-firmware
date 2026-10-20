/* cf_end_mtp_step @ 0x937a0c, 376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run, tx_flows__program_mac_tx
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, cf_end__tx_flow, mtp_service__dispatch, set_reg_88606c
 * Глобалы (через gp): 0x80056c, 0x800604, 0x800608, 0x800610, 0x800614
 */
	.section .text.cf_end_mtp_step,"ax",@progbits
	.global cf_end_mtp_step
cf_end_mtp_step:
	.global L_937a0c
L_937a0c:
	push_s blink
L_937a0e:
	bl L_920210
L_937a12:
	mov_s r14,r0
L_937a14:
	mov_s r15,r1
L_937a16:
	mov_s r0,0x2008000
L_937a1c:
	mov_s r32,r0
L_937a1e:
	st.ab r0,[r25,0x4]
L_937a22:
	bclr r25,r25,0xa
L_937a26:
	mov_s r0,0x19000001
L_937a2c:
	mov_s r32,r0
L_937a2e:
	st.ab r0,[r25,0x4]
L_937a32:
	bclr r25,r25,0xa
L_937a36:
	lsr r13,r43,0x1a
L_937a3a:
	bmsk_s r13,r13,0x0
	.global L_937a3c
L_937a3c:
	mov_s r0,r45
L_937a3e:
	bbit0 r0,0x1f,L_937a3c
L_937a42:
	ld_s r1,[r14,0x14]
L_937a44:
	extb r0,r45
L_937a48:
	and_s r0,r0,r1
L_937a4a:
	cmp_s r0,0x0
L_937a4c:
	mov_s r0,0x1
L_937a4e:
	sub_s.ne r0,r0,r0
L_937a50:
	extb.f 0x0,r0
L_937a54:
	beq_s L_937a8a
L_937a56:
	ld_s r1,[r14]
L_937a58:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_937a5a:
	add1_s r1,r1,r1
L_937a5c:
	add_s r1,r1,0x8016d8
L_937a62:
	ld_s r2,[r1]
L_937a64:
	mov_s r0,0x0
L_937a66:
	breq r2,0x2,L_937a82
L_937a6a:
	ld_s r1,[r1,0x4]
L_937a6c:
	cmp_s r1,0x3
L_937a6e:
	cmp.ne r1,0x4
L_937a72:
	cmp.ne r1,0x5
L_937a76:
	bne_s L_937a7a
L_937a78:
	mov_s r0,0x1
	.global L_937a7a
L_937a7a:
	extb.f 0x0,r0
L_937a7e:
	mov_s r0,0x0
L_937a80:
	beq_s L_937a84
	.global L_937a82
L_937a82:
	mov_s r0,0x1
	.global L_937a84
L_937a84:
	extb.f 0x0,r0
L_937a88:
	beq_s L_937b46
	.global L_937a8a
L_937a8a:
	ld_s r0,[r14,0x20]
L_937a8c:
	brne r0,0x2,L_937b30
L_937a90:
	ld_s r0,[r14,0xc]
L_937a92:
	bbit0 r0,0x0,L_937b30
L_937a96:
	ld_s r1,[r14]
L_937a98:
	asl_s r2,r1,0x2
L_937a9a:
	add1_s r2,r2,r2
L_937a9c:
	add_s r2,r2,0x8016d8
L_937aa2:
	ld_s r3,[r2]
L_937aa4:
	mov_s r0,0x0
L_937aa6:
	breq r3,0x2,L_937ac2
L_937aaa:
	ld_s r2,[r2,0x4]
L_937aac:
	cmp_s r2,0x3
L_937aae:
	cmp.ne r2,0x4
L_937ab2:
	cmp.ne r2,0x5
L_937ab6:
	bne_s L_937aba
L_937ab8:
	mov_s r0,0x1
	.global L_937aba
L_937aba:
	extb.f 0x0,r0
L_937abe:
	mov_s r0,0x0
L_937ac0:
	beq_s L_937ac4
	.global L_937ac2
L_937ac2:
	mov_s r0,0x1
	.global L_937ac4
L_937ac4:
	extb.f 0x0,r0
L_937ac8:
	bne_s L_937b30
L_937aca:
	ld_s r2,[r14,0x8]
L_937acc:
	mov_s r0,0x1
L_937ace:
	bl.d L_92a404
L_937ad2:
	mov_s r3,r15
	.global L_937ad4
L_937ad4:
	mov_s r0,r43
L_937ad6:
	bbit0 r0,0x1f,L_937ad4
L_937ada:
	mov_s r0,r51
L_937adc:
	bmsk r1,r0,0x3
L_937ae0:
	st.as r1,[gp,0x3a]
L_937ae4:
	lsr_s r0,r0,0x4
L_937ae6:
	st.as r0,[gp,0x3b]
L_937aea:
	mov_s r0,r43
	.global L_937aec
L_937aec:
	mov_s r0,r45
L_937aee:
	bbit0 r0,0x1f,L_937aec
L_937af2:
	ld_s r0,[gp,0xdc]
L_937af4:
	bbit0 r0,0x1,L_937b0c
L_937af8:
	asl_s r13,r13,0xb
L_937afa:
	bset_s r13,r13,0xe
L_937afc:
	bset_s r13,r13,0x1b
L_937afe:
	bset_s r13,r13,0x1c
L_937b00:
	mov_s r32,r13
L_937b02:
	st.ab r13,[r25,0x4]
L_937b06:
	bclr r25,r25,0xa
L_937b0a:
	b_s L_937b1a
	.global L_937b0c
L_937b0c:
	mov_s r0,0x18
L_937b0e:
	asl_s r0,r0,0x18
L_937b10:
	mov_s r32,r0
L_937b12:
	st.ab r0,[r25,0x4]
L_937b16:
	bclr r25,r25,0xa
	.global L_937b1a
L_937b1a:
	ld_s r1,[r14,0x4]
L_937b1c:
	ld_s r0,[gp,0x44]
L_937b1e:
	bbit0 r0,r1,L_937b28
L_937b22:
	ld_s r0,[gp,0xdc]
L_937b24:
	bbit1 r0,0x1,L_937b7e
	.global L_937b28
L_937b28:
	ld_s r0,[r14,0xc]
L_937b2a:
	bset_s r0,r0,0x8
L_937b2c:
	st_s r0,[r14,0xc]
L_937b2e:
	b_s L_937b7e
	.global L_937b30
L_937b30:
	ld_s r0,[gp,0xdc]
L_937b32:
	bbit0 r0,0x1,L_937b56
L_937b36:
	bl.d L_924578
L_937b3a:
	mov_s r0,r14
L_937b3c:
	ld_s r0,[gp,0xe0]
L_937b3e:
	bset_s r0,r0,0x9
L_937b40:
	st.as r0,[gp,0x38]
L_937b44:
	b_s L_937b7e
	.global L_937b46
L_937b46:
	ld_s r0,[r14,0xc]
L_937b48:
	bbit0 r0,0xc,L_937b56
L_937b4c:
	bl L_926cf8
L_937b50:
	ld_s r0,[r14,0xc]
L_937b52:
	bclr_s r0,r0,0xb
L_937b54:
	st_s r0,[r14,0xc]
	.global L_937b56
L_937b56:
	ld_s r0,[gp,0xdc]
L_937b58:
	bbit0 r0,0x1,L_937b70
L_937b5c:
	asl_s r13,r13,0xb
L_937b5e:
	bset_s r13,r13,0xe
L_937b60:
	bset_s r13,r13,0x1b
L_937b62:
	bset_s r13,r13,0x1c
L_937b64:
	mov_s r32,r13
L_937b66:
	st.ab r13,[r25,0x4]
L_937b6a:
	bclr r25,r25,0xa
L_937b6e:
	b_s L_937b7e
	.global L_937b70
L_937b70:
	mov_s r0,0x18
L_937b72:
	asl_s r0,r0,0x18
L_937b74:
	mov_s r32,r0
L_937b76:
	st.ab r0,[r25,0x4]
L_937b7a:
	bclr r25,r25,0xa
	.global L_937b7e
L_937b7e:
	b L_92027c
L_937b82:
	nop_s
