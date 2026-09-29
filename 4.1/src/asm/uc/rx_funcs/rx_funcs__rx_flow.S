/* rx_funcs__rx_flow @ 0x92f280, 2208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_funcs.c
 *   SYSTEM
 * Зовут его: bi_manager__rx_flow_kind0, bi_manager__rx_flow_kind1, bi_manager__rx_flow_kind2
 * Зовёт сам: bf__abort_unexpected, bf_metrics__reset_and_stamp, bf_sm__step_by_state, bf_substate__set, get_g_80051c, mac__load_tx_vector, mac_counter__program_0008, obj__set_field18_from_tbl_801130, ps_awake_peer__send_clear_peer, queue_sel__get_qset4, rate_search__current_mcs, rfc_ctrl__switch
 * Глобалы (через gp): 0x800538, 0x800540, 0x8005b0, 0x8005b8, 0x8005d8, 0x800604, 0x800608, 0x800610, 0x800614
 */
	.section .text.rx_funcs__rx_flow,"ax",@progbits
	.global rx_funcs__rx_flow
rx_funcs__rx_flow:
	.global L_92f280
L_92f280:
	st.a r13,[sp,-0x18]
L_92f284:
	st blink,[sp, 0x4]
L_92f288:
	st_s r14,[sp,0x8]
L_92f28a:
	st_s r15,[sp,0xc]
L_92f28c:
	st r16,[sp, 0x10]
L_92f290:
	st r17,[sp, 0x14]
L_92f294:
	mov_s r1,0xeeee08
L_92f29a:
	mov_s r32,r1
L_92f29c:
	st.ab r1,[r25,0x4]
L_92f2a0:
	bclr r25,r25,0xa
L_92f2a4:
	ld r5,[0x8006b4]
L_92f2ac:
	lr r5,[r5]
L_92f2b0:
	bmsk r5,r5,0x17
L_92f2b4:
	mov r32,r5
L_92f2b8:
	st.ab r5,[r25,0x4]
L_92f2bc:
	bclr r25,r25,0xa
L_92f2c0:
	mov r17,0x0
L_92f2c4:
	st.as r17,[gp,-0x1c]
L_92f2c8:
	bl.d L_931f54
L_92f2cc:
	mov r0,r17
L_92f2d0:
	st.as r0,[gp,0x24]
L_92f2d4:
	mov r5,0x4
L_92f2d8:
	st r5,[r0, 0xc]
L_92f2dc:
	st r17,[0x800664]
L_92f2e4:
	mov r11,0x8
L_92f2e8:
	st.as r11,[gp,0x37]
L_92f2ec:
	ld r11,[0x801ee8]
L_92f2f4:
	stb r17,[gp, -0xfc]
L_92f2f8:
	stb r17,[gp, -0xfb]
L_92f2fc:
	breq.d r11,0x0,L_92f318
L_92f300:
	st.as r17,[gp,0x38]
L_92f304:
	mov_s r0,blink
L_92f306:
	mov_s r2,0x1000ecc
L_92f30c:
	mov_s r1,0xa1
L_92f30e:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_92f310:
	bl.d L_925548
L_92f314:
	mov r3,0x162
	.global L_92f318
L_92f318:
	mov_s r2,0x20c0080
L_92f31e:
	mov_s r32,r2
L_92f320:
	st.ab r2,[r25,0x4]
L_92f324:
	bclr r25,r25,0xa
L_92f328:
	mov_s r1,0x490001c1
L_92f32e:
	mov_s r32,r1
L_92f330:
	st.ab r1,[r25,0x4]
L_92f334:
	bclr r25,r25,0xa
L_92f338:
	mov_s r2,0x14
L_92f33a:
	asl_s r2,r2,0x18
L_92f33c:
	mov r32,r2
L_92f340:
	st.ab r2,[r25,0x4]
L_92f344:
	bclr r25,r25,0xa
L_92f348:
	mov r15,0x1
L_92f34c:
	bl.d L_933414
L_92f350:
	mov r0,r15
