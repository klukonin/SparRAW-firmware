/* mac_mode_program_c @ 0x92c09c, 776 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_kick
 * Зовёт сам: direct_tx_step, mac__set_mode_a000, rx__arm_window_c, uc_evt__build_and_post_report, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mode_program_c
mac_mode_program_c:
	.global L_92c09c
L_92c09c:
	st.a r13,[sp,-0x10]
L_92c0a0:
	st blink,[sp, 0x4]
L_92c0a4:
	st_s r14,[sp,0x8]
L_92c0a6:
	st_s r15,[sp,0xc]
L_92c0a8:
	mov_s r14,r0
L_92c0aa:
	mov_s r15,0x0
L_92c0ac:
	mov_s r2,0x2011000
L_92c0b2:
	mov_s r32,r2
L_92c0b4:
	st.ab r2,[r25,0x4]
L_92c0b8:
	bclr r25,r25,0xa
L_92c0bc:
	mov_s r0,0x3d000400
L_92c0c2:
	mov_s r32,r0
L_92c0c4:
	st.ab r0,[r25,0x4]
L_92c0c8:
	bclr r25,r25,0xa
L_92c0cc:
	b L_92c13c
	.global L_92c0d0
L_92c0d0:
	lsr r9,r38,0x8
L_92c0d4:
	bmsk r9,r9,0x2
L_92c0d8:
	stb r9,[r14]
	.global L_92c0dc
L_92c0dc:
	ldw r10,[r13, 0x12]
L_92c0e0:
	mov_s r2,0x857800
L_92c0e6:
	bmsk r10,r10,0x1
L_92c0ea:
	stb r10,[r14, 0x8]
L_92c0ee:
	ldw r7,[r13, 0x10]
L_92c0f2:
	lsr r7,r7,0xa
L_92c0f6:
	stb r7,[r14, 0x9]
L_92c0fa:
	ldb_s r3,[r13,0x13]
L_92c0fc:
	lsr_s r3,r3,0x6
L_92c0fe:
	stb_s r3,[r14,0xa]
L_92c100:
	ldb r10,[r2, -0xc4]
L_92c104:
	ldb r8,[r13, 0x13]
L_92c108:
	brlt.d r10,0x2,L_92c130
L_92c10c:
	bmsk r8,r8,0x5
L_92c110:
	ld r0,[0x801024]
L_92c118:
	ld r11,[r2, -0x50]
L_92c11c:
	lsr_s r0,r0,0x8
L_92c11e:
	bmsk_s r0,r0,0xe
L_92c120:
	add1 r11,r11,r0
L_92c124:
	ldb r11,[r11]
L_92c128:
	add r8,r8,r11
L_92c12c:
	extb r8,r8
	.global L_92c130
L_92c130:
	stb r8,[r14, 0xb]
L_92c134:
	ldb.x r8,[r13, 0x14]
L_92c138:
	stb r8,[r14, 0x10]
	.global L_92c13c
L_92c13c:
	mov_s r0,0x0
L_92c13e:
	bset_s r0,r0,0xc
L_92c140:
	mov r1,0x80
L_92c144:
	bl.d L_9367e4
L_92c148:
	mov r2,0x0
L_92c14c:
	mov r11,r54
L_92c150:
	btst r11,0x7
L_92c154:
	bne_s L_92c230
L_92c156:
	mov_s r1,r42
L_92c158:
	bbit0 r1,0xc,L_92c13c
L_92c15c:
	bl.d L_92c568
L_92c160:
	mov r0,r14
L_92c164:
	breq_s r0,0,L_92c13c
L_92c166:
	ld.as r10,[gp,-0x11]
L_92c16a:
	and r10,r10,0xffff0fff
L_92c172:
	or r2,r10,0xd000
L_92c17a:
	or r1,r10,0x1d00d000
L_92c182:
	st.as r2,[gp,-0x11]
L_92c186:
	mov_s r32,r1
L_92c188:
	st.ab r1,[r25,0x4]
L_92c18c:
	bclr r25,r25,0xa
L_92c190:
	nop_s
L_92c192:
	nop_s
L_92c194:
	nop_s
L_92c196:
	lsr r9,r40,0x9
L_92c19a:
	bmsk r9,r9,0xa
L_92c19e:
	sub r3,r9,0x800
L_92c1a6:
	cmp r9,0x3ff
L_92c1aa:
	mov.hi r0,r3
L_92c1ae:
	mov_s r13,0x804010
L_92c1b4:
	ldw r8,[r13, 0x10]
L_92c1b8:
	mov.ls r0,r9
L_92c1bc:
	bbit0 r8,0x0,L_92c13c
L_92c1c0:
	cmp_s r15,0x0
L_92c1c2:
	beq L_92c370
L_92c1c6:
	ldb r4,[r14, 0x12]
L_92c1ca:
	ldb r5,[r13, 0xa]
L_92c1ce:
	brne r4,r5,L_92c13c
L_92c1d2:
	ldb r5,[r14, 0x13]
L_92c1d6:
	ldb r6,[r13, 0xb]
L_92c1da:
	brne r5,r6,L_92c13c
L_92c1de:
	ldb r6,[r14, 0x14]
L_92c1e2:
	ldb r7,[r13, 0xc]
L_92c1e6:
	brne r6,r7,L_92c13c
L_92c1ea:
	ldb r7,[r14, 0x15]
L_92c1ee:
	ldb_s r2,[r13,0xd]
L_92c1f0:
	brne r2,r7,L_92c13c
L_92c1f4:
	ldb r8,[r14, 0x16]
L_92c1f8:
	ldb r4,[r13, 0xe]
L_92c1fc:
	brne r8,r4,L_92c13c
L_92c200:
	ldb r9,[r14, 0x17]
L_92c204:
	ldb_s r1,[r13,0xf]
L_92c206:
	brne r1,r9,L_92c13c
L_92c20a:
	ld r4,[r14, 0x4]
L_92c20e:
	brge r4,r0,L_92c13c
L_92c212:
	st_s r0,[r14,0x4]
L_92c214:
	ldw r5,[r13, 0x12]
L_92c218:
	bmsk r5,r5,0x1
L_92c21c:
	stb r5,[r14, 0x8]
L_92c220:
	ldw r6,[r13, 0x10]
L_92c224:
	lsr r6,r6,0xa
L_92c228:
	b.d L_92c13c
L_92c22c:
	stb r6,[r14, 0x9]
	.global L_92c230
L_92c230:
	mov_s r3,0x49000080
L_92c236:
	mov_s r32,r3
L_92c238:
	st.ab r3,[r25,0x4]
L_92c23c:
	bclr r25,r25,0xa
L_92c240:
	bl L_92a754
L_92c244:
	mov_s r1,0x4d
L_92c246:
	asl_s r1,r1,0x18
L_92c248:
	mov r32,r1
L_92c24c:
	st.ab r1,[r25,0x4]
L_92c250:
	bclr r25,r25,0xa
L_92c254:
	nop_s
L_92c256:
	nop_s
L_92c258:
	nop_s
L_92c25a:
	mov r7,r55
L_92c25e:
	cmp r7,0x700
L_92c262:
	blo_s L_92c274
	.global L_92c264
L_92c264:
	ld blink,[sp, 0x4]
L_92c268:
	ld_s r14,[sp,0x8]
L_92c26a:
	ld_s r15,[sp,0xc]
L_92c26c:
	j.d [blink]
L_92c270:
	ld.ab r13,[sp,0x10]
	.global L_92c274
L_92c274:
	cmp r7,0x0
L_92c278:
	cmp.ne r15,0x0
L_92c27c:
	beq_s L_92c264
L_92c27e:
	mov r8,0x802f14
L_92c286:
	ldb r1,[r8, 0x2e]
L_92c28a:
	ld.as r9,[gp,-0x3]
L_92c28e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92c290:
	stb r1,[r8, 0x2e]
L_92c294:
	ldb_s r2,[r14,0x9]
L_92c296:
	or r6,r9,0x30
L_92c29a:
	asl_s r2,r2,0x8
L_92c29c:
	or r2,r2,r6
L_92c2a0:
	ldb r4,[r14]
L_92c2a4:
	mov r7,0x80110c
L_92c2ac:
	asl r4,r4,0x4
L_92c2b0:
	add2 r4,r4,r4
L_92c2b4:
	add r4,r4,r7
L_92c2b8:
	st r2,[r4]
L_92c2bc:
	bl.d L_92c3a4
L_92c2c0:
	mov r0,r14
L_92c2c4:
	mov r9,0x3c000004
L_92c2cc:
	mov r32,r9
L_92c2d0:
	st.ab r9,[r25,0x4]
L_92c2d4:
	bclr r25,r25,0xa
L_92c2d8:
	mov r7,0x802f14
L_92c2e0:
	ldw r10,[r7, 0x2c]
L_92c2e4:
	mov r0,r14
L_92c2e8:
	add r10,r10,0x1
L_92c2ec:
	stw r10,[r7, 0x2c]
L_92c2f0:
	bl.d L_93e624
L_92c2f4:
	mov r1,0x1
L_92c2f8:
	ld.as r6,[gp,-0x11]
L_92c2fc:
	and r6,r6,0xfff0ffff
L_92c304:
	or r5,r6,0x50000
L_92c30c:
	or r6,r6,0x1d050000
L_92c314:
	st.as r5,[gp,-0x11]
L_92c318:
	mov r32,r6
L_92c31c:
	st.ab r6,[r25,0x4]
L_92c320:
	bclr r25,r25,0xa
L_92c324:
	nop_s
L_92c326:
	nop_s
L_92c328:
	mov 0x0,0x0
	.global L_92c32c
L_92c32c:
	bmsk.f 0x0,r47,0x3
L_92c330:
	beq_s L_92c32c
L_92c332:
	and.f 0x0,r47,0xf0
L_92c33a:
	beq_s L_92c32c
L_92c33c:
	and.f 0x0,r47,0xf000
L_92c344:
	beq_s L_92c32c
L_92c346:
	ld.as r5,[gp,0x5e]
L_92c34a:
	ld r6,[0x802944]
L_92c352:
	and r5,r5,0xfcffffff
L_92c35a:
	asl r6,r6,0x18
L_92c35e:
	or r6,r6,r5
L_92c362:
	st.as r6,[gp,0x5e]
L_92c366:
	st r6,[0x889488]
L_92c36e:
	b_s L_92c264
	.global L_92c370
L_92c370:
	ldw r11,[r13, 0xa]
L_92c374:
	ldw r10,[r13, 0xc]
L_92c378:
	ldw r9,[r13, 0xe]
L_92c37c:
	stw r11,[r14, 0x12]
L_92c380:
	stw r10,[r14, 0x14]
L_92c384:
	stw r9,[r14, 0x16]
L_92c388:
	st r0,[r14, 0x4]
L_92c38c:
	mov r10,r38
L_92c390:
	btst r10,0xb
L_92c394:
	bne.d L_92c0d0
L_92c398:
	mov_s r15,0x1
L_92c39a:
	mov_s r3,0x8
L_92c39c:
	b.d L_92c0dc
L_92c3a0:
	stb_s r3,[r14]
L_92c3a2:
	nop_s
