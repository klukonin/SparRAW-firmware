/* rx__program_mac_and_wait @ 0x938b90, 676 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__handle_status_flags, rx_funcs__rx_flow, tx_sta__flow_loop
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__select_rf_module_cmd31, mac__set_rf_chain_state, mac_q__tx_ppdu, mtp__get_tx_permission, mtp_queue__byte_by_index, uc_read_tsf_lo, uc_spin_until_event, uc_sysassert, uc_wait_event_busy, uc_wait_one_event
 * Глобалы (через gp): 0x80053c, 0x80056c, 0x8005f4, 0x8005f8, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__program_mac_and_wait
rx__program_mac_and_wait:
	.global L_938b90
L_938b90:
	push_s blink
L_938b92:
	bl L_920230
L_938b96:
	mov_s r14,r0
L_938b98:
	mov_s r0,0x0
L_938b9a:
	st.a r0,[sp,-0x8]
L_938b9e:
	ld_s r0,[r14,0xc]
L_938ba0:
	btst_s r0,0x5
L_938ba2:
	bne_s L_938ccc
L_938ba4:
	ld_s r0,[r14]
L_938ba6:
	mov_s r1,0x80110c
L_938bac:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_938bae:
	add2_s r0,r0,r0
L_938bb0:
	ld_s r13,[r1,r0]
L_938bb2:
	mov_s r0,0x37000005
L_938bb8:
	mov_s r32,r0
L_938bba:
	st.ab r0,[r25,0x4]
L_938bbe:
	bclr r25,r25,0xa
L_938bc2:
	mov_s r0,0x37000002
L_938bc8:
	mov_s r32,r0
L_938bca:
	st.ab r0,[r25,0x4]
L_938bce:
	bclr r25,r25,0xa
L_938bd2:
	or r13,r13,0x3f000000
L_938bda:
	mov_s r32,r13
L_938bdc:
	st.ab r13,[r25,0x4]
L_938be0:
	bclr r25,r25,0xa
L_938be4:
	ld_s r15,[r14,0x4]
L_938be6:
	ld_s r0,[gp,0xcc]
L_938be8:
	asl_s r15,r15,0x10
L_938bea:
	ld_s r1,[r14]
L_938bec:
	bset_s r15,r15,0x0
L_938bee:
	bbit0 r0,0x1,L_938c0c
L_938bf2:
	asl_s r0,r1,0x2
L_938bf4:
	add1_s r0,r0,r0
L_938bf6:
	mov_s r2,0x802610
L_938bfc:
	ld_s r0,[r2,r0]
L_938bfe:
	sub.f r0,r0,0x0
L_938c02:
	mov.ne r0,0x1
L_938c06:
	extb.f 0x0,r0
L_938c0a:
	bne_s L_938c10
	.global L_938c0c
L_938c0c:
	mov_s r13,0x0
L_938c0e:
	b_s L_938c1c
	.global L_938c10
L_938c10:
	bl.d L_92ff68
L_938c14:
	mov_s r0,r1
L_938c16:
	asl_s r0,r0,0x8
L_938c18:
	or r13,r0,0x3
	.global L_938c1c
L_938c1c:
	mov_s r0,0x1b001111
L_938c22:
	mov_s r32,r0
L_938c24:
	st.ab r0,[r25,0x4]
L_938c28:
	bclr r25,r25,0xa
L_938c2c:
	bset_s r15,r15,0x19
L_938c2e:
	bset_s r15,r15,0x1a
L_938c30:
	bset_s r15,r15,0x1c
L_938c32:
	mov_s r32,r15
L_938c34:
	st.ab r15,[r25,0x4]
L_938c38:
	bclr r25,r25,0xa
L_938c3c:
	or r13,r13,0x17000000
L_938c44:
	mov_s r32,r13
L_938c46:
	st.ab r13,[r25,0x4]
L_938c4a:
	bclr r25,r25,0xa
L_938c4e:
	nop_s
L_938c50:
	nop_s
L_938c52:
	nop_s
	.global L_938c54
L_938c54:
	mov_s r0,r43
L_938c56:
	bbit0 r0,0x1f,L_938c54
L_938c5a:
	mov_s r0,r51
L_938c5c:
	bmsk r1,r0,0x3
L_938c60:
	st.as r1,[gp,0x38]
L_938c64:
	lsr_s r0,r0,0x4
L_938c66:
	st.as r0,[gp,0x39]
L_938c6a:
	lsr r13,r43,0x10
L_938c6e:
	bmsk_s r13,r13,0x4
L_938c70:
	asl_s r0,r13,0x4
L_938c72:
	or r0,r0,0x3e000000
L_938c7a:
	mov_s r32,r0
L_938c7c:
	st.ab r0,[r25,0x4]
L_938c80:
	bclr r25,r25,0xa
L_938c84:
	mov_s r0,0x37000020
L_938c8a:
	mov_s r32,r0
L_938c8c:
	st.ab r0,[r25,0x4]
L_938c90:
	bclr r25,r25,0xa
L_938c94:
	mov_s r1,0x8022c8
L_938c9a:
	ld_s r0,[r1,0xc]
L_938c9c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938c9e:
	st_s r0,[r1,0xc]
L_938ca0:
	ld_s r0,[gp,0x178]
L_938ca2:
	mov_s r1,0x802940
L_938ca8:
	bclr_s r0,r0,0x18
L_938caa:
	ld_s r1,[r1]
L_938cac:
	bclr_s r0,r0,0x19
L_938cae:
	asl_s r1,r1,0x18
L_938cb0:
	or_s r0,r0,r1
L_938cb2:
	st.as r0,[gp,0x5e]
L_938cb6:
	mov_s r1,0x889480
L_938cbc:
	st_s r0,[r1,0x8]
L_938cbe:
	mov_s r0,r14
L_938cc0:
	bl.d L_93e8c4
L_938cc4:
	mov_s r1,r13
L_938cc6:
	ld_s r0,[r14,0xc]
L_938cc8:
	bset_s r0,r0,0x5
L_938cca:
	st_s r0,[r14,0xc]
	.global L_938ccc
L_938ccc:
	bclr_s r0,r0,0x5
L_938cce:
	st_s r0,[r14,0xc]
L_938cd0:
	ld_s r0,[gp,0xd0]
L_938cd2:
	bbit0 r0,0x9,L_938cde
	.global L_938cd6
L_938cd6:
	mov_s r0,0x1
L_938cd8:
	b.d L_92029c
L_938cdc:
	add_s sp,sp,0x8
	.global L_938cde
L_938cde:
	ld_s r0,[gp,-0x48]
L_938ce0:
	or r0,r0,0x27004000
L_938ce8:
	mov_s r32,r0
L_938cea:
	st.ab r0,[r25,0x4]
L_938cee:
	bclr r25,r25,0xa
L_938cf2:
	mov_s r0,0x2004000
L_938cf8:
	mov_s r32,r0
L_938cfa:
	st.ab r0,[r25,0x4]
L_938cfe:
	bclr r25,r25,0xa
L_938d02:
	mov_s r0,0x802978
L_938d08:
	ld_s r1,[r0,0x78]
L_938d0a:
	mov_s r2,0x802229
L_938d10:
	ld_s r0,[r1,0x4]
L_938d12:
	add1_s r0,r0,r0
L_938d14:
	ldb_s r0,[r2,r0]
L_938d16:
	breq_s r0,0,L_938d2e
L_938d18:
	lsr r2,r45,0x5
L_938d1c:
	bxor r2,r2,0x0
L_938d20:
	ld_s r0,[r1,0xc]
L_938d22:
	bbit1 r2,0x0,L_938d2e
L_938d26:
	bset_s r0,r0,0x1
L_938d28:
	st_s r0,[r1,0xc]
L_938d2a:
	mov_s r0,0x0
L_938d2c:
	st_s r0,[r1,0x20]
	.global L_938d2e
L_938d2e:
	ld_s r0,[r1,0xc]
L_938d30:
	bbit1 r0,0x8,L_938d6a
L_938d34:
	lsr r0,r43,0xe
L_938d38:
	bmsk.f r0,r0,0x1
L_938d3c:
	beq_s L_938d4c
L_938d3e:
	brne r0,0x1,L_938d6a
L_938d42:
	ld_s r0,[r1,0xc]
L_938d44:
	or r0,r0,0xe
L_938d48:
	st_s r0,[r1,0xc]
L_938d4a:
	b_s L_938d6a
	.global L_938d4c
L_938d4c:
	mov_s r2,r43
L_938d4e:
	ld_s r0,[gp,0xd0]
L_938d50:
	btst_s r2,0x1b
L_938d52:
	bset.ne r0,r0,0x1
L_938d56:
	bset.eq r0,r0,0x0
L_938d5a:
	st.as r0,[gp,0x34]
L_938d5e:
	bbit1 r0,0x12,L_938d6a
L_938d62:
	mov_s r0,0x1
L_938d64:
	bl.d L_93cfdc
L_938d68:
	ld_s r1,[r1,0x4]
	.global L_938d6a
L_938d6a:
	mov_s r0,r42
L_938d6c:
	btst_s r0,0xe
L_938d6e:
	mov.ne r15,0x1
L_938d72:
	bne_s L_938d80
L_938d74:
	mov_s r0,0x0
L_938d76:
	bset_s r0,r0,0xe
L_938d78:
	bl.d L_9366e8
L_938d7c:
	mov_s r1,0x6
L_938d7e:
	mov_s r15,r0
	.global L_938d80
L_938d80:
	ld_s r1,[r14]
L_938d82:
	mov_s r13,0x0
L_938d84:
	ld_s r0,[gp,0xcc]
L_938d86:
	st_s r13,[sp,0x0]
L_938d88:
	bic r0,r0,-0x3
L_938d8c:
	or.f 0x0,r0,r13
L_938d90:
	mov_s r2,sp
L_938d92:
	ld.as r3,[gp,0x34]
L_938d96:
	beq_s L_938da2
L_938d98:
	bic r3,r3,-0x120
L_938d9c:
	cmp r3,0x100
L_938da0:
	beq_s L_938dd2
	.global L_938da2
L_938da2:
	mov_s r0,0x1
L_938da4:
	st_s r0,[r2]
L_938da6:
	ld_s r0,[gp,0x44]
L_938da8:
	mov_s r2,0x802978
L_938dae:
	ld_s r3,[r2,0x78]
L_938db0:
	breq_s r0,0,L_938dc0
L_938db2:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_938db4:
	mov_s r0,0x801108
L_938dba:
	add2_s r1,r1,r1
L_938dbc:
	ld_s r0,[r0,r1]
L_938dbe:
	st_s r0,[r3,0x2c]
	.global L_938dc0
L_938dc0:
	ld_s r1,[r2,0x78]
L_938dc2:
	mov_s r0,0x1
L_938dc4:
	bl.d L_92f42c
L_938dc8:
	ld_s r1,[r1,0x2c]
L_938dca:
	ld_s r0,[gp,0x44]
L_938dcc:
	breq_s r0,0,L_938dd2
L_938dce:
	st.as r13,[gp,0x11]
	.global L_938dd2
L_938dd2:
	breq_s r15,0,L_938e28
	.global L_938dd4
L_938dd4:
	ld_s r0,[r14,0xc]
L_938dd6:
	st_s r13,[r14,0x24]
L_938dd8:
	bic r0,r0,0x120
L_938ddc:
	st_s r0,[r14,0xc]
L_938dde:
	mov_s r0,0x0
L_938de0:
	bl.d L_9366dc
L_938de4:
	bset_s r0,r0,0xf
L_938de6:
	ld_s r0,[r14,0xc]
L_938de8:
	btst_s r0,0x3
L_938dea:
	mov.ne r0,r14
L_938dee:
	bl.ne.d L_939888
L_938df2:
	sub_s.ne r1,r1,r1
L_938df4:
	bl.d L_936588
L_938df8:
	mov_s r0,0x6
L_938dfa:
	ld_s r0,[sp,0x0]
L_938dfc:
	brne r0,0x1,L_938e1e
L_938e00:
	ld_s r0,[gp,0x178]
L_938e02:
	mov_s r1,0x802944
L_938e08:
	bclr_s r0,r0,0x18
L_938e0a:
	ld_s r1,[r1]
L_938e0c:
	bclr_s r0,r0,0x19
L_938e0e:
	asl_s r1,r1,0x18
L_938e10:
	or_s r0,r0,r1
L_938e12:
	st.as r0,[gp,0x5e]
L_938e16:
	mov_s r1,0x889480
L_938e1c:
	st_s r0,[r1,0x8]
	.global L_938e1e
L_938e1e:
	bl L_9364c8
L_938e22:
	st.as r0,[gp,0x5]
L_938e26:
	b_s L_938cd6
	.global L_938e28
L_938e28:
	mov_s r0,blink
L_938e2a:
	bl.d L_926618
L_938e2e:
	mov_s r1,0x91
L_938e30:
	b_s L_938dd4
L_938e32:
	nop_s