L_92f354:
	ld.as r1,[gp,-0xc]
L_92f358:
	mov_s r14,0x801a18
L_92f35e:
	ld r4,[r14, 0x60]
L_92f362:
	mov_s r2,0xff
L_92f364:
	st r1,[r4, 0x28]
L_92f368:
	mov_s r13,0x801418
L_92f36e:
	st_s r2,[r13,0x4]
L_92f370:
	mov_s r2,0x8
L_92f372:
	st_s r2,[r13]
L_92f374:
	bl.d L_92ce9c
L_92f378:
	st r17,[r13, 0x10]
L_92f37c:
	ld.as r2,[gp,0x38]
L_92f380:
	and.f 0x0,r2,0x3000000
L_92f388:
	beq_s L_92f3d0
L_92f38a:
	btst_s r2,0x18
L_92f38c:
	mov r13,0x2
L_92f390:
	bne.d L_92f39c
L_92f394:
	mov.ne r13,r17
L_92f398:
	bbit1 r2,0x19,L_92f3b0
	.global L_92f39c
L_92f39c:
	breq r13,0x2,L_92f3b8
	.global L_92f3a0
L_92f3a0:
	mov r7,0x0
L_92f3a4:
	st.as r7,[gp,0x37]
L_92f3a8:
	b.d L_92fb08
L_92f3ac:
	st.as r7,[gp,0x38]
	.global L_92f3b0
L_92f3b0:
	b.d L_92f3a0
L_92f3b4:
	mov r13,r15
	.global L_92f3b8
L_92f3b8:
	mov_s r0,blink
L_92f3ba:
	mov_s r2,0x1000ecc
L_92f3c0:
	mov r1,0x3e
L_92f3c4:
	bl.d L_925548
L_92f3c8:
	mov r3,0x143
L_92f3cc:
	b L_92f3a0
	.global L_92f3d0
L_92f3d0:
	mov_s r3,0x80
L_92f3d2:
	bset_s r3,r3,0x19
L_92f3d4:
	mov r32,r3
L_92f3d8:
	st.ab r3,[r25,0x4]
L_92f3dc:
	bclr r25,r25,0xa
L_92f3e0:
	ld r8,[r14, 0x60]
L_92f3e4:
	mov r4,0x801190
L_92f3ec:
	ld r3,[r8]
L_92f3f0:
	/* asl_s r3,r3,0x3 */
	.byte 0x03,0xbb
L_92f3f2:
	add3_s r3,r3,r3
L_92f3f4:
	add r2,r4,r3
L_92f3f8:
	add r3,r3,r4
L_92f3fc:
	ld r6,[r2, 0x18]
L_92f400:
	ld r5,[r3, 0x14]
L_92f404:
	add r4,r4,0x20
L_92f408:
	or r5,r5,r6
L_92f40c:
	st r5,[0x886d98]
L_92f414:
	ld r6,[r14, 0x60]
L_92f418:
	ld r5,[r6]
L_92f41c:
	asl r5,r5,0x3
L_92f420:
	add3 r5,r5,r5
L_92f424:
	ld r6,[r4,r5]
L_92f428:
	or r6,r6,0x12000000
L_92f430:
	mov r32,r6
L_92f434:
	st.ab r6,[r25,0x4]
L_92f438:
	bclr r25,r25,0xa
L_92f43c:
	ld r7,[r13, 0x10]
L_92f440:
	btst r7,0x2
L_92f444:
	beq L_92f554
L_92f448:
	ld.as r9,[gp,-0x36]
L_92f44c:
	and r9,r9,0xfffff0ff
L_92f454:
	bset r9,r9,0x1b
L_92f458:
	mov r32,r9
L_92f45c:
	st.ab r9,[r25,0x4]
L_92f460:
	bclr r25,r25,0xa
L_92f464:
	ld r9,[r13]
L_92f468:
	asl r9,r9,0x3
L_92f46c:
	add3 r9,r9,r9
L_92f470:
	add r9,r9,0x801190
