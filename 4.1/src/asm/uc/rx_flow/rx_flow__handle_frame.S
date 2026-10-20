/* rx_flow__handle_frame @ 0x92de68, 2416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_flow.c
 * Зовут его: rx_flow__run
 * Зовёт сам: get_g_804010, power_mngr_peer_update, rf_sector__find_by_id, rfc_ctrl__switch, rx__mac_prepare, rx__switch_to_rx_mode, rx_flow__grant_detected, rx_flow__post_rx_tail, rx_flow__post_rx_unsupported, rx_flow_substep, rx_funcs__identify_peer, rx_nav_bi_step
 * Глобалы (через gp): 0x800538, 0x800540, 0x80056c, 0x8005d8, 0x8005f9, 0x800604, 0x800608
 */
	.section .text.rx_flow__handle_frame,"ax",@progbits
	.global rx_flow__handle_frame
rx_flow__handle_frame:
	.global L_92de68
L_92de68:
	st.a r13,[sp,-0x14]
L_92de6c:
	st blink,[sp, 0x4]
L_92de70:
	st_s r14,[sp,0x8]
L_92de72:
	st_s r15,[sp,0xc]
L_92de74:
	st r16,[sp, 0x10]
L_92de78:
	mov r5,r42
L_92de7c:
	sub sp,sp,0x8
L_92de80:
	bbit1.d r5,0x10,L_92de94
L_92de84:
	mov_s r14,r0
L_92de86:
	mov_s r0,0x0
L_92de88:
	bset r0,r0,0x10
L_92de8c:
	bl.d L_931808
L_92de90:
	mov r1,0x0
	.global L_92de94
L_92de94:
	ldb r1,[gp, -0xf3]
L_92de98:
	breq r1,0x0,L_92df40
	.global L_92de9c
L_92de9c:
	mov_s r2,r36
L_92de9e:
	btst_s r2,0x7
L_92dea0:
	beq L_92e164
L_92dea4:
	mov r2,0x801b08
L_92deac:
	ld r11,[r2, 0x8]
L_92deb0:
	mov r6,0x49000100
L_92deb8:
	add r11,r11,0x1
L_92debc:
	st r11,[r2, 0x8]
L_92dec0:
	mov r32,r6
L_92dec4:
	st.ab r6,[r25,0x4]
L_92dec8:
	bclr r25,r25,0xa
L_92decc:
	bmsk r0,r38,0x0
L_92ded0:
	mov_s r13,0x801e68
L_92ded6:
	stb_s r0,[r13]
L_92ded8:
	mov_s r15,0x804010
L_92dede:
	ldb r9,[r15, 0x19]
L_92dee2:
	ldb_s r3,[r15,0x18]
L_92dee4:
	asl r9,r9,0x8
L_92dee8:
	or r3,r3,r9
L_92deec:
	bic.f r3,r3,-0x781
L_92def0:
	bne L_92e0c0
L_92def4:
	ldb r11,[r15, 0x17]
L_92def8:
	ldb r10,[r15, 0x18]
L_92defc:
	ldb r9,[r15, 0x19]
L_92df00:
	ldb r8,[r15, 0x1a]
L_92df04:
	stb r11,[r13, 0x2]
L_92df08:
	stb r10,[r13, 0x3]
L_92df0c:
	stb r9,[r13, 0x4]
L_92df10:
	stb r8,[r13, 0x5]
L_92df14:
	ldb r11,[r15, 0x1b]
L_92df18:
	ldb r10,[r15, 0x1c]
L_92df1c:
	stb r11,[r13, 0x6]
L_92df20:
	stb r10,[r13, 0x7]
L_92df24:
	ldb_s r1,[r13,0x3]
L_92df26:
	lsr_s r1,r1,0x2
L_92df28:
	bmsk r1,r1,0x3
L_92df2c:
	brhs r1,0x4,L_92df6c
L_92df30:
	mov r10,0x0
L_92df34:
	stb r10,[r13, 0x1]
L_92df38:
	b.d L_92e0e4
L_92df3c:
	stb r10,[r13, 0x1b]
	.global L_92df40
L_92df40:
	ldb r9,[gp, -0xf9]
L_92df44:
	bmsk r9,r9,0x0
L_92df48:
	or r9,r9,0x32000000
L_92df50:
	mov r32,r9
