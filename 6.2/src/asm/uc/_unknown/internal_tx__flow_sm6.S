/* internal_tx__flow_sm6 @ 0x93d348, 1484 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_isr
 * Зовёт сам: direct_tx__program_cmd34, direct_tx__send_after_delay, gp0__arm_usec, handle_bf_triggers, internal_tx__clear_pending_bit, itx__wait_ack, itx__wait_cts, mac__cmd_29000001, mac__program_rx_window, mac__program_tx_with_rate, mac__select_all_sectors_and_wait, mac__set_rf_chain_state
 * Глобалы (через gp): 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__flow_sm6
internal_tx__flow_sm6:
	.global L_93d348
L_93d348:
	st.a r13,[sp,-0x18]
L_93d34c:
	st blink,[sp, 0x4]
L_93d350:
	st_s r14,[sp,0x8]
L_93d352:
	st_s r15,[sp,0xc]
L_93d354:
	st r16,[sp, 0x10]
L_93d358:
	st r17,[sp, 0x14]
L_93d35c:
	mov_s r14,0x80212c
L_93d362:
	ldb r3,[r14, 0x68]
L_93d366:
	mov_s r15,r0
L_93d368:
	cmp r3,0x0
L_93d36c:
	norm r2,r3
L_93d370:
	beq.d L_93d4b0
L_93d374:
	rsub r16,r2,0x1e
	.global L_93d378
L_93d378:
	ld.as r4,[gp,-0xd]
L_93d37c:
	cmp r4,0x1
L_93d380:
	bl.eq.d L_934e18
L_93d384:
	mov.eq r0,r16
L_93d388:
	bl.d L_9384d4
L_93d38c:
	mov r0,0x1
L_93d390:
	asl r3,r16,0x4
L_93d394:
	mov_s r13,0x0
L_93d396:
	mov_s r17,r0
L_93d398:
	st_s r13,[r0,0x8]
L_93d39a:
	add2_s r3,r3,r3
L_93d39c:
	ld r0,[r3,0x80111c]
L_93d3a4:
	cmp_s r0,0x0
L_93d3a6:
	beq L_93d878
L_93d3aa:
	norm r0,r0
L_93d3ae:
	rsub r5,r0,0x1e
L_93d3b2:
	st r5,[r17, 0x4]
L_93d3b6:
	mov_s r0,r15
L_93d3b8:
	bl.d L_928318
L_93d3bc:
	mov r1,0x28
L_93d3c0:
	mov_s r3,0x15000028
L_93d3c6:
	mov_s r32,r3
L_93d3c8:
	st.ab r3,[r25,0x4]
L_93d3cc:
	bclr r25,r25,0xa
L_93d3d0:
	mov r4,0x14000007
L_93d3d8:
	mov r32,r4
L_93d3dc:
	st.ab r4,[r25,0x4]
L_93d3e0:
	bclr r25,r25,0xa
L_93d3e4:
	mov r0,0x10
L_93d3e8:
	bl.d L_9257a8
L_93d3ec:
	mov r1,r0
L_93d3f0:
	bl.d L_92d8e8
L_93d3f4:
	mov r0,0x0
	.global L_93d3f8
L_93d3f8:
	mov r6,r43
L_93d3fc:
	bbit0 r6,0x1f,L_93d3f8
L_93d400:
	mov r10,r51
L_93d404:
	bmsk r3,r10,0x3
L_93d408:
	st.as r3,[gp,0x38]
L_93d40c:
	lsr r10,r10,0x4
L_93d410:
	st.as r10,[gp,0x39]
	.global L_93d414
L_93d414:
	mov_s r1,r45
L_93d416:
	bbit0 r1,0x1f,L_93d414
L_93d41a:
	mov_s r0,r16
L_93d41c:
	mov r1,0xb
L_93d420:
	bl.d L_938218
L_93d424:
	mov r2,0x0
L_93d428:
	ld.as r5,[gp,-0x11]
L_93d42c:
	and r5,r5,0xffff0fff
L_93d434:
	or r4,r5,0xa000
L_93d43c:
	or r5,r5,0x1d00a000
L_93d444:
	st.as r4,[gp,-0x11]
L_93d448:
	mov r32,r5
L_93d44c:
	st.ab r5,[r25,0x4]
L_93d450:
	bclr r25,r25,0xa
L_93d454:
	bl L_936870
L_93d458:
	bl L_936520
L_93d45c:
	mov r8,r40
L_93d460:
	mov r2,r42
L_93d464:
	bbit1 r2,0xe,L_93d46c
L_93d468:
	bbit1 r8,0x18,L_93d4c0
	.global L_93d46c
L_93d46c:
	mov r6,r45
L_93d470:
	bbit0 r6,0x1f,L_93d46c
L_93d474:
	mov r5,0x29000002
L_93d47c:
	mov r32,r5
L_93d480:
	st.ab r5,[r25,0x4]
L_93d484:
	bclr r25,r25,0xa
L_93d488:
	asl r2,r16,0x2
L_93d48c:
	add2_s r2,r2,r2
L_93d48e:
	add_s r2,r2,0x857e38
L_93d494:
	ldb_s r1,[r2,0x13]
L_93d496:
	ld blink,[sp, 0x4]
L_93d49a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_93d49c:
	stb_s r1,[r2,0x13]
L_93d49e:
	ld_s r14,[sp,0x8]
L_93d4a0:
	ld_s r15,[sp,0xc]
L_93d4a2:
	ld r16,[sp, 0x10]
L_93d4a6:
	ld r17,[sp, 0x14]
L_93d4aa:
	j_s.d [blink]
L_93d4ac:
	ld.ab r13,[sp,0x18]
	.global L_93d4b0
L_93d4b0:
	mov r0,blink
L_93d4b4:
	bl.d L_926618
L_93d4b8:
	mov r1,0x200
L_93d4bc:
	b L_93d378
	.global L_93d4c0
L_93d4c0:
	asl r2,r16,0x4
L_93d4c4:
	add2_s r2,r2,r2
L_93d4c6:
	mov_s r0,0x5
L_93d4c8:
	ld r1,[r2,0x80110c]
L_93d4d0:
	mov r2,0x0
L_93d4d4:
	bl.d L_92f798
L_93d4d8:
	mov r3,r2
L_93d4dc:
	mov r6,0x19000001
L_93d4e4:
	mov r32,r6
L_93d4e8:
	st.ab r6,[r25,0x4]
L_93d4ec:
	bclr r25,r25,0xa
L_93d4f0:
	mov r7,0x18000000
L_93d4f8:
	mov r32,r7
L_93d4fc:
	st.ab r7,[r25,0x4]
L_93d500:
	bclr r25,r25,0xa
L_93d504:
	bl.d L_936544
L_93d508:
	mov r0,0x6
L_93d50c:
	asl r13,r16,0x4
L_93d510:
	add2_s r13,r13,r13
L_93d512:
	add_s r13,r13,0x801104
L_93d518:
	mov r0,0x1
L_93d51c:
	bl.d L_92f42c
L_93d520:
	ld r1,[r13, 0x4]
L_93d524:
	bl L_9364c8
L_93d528:
	st r0,[0x8006e0]
L_93d530:
	bl.d L_9361bc
L_93d534:
	mov r0,0x5
L_93d538:
	ld.as r9,[gp,0x5e]
L_93d53c:
	ld r8,[0x802944]
L_93d544:
	and r9,r9,0xfcffffff
L_93d54c:
	asl r8,r8,0x18
L_93d550:
	or r8,r8,r9
L_93d554:
	st.as r8,[gp,0x5e]
L_93d558:
	st r8,[0x889488]
L_93d560:
	bl.d L_93df4c
L_93d564:
	mov r0,r15
L_93d568:
	cmp_s r0,0x0
L_93d56a:
	beq L_93d78c
L_93d56e:
	mov_s r0,0x1
L_93d570:
	ld_s r1,[r13,0x8]
L_93d572:
	mov_s r2,r0
L_93d574:
	bl.d L_92f798
L_93d578:
	mov r3,0x0
L_93d57c:
	mov_s r0,r17
L_93d57e:
	mov_s r1,0x1
L_93d580:
	mov r2,0x0
L_93d584:
	bl.d L_9396a0
L_93d588:
	mov r3,r2
L_93d58c:
	mov r8,0x20000400
L_93d594:
	mov r32,r8
L_93d598:
	st.ab r8,[r25,0x4]
L_93d59c:
	bclr r25,r25,0xa
L_93d5a0:
	mov r0,r15
L_93d5a4:
	bl.d L_928318
L_93d5a8:
	mov r1,0xc
L_93d5ac:
	mov r9,0x2008000
L_93d5b4:
	mov r32,r9
L_93d5b8:
	st.ab r9,[r25,0x4]
L_93d5bc:
	bclr r25,r25,0xa
L_93d5c0:
	mov_s r0,0x19000001
L_93d5c6:
	mov_s r32,r0
L_93d5c8:
	st.ab r0,[r25,0x4]
L_93d5cc:
	bclr r25,r25,0xa
	.global L_93d5d0
L_93d5d0:
	mov_s r0,r45
L_93d5d2:
	bbit0 r0,0x1f,L_93d5d0
L_93d5d6:
	ldb r8,[r15,0x166]
L_93d5de:
	breq r8,0x0,L_93d5f8
L_93d5e2:
	mov_s r2,0x18000400
L_93d5e8:
	mov r32,r2
L_93d5ec:
	st.ab r2,[r25,0x4]
L_93d5f0:
	bclr r25,r25,0xa
L_93d5f4:
	b L_93d608
	.global L_93d5f8
L_93d5f8:
	mov_s r3,0x18
L_93d5fa:
	asl_s r3,r3,0x18
L_93d5fc:
	mov r32,r3
L_93d600:
	st.ab r3,[r25,0x4]
L_93d604:
	bclr r25,r25,0xa
	.global L_93d608
L_93d608:
	bl.d L_936544
L_93d60c:
	mov r0,0x6
L_93d610:
	asl r1,r16,0x4
L_93d614:
	add2 r1,r1,r1
L_93d618:
	ld r1,[r1,0x801108]
L_93d620:
	bl.d L_92f42c
L_93d624:
	mov r0,0x1
L_93d628:
	bl.d L_9361bc
L_93d62c:
	mov r0,0x5
L_93d630:
	ld.as r6,[gp,0x5e]
L_93d634:
	ld r7,[0x802944]
L_93d63c:
	and r6,r6,0xfcffffff
L_93d644:
	asl r7,r7,0x18
L_93d648:
	or r7,r7,r6
L_93d64c:
	st.as r7,[gp,0x5e]
L_93d650:
	st r7,[0x889488]
L_93d658:
	bl.d L_93dbb0
L_93d65c:
	mov r17,0x200
L_93d660:
	mov r4,0x803180
L_93d668:
	breq r0,0x0,L_93d708
L_93d66c:
	mov r13,0x0
L_93d670:
	stb r13,[r4, -0x74]
L_93d674:
	bl.d L_92bd70
L_93d678:
	mov r0,0x6
L_93d67c:
	bl.d L_92bb94
L_93d680:
	mov r0,0x6
L_93d684:
	add r14,r15,0x200
L_93d68c:
	stb r13,[r14, -0x8c]
L_93d690:
	ldb r5,[0x802194]
L_93d698:
	breq r5,0x0,L_93d6bc
L_93d69c:
	norm r5,r5
L_93d6a0:
	rsub r4,r5,0x1e
L_93d6a4:
	asl r4,r4,0x2
L_93d6a8:
	add2 r4,r4,r4
L_93d6ac:
	add r4,r4,0x857e38
L_93d6b4:
	stb r13,[r4, 0x12]
L_93d6b8:
	stb r13,[r4, 0x13]
	.global L_93d6bc
L_93d6bc:
	ldb r4,[r14, -0x9a]
L_93d6c0:
	cmp r4,0x0
L_93d6c4:
	beq_s L_93d780
L_93d6c6:
	mov_s r1,0x81
L_93d6c8:
	asl_s r1,r1,0x12
L_93d6ca:
	mov_s r32,r1
L_93d6cc:
	st.ab r1,[r25,0x4]
L_93d6d0:
	bclr r25,r25,0xa
L_93d6d4:
	bl.d L_9258e0
L_93d6d8:
	mov r0,0x8
L_93d6dc:
	mov r5,0x49020000
L_93d6e4:
	mov r32,r5
L_93d6e8:
	st.ab r5,[r25,0x4]
L_93d6ec:
	bclr r25,r25,0xa
L_93d6f0:
	mov r5,0x1
L_93d6f4:
	stb r5,[r14, -0x87]
L_93d6f8:
	mov_s r0,r15
L_93d6fa:
	mov_s r1,0x0
L_93d6fc:
	bl.d L_92845c
L_93d700:
	mov r2,0x2
L_93d704:
	b L_93d7a8
	.global L_93d708
L_93d708:
	ldb r3,[r4, -0x74]
L_93d70c:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_93d70e:
	extb_s r3,r3
L_93d710:
	brlt.d r3,0x6,L_93d7a8
L_93d714:
	stb r3,[r4, -0x74]
L_93d718:
	mov r13,0x0
L_93d71c:
	stb r13,[r4, -0x74]
L_93d720:
	bl.d L_92bd70
L_93d724:
	mov r0,0x6
L_93d728:
	bl.d L_92bb94
L_93d72c:
	mov r0,0x6
L_93d730:
	add r14,r15,0x200
L_93d738:
	stb r13,[r14, -0x8c]
L_93d73c:
	ldb r0,[0x802194]
L_93d744:
	breq_s r0,0,L_93d75c
L_93d746:
	norm r0,r0
L_93d74a:
	rsub r1,r0,0x1e
L_93d74e:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93d750:
	add2_s r1,r1,r1
L_93d752:
	add_s r1,r1,0x857e38
L_93d758:
	stb_s r13,[r1,0x12]
L_93d75a:
	stb_s r13,[r1,0x13]
	.global L_93d75c
L_93d75c:
	bl.d L_9258e0
L_93d760:
	mov r0,0x8
L_93d764:
	mov r6,0x49020000
L_93d76c:
	mov r32,r6
L_93d770:
	st.ab r6,[r25,0x4]
L_93d774:
	bclr r25,r25,0xa
L_93d778:
	ldb r7,[r14, -0x9a]
L_93d77c:
	brne r7,0x0,L_93d7a8
	.global L_93d780
L_93d780:
	bl.d L_926774
L_93d784:
	mov r0,r15
L_93d788:
	b L_93d7a8
	.global L_93d78c
L_93d78c:
	asl r0,r16,0x2
L_93d790:
	add2_s r0,r0,r0
L_93d792:
	add_s r0,r0,0x857e38
L_93d798:
	ldb r11,[r0, 0x12]
L_93d79c:
	mov r17,0x200
L_93d7a0:
	add r11,r11,0x1
L_93d7a4:
	stb r11,[r0, 0x12]
	.global L_93d7a8
L_93d7a8:
	mov_s r2,0x0
L_93d7aa:
	bset_s r2,r2,0x1d
L_93d7ac:
	mov r32,r2
L_93d7b0:
	st.ab r2,[r25,0x4]
L_93d7b4:
	bclr r25,r25,0xa
L_93d7b8:
	ld r1,[0x8014a0]
L_93d7c0:
	tst r1,r17
L_93d7c4:
	mov r17,0x8021b8
L_93d7cc:
	beq L_93d7d8
L_93d7d0:
	b.d L_93d7dc
L_93d7d4:
	ldb r5,[r17, 0xa]
	.global L_93d7d8
L_93d7d8:
	ldb r5,[r17, 0x8]
	.global L_93d7dc
L_93d7dc:
	asl r4,r16,0x2
L_93d7e0:
	mov r13,0x857e38
L_93d7e8:
	add2 r4,r4,r4
L_93d7ec:
	add r14,r13,r4
L_93d7f0:
	ldb r7,[r14, 0x12]
L_93d7f4:
	cmp r7,r5
L_93d7f8:
	blt L_93d8dc
L_93d7fc:
	bl.d L_92bd70
L_93d800:
	mov r0,0x6
L_93d804:
	bl.d L_92bb94
L_93d808:
	mov r0,0x6
L_93d80c:
	mov r5,0x0
L_93d810:
	add r15,r15,0x174
L_93d814:
	stb r5,[r15]
L_93d818:
	ldb r1,[0x802194]
L_93d820:
	breq_s r1,0,L_93d83c
L_93d822:
	norm r1,r1
L_93d826:
	rsub r11,r1,0x1e
L_93d82a:
	asl r11,r11,0x2
L_93d82e:
	add2 r11,r11,r11
L_93d832:
	add_s r13,r13,r11
L_93d834:
	stb r5,[r13, 0x12]
L_93d838:
	stb r5,[r13, 0x13]
	.global L_93d83c
L_93d83c:
	ld r9,[r17, 0x20]
L_93d840:
	bbit0 r9,0x5,L_93d854
L_93d844:
	ldb_s r3,[r14,0x11]
L_93d846:
	bset_s r3,r3,0x7
L_93d848:
	stb r3,[r14, 0x11]
L_93d84c:
	stb r5,[r14, 0x12]
L_93d850:
	stb r5,[r14, 0x13]
	.global L_93d854
L_93d854:
	mov r0,r16
L_93d858:
	bl.d L_928750
L_93d85c:
	mov r1,0x2
L_93d860:
	ld blink,[sp, 0x4]
L_93d864:
	ld_s r14,[sp,0x8]
L_93d866:
	ld_s r15,[sp,0xc]
L_93d868:
	ld r16,[sp, 0x10]
L_93d86c:
	ld r17,[sp, 0x14]
L_93d870:
	j.d [blink]
L_93d874:
	ld.ab r13,[sp,0x18]
	.global L_93d878
L_93d878:
	stb r13,[0x80310c]
L_93d880:
	bl.d L_92bd70
L_93d884:
	mov r0,0x6
L_93d888:
	bl.d L_92bb94
L_93d88c:
	mov r0,0x6
L_93d890:
	add r16,r15,0x200
L_93d898:
	stb r13,[r16, -0x8c]
L_93d89c:
	ldb r2,[r14, 0x68]
L_93d8a0:
	breq_s r2,0,L_93d8b8
L_93d8a2:
	norm r2,r2
L_93d8a6:
	rsub r3,r2,0x1e
L_93d8aa:
	/* asl_s r3,r3,0x2 */
	.byte 0x02,0xbb