L_92f478:
	ldb r8,[r9, 0x47]
L_92f47c:
	breq.d r8,0x0,L_92f4a0
L_92f480:
	mov r17,0x1
L_92f484:
	bl.d L_926d08
L_92f488:
	add r0,r9,0x34
L_92f48c:
	ld r6,[0x801a78]
L_92f494:
	ld r5,[r6, 0xc]
L_92f498:
	bset r5,r5,0xb
L_92f49c:
	st r5,[r6, 0xc]
	.global L_92f4a0
L_92f4a0:
	mov r4,0x20000400
L_92f4a8:
	mov r32,r4
L_92f4ac:
	st.ab r4,[r25,0x4]
L_92f4b0:
	bclr r25,r25,0xa
L_92f4b4:
	b L_92f4c0
	.global L_92f4b8
L_92f4b8:
	ld_s r0,[gp,0xe0]
L_92f4ba:
	bset_s r0,r0,0xa
L_92f4bc:
	st.as r0,[gp,0x38]
	.global L_92f4c0
L_92f4c0:
	mov_s r13,0x801418
L_92f4c6:
	ld_s r1,[r13,0x10]
L_92f4c8:
	bbit0 r1,0x1,L_92f4f0
L_92f4cc:
	ld r0,[0x801a78]
L_92f4d4:
	bl L_933568
L_92f4d8:
	ld r7,[r13, 0x10]
L_92f4dc:
	mov r8,0x1
L_92f4e0:
	bclr r7,r7,0x1
L_92f4e4:
	st r7,[r13, 0x10]
L_92f4e8:
	st r8,[0x800664]
	.global L_92f4f0
L_92f4f0:
	bl L_9315e8
L_92f4f4:
	ld.as r11,[gp,0x4]
L_92f4f8:
	ld.as r10,[gp,-0x5]
L_92f4fc:
	sub r0,r0,r11
L_92f500:
	brhs.d r10,r0,L_92f510
L_92f504:
	ld.as r1,[gp,0x38]
L_92f508:
	bset r1,r1,0x10
L_92f50c:
	st.as r1,[gp,0x38]
	.global L_92f510
L_92f510:
	and.f 0x0,r1,0x10600
L_92f518:
	beq L_92f5d8
L_92f51c:
	ldb r7,[gp, -0xe7]
L_92f520:
	brlt r7,0x2,L_92f540
L_92f524:
	bl.d L_92c30c
L_92f528:
	ld r0,[r13]
L_92f52c:
	brne_s r0,0,L_92f540
L_92f52e:
	ld_s r0,[r13]
L_92f530:
	ldb r4,[0x801034]
L_92f538:
	btst r4,r0
L_92f53c:
	bl.ne L_925cdc
	.global L_92f540
L_92f540:
	mov r5,0x20000000
L_92f548:
	mov r32,r5
L_92f54c:
	st.ab r5,[r25,0x4]
L_92f550:
	bclr r25,r25,0xa
	.global L_92f554
L_92f554:
	ldw_s r0,[gp,0xdc]
L_92f556:
	or r0,r0,0xcb0000
L_92f55e:
	mov_s r32,r0
L_92f560:
	st.ab r0,[r25,0x4]
L_92f564:
	bclr r25,r25,0xa
L_92f568:
	ld.as r7,[gp,0x37]
L_92f56c:
	lsr r7,r7,0x10
L_92f570:
	or r7,r7,0xcb0000
L_92f578:
	mov r32,r7
L_92f57c:
	st.ab r7,[r25,0x4]
L_92f580:
	bclr r25,r25,0xa
L_92f584:
	ldw.as r8,[gp,0x70]
L_92f588:
	or r8,r8,0xcb0000
L_92f590:
	mov r32,r8
L_92f594:
	st.ab r8,[r25,0x4]
L_92f598:
	bclr r25,r25,0xa
L_92f59c:
	ld.as r9,[gp,0x38]
L_92f5a0:
	lsr r9,r9,0x10
L_92f5a4:
	or r9,r9,0xcb0000
