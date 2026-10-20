/* abft_responder_worker @ 0x92c594, 636 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_dti__kick_worker
 * Зовёт сам: abft__arm_response_window, abft_responder__tx_ssw, abft_responder_substep, hw_modes_mac__switch_core, tx_ctx__next_slot, uc_send_evt__bf_done, uc_send_evt__new_link, uc_spin_until_event4, uc_wait_event1_or_event4
 */
	.section .text.abft_responder_worker,"ax",@progbits
	.global abft_responder_worker
abft_responder_worker:
	.global L_92c594
L_92c594:
	st.a r13,[sp,-0x10]
L_92c598:
	st blink,[sp, 0x4]
L_92c59c:
	st_s r14,[sp,0x8]
L_92c59e:
	st_s r15,[sp,0xc]
L_92c5a0:
	sub sp,sp,0x20
L_92c5a4:
	bl.d L_927944
L_92c5a8:
	mov r14,r0
L_92c5ac:
	mov r7,0x3d000002
L_92c5b4:
	mov r32,r7
L_92c5b8:
	st.ab r7,[r25,0x4]
L_92c5bc:
	bclr r25,r25,0xa
L_92c5c0:
	mov r15,0x180
L_92c5c4:
	mov r9,0x801e68
L_92c5cc:
	ldb r1,[r9, 0x3]
L_92c5d0:
	ldb r7,[r9, 0x2]
L_92c5d4:
	asl r1,r1,0x8
L_92c5d8:
	or r7,r7,r1
L_92c5dc:
	lsr r7,r7,0x7
L_92c5e0:
	bmsk r7,r7,0x2
L_92c5e4:
	ld.as r6,[gp,-0x11]
L_92c5e8:
	add r13,r7,0x1
L_92c5ec:
	and r6,r6,0xfff0ffff
L_92c5f4:
	bset r10,r6,0x11
L_92c5f8:
	st.as r10,[gp,-0x11]
L_92c5fc:
	or r6,r6,0x1d020000
L_92c604:
	mov r32,r6
L_92c608:
	st.ab r6,[r25,0x4]
L_92c60c:
	bclr r25,r25,0xa
L_92c610:
	nop_s
L_92c612:
	nop_s
L_92c614:
	mov 0x0,0x0
L_92c618:
	mov r8,r47
L_92c61c:
	mulu64 r8,r13
L_92c620:
	mov r0,mhi
L_92c624:
	b.d L_92c64c
L_92c628:
	mov r13,r0
	.global L_92c62c
L_92c62c:
	bl L_925bd0
	.global L_92c630
L_92c630:
	mov r15,0x100
	.global L_92c634
L_92c634:
	bl L_927944
L_92c638:
	mov r5,0x3d000002
L_92c640:
	mov r32,r5
L_92c644:
	st.ab r5,[r25,0x4]
L_92c648:
	bclr r25,r25,0xa
	.global L_92c64c
L_92c64c:
	bl.d L_9317f0
L_92c650:
	mov r0,r15
L_92c654:
	mov r11,r54
L_92c658:
	bbit0 r11,0x8,L_92c694
L_92c65c:
	mov r9,0x3d000400
L_92c664:
	mov r32,r9
L_92c668:
	st.ab r9,[r25,0x4]
L_92c66c:
	bclr r25,r25,0xa
L_92c670:
	mov r8,0x3d000200
L_92c678:
	mov r32,r8
L_92c67c:
	st.ab r8,[r25,0x4]
L_92c680:
	bclr r25,r25,0xa
L_92c684:
	add_s sp,sp,0x20
L_92c686:
	ld blink,[sp, 0x4]
L_92c68a:
	ld_s r14,[sp,0x8]
L_92c68c:
	ld_s r15,[sp,0xc]
L_92c68e:
	j_s.d [blink]
L_92c690:
	ld.ab r13,[sp,0x10]
	.global L_92c694
L_92c694:
	mov r6,0x49000080
L_92c69c:
	mov r32,r6
L_92c6a0:
	st.ab r6,[r25,0x4]
L_92c6a4:
	bclr r25,r25,0xa
L_92c6a8:
	bl L_92c810
L_92c6ac:
	brne r0,0x0,L_92c64c
L_92c6b0:
	cmp_s r13,0x0
L_92c6b2:
	bne_s L_92c808
L_92c6b4:
	bl.d L_933414
L_92c6b8:
	mov r0,0x1
L_92c6bc:
	mov r1,r0
L_92c6c0:
	bl.d L_92ca3c
L_92c6c4:
	mov r0,r14
L_92c6c8:
	breq.d r0,0x0,L_92c7a0
L_92c6cc:
	mov r13,0x0
	.global L_92c6d0