L_92df54:
	st.ab r9,[r25,0x4]
L_92df58:
	bclr r25,r25,0xa
L_92df5c:
	ldb r10,[gp, -0xf9]
L_92df60:
	add r10,r10,0x1
L_92df64:
	b.d L_92de9c
L_92df68:
	stb r10,[gp, -0xf9]
	.global L_92df6c
L_92df6c:
	mov r4,0x1
L_92df70:
	mov r6,0x80208c
L_92df78:
	ld r3,[r6, 0x4]
L_92df7c:
	stb r4,[r13, 0x1]
L_92df80:
	breq.d r3,0x3,L_92dfbc
L_92df84:
	ld r8,[r6, 0x8]
L_92df88:
	brne_s r3,0,L_92dfa0
L_92df8a:
	ldb r2,[0x801034]
L_92df92:
	sub.f r2,r2,0x0
L_92df96:
	mov.ne r2,0x1
L_92df9a:
	extb.f 0x0,r2
L_92df9e:
	bne_s L_92dfbc
	.global L_92dfa0
L_92dfa0:
	brne r3,0x1,L_92dfd0
L_92dfa4:
	ldb r11,[0x801034]
L_92dfac:
	sub.f r11,r11,0x0
L_92dfb0:
	mov.ne r11,0x1
L_92dfb4:
	extb.f 0x0,r11
L_92dfb8:
	bne L_92dfd0
	.global L_92dfbc
L_92dfbc:
	ldw_s r3,[r13,0x20]
L_92dfbe:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92dfc0:
	stw r3,[r13, 0x20]
	.global L_92dfc4
L_92dfc4:
	mov r9,0x0
L_92dfc8:
	b.d L_92e0cc
L_92dfcc:
	stb r9,[r13, 0x1b]
	.global L_92dfd0
L_92dfd0:
	brne r8,0x0,L_92dfe8
L_92dfd4:
	ldb r7,[r13, 0x3]
L_92dfd8:
	ldb r5,[r13, 0x2]
L_92dfdc:
	asl r7,r7,0x8
L_92dfe0:
	or r5,r5,r7
L_92dfe4:
	bbit1 r5,0x1,L_92e000
	.global L_92dfe8
L_92dfe8:
	brne r8,0x1,L_92e010
L_92dfec:
	ldb r5,[r13, 0x3]
L_92dff0:
	ldb r2,[r13, 0x2]
L_92dff4:
	asl r5,r5,0x8
L_92dff8:
	or r2,r2,r5
L_92dffc:
	bbit1 r2,0x1,L_92e010
	.global L_92e000
L_92e000:
	ldw r4,[r13, 0x22]
L_92e004:
	add r4,r4,0x1
L_92e008:
	b.d L_92dfc4
L_92e00c:
	stw r4,[r13, 0x22]
	.global L_92e010
L_92e010:
	ldw r5,[r6]
L_92e014:
	brlt r5,0x1,L_92e030
L_92e018:
	sub r5,r5,0x1
L_92e01c:
	stw r5,[r6]
L_92e020:
	ldw r6,[r13, 0x24]
L_92e024:
	add r6,r6,0x1
L_92e028:
	b.d L_92dfc4
L_92e02c:
	stw r6,[r13, 0x24]
	.global L_92e030
L_92e030:
	ldw r7,[r13, 0x26]
L_92e034:
	mov_s r0,0x1
L_92e036:
	add r7,r7,0x1
L_92e03a:
	stw r7,[r13, 0x26]
L_92e03e:
	ld.as r8,[gp,-0x11]
L_92e042:
	stb_s r0,[r13,0x1b]
L_92e044:
	and r8,r8,0xffff0fff
L_92e04c:
	or r6,r8,0xd000
L_92e054:
	st.as r6,[gp,-0x11]
L_92e058:
	or r8,r8,0x1d00d000
L_92e060:
	mov r32,r8
L_92e064:
	st.ab r8,[r25,0x4]
L_92e068:
	bclr r25,r25,0xa
L_92e06c:
	nop_s
L_92e06e:
	nop_s
L_92e070:
	nop_s
L_92e072:
	mov r9,r40
L_92e076:
	st r9,[sp]
L_92e07a:
	lsr r9,r9,0x9
L_92e07e:
	bmsk r9,r9,0xa
