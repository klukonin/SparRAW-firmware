/* abft_responder__tx_ssw @ 0x930908, 1084 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow
 * Зовёт сам: abft__send_ssw_feedback, mac__program_tx_common, mac__set_rf_chain_state__with_sta_sector, mac_evt__enable_bit_sync, mac_evt__enable_bit_sync_b, tx__program_vector_rf, uc_spin_until_event, uc_sysassert
 * Глобалы (через gp): 0x8005f4, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abft_responder__tx_ssw
abft_responder__tx_ssw:
	.global L_930908
L_930908:
	st.a r13,[sp,-0x20]
L_93090c:
	st blink,[sp, 0x4]
L_930910:
	st_s r14,[sp,0x8]
L_930912:
	st_s r15,[sp,0xc]
L_930914:
	st r16,[sp, 0x10]
L_930918:
	st r17,[sp, 0x14]
L_93091c:
	st r18,[sp, 0x18]
L_930920:
	st r19,[sp, 0x1c]
L_930924:
	mov_s r19,r0
L_930926:
	mov r11,0x7fffffff
L_93092e:
	norm r13,r11
L_930932:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_930934:
	extb r13,r13
L_930938:
	rsub r10,r13,0x1f
L_93093c:
	bclr r16,r11,r10
L_930940:
	mov r7,0x4d000000
L_930948:
	mov r32,r7
L_93094c:
	st.ab r7,[r25,0x4]
L_930950:
	bclr r25,r25,0xa
L_930954:
	nop_s
L_930956:
	nop_s
L_930958:
	nop_s
L_93095a:
	mov_s r0,r55
L_93095c:
	cmp r0,0x160
L_930960:
	bhs_s L_930964
L_930962:
	brne_s r0,0,L_93096c
	.global L_930964
L_930964:
	b.d L_930d24
L_930968:
	mov r0,0x0
	.global L_93096c
L_93096c:
	mov r8,0x3d000100
L_930974:
	mov r32,r8
L_930978:
	st.ab r8,[r25,0x4]
L_93097c:
	bclr r25,r25,0xa
L_930980:
	ld.as r1,[gp,-0x3]
L_930984:
	asl r14,r13,0x8
L_930988:
	or r15,r1,0x30
L_93098c:
	or_s r14,r14,r15
L_93098e:
	mov_s r1,0x38000200
L_930994:
	mov r32,r1
L_930998:
	st.ab r1,[r25,0x4]
L_93099c:
	bclr r25,r25,0xa
L_9309a0:
	mov_s r2,0x36000038
L_9309a6:
	mov_s r32,r2
L_9309a8:
	st.ab r2,[r25,0x4]
L_9309ac:
	bclr r25,r25,0xa
L_9309b0:
	mov_s r3,0x6000101
L_9309b6:
	mov_s r32,r3
L_9309b8:
	st.ab r3,[r25,0x4]
L_9309bc:
	bclr r25,r25,0xa
L_9309c0:
	or r14,r14,0x3f000000
L_9309c8:
	mov r32,r14
L_9309cc:
	st.ab r14,[r25,0x4]
L_9309d0:
	bclr r25,r25,0xa
L_9309d4:
	mov r4,0x3e000000
L_9309dc:
	mov r32,r4
L_9309e0:
	st.ab r4,[r25,0x4]
L_9309e4:
	bclr r25,r25,0xa
L_9309e8:
	mov r5,0x37000020
L_9309f0:
	mov r32,r5
L_9309f4:
	st.ab r5,[r25,0x4]
L_9309f8:
	bclr r25,r25,0xa
L_9309fc:
	mov r6,0x8022c8
L_930a04:
	ld r1,[r6, 0xc]
L_930a08:
	ld.as r2,[gp,0x5e]
L_930a0c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_930a0e:
	st r1,[r6, 0xc]
L_930a12:
	ld r3,[0x802940]
L_930a1a:
	and r2,r2,0xfcffffff
L_930a22:
	asl_s r3,r3,0x18
L_930a24:
	or r3,r3,r2
L_930a28:
	st.as r3,[gp,0x5e]
L_930a2c:
	st r3,[0x889488]
L_930a34:
	mov r18,0x802f14
L_930a3c:
	ldb r4,[r18, 0x3]
L_930a40:
	lsr r4,r4,0x2
L_930a44:
	bmsk r14,r4,0x3
L_930a48:
	brhs.d r14,0x4,L_930a78
L_930a4c:
	mov r17,0x1
L_930a50:
	mov_s r0,blink
L_930a52:
	mov_s r1,0x145d
L_930a58:
	bl L_926618
L_930a5c:
	ldb r5,[r18, 0x3]
L_930a60:
	ror r5,r5,0x2
L_930a64:
	bic r5,r5,0xf
L_930a68:
	bset r5,r5,0x2
L_930a6c:
	ror r5,r5,0x1e
L_930a70:
	b.d L_930964
L_930a74:
	stb r5,[r18, 0x3]
	.global L_930a78
L_930a78:
	mov_s r0,0x80164c
L_930a7e:
	sub_s r0,r0,0x8
L_930a80:
	ldw.as r15,[r0,r14]
L_930a84:
	mov r4,0x802b4c
L_930a8c:
	stw 0x864,[r4]
L_930a94:
	ldb r10,[r18, 0xd]
L_930a98:
	ldb r3,[r18, 0xc]
L_930a9c:
	asl r10,r10,0x6
L_930aa0:
	or r10,r10,r3
L_930aa4:
	ld r3,[r18, 0x10]
L_930aa8:
	stb r10,[r4, 0x13]
L_930aac:
	mov r5,0x0
L_930ab0:
	stb r3,[r4, 0x14]
L_930ab4:
	stb r5,[r4, 0x15]
L_930ab8:
	ldw r11,[r18, 0x14]
L_930abc:
	ldw r10,[r18, 0x16]
L_930ac0:
	ldw r9,[r18, 0x18]
L_930ac4:
	stw r11,[r4, 0x4]
L_930ac8:
	stw r10,[r4, 0x6]
L_930acc:
	b.d L_930b64
L_930ad0:
	stw r9,[r4, 0x8]
	.global L_930ad4
L_930ad4:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_930ad6:
	extb_s r14,r14
L_930ad8:
	norm r13,r16
L_930adc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_930ade:
	extb_s r13,r13
L_930ae0:
	rsub r8,r13,0x1f
L_930ae4:
	ld.as r9,[gp,-0x3]
L_930ae8:
	bclr r16,r16,r8
L_930aec:
	or r1,r9,0x30
L_930af0:
	asl r2,r13,0x8
L_930af4:
	mov r0,r19
L_930af8:
	bl.d L_9302d8
L_930afc:
	or r1,r1,r2
L_930b00:
	mov r0,0x0
L_930b04:
	bl.d L_9366dc
L_930b08:
	bset r0,r0,0xf
L_930b0c:
	mov r8,0x802b4c
L_930b14:
	stw 0x864,[r8]
L_930b1c:
	mov_s r0,0x802f14
L_930b22:
	ldb r5,[r0, 0xd]
L_930b26:
	ldb_s r3,[r0,0xc]
L_930b28:
	asl r5,r5,0x6
L_930b2c:
	or r3,r3,r5
L_930b30:
	ld r7,[r0, 0x10]
L_930b34:
	stb r3,[r8, 0x13]
L_930b38:
	mov r6,0x0
L_930b3c:
	stb r7,[r8, 0x14]
L_930b40:
	stb r6,[r8, 0x15]
L_930b44:
	ldw r11,[r0, 0x14]
L_930b48:
	ldw r10,[r0, 0x16]
L_930b4c:
	ldw r9,[r0, 0x18]
L_930b50:
	stw r11,[r8, 0x4]
L_930b54:
	stw r10,[r8, 0x6]
L_930b58:
	stw r9,[r8, 0x8]
L_930b5c:
	bl.d L_9361bc
L_930b60:
	mov r0,0x5
	.global L_930b64
L_930b64:
	ldb_s r0,[gp,-0xc]
L_930b66:
	asl r11,r14
L_930b6a:
	or r11,r11,0x2d000001
L_930b72:
	asl_s r13,r13,0xa
L_930b74:
	or r11,r11,r13
L_930b78:
	asl_s r0,r0,0x10
L_930b7a:
	or r0,r0,r11
L_930b7e:
	mov_s r32,r0
L_930b80:
	st.ab r0,[r25,0x4]
L_930b84:
	bclr r25,r25,0xa
L_930b88:
	bl L_93b39c
L_930b8c:
	or r7,r15,0x15000000
L_930b94:
	mov r32,r7
L_930b98:
	st.ab r7,[r25,0x4]
L_930b9c:
	bclr r25,r25,0xa
L_930ba0:
	mov r8,0x14000007
L_930ba8:
	mov r32,r8
L_930bac:
	st.ab r8,[r25,0x4]
L_930bb0:
	bclr r25,r25,0xa
L_930bb4:
	bl.d L_92d990
L_930bb8:
	sub r15,r15,0x10
	.global L_930bbc
L_930bbc:
	mov_s r1,r43
L_930bbe:
	bbit0 r1,0x1f,L_930bbc
L_930bc2:
	mov_s r1,r51
L_930bc4:
	bmsk r2,r1,0x3
L_930bc8:
	st.as r2,[gp,0x38]
L_930bcc:
	lsr r1,r1,0x4
L_930bd0:
	st.as r1,[gp,0x39]
L_930bd4:
	bl.d L_936544
L_930bd8:
	mov r0,0x6
L_930bdc:
	breq r17,0x0,L_930c50
L_930be0:
	ld.as r3,[gp,-0x11]
L_930be4:
	mov r17,0x0
L_930be8:
	and r3,r3,0xfff0ffff
L_930bf0:
	bset r4,r3,0x12
L_930bf4:
	st.as r4,[gp,-0x11]
L_930bf8:
	or r3,r3,0x1d040000
L_930c00:
	mov r32,r3
L_930c04:
	st.ab r3,[r25,0x4]
L_930c08:
	bclr r25,r25,0xa
L_930c0c:
	nop_s
L_930c0e:
	nop_s
L_930c10:
	mov 0x0,0x0
L_930c14:
	mov r6,0x38000200
L_930c1c:
	mov r32,r6
L_930c20:
	st.ab r6,[r25,0x4]
L_930c24:
	bclr r25,r25,0xa
L_930c28:
	mov r9,0x36000038
L_930c30:
	mov r32,r9
L_930c34:
	st.ab r9,[r25,0x4]
L_930c38:
	bclr r25,r25,0xa
L_930c3c:
	mov r5,0x6000103
L_930c44:
	mov r32,r5
L_930c48:
	st.ab r5,[r25,0x4]
L_930c4c:
	bclr r25,r25,0xa
	.global L_930c50
L_930c50:
	mov_s r1,0x2008000
L_930c56:
	mov_s r32,r1
L_930c58:
	st.ab r1,[r25,0x4]
L_930c5c:
	bclr r25,r25,0xa
L_930c60:
	ld.as r2,[gp,0x33]
L_930c64:
	mov_s r3,0x0
L_930c66:
	and r5,r2,0x10
L_930c6a:
	or.f 0x0,r5,r3
L_930c6e:
	beq_s L_930c94
L_930c70:
	ld_s r0,[gp,0xe0]
L_930c72:
	ld.as r2,[gp,0x39]
L_930c76:
	bic r0,r0,-0x3
L_930c7a:
	cmp_s r0,0x2
L_930c7c:
	mov_s r0,0x1
L_930c7e:
	sub_s.ne r0,r0,r0
L_930c80:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_930c82:
	or r0,r0,0x19800830
L_930c8a:
	asl_s r2,r2,0xe
L_930c8c:
	b.d L_930c9c
L_930c90:
	or r2,r2,r0
	.global L_930c94
L_930c94:
	mov r2,0x19000001
	.global L_930c9c
L_930c9c:
	mov r32,r2
L_930ca0:
	st.ab r2,[r25,0x4]
L_930ca4:
	bclr r25,r25,0xa
	.global L_930ca8
L_930ca8:
	mov r6,r45
L_930cac:
	bbit0 r6,0x1f,L_930ca8
L_930cb0:
	ld.as r7,[gp,0x33]
L_930cb4:
	mov_s r0,0x0
L_930cb6:
	and r6,r7,0x10
L_930cba:
	or.f 0x0,r6,r0
L_930cbe:
	beq_s L_930cd4
L_930cc0:
	mov_s r3,0x18
L_930cc2:
	asl_s r3,r3,0x18
L_930cc4:
	mov r32,r3
L_930cc8:
	st.ab r3,[r25,0x4]
L_930ccc:
	bclr r25,r25,0xa
L_930cd0:
	b L_930ce4
	.global L_930cd4
L_930cd4:
	mov_s r0,0x18001000
L_930cda:
	mov_s r32,r0
L_930cdc:
	st.ab r0,[r25,0x4]
L_930ce0:
	bclr r25,r25,0xa
	.global L_930ce4
L_930ce4:
	cmp r14,0x0
L_930ce8:
	bne L_930ad4
L_930cec:
	bl L_935928
L_930cf0:
	bl.d L_9361bc
L_930cf4:
	mov r0,0x5
L_930cf8:
	ld.as r11,[gp,0x5e]
L_930cfc:
	mov r0,0x1
L_930d00:
	and r9,r11,0xfcffffff
L_930d08:
	ld r11,[0x802944]
L_930d10:
	asl r11,r11,0x18
L_930d14:
	or r11,r11,r9
L_930d18:
	st.as r11,[gp,0x5e]
L_930d1c:
	st r11,[0x889488]
	.global L_930d24
L_930d24:
	ld blink,[sp, 0x4]
L_930d28:
	ld_s r14,[sp,0x8]
L_930d2a:
	ld_s r15,[sp,0xc]
L_930d2c:
	ld r16,[sp, 0x10]
L_930d30:
	ld r17,[sp, 0x14]
L_930d34:
	ld r18,[sp, 0x18]
L_930d38:
	ld r19,[sp, 0x1c]
L_930d3c:
	j.d [blink]
L_930d40:
	ld.ab r13,[sp,0x20]
