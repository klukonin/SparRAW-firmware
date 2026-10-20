/* mac_mode_program_c @ 0x929190, 760 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_kick
 * Зовёт сам: direct_tx_step, hw_modes_mac__switch_core, mac_mode__wait_ppdu_and_kick_e, uc_send_evt__bf_done, uc_send_evt__new_link, uc_wait_event1_or_event4
 */
	.section .text.mac_mode_program_c,"ax",@progbits
	.global mac_mode_program_c
mac_mode_program_c:
	.global L_929190
L_929190:
	st.a r13,[sp,-0xc]
L_929194:
	st blink,[sp, 0x4]
L_929198:
	st_s r14,[sp,0x8]
L_92919a:
	sub_s sp,sp,0x20
L_92919c:
	mov_s r13,r0
L_92919e:
	mov_s r14,0x0
L_9291a0:
	mov_s r2,0x2011000
L_9291a6:
	mov_s r32,r2
L_9291a8:
	st.ab r2,[r25,0x4]
L_9291ac:
	bclr r25,r25,0xa
L_9291b0:
	mov_s r0,0x3d000400
L_9291b6:
	mov_s r32,r0
L_9291b8:
	st.ab r0,[r25,0x4]
L_9291bc:
	bclr r25,r25,0xa
L_9291c0:
	b L_929204
	.global L_9291c4
L_9291c4:
	lsr r4,r38,0x8
L_9291c8:
	bmsk r4,r4,0x2
L_9291cc:
	stb r4,[r13]
	.global L_9291d0
L_9291d0:
	ldw r5,[r0, 0x12]
L_9291d4:
	bmsk r5,r5,0x1
L_9291d8:
	stb r5,[r13, 0x8]
L_9291dc:
	ldw r6,[r0, 0x10]
L_9291e0:
	lsr r6,r6,0xa
L_9291e4:
	stb r6,[r13, 0x9]
L_9291e8:
	ldb r7,[r0, 0x13]
L_9291ec:
	lsr r7,r7,0x6
L_9291f0:
	stb r7,[r13, 0xa]
L_9291f4:
	ldb_s r2,[r0,0x13]
L_9291f6:
	bmsk_s r2,r2,0x5
L_9291f8:
	stb r2,[r13, 0xb]
L_9291fc:
	ldb.x r7,[r0, 0x14]
L_929200:
	stb r7,[r13, 0x10]
	.global L_929204
L_929204:
	mov_s r0,0x0
L_929206:
	bset_s r0,r0,0xc
L_929208:
	mov r1,0x80
L_92920c:
	bl.d L_9318f4
L_929210:
	mov r2,0x0
L_929214:
	mov r11,r54
L_929218:
	bbit1 r11,0x7,L_9292e8
L_92921c:
	mov r5,r42
L_929220:
	bbit0 r5,0xc,L_929204
L_929224:
	bl.d L_92964c
L_929228:
	mov r0,r13
L_92922c:
	breq_s r0,0,L_929204
L_92922e:
	ld.as r3,[gp,-0x11]
L_929232:
	and r3,r3,0xffff0fff
L_92923a:
	or r6,r3,0xd000
L_929242:
	or r3,r3,0x1d00d000
L_92924a:
	st.as r6,[gp,-0x11]
L_92924e:
	mov_s r32,r3
L_929250:
	st.ab r3,[r25,0x4]
L_929254:
	bclr r25,r25,0xa
L_929258:
	nop_s
L_92925a:
	nop_s
L_92925c:
	nop_s
L_92925e:
	lsr r7,r40,0x9
L_929262:
	bmsk r7,r7,0xa
L_929266:
	sub r4,r7,0x800
L_92926e:
	cmp r7,0x3ff
L_929272:
	mov.hi r6,r4
L_929276:
	mov.ls r6,r7
L_92927a:
	cmp_s r14,0x0
L_92927c:
	mov_s r0,0x804010
L_929282:
	beq L_929450
L_929286:
	ldb r5,[r13, 0x12]
L_92928a:
	ldb r8,[r0, 0xa]
L_92928e:
	brne r5,r8,L_929204
L_929292:
	ldb r7,[r13, 0x13]
L_929296:
	ldb_s r3,[r0,0xb]
L_929298:
	brne r3,r7,L_929204
L_92929c:
	ldb r8,[r13, 0x14]
L_9292a0:
	ldb r5,[r0, 0xc]
L_9292a4:
	brne r8,r5,L_929204
L_9292a8:
	ldb r9,[r13, 0x15]
L_9292ac:
	ldb_s r2,[r0,0xd]
L_9292ae:
	brne r2,r9,L_929204
L_9292b2:
	ldb r10,[r13, 0x16]
L_9292b6:
	ldb r4,[r0, 0xe]
L_9292ba:
	brne r10,r4,L_929204
L_9292be:
	ldb r11,[r13, 0x17]
L_9292c2:
	ldb r10,[r0, 0xf]
L_9292c6:
	brne r11,r10,L_929204
L_9292ca:
	ld r7,[r13, 0x4]
L_9292ce:
	brge r7,r6,L_929204
L_9292d2:
	st r6,[r13, 0x4]
L_9292d6:
	ldw_s r1,[r0,0x12]
L_9292d8:
	bmsk_s r1,r1,0x1
L_9292da:
	stb_s r1,[r13,0x8]
L_9292dc:
	ldw_s r0,[r0,0x10]
L_9292de:
	lsr_s r0,r0,0xa
L_9292e0:
	b.d L_929204