L_92f5ac:
	mov r32,r9
L_92f5b0:
	st.ab r9,[r25,0x4]
L_92f5b4:
	bclr r25,r25,0xa
L_92f5b8:
	mov r13,0x801038
L_92f5c0:
	ld r5,[r13]
L_92f5c4:
	bic.f r5,r5,-0x222
L_92f5c8:
	bne L_92f830
	.global L_92f5cc
L_92f5cc:
	mov r13,0x801418
L_92f5d4:
	b L_92f8bc
	.global L_92f5d8
L_92f5d8:
	mov_s r3,0x2080002
L_92f5de:
	mov_s r32,r3
L_92f5e0:
	st.ab r3,[r25,0x4]
L_92f5e4:
	bclr r25,r25,0xa
L_92f5e8:
	mov_s r14,0x801a18
L_92f5ee:
	ld_s r0,[r14,0x60]
L_92f5f0:
	mov r15,0x0
L_92f5f4:
	ld.a r16,[r0,0x4]
L_92f5f8:
	bl.d L_92b4b4
L_92f5fc:
	st.as r15,[gp,-0x1]
L_92f600:
	cmp r0,0x0
L_92f604:
	bne.d L_92f734
L_92f608:
	ld r4,[r14, 0x60]
	.global L_92f60c
L_92f60c:
	mov_s r2,0x13
L_92f60e:
	st r2,[r4, 0x14]
L_92f612:
	ld_s r0,[r14,0x60]
L_92f614:
	ld r10,[r0, 0x4]
L_92f618:
	add1 r10,r10,r10
L_92f61c:
	ldb r4,[r10,0x801130]
L_92f624:
	breq r4,0x0,L_92f638
L_92f628:
	ld r10,[r0, 0x14]
L_92f62c:
	bset r10,r10,0x6
L_92f630:
	st r10,[r0, 0x14]
L_92f634:
	ld r0,[r14, 0x60]
	.global L_92f638
L_92f638:
	bl L_937598
L_92f63c:
	bl.d L_931e74
L_92f640:
	ldw.as r0,[gp,-0x11]
L_92f644:
	breq.d r15,0x0,L_92f68c
L_92f648:
	mov r13,r0
	.global L_92f64c
L_92f64c:
	mov r5,r43
L_92f650:
	bbit0 r5,0x1f,L_92f64c
L_92f654:
	mov_s r0,r51
L_92f656:
	bmsk r6,r0,0x3
L_92f65a:
	st.as r6,[gp,0x3a]
L_92f65e:
	lsr_s r0,r0,0x4
L_92f660:
	st.as r0,[gp,0x3b]
L_92f664:
	mov r8,r43
L_92f668:
	bbit0 r8,0x1b,L_92f67c
L_92f66c:
	ld r3,[0x801a78]
L_92f674:
	ld_s r1,[r3,0xc]
L_92f676:
	bset_s r1,r1,0x9
L_92f678:
	st r1,[r3, 0xc]
	.global L_92f67c
L_92f67c:
	mov_s r2,0x1b010000
L_92f682:
	mov_s r32,r2
L_92f684:
	st.ab r2,[r25,0x4]
L_92f688:
	bclr r25,r25,0xa
	.global L_92f68c
L_92f68c:
	cmp_s r13,0x0
L_92f68e:
	beq_s L_92f7b0
L_92f690:
	mov r5,0x4
L_92f694:
	st.as r5,[gp,0x37]
L_92f698:
	mov_s r13,0x801418
L_92f69e:
	ld_s r0,[r13]
L_92f6a0:
	bl.d L_92ce9c
L_92f6a4:
	st r0,[r13, 0x4]
L_92f6a8:
	ld r9,[r13, 0xc]
L_92f6ac:
	cmp r9,0x3
L_92f6b0:
	beq.d L_92f798
L_92f6b4:
	mov r16,0x0
	.global L_92f6b8
L_92f6b8:
	ld_s r2,[r13,0x4]
