/* abft_responder__respond_flow @ 0x930370, 632 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_ctx__dispatch_by_role
 * Зовёт сам: abft__arm_response_window, abft_resp__parse_fdbk, abft_responder__tx_ssw, mac__set_mode_a000, tx_ctx__alloc_next, uc_evt__build_and_post_report, uc_spin_until_event4, uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abft_responder__respond_flow
abft_responder__respond_flow:
	.global L_930370
L_930370:
	st.a r13,[sp,-0x18]
L_930374:
	st blink,[sp, 0x4]
L_930378:
	st_s r14,[sp,0x8]
L_93037a:
	st_s r15,[sp,0xc]
L_93037c:
	st r16,[sp, 0x10]
L_930380:
	st r17,[sp, 0x14]
L_930384:
	bl.d L_92a754
L_930388:
	mov r13,r0
L_93038c:
	mov r5,0x3d000002
L_930394:
	mov r32,r5
L_930398:
	st.ab r5,[r25,0x4]
L_93039c:
	bclr r25,r25,0xa
L_9303a0:
	mov r17,r54
L_9303a4:
	mov r16,0x180
L_9303a8:
	mov r6,0x802f14
L_9303b0:
	ldb r1,[r6, 0x3]
L_9303b4:
	ldb r3,[r6, 0x2]
L_9303b8:
	asl_s r1,r1,0x8
L_9303ba:
	or_s r3,r3,r1
L_9303bc:
	lsr r3,r3,0x7
L_9303c0:
	ld.as r4,[gp,-0x11]
L_9303c4:
	bmsk r14,r3,0x2
L_9303c8:
	and r4,r4,0xfff0ffff
L_9303d0:
	bset r5,r4,0x11
L_9303d4:
	st.as r5,[gp,-0x11]
L_9303d8:
	or r4,r4,0x1d020000
L_9303e0:
	mov r32,r4
L_9303e4:
	st.ab r4,[r25,0x4]
L_9303e8:
	bclr r25,r25,0xa
L_9303ec:
	nop_s
L_9303ee:
	nop_s
L_9303f0:
	mov 0x0,0x0
L_9303f4:
	mov r5,r47
L_9303f8:
	mulu64 r5,r14
L_9303fc:
	mov r0,mhi
L_930400:
	mov r14,r0
L_930404:
	bbit0.d r17,0x7,L_93044c
L_930408:
	mov r15,0x100
L_93040c:
	brne_s r14,0,L_93044c
L_93040e:
	mov r7,0x802f14
L_930416:
	ldb r3,[r7, 0x3]
L_93041a:
	ldb r6,[r7, 0x2]
L_93041e:
	asl_s r3,r3,0x8
L_930420:
	or r6,r6,r3
L_930424:
	bic.f r6,r6,-0x381
L_930428:
	beq L_930440
L_93042c:
	b.d L_93046c
L_930430:
	mov r14,0x1
	.global L_930434
L_930434:
	sub r14,r14,0x1
	.global L_930438
L_930438:
	b.d L_93046c
L_93043c:
	mov r15,0x100
	.global L_930440
L_930440:
	bl.d L_9366d0
L_930444:
	mov r0,r15
L_930448:
	b L_93046c
	.global L_93044c
L_93044c:
	ldb r5,[gp, -0xef]
L_930450:
	breq r5,0x0,L_93046c
L_930454:
	ldb r4,[gp, -0xe5]
L_930458:
	brhs r4,r14,L_93046c
L_93045c:
	add r4,r4,0x1
L_930460:
	sub r14,r14,r4
L_930464:
	mov r7,0x0
L_930468:
	stb r7,[gp, -0xef]
	.global L_93046c
L_93046c:
	bl.d L_9366d0
L_930470:
	mov r0,r16
L_930474:
	tst r54,r15
L_930478:
	beq L_9304bc
L_93047c:
	mov r5,0x3d000400
L_930484:
	mov r32,r5
L_930488:
	st.ab r5,[r25,0x4]
L_93048c:
	bclr r25,r25,0xa
L_930490:
	mov r4,0x3d000200
L_930498:
	mov r32,r4
L_93049c:
	st.ab r4,[r25,0x4]
L_9304a0:
	bclr r25,r25,0xa
L_9304a4:
	ld blink,[sp, 0x4]
L_9304a8:
	ld_s r14,[sp,0x8]
L_9304aa:
	ld_s r15,[sp,0xc]
L_9304ac:
	ld r16,[sp, 0x10]
L_9304b0:
	ld r17,[sp, 0x14]
L_9304b4:
	j.d [blink]
L_9304b8:
	ld.ab r13,[sp,0x18]
	.global L_9304bc
L_9304bc:
	mov_s r3,0x49000080
L_9304c2:
	mov_s r32,r3
L_9304c4:
	st.ab r3,[r25,0x4]
L_9304c8:
	bclr r25,r25,0xa
L_9304cc:
	bl L_9305e8
L_9304d0:
	brne r0,0x0,L_930438
L_9304d4:
	brne r14,0x0,L_930434
L_9304d8:
	bl.d L_9384d4
L_9304dc:
	mov r0,0x1
L_9304e0:
	mov r1,r0
L_9304e4:
	bl.d L_930908
L_9304e8:
	mov r0,r13
L_9304ec:
	breq.d r0,0x0,L_930578
L_9304f0:
	mov r14,0x0
	.global L_9304f4
L_9304f4:
	mov_s r0,0x0
L_9304f6:
	bset_s r0,r0,0xc
L_9304f8:
	mov r1,0x80
L_9304fc:
	bl.d L_9367e4
L_930500:
	mov r2,0x0
L_930504:
	mov r6,r42
L_930508:
	bbit0 r6,0xc,L_930570
L_93050c:
	bl.d L_93061c
L_930510:
	mov r0,r13
L_930514:
	breq_s r0,0,L_9304f4
L_930516:
	ld.as r8,[gp,-0x3]
L_93051a:
	ldb_s r3,[r13,0xe]
L_93051c:
	or r4,r8,0x30
L_930520:
	asl_s r3,r3,0x8
L_930522:
	or r3,r3,r4
L_930526:
	ldb r10,[r13, 0xd]
L_93052a:
	mov r5,0x80110c
L_930532:
	asl r10,r10,0x4
L_930536:
	add2 r10,r10,r10
L_93053a:
	add r10,r10,r5
L_93053e:
	mov_s r2,0x802f14
L_930544:
	ldw_s r1,[r2,0x20]
L_930546:
	st r3,[r10]
L_93054a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93054c:
	stw_s r1,[r2,0x20]
L_93054e:
	mov_s r2,0x803124
L_930554:
	ldw r9,[r2, 0xc]
L_930558:
	mov r0,r13
L_93055c:
	stw r9,[r2]
L_930560:
	bl.d L_93e624
L_930564:
	mov r1,0x0
L_930568:
	b.d L_9305d0
L_93056c:
	mov r16,0x100
	.global L_930570
L_930570:
	mov r4,r54
L_930574:
	bbit0 r4,0x7,L_9304f4
	.global L_930578
L_930578:
	mov_s r1,0x802f14
L_93057e:
	ldw_s r2,[r1,0x22]
L_930580:
	ldb r11,[r1, 0x2]
L_930584:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_930586:
	ldb_s r0,[r1,0x3]
L_930588:
	stw_s r2,[r1,0x22]
L_93058a:
	asl_s r0,r0,0x8
L_93058c:
	or r11,r11,r0
L_930590:
	lsr r11,r11,0x7
L_930594:
	ld_s r0,[gp,-0x44]
L_930596:
	bmsk r14,r11,0x2
L_93059a:
	and r0,r0,0xfff0ffff
L_9305a2:
	bset r2,r0,0x11
L_9305a6:
	st.as r2,[gp,-0x11]
L_9305aa:
	or r0,r0,0x1d020000
L_9305b2:
	mov_s r32,r0
L_9305b4:
	st.ab r0,[r25,0x4]
L_9305b8:
	bclr r25,r25,0xa
L_9305bc:
	nop_s
L_9305be:
	nop_s
L_9305c0:
	nop_s
L_9305c2:
	mov_s r1,r47
L_9305c4:
	mulu64 r1,r14
L_9305c8:
	mov r0,mhi
L_9305cc:
	mov r14,r0
	.global L_9305d0
L_9305d0:
	bl L_92a754
L_9305d4:
	mov_s r1,0x3d000002
L_9305da:
	mov_s r32,r1
L_9305dc:
	st.ab r1,[r25,0x4]
L_9305e0:
	bclr r25,r25,0xa
L_9305e4:
	b L_930438