L_92e082:
	sub r1,r9,0x800
L_92e08a:
	cmp r9,0x3ff
L_92e08e:
	mov.hi r2,r1
L_92e092:
	mov.ls r2,r9
L_92e096:
	mov_s r13,0x801e68
L_92e09c:
	st r2,[r13, 0xc]
L_92e0a0:
	ldw r10,[r15, 0x12]
L_92e0a4:
	lsr r10,r10,0xa
L_92e0a8:
	stb r10,[r13, 0x8]
L_92e0ac:
	ldw r11,[r15, 0x14]
L_92e0b0:
	bmsk r11,r11,0x1
L_92e0b4:
	stb r11,[r13, 0x9]
L_92e0b8:
	b.d L_92e0cc
L_92e0bc:
	ldb r0,[r13]
	.global L_92e0c0
L_92e0c0:
	mov r8,0x0
L_92e0c4:
	stb r8,[r13, 0x1]
L_92e0c8:
	stb r8,[r13, 0x1b]
	.global L_92e0cc
L_92e0cc:
	ldw r11,[r15, 0x4]
L_92e0d0:
	ldw r10,[r15, 0x6]
L_92e0d4:
	ldw r9,[r15, 0x8]
L_92e0d8:
	stw r11,[r13, 0x10]
L_92e0dc:
	stw r10,[r13, 0x12]
L_92e0e0:
	stw r9,[r13, 0x14]
	.global L_92e0e4
L_92e0e4:
	brne r0,0x0,L_92e0f0
L_92e0e8:
	ldb r6,[r13, 0x1b]
L_92e0ec:
	breq r6,0x0,L_92e164
	.global L_92e0f0
L_92e0f0:
	ld.as r3,[gp,0x37]
L_92e0f4:
	mov_s r15,0x1
L_92e0f6:
	bic r3,r3,-0x9
L_92e0fa:
	mov_s r2,0x0
L_92e0fc:
	or.f 0x0,r3,r2
L_92e100:
	mov r13,0x801458
L_92e108:
	bne.d L_92e11c
L_92e10c:
	ld.as r1,[gp,0x38]
L_92e110:
	ld_s r0,[r13,0x64]
L_92e112:
	bset_s r1,r1,0xa
L_92e114:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e116:
	st_s r0,[r13,0x64]
L_92e118:
	st.as r1,[gp,0x38]
	.global L_92e11c
L_92e11c:
	bl L_92b7c4
L_92e120:
	ld_s r2,[r14,0xc]
L_92e122:
	mov r5,0x80088c
L_92e12a:
	bclr_s r2,r2,0x0
L_92e12c:
	st_s r2,[r14,0xc]
L_92e12e:
	ldb r2,[r5, 0x50]
L_92e132:
	ld r4,[r13, 0x5c]
L_92e136:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_92e138:
	add2_s r2,r2,r2
L_92e13a:
	add_s r2,r2,r5
L_92e13c:
	ldb r3,[r2, 0x25]
L_92e140:
	add r4,r4,0x1
L_92e144:
	add r3,r3,0x1
L_92e148:
	stb r3,[r2, 0x25]
L_92e14c:
	stb r15,[r2, 0x26]
L_92e150:
	ld.as r5,[gp,0x38]
L_92e154:
	st r4,[r13, 0x5c]
L_92e158:
	bset r5,r5,0x18
L_92e15c:
	b.d L_92eaac
L_92e160:
	st.as r5,[gp,0x38]
	.global L_92e164
L_92e164:
	mov r9,r36
L_92e168:
	bbit0 r9,0x19,L_92e1cc
L_92e16c:
	bl L_928fa0
L_92e170:
	breq r0,0x0,L_92e1cc
L_92e174:
	mov r10,r38
L_92e178:
	bbit0 r10,0xb,L_92e188
L_92e17c:
	lsr r6,r38,0x8
L_92e180:
	b.d L_92e18c
L_92e184:
	bmsk r6,r6,0x2
	.global L_92e188
L_92e188:
	mov r6,0x8
	.global L_92e18c
L_92e18c:
	mov r8,0x801458
L_92e194:
	ldb r7,[r8, 0x83]
L_92e198:
	st r6,[0x801418]
L_92e1a0:
	add r7,r7,0x1
L_92e1a4:
	stb r7,[r8, 0x83]
