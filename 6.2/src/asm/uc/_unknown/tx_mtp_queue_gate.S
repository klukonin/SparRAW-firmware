/* tx_mtp_queue_gate @ 0x939aa4, 544 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__handle_status_flags, tx_sta__flow_loop
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__select_rf_module_cmd31, mac__set_rf_chain_state, mac_q__tx_ppdu, mtp_queue__release_mgmt, tx__cca_check_and_send, txop__await_cts_ppdu, uc_spin_until_event, uc_wait_one_event
 * Глобалы (через gp): 0x800538, 0x800564, 0x80056c, 0x8005f4, 0x8005f8, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_mtp_queue_gate
tx_mtp_queue_gate:
	.global L_939aa4
L_939aa4:
	push_s blink
L_939aa6:
	bl.d L_920234
L_939aaa:
	mov_s r2,0x0
L_939aac:
	mov_s r0,0x802978
L_939ab2:
	ld_s r13,[r0,0x78]
L_939ab4:
	st.a r2,[sp,-0x10]
L_939ab8:
	ld_s r3,[r13,0x4]
L_939aba:
	ld_s r0,[gp,0x3c]
L_939abc:
	mov_s r1,0x1
L_939abe:
	bbit0 r0,r3,L_939ac8
L_939ac2:
	ld_s r0,[gp,0x10]
L_939ac4:
	mov_s r2,r1
L_939ac6:
	st_s r0,[r13,0x8]
	.global L_939ac8
L_939ac8:
	ld_s r0,[gp,0xd0]
L_939aca:
	add_s r1,sp,0x4
L_939acc:
	and r0,r0,0x40000000
L_939ad4:
	sub.f r3,r0,0x0
L_939ad8:
	mov.ne r3,0x1
L_939adc:
	bl.d L_93ea40
L_939ae0:
	mov_s r0,r13
L_939ae2:
	breq_s r0,0,L_939b1e
L_939ae4:
	ld_s r1,[r13]
L_939ae6:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_939ae8:
	add1_s r1,r1,r1
L_939aea:
	add_s r1,r1,0x802610
L_939af0:
	ld_s r2,[r1]
L_939af2:
	mov_s r0,0x0
L_939af4:
	breq r2,0x2,L_939b10
L_939af8:
	ld_s r1,[r1,0x4]
L_939afa:
	cmp_s r1,0x3
L_939afc:
	cmp.ne r1,0x4
L_939b00:
	cmp.ne r1,0x5
L_939b04:
	bne_s L_939b08
L_939b06:
	mov_s r0,0x1
	.global L_939b08
L_939b08:
	extb.f 0x0,r0
L_939b0c:
	mov_s r0,0x0
L_939b0e:
	beq_s L_939b12
	.global L_939b10
L_939b10:
	mov_s r0,0x1
	.global L_939b12
L_939b12:
	extb.f 0x0,r0
L_939b16:
	bne_s L_939b1e
L_939b18:
	mov_s r0,r42
L_939b1a:
	bbit0 r0,0x7,L_939b2c
	.global L_939b1e
L_939b1e:
	mov_s r0,r13
L_939b20:
	ld_s r1,[sp,0x4]
L_939b22:
	mov_s r2,0x1
L_939b24:
	bl.d L_924d00
L_939b28:
	mov_s r3,0x0
L_939b2a:
	b_s L_939cbc
	.global L_939b2c
L_939b2c:
	ld_s r0,[gp,0xe0]
L_939b2e:
	ld.as r1,[gp,0x39]
L_939b32:
	bic r0,r0,-0x3
L_939b36:
	cmp_s r0,0x2
L_939b38:
	mov_s r0,0x1
L_939b3a:
	sub_s.ne r0,r0,r0
L_939b3c:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_939b3e:
	or r0,r0,0x19000b00
L_939b46:
	asl_s r1,r1,0xe
L_939b48:
	or_s r0,r0,r1
L_939b4a:
	mov_s r32,r0
L_939b4c:
	st.ab r0,[r25,0x4]
L_939b50:
	bclr r25,r25,0xa
L_939b54:
	add_s r1,sp,0x4
L_939b56:
	bl.d L_9399a4
L_939b5a:
	mov_s r0,r13
L_939b5c:
	brne_s r0,0,L_939b74
L_939b5e:
	mov_s r1,0x8022c8
L_939b64:
	ld_s r0,[r1,0x4]
L_939b66:
	st.as 0x800,[gp,0x34]
L_939b6e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_939b70:
	st_s r0,[r1,0x4]
L_939b72:
	b_s L_939cbc
	.global L_939b74
L_939b74:
	ld_s r0,[gp,-0x48]
L_939b76:
	or r0,r0,0x27004000
L_939b7e:
	mov_s r32,r0
L_939b80:
	st.ab r0,[r25,0x4]
L_939b84:
	bclr r25,r25,0xa
L_939b88:
	mov_s r0,0x2004000
L_939b8e:
	mov_s r32,r0
L_939b90:
	st.ab r0,[r25,0x4]
L_939b94:
	bclr r25,r25,0xa
L_939b98:
	ld_s r0,[gp,0xd0]
L_939b9a:
	and.f 0x0,r0,0x20004
L_939ba2:
	bne_s L_939c22
L_939ba4:
	mov_s r1,0x802978
L_939baa:
	ld_s r0,[r1,0x78]
L_939bac:
	mov_s r2,0x802229
L_939bb2:
	ld_s r0,[r0,0x4]
L_939bb4:
	add1_s r0,r0,r0
L_939bb6:
	ldb_s r0,[r2,r0]
L_939bb8:
	breq_s r0,0,L_939bd4
L_939bba:
	lsr r0,r45,0x5
L_939bbe:
	bxor r0,r0,0x0
L_939bc2:
	ld_s r2,[r1,0x78]
L_939bc4:
	bbit1 r0,0x0,L_939bd4
L_939bc8:
	ld_s r0,[r2,0xc]
L_939bca:
	bset_s r0,r0,0x1
L_939bcc:
	st_s r0,[r2,0xc]
L_939bce:
	ld_s r0,[r1,0x78]
L_939bd0:
	mov_s r2,0x0
L_939bd2:
	st_s r2,[r0,0x20]
	.global L_939bd4
L_939bd4:
	ld_s r0,[r1,0x78]
L_939bd6:
	ld_s r0,[r0,0xc]
L_939bd8:
	bbit1 r0,0x8,L_939c22
L_939bdc:
	lsr r0,r43,0xe
L_939be0:
	bmsk.f r0,r0,0x1
L_939be4:
	beq_s L_939bfc
L_939be6:
	brne r0,0x1,L_939c22
L_939bea:
	mov_s r0,0x802978
L_939bf0:
	ld_s r1,[r0,0x78]
L_939bf2:
	ld_s r0,[r1,0xc]
L_939bf4:
	or r0,r0,0xe
L_939bf8:
	st_s r0,[r1,0xc]
L_939bfa:
	b_s L_939c22
	.global L_939bfc
L_939bfc:
	mov_s r1,r43
L_939bfe:
	ld_s r0,[gp,0xd0]
L_939c00:
	btst_s r1,0x1b
L_939c02:
	bset.ne r0,r0,0x1
L_939c06:
	bset.eq r0,r0,0x0
L_939c0a:
	st.as r0,[gp,0x34]
L_939c0e:
	bbit1 r0,0x12,L_939c22
L_939c12:
	mov_s r0,0x802978
L_939c18:
	ld_s r1,[r0,0x78]
L_939c1a:
	mov_s r0,0x1
L_939c1c:
	bl.d L_93cfdc
L_939c20:
	ld_s r1,[r1,0x4]
	.global L_939c22
L_939c22:
	mov_s r0,0x0
L_939c24:
	bl.d L_9366dc
L_939c28:
	bset_s r0,r0,0xe
L_939c2a:
	ld_s r1,[r13]
L_939c2c:
	mov_s r14,0x0
L_939c2e:
	ld_s r0,[gp,0xcc]
L_939c30:
	st_s r14,[sp,0x0]
L_939c32:
	bic r0,r0,-0x3
L_939c36:
	or.f 0x0,r0,r14
L_939c3a:
	mov_s r3,sp
L_939c3c:
	ld.as r2,[gp,0x34]
L_939c40:
	beq_s L_939c4c
L_939c42:
	bic r2,r2,-0x120
L_939c46:
	cmp r2,0x100
L_939c4a:
	beq_s L_939c7c
	.global L_939c4c
L_939c4c:
	mov_s r0,0x1
L_939c4e:
	st_s r0,[r3]
L_939c50:
	ld_s r0,[gp,0x44]
L_939c52:
	mov_s r3,0x802978
L_939c58:
	ld_s r2,[r3,0x78]
L_939c5a:
	breq_s r0,0,L_939c6a
L_939c5c:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_939c5e:
	mov_s r0,0x801108
L_939c64:
	add2_s r1,r1,r1
L_939c66:
	ld_s r0,[r0,r1]
L_939c68:
	st_s r0,[r2,0x2c]
	.global L_939c6a
L_939c6a:
	ld_s r1,[r3,0x78]
L_939c6c:
	mov_s r0,0x1
L_939c6e:
	bl.d L_92f42c
L_939c72:
	ld_s r1,[r1,0x2c]
L_939c74:
	ld_s r0,[gp,0x44]
L_939c76:
	breq_s r0,0,L_939c7c
L_939c78:
	st.as r14,[gp,0x11]
	.global L_939c7c
L_939c7c:
	mov_s r0,0x0
L_939c7e:
	bl.d L_9366dc
L_939c82:
	bset_s r0,r0,0xf
L_939c84:
	ld_s r0,[r13,0xc]
L_939c86:
	btst_s r0,0x3
L_939c88:
	mov.ne r0,r13
L_939c8c:
	bl.ne.d L_939888
L_939c90:
	sub_s.ne r1,r1,r1
L_939c92:
	bl.d L_936588
L_939c96:
	mov_s r0,0x6
L_939c98:
	ld_s r0,[sp,0x0]
L_939c9a:
	brne r0,0x1,L_939cbc
L_939c9e:
	ld_s r0,[gp,0x178]
L_939ca0:
	mov_s r1,0x802944
L_939ca6:
	bclr_s r0,r0,0x18
L_939ca8:
	ld_s r1,[r1]
L_939caa:
	bclr_s r0,r0,0x19
L_939cac:
	asl_s r1,r1,0x18
L_939cae:
	or_s r0,r0,r1
L_939cb0:
	st.as r0,[gp,0x5e]
L_939cb4:
	mov_s r1,0x889480
L_939cba:
	st_s r0,[r1,0x8]
	.global L_939cbc
L_939cbc:
	b.d L_9202a4
L_939cc0:
	add_s sp,sp,0x10
L_939cc2:
	nop_s