L_92c6d0:
	mov_s r0,0x0
L_92c6d2:
	bset_s r0,r0,0xc
L_92c6d4:
	mov r1,0x80
L_92c6d8:
	bl.d L_9318f4
L_92c6dc:
	mov r2,0x0
L_92c6e0:
	mov r9,r42
L_92c6e4:
	bbit0 r9,0xc,L_92c798
L_92c6e8:
	bl.d L_92c844
L_92c6ec:
	mov r0,r14
L_92c6f0:
	breq_s r0,0,L_92c6d0
L_92c6f2:
	ld.as r1,[gp,-0x4]
L_92c6f6:
	ldb r6,[r14, 0xe]
L_92c6fa:
	or r7,r1,0x30
L_92c6fe:
	asl r6,r6,0x8
L_92c702:
	ldb_s r2,[r14,0xd]
L_92c704:
	or r6,r6,r7
L_92c708:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_92c70a:
	add3_s r2,r2,r2
L_92c70c:
	add r3,r2,0x801198
L_92c714:
	st r6,[r3]
L_92c718:
	mov_s r3,0x801e68
L_92c71e:
	ldw r5,[r3, 0x1c]
L_92c722:
	mov r4,0x80208c
L_92c72a:
	add r5,r5,0x1
L_92c72e:
	ldw r6,[r4, 0xc]
L_92c732:
	stw r5,[r3, 0x1c]
L_92c736:
	stw r6,[r4]
L_92c73a:
	ldb r9,[r14, 0xd]
L_92c73e:
	mov_s r2,0x0
L_92c740:
	stb r9,[sp, 0x4]
L_92c744:
	mov_s r0,0x4
L_92c746:
	stb r0,[sp, 0x1a]
L_92c74a:
	stb r2,[sp, 0x1b]
L_92c74e:
	ldw r5,[r3, 0x10]
L_92c752:
	ldb_s r0,[r14,0x10]
L_92c754:
	ldw r7,[r3, 0x12]
L_92c758:
	stw r5,[sp, 0x14]
L_92c75c:
	ldw r8,[r3, 0x14]
L_92c760:
	stw r7,[sp, 0x16]
L_92c764:
	ldb r4,[r14, 0xe]
L_92c768:
	stw r8,[sp, 0x18]
L_92c76c:
	stb r4,[sp, 0x6]
L_92c770:
	ld_s r1,[sp,0x4]
L_92c772:
	ld_s r2,[sp,0x8]
L_92c774:
	ld r5,[sp, 0x14]
L_92c778:
	ld r6,[sp, 0x18]
L_92c77c:
	ld r7,[sp, 0x1c]
L_92c780:
	cmp r9,0x8
L_92c784:
	mov r3,0x1
L_92c788:
	bne.d L_92c62c
L_92c78c:
	mov r4,0x2
L_92c790:
	bl L_925c6c
L_92c794:
	b L_92c630
	.global L_92c798
L_92c798:
	mov r3,r54
L_92c79c:
	bbit0 r3,0x7,L_92c6d0
	.global L_92c7a0
L_92c7a0:
	mov r5,0x801e68
L_92c7a8:
	ldw r4,[r5, 0x1e]
L_92c7ac:
	ldb r13,[r5, 0x2]
L_92c7b0:
	add r4,r4,0x1
L_92c7b4:
	ldb r0,[r5, 0x3]
L_92c7b8:
	stw r4,[r5, 0x1e]
L_92c7bc:
	asl_s r0,r0,0x8
L_92c7be:
	or_s r13,r13,r0
L_92c7c0:
	lsr_s r13,r13,0x7
L_92c7c2:
	bmsk_s r13,r13,0x2
L_92c7c4:
	ld.as r3,[gp,-0x11]
L_92c7c8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92c7ca:
	and r3,r3,0xfff0ffff
L_92c7d2:
	bset r2,r3,0x11
L_92c7d6:
	st.as r2,[gp,-0x11]
L_92c7da:
	or r3,r3,0x1d020000
L_92c7e2:
	mov_s r32,r3
L_92c7e4:
	st.ab r3,[r25,0x4]
L_92c7e8:
	bclr r25,r25,0xa
L_92c7ec:
	nop_s
L_92c7ee:
	nop_s
L_92c7f0:
	mov 0x0,0x0
L_92c7f4:
	mov r4,r47
L_92c7f8:
	mulu64 r4,r13
L_92c7fc:
	mov r0,mhi
L_92c800:
	b.d L_92c634
L_92c804:
	mov r13,r0
	.global L_92c808
L_92c808:
	/* b.d 0x0092c64c */
	.byte 0x45,0x06,0xef,0xff
L_92c80c:
	/* _sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_92c80e:
	nop_s