L_9292e4:
	stb r0,[r13, 0x9]
	.global L_9292e8
L_9292e8:
	mov_s r3,0x49000080
L_9292ee:
	mov_s r32,r3
L_9292f0:
	st.ab r3,[r25,0x4]
L_9292f4:
	bclr r25,r25,0xa
L_9292f8:
	bl L_927944
L_9292fc:
	mov_s r1,0x4d
L_9292fe:
	asl_s r1,r1,0x18
L_929300:
	mov r32,r1
L_929304:
	st.ab r1,[r25,0x4]
L_929308:
	bclr r25,r25,0xa
L_92930c:
	nop_s
L_92930e:
	nop_s
L_929310:
	nop_s
L_929312:
	mov r7,r55
L_929316:
	cmp r7,0x700
L_92931a:
	blo_s L_92932c
	.global L_92931c
L_92931c:
	add_s sp,sp,0x20
L_92931e:
	ld blink,[sp, 0x4]
L_929322:
	ld_s r14,[sp,0x8]
L_929324:
	j.d [blink]
L_929328:
	ld.ab r13,[sp,0xc]
	.global L_92932c
L_92932c:
	cmp r7,0x0
L_929330:
	cmp.ne r14,0x0
L_929334:
	beq_s L_92931c
L_929336:
	mov r8,0x801e68
L_92933e:
	ldb r3,[r8, 0x2a]
L_929342:
	ld.as r9,[gp,-0x4]
L_929346:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_929348:
	stb r3,[r8, 0x2a]
L_92934c:
	ldb r4,[r13, 0x9]
L_929350:
	or r5,r9,0x30
L_929354:
	asl r4,r4,0x8
L_929358:
	ldb_s r1,[r13]
L_92935a:
	or r4,r4,r5
L_92935e:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_929360:
	add3 r1,r1,r1
L_929364:
	add r3,r1,0x801198
L_92936c:
	st r4,[r3]
L_929370:
	bl.d L_929488
L_929374:
	mov r0,r13
L_929378:
	mov r9,0x3c000004
L_929380:
	mov r32,r9
L_929384:
	st.ab r9,[r25,0x4]
L_929388:
	bclr r25,r25,0xa
L_92938c:
	mov r7,0x801e68
L_929394:
	ldw r5,[r7, 0x28]
L_929398:
	mov_s r2,0x0
L_92939a:
	add r5,r5,0x1
L_92939e:
	stw r5,[r7, 0x28]
L_9293a2:
	ldb r9,[r13]
L_9293a6:
	mov r10,0x3
L_9293aa:
	stb r9,[sp, 0x4]
L_9293ae:
	stb r10,[sp, 0x1a]
L_9293b2:
	stb r2,[sp, 0x1b]
L_9293b6:
	ldw r8,[r13, 0x12]
L_9293ba:
	ldb_s r0,[r13,0xc]
L_9293bc:
	ldw r11,[r13, 0x14]
L_9293c0:
	stw r8,[sp, 0x14]
L_9293c4:
	ldw_s r1,[r13,0x16]
L_9293c6:
	stw r11,[sp, 0x16]
L_9293ca:
	ldb_s r2,[r13,0xb]
L_9293cc:
	stw r1,[sp, 0x18]
L_9293d0:
	stb r2,[sp, 0x6]
L_9293d4:
	ld_s r1,[sp,0x4]
L_9293d6:
	ld_s r2,[sp,0x8]
L_9293d8:
	ld r5,[sp, 0x14]
L_9293dc:
	ld r6,[sp, 0x18]
L_9293e0:
	ld r7,[sp, 0x1c]
L_9293e4:
	mov r3,0x1
L_9293e8:
	breq.d r9,0x8,L_9293f8
L_9293ec:
	mov r4,0x2
L_9293f0:
	bl L_925bd0
L_9293f4:
	b L_9293fc
	.global L_9293f8
L_9293f8:
	bl L_925c6c
	.global L_9293fc
L_9293fc:
	ld.as r6,[gp,-0x11]
L_929400:
	and r6,r6,0xfff0ffff
L_929408:
	or r3,r6,0x50000
L_929410:
	or r6,r6,0x1d050000
L_929418:
	st.as r3,[gp,-0x11]
L_92941c:
	mov r32,r6
L_929420:
	st.ab r6,[r25,0x4]
L_929424:
	bclr r25,r25,0xa
L_929428:
	nop_s
L_92942a:
	nop_s
L_92942c:
	mov 0x0,0x0
	.global L_929430
L_929430:
	bmsk.f 0x0,r47,0x3
L_929434:
	beq_s L_929430
L_929436:
	and.f 0x0,r47,0xf0
L_92943e:
	beq_s L_929430
L_929440:
	and.f 0x0,r47,0xf000
L_929448:
	beq L_929430
L_92944c:
	b L_92931c
	.global L_929450
L_929450:
	ldw r11,[r0, 0xa]
L_929454:
	ldw r10,[r0, 0xc]
L_929458:
	ldw r9,[r0, 0xe]
L_92945c:
	stw r11,[r13, 0x12]
L_929460:
	stw r10,[r13, 0x14]
L_929464:
	stw r9,[r13, 0x16]
L_929468:
	st r6,[r13, 0x4]
L_92946c:
	mov r9,r38
L_929470:
	btst r9,0xb
L_929474:
	bne.d L_9291c4
L_929478:
	mov r14,0x1
L_92947c:
	mov r6,0x8
L_929480:
	b.d L_9291d0
L_929484:
	stb r6,[r13]