L_92f6ba:
	ld r11,[r13]
L_92f6be:
	breq r2,r11,L_92f724
L_92f6c2:
	asl r11,r11,0x3
L_92f6c6:
	add3 r11,r11,r11
L_92f6ca:
	mov_s r14,0x801190
L_92f6d0:
	add r11,r11,r14
L_92f6d4:
	ldb r1,[r11, 0x47]
L_92f6d8:
	mov_s r15,0x801a18
L_92f6de:
	breq_s r1,0,L_92f6f0
L_92f6e0:
	bl.d L_926d08
L_92f6e4:
	add r0,r11,0x34
L_92f6e8:
	ld_s r1,[r15,0x60]
L_92f6ea:
	ld_s r0,[r1,0xc]
L_92f6ec:
	bset_s r0,r0,0xb
L_92f6ee:
	st_s r0,[r1,0xc]
	.global L_92f6f0
L_92f6f0:
	ld_s r1,[r15,0x60]
L_92f6f2:
	ld r11,[r1, 0xc]
L_92f6f6:
	bclr r11,r11,0x0
L_92f6fa:
	st r11,[r1, 0xc]
L_92f6fe:
	ld r8,[r13]
L_92f702:
	st r8,[r13, 0x4]
L_92f706:
	asl r8,r8,0x3
L_92f70a:
	add3 r8,r8,r8
L_92f70e:
	add r6,r14,r8
L_92f712:
	ld r2,[r6, 0x18]
L_92f716:
	add_s r14,r14,r8
L_92f718:
	ld_s r1,[r14,0x14]
L_92f71a:
	or_s r1,r1,r2
L_92f71c:
	st r1,[0x886d98]
	.global L_92f724
L_92f724:
	st.as r16,[gp,-0x1c]
L_92f728:
	mov_s r3,r42
L_92f72a:
	btst_s r3,0x7
L_92f72c:
	beq L_92f4c0
L_92f730:
	b L_92f4b8
	.global L_92f734
L_92f734:
	mov_s r3,0x1
L_92f736:
	st.as r3,[gp,-0x1]
L_92f73a:
	ld r13,[r4, 0x4]
L_92f73e:
	cmp_s r13,r16
L_92f740:
	beq_s L_92f60c
L_92f742:
	asl_s r13,r13,0x10
L_92f744:
	bset r13,r13,0x0
L_92f748:
	mov r6,0x1b001111
L_92f750:
	mov r32,r6
L_92f754:
	st.ab r6,[r25,0x4]
L_92f758:
	bclr r25,r25,0xa
L_92f75c:
	or r13,r13,0x16000000
L_92f764:
	mov r32,r13
L_92f768:
	st.ab r13,[r25,0x4]
L_92f76c:
	bclr r25,r25,0xa
L_92f770:
	mov_s r0,0x17
L_92f772:
	asl_s r0,r0,0x18
L_92f774:
	mov r32,r0
L_92f778:
	st.ab r0,[r25,0x4]
L_92f77c:
	bclr r25,r25,0xa
L_92f780:
	nop_s
L_92f782:
	nop_s
L_92f784:
	nop_s
L_92f786:
	ld_s r2,[r14,0x60]
L_92f788:
	mov_s r15,0x1
L_92f78a:
	ld_s r1,[r2,0xc]
L_92f78c:
	bclr_s r1,r1,0x9
L_92f78e:
	st_s r1,[r2,0xc]
L_92f790:
	b.d L_92f60c
L_92f794:
	ld r4,[r14, 0x60]
	.global L_92f798
L_92f798:
	mov r5,0x2000080
L_92f7a0:
	mov r32,r5
L_92f7a4:
	st.ab r5,[r25,0x4]
L_92f7a8:
	bclr r25,r25,0xa
L_92f7ac:
	b L_92f6b8
	.global L_92f7b0
L_92f7b0:
	ldb r1,[0x801a0b]
L_92f7b8:
	ld.as r11,[gp,-0x1c]
L_92f7bc:
	add r1,r1,r11