L_92e1a8:
	ld.as r8,[gp,0x37]
L_92e1ac:
	bbit1 r8,0x2,L_92e1bc
L_92e1b0:
	ld.as r8,[gp,0x38]
L_92e1b4:
	bset r8,r8,0x19
L_92e1b8:
	st.as r8,[gp,0x38]
	.global L_92e1bc
L_92e1bc:
	bl L_92b7c4
	.global L_92e1c0
L_92e1c0:
	ld_s r1,[r14,0xc]
L_92e1c2:
	bclr_s r1,r1,0x0
L_92e1c4:
	b.d L_92eaac
L_92e1c8:
	st r1,[r14, 0xc]
	.global L_92e1cc
L_92e1cc:
	mov r16,0x0
L_92e1d0:
	mov r7,0xeeee0c
L_92e1d8:
	mov r32,r7
L_92e1dc:
	st.ab r7,[r25,0x4]
L_92e1e0:
	bclr r25,r25,0xa
L_92e1e4:
	mov_s r1,0x0
L_92e1e6:
	st_s r1,[r14,0x20]
L_92e1e8:
	ld.as r4,[gp,-0x1]
L_92e1ec:
	mov_s r3,0x801418
L_92e1f2:
	ld_s r0,[r3,0x10]
L_92e1f4:
	cmp r4,0x0
L_92e1f8:
	btst.ne r0,0x3
L_92e1fc:
	bne L_92e208
	.global L_92e200
L_92e200:
	b.d L_92e218
L_92e204:
	mov r9,0x0
	.global L_92e208
L_92e208:
	ld r4,[r14, 0x4]
L_92e20c:
	ld.as r10,[gp,0x11]
L_92e210:
	bbit0.d r10,r4,L_92e200
L_92e214:
	mov r9,0x1
	.global L_92e218
L_92e218:
	extb r11,r9
L_92e21c:
	st r11,[sp]
L_92e220:
	bmsk r9,r9,0x0
L_92e224:
	asl r9,r9,0x4
L_92e228:
	bclr_s r0,r0,0x4
L_92e22a:
	or r0,r0,r9
L_92e22e:
	st_s r0,[r3,0x10]
L_92e230:
	nop_s
L_92e232:
	nop_s
L_92e234:
	mov 0x0,0x0
L_92e238:
	ld.as r9,[gp,-0x11]
L_92e23c:
	and r9,r9,0xffff0fff
L_92e244:
	or r6,r9,0xb000
L_92e24c:
	or r9,r9,0x1d00b000
L_92e254:
	st.as r6,[gp,-0x11]
L_92e258:
	mov r32,r9
L_92e25c:
	st.ab r9,[r25,0x4]
L_92e260:
	bclr r25,r25,0xa
L_92e264:
	nop_s
L_92e266:
	nop_s
L_92e268:
	mov 0x0,0x0
L_92e26c:
	mov r11,r37
L_92e270:
	mov r4,0x804010
L_92e278:
	bbit0 r11,0x10,L_92e284
L_92e27c:
	ldw r6,[r4, 0x2]
L_92e280:
	brne r6,0x0,L_92e290
	.global L_92e284
L_92e284:
	mov_s r2,r37
L_92e286:
	bbit1 r2,0x0,L_92e290
L_92e28a:
	mov_s r3,r40
L_92e28c:
	bbit0 r3,0xf,L_92e294
	.global L_92e290
L_92e290:
	bl L_9248e8
	.global L_92e294
L_92e294:
	mov r5,r38
L_92e298:
	mov r13,0x801418
L_92e2a0:
	bbit0 r5,0xb,L_92e2b4
L_92e2a4:
	lsr r6,r38,0x8
L_92e2a8:
	bmsk r6,r6,0x2
L_92e2ac:
	b.d L_92e2f8
L_92e2b0:
	st r6,[r13]
	.global L_92e2b4
L_92e2b4:
	mov r5,r36
L_92e2b8:
	bbit0 r5,0x7,L_92e2d0
L_92e2bc:
	mov r0,0x804014
L_92e2c4:
	bl L_930114
L_92e2c8:
	b.d L_92e2f8
L_92e2cc:
	st r0,[r13]
	.global L_92e2d0
L_92e2d0:
	mov_s r1,r36