L_93d8ac:
	add2_s r3,r3,r3
L_93d8ae:
	add_s r3,r3,0x857e38
L_93d8b4:
	stb_s r13,[r3,0x12]
L_93d8b6:
	stb_s r13,[r3,0x13]
	.global L_93d8b8
L_93d8b8:
	bl.d L_9258e0
L_93d8bc:
	mov r0,0x8
L_93d8c0:
	mov r4,0x49020000
L_93d8c8:
	mov r32,r4
L_93d8cc:
	st.ab r4,[r25,0x4]
L_93d8d0:
	bclr r25,r25,0xa
L_93d8d4:
	ldb r3,[r16, -0x9a]
L_93d8d8:
	breq r3,0x0,L_93d8f4
	.global L_93d8dc
L_93d8dc:
	ld blink,[sp, 0x4]
L_93d8e0:
	ld_s r14,[sp,0x8]
L_93d8e2:
	ld_s r15,[sp,0xc]
L_93d8e4:
	ld r16,[sp, 0x10]
L_93d8e8:
	ld r17,[sp, 0x14]
L_93d8ec:
	j.d [blink]
L_93d8f0:
	ld.ab r13,[sp,0x18]
	.global L_93d8f4
L_93d8f4:
	bl.d L_926774
L_93d8f8:
	mov r0,r15
L_93d8fc:
	ld blink,[sp, 0x4]
L_93d900:
	ld_s r14,[sp,0x8]
L_93d902:
	ld_s r15,[sp,0xc]
L_93d904:
	ld r16,[sp, 0x10]
L_93d908:
	ld r17,[sp, 0x14]
L_93d90c:
	j.d [blink]
L_93d910:
	ld.ab r13,[sp,0x18]