L_92f7c0:
	st.as r1,[gp,-0x1c]
L_92f7c4:
	brlo.d r1,0x1f,L_92f7d4
L_92f7c8:
	ld.as r11,[gp,0x38]
L_92f7cc:
	bset r11,r11,0x10
L_92f7d0:
	st.as r11,[gp,0x38]
	.global L_92f7d4
L_92f7d4:
	bbit0 r11,0x1,L_92f824
L_92f7d8:
	ld r13,[0x801a78]
L_92f7e0:
	bic r11,r11,0x1f
L_92f7e4:
	bset r11,r11,0x7
L_92f7e8:
	st.as r11,[gp,0x38]
L_92f7ec:
	mov r7,0x0
L_92f7f0:
	stb r7,[gp, -0xe9]
L_92f7f4:
	mov r4,0x31000000
L_92f7fc:
	mov r32,r4
L_92f800:
	st.ab r4,[r25,0x4]
L_92f804:
	bclr r25,r25,0xa
L_92f808:
	ld_s r1,[r13,0xc]
L_92f80a:
	btst_s r1,0x1
L_92f80c:
	mov.ne r0,r13
L_92f810:
	bl.ne.d L_933f90
L_92f814:
	mov.ne r1,0x2
L_92f818:
	mov_s r0,0x801118
L_92f81e:
	ld_s r1,[r0,0xc]
L_92f820:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92f822:
	st_s r1,[r0,0xc]
	.global L_92f824
L_92f824:
	mov_s r3,r42
L_92f826:
	btst_s r3,0x7
L_92f828:
	beq L_92f4c0
L_92f82c:
	b L_92f4b8
	.global L_92f830
L_92f830:
	ld.as r9,[gp,-0x36]
L_92f834:
	and r9,r9,0xfffff0ff
L_92f83c:
	bset r9,r9,0x1b
L_92f840:
	mov r32,r9
L_92f844:
	st.ab r9,[r25,0x4]
L_92f848:
	bclr r25,r25,0xa
L_92f84c:
	ld r10,[r13]
L_92f850:
	mov r17,0x1
L_92f854:
	btst r10,0x0
L_92f858:
	mov r14,0x4
L_92f85c:
	mov.eq r14,0xa
L_92f860:
	bl.d L_931f54
L_92f864:
	mov r0,0x1
L_92f868:
	st.as r0,[gp,0x22]
L_92f86c:
	st_s r14,[r0,0xc]
L_92f86e:
	mov_s r13,0x801418
L_92f874:
	ld r11,[r13]
L_92f878:
	ld.as r1,[gp,0x22]
L_92f87c:
	asl r11,r11,0x2
L_92f880:
	add2 r11,r11,r11
L_92f884:
	ldb r11,[r11,0x857849]
L_92f88c:
	st r11,[r1, 0x10]
L_92f890:
	ld_s r0,[gp,0x18]
L_92f892:
	btst_s r0,0x0
L_92f894:
	beq L_92f9b0
	.global L_92f898
L_92f898:
	ld r0,[r13]
L_92f89c:
	bl.d L_9283dc
L_92f8a0:
	mov r1,r14
L_92f8a4:
	cmp_s r0,0x0
L_92f8a6:
	beq_s L_92f9c8
L_92f8a8:
	ld r0,[r13]
L_92f8ac:
	bl.d L_930dc4
L_92f8b0:
	mov r1,0x0
L_92f8b4:
	bl.d L_9221f8
L_92f8b8:
	ld r0,[r13]
	.global L_92f8bc
L_92f8bc:
	ld_s r0,[gp,0xe0]
L_92f8be:
	bbit1 r0,0x9,L_92f8d4
L_92f8c2:
	mov_s r0,0x14000100
L_92f8c8:
	mov r32,r0
L_92f8cc:
	st.ab r0,[r25,0x4]
L_92f8d0:
	bclr r25,r25,0xa
	.global L_92f8d4
L_92f8d4:
	breq r17,0x0,L_92f908
