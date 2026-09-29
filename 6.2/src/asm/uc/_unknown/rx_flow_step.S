/* rx_flow_step @ 0x931acc, 1080 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: bf_pending__set_bit, mac_clk__div165, rx__dispatch_by_g_8005f8, rx__mac_prepare, rx__switch_to_rx_mode, rx__update_nav_from_frame, rx_capture__match_filter, rx_flow_substep_uc, rx_meas__append_sample, rx_meas__capture_frame, rx_meas__finish_with_8830ec, sends_pmc_mark_aaab02
 * Глобалы (через gp): 0x800538, 0x800564, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow_step
rx_flow_step:
	.global L_931acc
L_931acc:
	st.a r13,[sp,-0x18]
L_931ad0:
	st blink,[sp, 0x4]
L_931ad4:
	st_s r14,[sp,0x8]
L_931ad6:
	st_s r15,[sp,0xc]
L_931ad8:
	st r16,[sp, 0x10]
L_931adc:
	st r17,[sp, 0x14]
L_931ae0:
	sub_s sp,sp,0x4
L_931ae2:
	ld.as r10,[gp,-0xd]
L_931ae6:
	mov_s r16,r1
L_931ae8:
	mov r15,r0
L_931aec:
	brne.d r10,0x1,L_931afc
L_931af0:
	mov_s r14,0x0
L_931af2:
	mov_s r0,0x801be8
L_931af8:
	bl L_93cc40
	.global L_931afc
L_931afc:
	mov_s r3,0xeeee0b
L_931b02:
	mov_s r32,r3
L_931b04:
	st.ab r3,[r25,0x4]
L_931b08:
	bclr r25,r25,0xa
L_931b0c:
	ld r11,[r15, 0x1c]
L_931b10:
	cmp r16,r11
L_931b14:
	bhi.d L_931c14
L_931b18:
	mov r13,0x0
	.global L_931b1c
L_931b1c:
	extb r13,r13
L_931b20:
	bl.d L_93daf0
L_931b24:
	mov r0,r15
L_931b28:
	cmp_s r0,0x1
L_931b2a:
	mov r17,0x0
L_931b2e:
	mov.ne r17,r13
L_931b32:
	mov_s r0,r42
L_931b34:
	bbit1 r0,0x10,L_931b44
L_931b38:
	mov_s r0,0x0
L_931b3a:
	bset_s r0,r0,0x10
L_931b3c:
	bl.d L_9366e8
L_931b40:
	mov r1,0x0
	.global L_931b44
L_931b44:
	mov_s r13,0x803134
L_931b4a:
	ld_s r2,[r13,0xc]
L_931b4c:
	cmp_s r2,0x2
L_931b4e:
	bne_s L_931c48
L_931b50:
	ld r7,[r13]
L_931b54:
	cmp r7,0x0
L_931b58:
	beq L_931c48
L_931b5c:
	cmp r7,0x6
L_931b60:
	bhi L_931c48
L_931b64:
	bl.d L_93e56c
L_931b68:
	mov r0,r13
L_931b6c:
	cmp_s r0,0x0
L_931b6e:
	beq_s L_931c48
L_931b70:
	ld r10,[r13]
L_931b74:
	sub.f r10,r10,0x1
L_931b78:
	beq_s L_931c20
L_931b7a:
	breq r10,0x1,L_931c30
L_931b7e:
	breq r10,0x2,L_931c3c
L_931b82:
	cmp r10,0x3
L_931b86:
	beq_s L_931c48
L_931b88:
	cmp r10,0x4
L_931b8c:
	bne_s L_931c48
L_931b8e:
	ld.as r2,[gp,-0x11]
L_931b92:
	add r16,r13,0x18
L_931b96:
	and r2,r2,0xffff0fff
L_931b9e:
	or r3,r2,0x5000
L_931ba6:
	st.as r3,[gp,-0x11]
L_931baa:
	or r2,r2,0x1d005000
L_931bb2:
	mov_s r32,r2
L_931bb4:
	st.ab r2,[r25,0x4]
L_931bb8:
	bclr r25,r25,0xa
L_931bbc:
	nop_s
L_931bbe:
	nop_s
L_931bc0:
	mov 0x0,0x0
L_931bc4:
	st r40,[r16]
L_931bc8:
	ld.as r6,[gp,-0x11]
L_931bcc:
	and r6,r6,0xffff0fff
L_931bd4:
	or r8,r6,0x6000
L_931bdc:
	or r6,r6,0x1d006000
L_931be4:
	st.as r8,[gp,-0x11]
L_931be8:
	mov r32,r6
L_931bec:
	st.ab r6,[r25,0x4]
L_931bf0:
	bclr r25,r25,0xa
L_931bf4:
	nop_s
L_931bf6:
	nop_s
L_931bf8:
	mov 0x0,0x0
L_931bfc:
	st r40,[r16, 0x4]
L_931c00:
	mov r7,0x1
L_931c04:
	st r7,[r13, 0xc]
L_931c08:
	bl.d L_9216f8
L_931c0c:
	mov r0,0x0
L_931c10:
	b L_931c48
	.global L_931c14
L_931c14:
	mov_s r0,r42
L_931c16:
	btst_s r0,0x7
L_931c18:
	b.d L_931b1c
L_931c1c:
	mov.eq r13,0x1
	.global L_931c20
L_931c20:
	mov r0,r13
L_931c24:
	bl.d L_928854
L_931c28:
	mov r1,0x0
L_931c2c:
	b L_931c48
	.global L_931c30
L_931c30:
	bl.d L_92893c
L_931c34:
	mov r0,r13
L_931c38:
	b L_931c48
	.global L_931c3c
L_931c3c:
	mov r0,r13
L_931c40:
	bl.d L_927f6c
L_931c44:
	mov r1,0x0
	.global L_931c48
L_931c48:
	mov r6,r38
L_931c4c:
	btst r6,0xf
L_931c50:
	bl.eq L_924fc4
L_931c54:
	ldb r11,[gp, -0xf2]
L_931c58:
	breq r11,0x0,L_931d00
	.global L_931c5c
L_931c5c:
	mov_s r1,r38
L_931c5e:
	bbit0 r1,0xb,L_931cbc
L_931c62:
	lsr r7,r38,0x8
L_931c66:
	bmsk r7,r7,0x2
L_931c6a:
	ld r8,[0x801424]
L_931c72:
	st r7,[0x802288]
L_931c7a:
	btst r8,0x0
L_931c7e:
	btst.eq r8,0x1
L_931c82:
	bne_s L_931cbc
L_931c84:
	asl r2,r7,0x2
L_931c88:
	add1_s r2,r2,r2
L_931c8a:
	ld r8,[r2,0x802610]
L_931c92:
	sub.f r8,r8,0x0
L_931c96:
	mov.ne r8,0x1
L_931c9a:
	extb.f 0x0,r8
L_931c9e:
	bne_s L_931cbc
L_931ca0:
	mov r10,0x8014e8
L_931ca8:
	ldb r8,[r10]
L_931cac:
	ldb r1,[r10, 0x1]
L_931cb0:
	brge r8,r1,L_931cbc
L_931cb4:
	stb r8,[r10, 0x1]
L_931cb8:
	stb r7,[r10, 0x2]
	.global L_931cbc
L_931cbc:
	bl L_9333fc
L_931cc0:
	and r13,r0,r17
L_931cc4:
	cmp_s r13,0x1
L_931cc6:
	bne_s L_931d94
L_931cc8:
	and.f 0x0,r36,0x6
L_931ccc:
	beq_s L_931d30
L_931cce:
	and.f 0x0,r38,0x30000
L_931cd6:
	bne_s L_931d30
L_931cd8:
	lsr r0,r36,0x13
L_931cdc:
	bmsk_s r0,r0,0x4
L_931cde:
	st_s r0,[r15,0x8]
L_931ce0:
	mov_s r1,r38
L_931ce2:
	ld r6,[r15, 0x4]
L_931ce6:
	asl r10,0x1,r6
L_931cee:
	bbit0 r1,0x19,L_931d28
L_931cf2:
	mov_s r1,0x0
L_931cf4:
	st r1,[r15, 0x30]
L_931cf8:
	b.d L_931d5c
L_931cfc:
	mov r11,0x2
	.global L_931d00
L_931d00:
	ldb r3,[gp, -0xf9]
L_931d04:
	bmsk_s r3,r3,0x0
L_931d06:
	or r3,r3,0x32000000
L_931d0e:
	mov_s r32,r3
L_931d10:
	st.ab r3,[r25,0x4]
L_931d14:
	bclr r25,r25,0xa
L_931d18:
	ldb r4,[gp, -0xf9]
L_931d1c:
	add r4,r4,0x1
L_931d20:
	b.d L_931c5c
L_931d24:
	stb r4,[gp, -0xf9]
	.global L_931d28
L_931d28:
	b.d L_931d5c
L_931d2c:
	mov r11,0x1
	.global L_931d30
L_931d30:
	ld r5,[r15, 0x4]
L_931d34:
	ld.as r9,[gp,0xf]
L_931d38:
	asl r10,0x1,r5
L_931d40:
	tst r9,r10
L_931d44:
	beq L_931d58
L_931d48:
	ld.as r5,[gp,0x4]
L_931d4c:
	st r5,[r15, 0x8]
L_931d50:
	b.d L_931d5c
L_931d54:
	mov r11,0x2
	.global L_931d58
L_931d58:
	mov r11,0x0
	.global L_931d5c
L_931d5c:
	ld r9,[r15]
L_931d60:
	st r11,[r15, 0x24]
L_931d64:
	asl r9,r9,0x4
L_931d68:
	ld r3,[0x802948]
L_931d70:
	add2 r9,r9,r9
L_931d74:
	tst r3,r10
L_931d78:
	ld r14,[r9,0x80110c]
L_931d80:
	beq L_931e18
L_931d84:
	ld.as r10,[gp,0x34]
L_931d88:
	bset r10,r10,0x1e
L_931d8c:
	b.d L_931e18
L_931d90:
	st.as r10,[gp,0x34]
	.global L_931d94
L_931d94:
	bl L_92f2bc
L_931d98:
	mov r4,r38
L_931d9c:
	bbit0 r4,0xb,L_931dc4
L_931da0:
	ld r8,[0x8029f0]
L_931da8:
	ld r0,[0x802288]
L_931db0:
	ld r2,[r8]
L_931db4:
	breq r0,r2,L_931dc4
L_931db8:
	ld.as r8,[gp,0x34]
L_931dbc:
	bset r8,r8,0x6
L_931dc0:
	st.as r8,[gp,0x34]
	.global L_931dc4
L_931dc4:
	brne r17,0x0,L_931dfc
L_931dc8:
	ld.as r1,[gp,0x34]
L_931dcc:
	bset_s r1,r1,0xa
L_931dce:
	st.as r1,[gp,0x34]
L_931dd2:
	mov_s r3,r42
L_931dd4:
	bbit0 r3,0x7,L_931dfc
L_931dd8:
	ld.as r2,[gp,-0xf]
L_931ddc:
	breq r2,0x0,L_931dfc
L_931de0:
	mov r7,0x1
L_931de4:
	st.as r7,[gp,-0xe]
L_931de8:
	mov r4,0x1f000601
L_931df0:
	mov r32,r4
L_931df4:
	st.ab r4,[r25,0x4]
L_931df8:
	bclr r25,r25,0xa
	.global L_931dfc
L_931dfc:
	mov r9,r38
L_931e00:
	bbit0 r9,0x1c,L_931e18
L_931e04:
	bl.d L_9343a8
L_931e08:
	mov r0,0x1
L_931e0c:
	ld.as r5,[gp,0x34]
L_931e10:
	bset r5,r5,0xa
L_931e14:
	st.as r5,[gp,0x34]
	.global L_931e18
L_931e18:
	bmsk r11,r13,0x0
L_931e1c:
	mov r7,0x802288
L_931e24:
	ld r6,[r7, 0x10]
L_931e28:
	asl r5,r11
L_931e2c:
	bclr r6,r6,0x1
L_931e30:
	or r5,r5,r6
L_931e34:
	st r5,[r7, 0x10]
L_931e38:
	ld_s r3,[r15,0xc]
L_931e3a:
	cmp_s r13,0x1
L_931e3c:
	bclr r3,r3,0x0
L_931e40:
	or r11,r11,r3
L_931e44:
	bne.d L_931eec
L_931e48:
	st r11,[r15, 0xc]
L_931e4c:
	mov r9,0x4d000000
L_931e54:
	mov r32,r9
L_931e58:
	st.ab r9,[r25,0x4]
L_931e5c:
	bclr r25,r25,0xa
L_931e60:
	nop_s
L_931e62:
	nop_s
L_931e64:
	nop_s
L_931e66:
	stw r55,[sp]
L_931e6a:
	ldb_s r1,[sp,0x0]
L_931e6c:
	mov_s r13,0x802588
L_931e72:
	ldb_s r0,[r13]
L_931e74:
	add_s r0,r0,r1
L_931e76:
	add_s r0,r0,0xd
L_931e78:
	bl.d L_936b94
L_931e7c:
	add r1,sp,0x2
L_931e80:
	ldb r3,[sp, 0x1]
L_931e84:
	ldb_s r2,[r13,0x1]
L_931e86:
	ldb r4,[sp, 0x3]
L_931e8a:
	add_s r2,r2,r3
L_931e8c:
	add r2,r2,r4
L_931e90:
	stb r2,[sp, 0x3]
L_931e94:
	ldw r3,[sp, 0x2]
L_931e98:
	mov r8,0x14000206
L_931ea0:
	st r3,[0x886d10]
L_931ea8:
	mov r32,r8
L_931eac:
	st.ab r8,[r25,0x4]
L_931eb0:
	bclr r25,r25,0xa
L_931eb4:
	mov_s r0,0x37000005
L_931eba:
	mov_s r32,r0
L_931ebc:
	st.ab r0,[r25,0x4]
L_931ec0:
	bclr r25,r25,0xa
L_931ec4:
	mov r9,0x37000002
L_931ecc:
	mov r32,r9
L_931ed0:
	st.ab r9,[r25,0x4]
L_931ed4:
	bclr r25,r25,0xa
L_931ed8:
	or r14,r14,0x3f000000
L_931ee0:
	mov r32,r14
L_931ee4:
	st.ab r14,[r25,0x4]
L_931ee8:
	bclr r25,r25,0xa
	.global L_931eec
L_931eec:
	add_s sp,sp,0x4
L_931eee:
	ld blink,[sp, 0x4]
L_931ef2:
	ld_s r14,[sp,0x8]
L_931ef4:
	ld_s r15,[sp,0xc]
L_931ef6:
	ld r16,[sp, 0x10]
L_931efa:
	ld r17,[sp, 0x14]
L_931efe:
	j_s.d [blink]
L_931f00:
	ld.ab r13,[sp,0x18]
