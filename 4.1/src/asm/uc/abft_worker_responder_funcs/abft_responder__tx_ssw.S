/* abft_responder__tx_ssw @ 0x92ca3c, 976 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   abft_worker_responder_funcs.cpp
 * Зовут его: abft_responder_worker
 * Зовёт сам: abft__program_ssw_tx, abft__send_ssw_feedback, get_g_80087c, mac__program_tx_common, mac__select_sector_and_wait_a, mac__select_sector_and_wait_b, softfloat_double_to_short_b, softfloat_negate_r3, softfloat_u32_to_double, uc_spin_until_event, uc_sysassert
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.abft_responder__tx_ssw,"ax",@progbits
	.global abft_responder__tx_ssw
abft_responder__tx_ssw:
	.global L_92ca3c
L_92ca3c:
	st.a r13,[sp,-0x20]
L_92ca40:
	st blink,[sp, 0x4]
L_92ca44:
	st_s r14,[sp,0x8]
L_92ca46:
	st_s r15,[sp,0xc]
L_92ca48:
	st r16,[sp, 0x10]
L_92ca4c:
	st r17,[sp, 0x14]
L_92ca50:
	st r18,[sp, 0x18]
L_92ca54:
	st r19,[sp, 0x1c]
L_92ca58:
	mov_s r19,r0
L_92ca5a:
	mov r11,0x7fffffff
L_92ca62:
	norm r13,r11
L_92ca66:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92ca68:
	extb r13,r13
L_92ca6c:
	rsub r3,r13,0x1f
L_92ca70:
	bclr r17,r11,r3
L_92ca74:
	mov r7,0x4d000000
L_92ca7c:
	mov r32,r7
L_92ca80:
	st.ab r7,[r25,0x4]
L_92ca84:
	bclr r25,r25,0xa
L_92ca88:
	nop_s
L_92ca8a:
	nop_s
L_92ca8c:
	nop_s
L_92ca8e:
	mov_s r0,r55
L_92ca90:
	cmp r0,0x160
L_92ca94:
	bhs_s L_92ca98
L_92ca96:
	brne_s r0,0,L_92caa0
	.global L_92ca98
L_92ca98:
	b.d L_92cdec
L_92ca9c:
	mov r0,0x0
	.global L_92caa0
L_92caa0:
	mov r8,0x3d000100
L_92caa8:
	mov r32,r8
L_92caac:
	st.ab r8,[r25,0x4]
L_92cab0:
	bclr r25,r25,0xa
L_92cab4:
	ld.as r3,[gp,-0x4]
L_92cab8:
	asl r14,r13,0x8
L_92cabc:
	or r15,r3,0x30
L_92cac0:
	or_s r14,r14,r15
L_92cac2:
	mov_s r1,0x38000200
L_92cac8:
	mov r32,r1
L_92cacc:
	st.ab r1,[r25,0x4]
L_92cad0:
	bclr r25,r25,0xa
L_92cad4:
	mov_s r2,0x36000038
L_92cada:
	mov_s r32,r2
L_92cadc:
	st.ab r2,[r25,0x4]
L_92cae0:
	bclr r25,r25,0xa
L_92cae4:
	mov_s r3,0x6000101
L_92caea:
	mov_s r32,r3
L_92caec:
	st.ab r3,[r25,0x4]
L_92caf0:
	bclr r25,r25,0xa
L_92caf4:
	or r14,r14,0x3f000000
L_92cafc:
	mov r32,r14
L_92cb00:
	st.ab r14,[r25,0x4]
L_92cb04:
	bclr r25,r25,0xa
L_92cb08:
	mov r4,0x3e000000
L_92cb10:
	mov r32,r4
L_92cb14:
	st.ab r4,[r25,0x4]
L_92cb18:
	bclr r25,r25,0xa
L_92cb1c:
	mov r5,0x37000020
L_92cb24:
	mov r32,r5
L_92cb28:
	st.ab r5,[r25,0x4]
L_92cb2c:
	bclr r25,r25,0xa
L_92cb30:
	mov r6,0x801458
L_92cb38:
	ld r2,[r6, 0xc]
L_92cb3c:
	mov_s r14,0x801e68
L_92cb42:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_92cb44:
	ldb_s r3,[r14,0x3]
L_92cb46:
	st r2,[r6, 0xc]
L_92cb4a:
	lsr_s r3,r3,0x2
L_92cb4c:
	bmsk r15,r3,0x3
L_92cb50:
	brhs.d r15,0x4,L_92cb88
L_92cb54:
	mov r18,0x1
L_92cb58:
	mov_s r0,blink
L_92cb5a:
	mov_s r2,0x10033dc
L_92cb60:
	mov r1,0x1449
L_92cb68:
	bl.d L_925548
L_92cb6c:
	mov r3,0x79
L_92cb70:
	ldb_s r3,[r14,0x3]
L_92cb72:
	ror r3,r3,0x2
L_92cb76:
	bic r3,r3,0xf
L_92cb7a:
	bset_s r3,r3,0x2
L_92cb7c:
	ror r3,r3,0x1e
L_92cb80:
	b.d L_92ca98
L_92cb84:
	stb r3,[r14, 0x3]
	.global L_92cb88
L_92cb88:
	mov r10,0x802030
L_92cb90:
	sub r10,r10,0x8
L_92cb94:
	b.d L_92cbe4
L_92cb98:
	ldw.as r16,[r10,r15]
	.global L_92cb9c
L_92cb9c:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_92cb9e:
	extb_s r15,r15
L_92cba0:
	norm r13,r17
L_92cba4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92cba6:
	extb_s r13,r13
L_92cba8:
	rsub r1,r13,0x1f
L_92cbac:
	ld.as r3,[gp,-0x4]
L_92cbb0:
	bclr r17,r17,r1
L_92cbb4:
	or r1,r3,0x30
L_92cbb8:
	asl r2,r13,0x8
L_92cbbc:
	mov r0,r19
L_92cbc0:
	bl.d L_92c528
L_92cbc4:
	or r1,r1,r2
L_92cbc8:
	mov r0,0x0
L_92cbcc:
	bl.d L_9317fc
L_92cbd0:
	bset r0,r0,0xf
L_92cbd4:
	bl.d L_931338
L_92cbd8:
	mov r0,0x5
L_92cbdc:
	mov r14,0x801e68
	.global L_92cbe4
L_92cbe4:
	mov r5,0x801b90
L_92cbec:
	stw 0x864,[r5]
L_92cbf4:
	ldb r4,[r14, 0x9]
L_92cbf8:
	ldb r6,[r14, 0x8]
L_92cbfc:
	asl r4,r4,0x6
L_92cc00:
	or r4,r4,r6
L_92cc04:
	ld_s r2,[r14,0xc]
L_92cc06:
	stb r4,[r5, 0x13]
L_92cc0a:
	mov r7,0x0
L_92cc0e:
	stb r2,[r5, 0x14]
L_92cc12:
	stb r7,[r5, 0x15]
L_92cc16:
	ldw r11,[r14, 0x10]
L_92cc1a:
	ldw r10,[r14, 0x12]
L_92cc1e:
	ldw r9,[r14, 0x14]
L_92cc22:
	stw r11,[r5, 0x4]
L_92cc26:
	stw r10,[r5, 0x6]
L_92cc2a:
	stw r9,[r5, 0x8]
L_92cc2e:
	ldb r2,[gp, -0x10]
L_92cc32:
	asl r5,r15
L_92cc36:
	or r5,r5,0x2d000001
L_92cc3e:
	asl_s r13,r13,0xa
L_92cc40:
	or r5,r5,r13
L_92cc44:
	asl_s r2,r2,0x10
L_92cc46:
	or r2,r2,r5
L_92cc4a:
	mov_s r32,r2
L_92cc4c:
	st.ab r2,[r25,0x4]
L_92cc50:
	bclr r25,r25,0xa
L_92cc54:
	bl L_935990
L_92cc58:
	or r7,r16,0x15000000
L_92cc60:
	mov r32,r7
L_92cc64:
	st.ab r7,[r25,0x4]
L_92cc68:
	bclr r25,r25,0xa
L_92cc6c:
	mov r8,0x14000007
L_92cc74:
	mov r32,r8
L_92cc78:
	st.ab r8,[r25,0x4]
L_92cc7c:
	bclr r25,r25,0xa
L_92cc80:
	bl L_92a3c0
L_92cc84:
	bl.d L_920478
L_92cc88:
	mov r0,r16
L_92cc8c:
	mov_s r2,0xcccccccd
L_92cc92:
	mov_s r3,0x402fcccc
L_92cc98:
	bl L_92096c
L_92cc9c:
	bl L_9210d4
L_92cca0:
	mov r16,r0
	.global L_92cca4
L_92cca4:
	mov r4,r43
L_92cca8:
	bbit0 r4,0x1f,L_92cca4
L_92ccac:
	mov_s r0,r51
L_92ccae:
	bmsk r5,r0,0x3
L_92ccb2:
	st.as r5,[gp,0x3a]
L_92ccb6:
	lsr_s r0,r0,0x4
L_92ccb8:
	st.as r0,[gp,0x3b]
L_92ccbc:
	bl.d L_931664
L_92ccc0:
	mov r0,0x6
L_92ccc4:
	breq r18,0x0,L_92cd38
L_92ccc8:
	ld.as r3,[gp,-0x11]
L_92cccc:
	mov r18,0x0
L_92ccd0:
	and r3,r3,0xfff0ffff
L_92ccd8:
	bset r6,r3,0x12
L_92ccdc:
	st.as r6,[gp,-0x11]
L_92cce0:
	or r3,r3,0x1d040000
L_92cce8:
	mov r32,r3
L_92ccec:
	st.ab r3,[r25,0x4]
L_92ccf0:
	bclr r25,r25,0xa
L_92ccf4:
	nop_s
L_92ccf6:
	nop_s
L_92ccf8:
	mov 0x0,0x0
L_92ccfc:
	mov r6,0x38000200
L_92cd04:
	mov r32,r6
L_92cd08:
	st.ab r6,[r25,0x4]
L_92cd0c:
	bclr r25,r25,0xa
L_92cd10:
	mov r4,0x36000038
L_92cd18:
	mov r32,r4
L_92cd1c:
	st.ab r4,[r25,0x4]
L_92cd20:
	bclr r25,r25,0xa
L_92cd24:
	mov r5,0x6000103
L_92cd2c:
	mov r32,r5
L_92cd30:
	st.ab r5,[r25,0x4]
L_92cd34:
	bclr r25,r25,0xa
	.global L_92cd38
L_92cd38:
	mov_s r1,0x2008000
L_92cd3e:
	mov_s r32,r1
L_92cd40:
	st.ab r1,[r25,0x4]
L_92cd44:
	bclr r25,r25,0xa
L_92cd48:
	ld.as r4,[gp,0x37]
L_92cd4c:
	and r5,r4,0x10
L_92cd50:
	mov r4,0x0
L_92cd54:
	or.f 0x0,r5,r4
L_92cd58:
	beq_s L_92cd80
L_92cd5a:
	ld.as r1,[gp,0x3a]
L_92cd5e:
	ld.as r2,[gp,0x3b]
L_92cd62:
	bic r1,r1,-0x3
L_92cd66:
	cmp_s r1,0x2
L_92cd68:
	mov_s r1,0x1
L_92cd6a:
	sub_s.ne r1,r1,r1
L_92cd6c:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_92cd6e:
	or r1,r1,0x19800830
L_92cd76:
	asl_s r2,r2,0xe
L_92cd78:
	b.d L_92cd88
L_92cd7c:
	or r2,r2,r1
	.global L_92cd80
L_92cd80:
	mov r2,0x19000001
	.global L_92cd88
L_92cd88:
	mov r32,r2
L_92cd8c:
	st.ab r2,[r25,0x4]
L_92cd90:
	bclr r25,r25,0xa
	.global L_92cd94
L_92cd94:
	mov r8,r45
L_92cd98:
	bbit0 r8,0x1f,L_92cd94
L_92cd9c:
	ld.as r9,[gp,0x37]
L_92cda0:
	mov_s r0,0x0
L_92cda2:
	and r6,r9,0x10
L_92cda6:
	or.f 0x0,r6,r0
L_92cdaa:
	beq_s L_92cdc4
L_92cdac:
	mov r9,0x18000000
L_92cdb4:
	mov r32,r9
L_92cdb8:
	st.ab r9,[r25,0x4]
L_92cdbc:
	bclr r25,r25,0xa
L_92cdc0:
	b L_92cdd4
	.global L_92cdc4
L_92cdc4:
	mov_s r0,0x18001000
L_92cdca:
	mov_s r32,r0
L_92cdcc:
	st.ab r0,[r25,0x4]
L_92cdd0:
	bclr r25,r25,0xa
	.global L_92cdd4
L_92cdd4:
	cmp r15,0x0
L_92cdd8:
	bne L_92cb9c
L_92cddc:
	bl L_930f34
L_92cde0:
	bl.d L_931338
L_92cde4:
	mov r0,0x5
L_92cde8:
	mov r0,0x1
	.global L_92cdec
L_92cdec:
	ld blink,[sp, 0x4]
L_92cdf0:
	ld_s r14,[sp,0x8]
L_92cdf2:
	ld_s r15,[sp,0xc]
L_92cdf4:
	ld r16,[sp, 0x10]
L_92cdf8:
	ld r17,[sp, 0x14]
L_92cdfc:
	ld r18,[sp, 0x18]
L_92ce00:
	ld r19,[sp, 0x1c]
L_92ce04:
	j.d [blink]
L_92ce08:
	ld.ab r13,[sp,0x20]