L_92f8d8:
	ld r2,[0x80099c]
L_92f8e0:
	ld.as r1,[gp,-0x36]
L_92f8e4:
	and_s r2,r2,r1
L_92f8e6:
	bset_s r2,r2,0x1b
L_92f8e8:
	mov r32,r2
L_92f8ec:
	st.ab r2,[r25,0x4]
L_92f8f0:
	bclr r25,r25,0xa
L_92f8f4:
	mov r8,0x2040000
L_92f8fc:
	mov r32,r8
L_92f900:
	st.ab r8,[r25,0x4]
L_92f904:
	bclr r25,r25,0xa
	.global L_92f908
L_92f908:
	ld.as r9,[gp,0x37]
L_92f90c:
	bic.f r9,r9,-0x7e1
L_92f910:
	bne L_92f920
L_92f914:
	mov r10,0x0
L_92f918:
	st.as r10,[gp,0x37]
L_92f91c:
	st.as r10,[gp,0x38]
	.global L_92f920
L_92f920:
	mov_s r14,0x0
L_92f922:
	st_s r14,[r13,0xc]
L_92f924:
	st_s r14,[r13,0x10]
L_92f926:
	mov_s r13,0x801a18
L_92f92c:
	ld_s r1,[r13,0x60]
L_92f92e:
	ld r11,[r1, 0xc]
L_92f932:
	bbit0 r11,0xa,L_92f944
L_92f936:
	mov_s r0,0x801ed0
L_92f93c:
	bl.d L_9268f8
L_92f940:
	ldb r1,[r1]
	.global L_92f944
L_92f944:
	st_s r14,[r13,0xc]
L_92f946:
	st_s r14,[r13,0x3c]
L_92f948:
	mov r9,0x20c0000
L_92f950:
	mov r32,r9
L_92f954:
	st.ab r9,[r25,0x4]
L_92f958:
	bclr r25,r25,0xa
L_92f95c:
	ld r9,[0x800664]
L_92f964:
	breq r9,0x1,L_92f978
L_92f968:
	ldb r6,[gp, -0xfb]
L_92f96c:
	breq r6,0x1,L_92f978
L_92f970:
	ldb_s r0,[gp,-0xfc]
L_92f972:
	cmp_s r0,0x1
L_92f974:
	bne L_92faf4
	.global L_92f978
L_92f978:
	ld r3,[0x801a78]
L_92f980:
	mov r4,0x0
L_92f984:
	ld r14,[r3]
L_92f988:
	mov r7,0x857848
L_92f990:
	asl r10,r14,0x2
L_92f994:
	add2 r10,r10,r10
L_92f998:
	cmp r9,0x0
L_92f99c:
	add r10,r10,r7
L_92f9a0:
	bne.d L_92fa60
L_92f9a4:
	stb r4,[r10]
L_92f9a8:
	b.d L_92fa68
L_92f9ac:
	mov r0,0x1
	.global L_92f9b0
L_92f9b0:
	mov_s r0,blink
L_92f9b2:
	mov_s r2,0x1000ecc
L_92f9b8:
	mov r1,0x3e
L_92f9bc:
	bl.d L_925548
L_92f9c0:
	mov r3,0x271
L_92f9c4:
	b L_92f898
	.global L_92f9c8
L_92f9c8:
	mov r6,0x6000000
L_92f9d0:
	mov r32,r6
L_92f9d4:
	st.ab r6,[r25,0x4]
L_92f9d8:
	bclr r25,r25,0xa
L_92f9dc:
	nop_s
L_92f9de:
	nop_s
L_92f9e0:
	nop_s
L_92f9e2:
	mov_s r3,0x3800033f
L_92f9e8:
	mov r32,r3
L_92f9ec:
	st.ab r3,[r25,0x4]
L_92f9f0:
	bclr r25,r25,0xa
L_92f9f4:
	bl L_9377bc
L_92f9f8:
	ldw.as r10,[gp,0x58]
L_92f9fc:
	ldw r1,[0x801a08]