L_92e2d2:
	bbit0 r1,0x6,L_92e2e8
L_92e2d6:
	mov_s r0,0x80401a
L_92e2dc:
	bl L_930114
L_92e2e0:
	b.d L_92e2f8
L_92e2e4:
	st r0,[r13]
	.global L_92e2e8
L_92e2e8:
	mov r4,0x8
L_92e2ec:
	st r4,[r13]
L_92e2f0:
	mov r4,0x0
L_92e2f4:
	st r4,[sp]
	.global L_92e2f8
L_92e2f8:
	mov_s r2,r36
L_92e2fa:
	bbit1 r2,0x6,L_92e3c0
L_92e2fe:
	mov_s r1,r36
L_92e300:
	bbit1 r1,0x19,L_92e3c0
L_92e304:
	and r7,r38,0x30006800
L_92e30c:
	mov_s r13,0x801418
L_92e312:
	cmp r7,0x20000800
L_92e31a:
	bne L_92e65c
L_92e31e:
	ld.as r8,[gp,0x6]
L_92e322:
	ld r4,[r13]
L_92e326:
	btst r8,0x0
L_92e32a:
	btst.eq r8,0x1
L_92e32e:
	bne_s L_92e36c
L_92e330:
	asl r5,r4,0x2
L_92e334:
	add1 r5,r5,r5
L_92e338:
	ld r2,[r5,0x8016d8]
L_92e340:
	sub.f r2,r2,0x0
L_92e344:
	mov.ne r2,0x1
L_92e348:
	extb.f 0x0,r2
L_92e34c:
	bne L_92e36c
L_92e350:
	mov r7,0x800a0c
L_92e358:
	ldb r3,[r7]
L_92e35c:
	ldb r11,[r7, 0x1]
L_92e360:
	brge r3,r11,L_92e36c
L_92e364:
	stb r3,[r7, 0x1]
L_92e368:
	stb r4,[r7, 0x2]
	.global L_92e36c
L_92e36c:
	ld.as r8,[gp,-0x11]
L_92e370:
	and r8,r8,0xffff0fff
L_92e378:
	or r3,r8,0x3000
L_92e380:
	or r8,r8,0x1d003000
L_92e388:
	st.as r3,[gp,-0x11]
L_92e38c:
	mov r32,r8
L_92e390:
	st.ab r8,[r25,0x4]
L_92e394:
	bclr r25,r25,0xa
L_92e398:
	nop_s
L_92e39a:
	nop_s
L_92e39c:
	nop_s
L_92e39e:
	extw r2,r40
L_92e3a2:
	ld r4,[r14, 0x18]
L_92e3a6:
	brhs r2,r4,L_92e44c
L_92e3aa:
	mov r7,0x0
L_92e3ae:
	st r7,[r14, 0x20]
L_92e3b2:
	mov_s r13,0x801418
L_92e3b8:
	b.d L_92e590
L_92e3bc:
	mov r16,0x0
	.global L_92e3c0
L_92e3c0:
	ld.as r4,[gp,0x6]
L_92e3c4:
	bbit1 r4,0x0,L_92e3dc
L_92e3c8:
	bl L_92b7c4
L_92e3cc:
	ld.as r3,[gp,0x38]
L_92e3d0:
	bset r3,r3,0xa
L_92e3d4:
	b.d L_92e1c0
L_92e3d8:
	st.as r3,[gp,0x38]
	.global L_92e3dc
L_92e3dc:
	bl L_926608
L_92e3e0:
	cmp r0,0x0
L_92e3e4:
	beq L_92eaac
L_92e3e8:
	bl L_92b7c4
L_92e3ec:
	ld r4,[r14, 0xc]
L_92e3f0:
	bclr r4,r4,0x0
L_92e3f4:
	st r4,[r14, 0xc]
L_92e3f8:
	ld r9,[0x801038]
L_92e400:
	bic.f r9,r9,-0x222
L_92e404:
	bne L_92eaac
L_92e408:
	ldw.as r5,[gp,0x58]
L_92e40c:
	ldw r1,[0x801a08]
L_92e414:
	cmp r1,r5
L_92e418:
	beq L_92eaac
L_92e41c:
	stw.as r1,[gp,0x58]
L_92e420:
	or r1,r1,0x1730000
L_92e428:
	st r1,[0x886d00]