L_92fa04:
	breq r1,r10,L_92fa34
L_92fa08:
	stw.as r1,[gp,0x58]
L_92fa0c:
	or r1,r1,0x1730000
L_92fa14:
	st r1,[0x886d00]
L_92fa1c:
	sync
L_92fa20:
	mov r4,0x38000200
L_92fa28:
	mov r32,r4
L_92fa2c:
	st.ab r4,[r25,0x4]
L_92fa30:
	bclr r25,r25,0xa
	.global L_92fa34
L_92fa34:
	nop_s
L_92fa36:
	nop_s
L_92fa38:
	mov 0x0,0x0
L_92fa3c:
	mov r7,0x1f000601
L_92fa44:
	mov r32,r7
L_92fa48:
	st.ab r7,[r25,0x4]
L_92fa4c:
	bclr r25,r25,0xa
L_92fa50:
	mov r0,0x3
L_92fa54:
	bl.d L_92b9d0
L_92fa58:
	mov r1,0xff
L_92fa5c:
	b L_92f5cc
	.global L_92fa60
L_92fa60:
	bl.d L_92c278
L_92fa64:
	mov r0,r14
	.global L_92fa68
L_92fa68:
	ld.as r9,[gp,0x24]
L_92fa6c:
	mov_s r13,0x801118
L_92fa72:
	st r0,[r9, 0x18]
L_92fa76:
	ldw r0,[0x800930]
L_92fa7e:
	ld.as r10,[gp,0x24]
L_92fa82:
	mov r11,0x800fb0
L_92fa8a:
	st r0,[r10, 0x20]
L_92fa8e:
	ld_s r2,[r13]
L_92fa90:
	ld.as r1,[gp,0x24]
L_92fa94:
	st_s r2,[r1,0x24]
L_92fa96:
	ld_s r3,[r13,0x4]
L_92fa98:
	ld.as r7,[gp,0x24]
L_92fa9c:
	st r3,[r7, 0x28]
L_92faa0:
	ld r4,[r13, 0x8]
L_92faa4:
	ld.as r2,[gp,0x24]
L_92faa8:
	st r4,[r2, 0x2c]
L_92faac:
	ld r6,[r13, 0xc]
L_92fab0:
	ld.as r8,[gp,0x24]
L_92fab4:
	st r6,[r8, 0x30]
L_92fab8:
	ldb r3,[r11]
L_92fabc:
	ld.as r10,[gp,0x24]
L_92fac0:
	st r3,[r10, 0x34]
L_92fac4:
	ldb r5,[r11, 0x1]
L_92fac8:
	ld.as r1,[gp,0x24]
L_92facc:
	st r5,[r1, 0x38]
L_92fad0:
	bl.d L_931ef8
L_92fad4:
	mov r0,0x0
L_92fad8:
	ld_s r3,[r13,0x14]
L_92fada:
	breq_s r3,0,L_92faf0
L_92fadc:
	mov_s r2,0x857000
L_92fae2:
	add2_s r2,r2,r14
L_92fae4:
	ld.as r10,[r2,0x67]
L_92fae8:
	add r10,r10,0x1
L_92faec:
	st.as r10,[r2,0x67]
	.global L_92faf0
L_92faf0:
	bl L_9374b4
	.global L_92faf4
L_92faf4:
	bl.d L_9377bc
L_92faf8:
	mov r13,0x2
L_92fafc:
	mov r0,r13
L_92fb00:
	bl.d L_92b9d0
L_92fb04:
	mov r1,0xff
	.global L_92fb08
L_92fb08:
	ld blink,[sp, 0x4]
L_92fb0c:
	mov_s r0,r13
L_92fb0e:
	ld_s r14,[sp,0x8]
L_92fb10:
	ld_s r15,[sp,0xc]
L_92fb12:
	ld r16,[sp, 0x10]
L_92fb16:
	ld r17,[sp, 0x14]
L_92fb1a:
	j_s.d [blink]
L_92fb1c:
	ld.ab r13,[sp,0x18]