L_92e430:
	sync
L_92e434:
	mov r9,0x38000200
L_92e43c:
	mov r32,r9
L_92e440:
	st.ab r9,[r25,0x4]
L_92e444:
	bclr r25,r25,0xa
L_92e448:
	b L_92eaac
	.global L_92e44c
L_92e44c:
	lsr r5,r38,0x14
L_92e450:
	bmsk r5,r5,0x4
L_92e454:
	stb r5,[gp, -0xe7]
L_92e458:
	mov r1,sp
L_92e45c:
	bl.d L_92eac0
L_92e460:
	mov r0,r14
L_92e464:
	st_s r0,[r14,0x20]
L_92e466:
	ldb r13,[gp, -0xe7]
L_92e46a:
	mov_s r0,r36
L_92e46c:
	btst r0,0x9
L_92e470:
	beq.d L_92e53c
L_92e474:
	mov_s r15,0x0
L_92e476:
	mov_s r1,r38
L_92e478:
	btst_s r1,0xc
L_92e47a:
	beq_s L_92e53c
L_92e47c:
	ldb r5,[gp, -0xe9]
L_92e480:
	breq r5,0x0,L_92e4f4
L_92e484:
	mov r7,r53
L_92e488:
	bbit1 r7,0x0,L_92e4d8
L_92e48c:
	mov r8,0x23010003
L_92e494:
	mov r32,r8
L_92e498:
	st.ab r8,[r25,0x4]
L_92e49c:
	bclr r25,r25,0xa
L_92e4a0:
	mov r4,0x2000200
L_92e4a8:
	mov r32,r4
L_92e4ac:
	st.ab r4,[r25,0x4]
L_92e4b0:
	bclr r25,r25,0xa
L_92e4b4:
	nop_s
L_92e4b6:
	nop_s
L_92e4b8:
	mov 0x0,0x0
	.global L_92e4bc
L_92e4bc:
	mov r2,r42
L_92e4c0:
	bbit1 r2,0x9,L_92e4cc
L_92e4c4:
	mov r4,r53
L_92e4c8:
	bbit0 r4,0x0,L_92e4bc
	.global L_92e4cc
L_92e4cc:
	mov r7,r42
L_92e4d0:
	btst r7,0x9
L_92e4d4:
	bne L_92e61c
	.global L_92e4d8
L_92e4d8:
	and r3,r53,0x10
L_92e4dc:
	st.as r3,[gp,-0x33]
L_92e4e0:
	mov r9,0x1c000001
L_92e4e8:
	mov r32,r9
L_92e4ec:
	st.ab r9,[r25,0x4]
L_92e4f0:
	bclr r25,r25,0xa
	.global L_92e4f4
L_92e4f4:
	lsr r4,r53,0x8
L_92e4f8:
	bmsk r4,r4,0x6
L_92e4fc:
	lsr r7,r53,0x10
L_92e500:
	mov r5,0x801118
L_92e508:
	ld r8,[r5]
L_92e50c:
	bmsk r7,r7,0x6
L_92e510:
	add r8,r8,r4
L_92e514:
	ld r9,[r5, 0x4]
L_92e518:
	st r8,[r5]
L_92e51c:
	add r9,r9,r7
L_92e520:
	ld r10,[r5, 0x8]
L_92e524:
	st r9,[r5, 0x4]
L_92e528:
	add r10,r10,0x1
L_92e52c:
	brlt.d r13,0x1,L_92e53c
L_92e530:
	st r10,[r5, 0x8]
L_92e534:
	mov r3,0x1
L_92e538:
	st r3,[r5, 0x14]
	.global L_92e53c
L_92e53c:
	mov r5,0x8800
L_92e544:
	and r8,r38,r5
L_92e548:
	mov_s r13,0x801418
L_92e54e:
	brne r8,r5,L_92e560
L_92e552:
	ld r8,[r13, 0x10]
L_92e556:
	mov_s r15,0x1
L_92e558:
	bset r8,r8,0x3
L_92e55c:
	st r8,[r13, 0x10]
	.global L_92e560
L_92e560:
	bl.d L_9374f0
L_92e564:
	mov r0,r14
L_92e568:
	brne.d r0,0x0,L_92e590
L_92e56c:
	ld r7,[r14, 0x20]
L_92e570:
	ld.as r6,[gp,-0x1]
L_92e574:
	tst r15,r6
L_92e578:
	beq.d L_92e590
L_92e57c:
	ld r16,[sp]
L_92e580:
	ld r5,[r13, 0x4]
L_92e584:
	ld r6,[r13]
L_92e588:
	cmp r6,r5
L_92e58c:
	bset.eq r16,r16,0x0
	.global L_92e590
L_92e590:
	brne r7,0x0,L_92e598
L_92e594:
	brne r16,0x1,L_92e634
	.global L_92e598
L_92e598:
	cmp r7,0x1
L_92e59c:
	mov.eq r16,0x0
L_92e5a0:
	breq.d r7,0x0,L_92e5b4
L_92e5a4:
	ld r4,[r13]
L_92e5a8:
	ld r7,[r14, 0xc]
L_92e5ac:
	btst r7,0x9
L_92e5b0:
	mov.eq r16,0x0
	.global L_92e5b4
L_92e5b4:
	asl r4,r4,0x3
L_92e5b8:
	add3 r4,r4,r4
L_92e5bc:
	ld r15,[r4,0x801198]
L_92e5c4:
	mov_s r1,0x37000005
L_92e5ca:
	mov_s r32,r1
L_92e5cc:
	st.ab r1,[r25,0x4]
L_92e5d0:
	bclr r25,r25,0xa
L_92e5d4:
	mov_s r0,0x37000002
L_92e5da:
	mov_s r32,r0
L_92e5dc:
	st.ab r0,[r25,0x4]
L_92e5e0:
	bclr r25,r25,0xa
L_92e5e4:
	or r15,r15,0x3f000000
L_92e5ec:
	mov r32,r15
L_92e5f0:
	st.ab r15,[r25,0x4]
L_92e5f4:
	bclr r25,r25,0xa
L_92e5f8:
	ld_s r1,[r14,0xc]
L_92e5fa:
	bmsk r2,r16,0x0
L_92e5fe:
	bclr_s r1,r1,0x0
L_92e600:
	or_s r1,r1,r2
L_92e602:
	st_s r1,[r14,0xc]
L_92e604:
	ld r8,[r13]
L_92e608:
	asl_s r2,r2
L_92e60a:
	st r8,[r14]
L_92e60e:
	ld_s r1,[r13,0x10]
L_92e610:
	bclr r1,r1,0x1
L_92e614:
	b.d L_92e650
L_92e618:
	or r1,r1,r2
	.global L_92e61c
L_92e61c:
	mov_s r0,blink
L_92e61e:
	mov_s r2,0x10010dc
L_92e624:
	mov r1,0x3b
L_92e628:
	bl.d L_925548
L_92e62c:
	mov r3,0x6f
L_92e630:
	b L_92e4d8
	.global L_92e634
L_92e634:
	bl L_92b7c4
L_92e638:
	mov r6,r37
L_92e63c:
	bbit0.d r6,0x10,L_92e650
L_92e640:
	ld r1,[r13, 0x10]
L_92e644:
	ld.as r10,[gp,0x38]
L_92e648:
	bset r10,r10,0x9
L_92e64c:
	st.as r10,[gp,0x38]
	.global L_92e650
L_92e650:
	bset r1,r1,0x2
L_92e654:
	b.d L_92e7a8
L_92e658:
	st r1,[r13, 0x10]
	.global L_92e65c
L_92e65c:
	bl L_92b7c4
L_92e660:
	mov r10,r38
L_92e664:
	mov r6,0x804010
L_92e66c:
	bbit0 r10,0x1e,L_92e704
L_92e670:
	lsr r2,r39,0x8
L_92e674:
	bmsk_s r2,r2,0x5
L_92e676:
	brne r2,0x33,L_92e704
L_92e67a:
	ldb r7,[gp, 0xcc]
L_92e67e:
	ldb r8,[r6, 0xa]
L_92e682:
	brne r7,r8,L_92e704
L_92e686:
	ldb r8,[gp, 0xcd]
L_92e68a:
	ldb r11,[r6, 0xb]
L_92e68e:
	brne r8,r11,L_92e704
L_92e692:
	ldb r9,[gp, 0xce]
L_92e696:
	ldb r0,[r6, 0xc]
L_92e69a:
	brne r0,r9,L_92e704
L_92e69e:
	ldb r10,[gp, 0xcf]
L_92e6a2:
	ldb r7,[r6, 0xd]
L_92e6a6:
	brne r10,r7,L_92e704
L_92e6aa:
	ldb r11,[gp, 0xd0]
L_92e6ae:
	ldb r9,[r6, 0xe]
L_92e6b2:
	brne r11,r9,L_92e704
L_92e6b6:
	ldb_s r0,[gp,0xd1]
L_92e6b8:
	ldb r7,[r6, 0xf]
L_92e6bc:
	brne r0,r7,L_92e704
L_92e6c0:
	mov r0,0x804014
L_92e6c8:
	bl L_930114
L_92e6cc:
	mov r15,0x801458
L_92e6d4:
	brhs.d r0,0x8,L_92e718
L_92e6d8:
	mov_s r1,r0
L_92e6da:
	st_s r1,[r13]
L_92e6dc:
	bl.d L_92b9d0
L_92e6e0:
	mov r0,0x1
L_92e6e4:
	ld r7,[r13, 0x10]
L_92e6e8:
	ld_s r3,[r15,0x78]
L_92e6ea:
	bset r7,r7,0x2
L_92e6ee:
	st r7,[r13, 0x10]
L_92e6f2:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92e6f4:
	bl.d L_9315e8
L_92e6f8:
	st r3,[r15, 0x78]
L_92e6fc:
	b.d L_92e7a8
L_92e700:
	st.as r0,[gp,0x4]
	.global L_92e704
L_92e704:
	mov r5,r38
L_92e708:
	bbit0 r5,0x1c,L_92e728
L_92e70c:
	bl.d L_92fb20
L_92e710:
	ld r0,[r13]
L_92e714:
	b L_92e7a8
	.global L_92e718
L_92e718:
	ld r4,[r15, 0x7c]
L_92e71c:
	add r4,r4,0x1
L_92e720:
	b.d L_92e7a8
L_92e724:
	st r4,[r15, 0x7c]
	.global L_92e728
L_92e728:
	mov_s r2,r39
L_92e72a:
	mov_s r3,r38
L_92e72c:
	lsr r6,r39,0x8
L_92e730:
	bmsk r6,r6,0x5
L_92e734:
	cmp r6,0x8
L_92e738:
	mov r6,0x1
L_92e73c:
	sub.ne r6,r6,r6
L_92e740:
	mov_s r0,0x801ed0
L_92e746:
	ld.as r8,[r0,0x51]
L_92e74a:
	btst_s r2,0x4
L_92e74c:
	btst.ne r3,0xe
L_92e750:
	cmp.ne r6,0x0
L_92e754:
	beq_s L_92e7a8
L_92e756:
	ld r9,[r13]
L_92e75a:
	asl r2,0x1,r9
L_92e762:
	brne r8,0x0,L_92e788
L_92e766:
	mov_s r1,0x3
L_92e768:
	bl.d L_9302a4
L_92e76c:
	asl r2,r2,0x8
L_92e770:
	mov r9,0x80088c
L_92e778:
	ldb r7,[r9, 0x90]
L_92e77c:
	add r7,r7,0x1
L_92e780:
	b.d L_92e7a8
L_92e784:
	stb r7,[r9, 0x90]
	.global L_92e788
L_92e788:
	mov r1,0x4
L_92e78c:
	bl.d L_9302a4
L_92e790:
	asl r2,r2,0x8
L_92e794:
	mov r1,0x8016f0
L_92e79c:
	ldb r8,[r1, -0xfc]
L_92e7a0:
	add r8,r8,0x1
L_92e7a4:
	stb r8,[r1, -0xfc]
	.global L_92e7a8
L_92e7a8:
	cmp r16,0x0
L_92e7ac:
	ld r4,[r14, 0x20]
L_92e7b0:
	bne.d L_92eaac
L_92e7b4:
	st r4,[r13, 0xc]
L_92e7b8:
	ld r10,[r14, 0xc]
L_92e7bc:
	cmp r4,0x9
L_92e7c0:
	bclr r10,r10,0x0
L_92e7c4:
	bhi.d L_92ea64
L_92e7c8:
	st r10,[r14, 0xc]
L_92e7cc:
	ld.as r8,[0x800bf0,r4]
L_92e7d4:
	j [r8]
