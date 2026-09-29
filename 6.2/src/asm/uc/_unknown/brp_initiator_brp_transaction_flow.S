/* brp_initiator_brp_transaction_flow @ 0x922514, 532 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HH brp_initiator_brp_transaction_flow: failure 1
 *   HH brp_initiator_brp_transaction_flow: failure 2
 *   HH brp_initiator_brp_transaction_flow: failure 3
 *   HH brp_initiator_brp_transaction_flow: failure 4
 *   HH brp_initiator_brp_transaction_flow: failure 5
 * Зовут его: brp_init__flow
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, brp__parse_request_fields, brp__program_and_measure, brp__read_rf_id, brp_init__tx_request, brp_initiator_flow_successful_receive_training, mac__program_4f_52, popcount8, rfc__clear_core_reg1, rfca__select_rf_uc, rx__arm_window
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_initiator_brp_transaction_flow
brp_initiator_brp_transaction_flow:
	.global L_922514
L_922514:
	push_s blink
L_922516:
	bl L_920218
L_92251a:
	mov_s r13,0x800824
L_922520:
	ldb r18,[r13, 0x48]
L_922524:
	mov_s r1,0x802008
L_92252a:
	asl r0,r18,0x2
L_92252e:
	add2_s r0,r0,r0
L_922530:
	ld r21,[r1,r0]
L_922534:
	mov_s r15,0x8006b4
L_92253a:
	bl.d L_92828c
L_92253e:
	ldb_s r0,[r15,0x3]
L_922540:
	mov_s r20,r0
L_922542:
	extw r19,r0
L_922546:
	mov_s r0,0x3a
L_922548:
	bset_s r0,r0,0xd
L_92254a:
	bl.d L_924d8c
L_92254e:
	mov_s r1,0x4
L_922550:
	bl.d L_9364c8
L_922554:
	mov_s r14,0x0
L_922556:
	mov_s r16,r14
L_922558:
	b_s L_922560
	.global L_92255a
L_92255a:
	mov_s r15,0x8006b4
	.global L_922560
L_922560:
	bl L_9229c0
L_922564:
	mov_s r0,0x0
L_922566:
	bl.d L_929f94
L_92256a:
	mov_s r17,r0
L_92256c:
	ld_s r2,[r13,0x4c]
L_92256e:
	ldb_s r0,[r15,0x5]
L_922570:
	breq_s r2,0,L_92259a
L_922572:
	and.f r1,r0,r2
L_922576:
	bne_s L_922586
L_922578:
	norm r15,r2
L_92257c:
	rsub r3,r15,0x1e
L_922580:
	bset r0,r0,r3
L_922584:
	extb_s r0,r0
	.global L_922586
L_922586:
	breq_s r1,0,L_92258e
L_922588:
	norm r1,r1
L_92258c:
	b_s L_92259e
	.global L_92258e
L_92258e:
	norm r2,r2
L_922592:
	rsub r15,r2,0x1e
L_922596:
	extb_s r15,r15
L_922598:
	b_s L_9225a4
	.global L_92259a
L_92259a:
	norm r1,r0
	.global L_92259e
L_92259e:
	rsub r15,r1,0x1e
L_9225a2:
	extb_s r15,r15
	.global L_9225a4
L_9225a4:
	bl.d L_928b8c
L_9225a8:
	mov_s r1,0x0
L_9225aa:
	mov_s r1,0x883b00
L_9225b0:
	ld_s r0,[r1,0x78]
L_9225b2:
	bclr_s r0,r0,0x18
L_9225b4:
	bclr_s r0,r0,0x19
L_9225b6:
	st_s r0,[r1,0x78]
L_9225b8:
	mov_s r0,0x49000040
L_9225be:
	mov_s r32,r0
L_9225c0:
	st.ab r0,[r25,0x4]
L_9225c4:
	bclr r25,r25,0xa
L_9225c8:
	mov_s r0,0x80
L_9225ca:
	bset_s r0,r0,0xc
L_9225cc:
	mov_s r1,0x40
L_9225ce:
	bl.d L_9367e4
L_9225d2:
	mov_s r2,0x0
L_9225d4:
	st r17,[r13, 0x54]
L_9225d8:
	mov_s r0,r42
L_9225da:
	bbit0 r0,0xc,L_92267a
L_9225de:
	bl L_9228d4
L_9225e2:
	mov_s r0,r36
L_9225e4:
	bbit0 r0,0x19,L_922664
L_9225e8:
	bl L_92bdbc
L_9225ec:
	breq r0,0x0,L_922664
L_9225f0:
	mov_s r1,0x802348
L_9225f6:
	ldb_s r0,[r1,0x8]
L_9225f8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9225fa:
	extb_s r0,r0
L_9225fc:
	stb_s r0,[r1,0x8]
L_9225fe:
	bl.d L_92e1e4
L_922602:
	mov_s r0,r18
L_922604:
	mov_s r1,0x800824
L_92260a:
	st_s r0,[r1,0x54]
L_92260c:
	bbit0 r0,0x0,L_922694
L_922610:
	mov_s r0,r18
L_922612:
	mov_s r1,r16
L_922614:
	bl.d L_923678
L_922618:
	mov_s r2,r15
L_92261a:
	breq_s r0,0,L_92263e
L_92261c:
	mov_s r1,0x801ed4
L_922622:
	ldw_s r0,[r1,0x10]
L_922624:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922626:
	extw_s r0,r0
L_922628:
	stw_s r0,[r1,0x10]
L_92262a:
	add r0,r16,0x1
L_92262e:
	extw_s r0,r0
L_922630:
	cmp_s r0,r19
L_922632:
	mov_s r16,r0
L_922634:
	bl.le.d L_922824
L_922638:
	mov.le r0,r15
L_92263c:
	b_s L_922694
	.global L_92263e
L_92263e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_922640:
	extb_s r14,r14
L_922642:
	brne r14,0xa,L_922694
L_922646:
	mov_s r1,0x801ed4
L_92264c:
	ldw_s r0,[r1,0x12]
L_92264e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922650:
	extw_s r0,r0
L_922652:
	stw_s r0,[r1,0x12]
L_922654:
	mov_s r1,0x1000a80
	.global L_92265a
L_92265a:
	bl.d L_92d13c
L_92265e:
	mov_s r0,0x0
L_922660:
	mov_s r13,0x0
L_922662:
	b_s L_9226ea
	.global L_922664
L_922664:
	mov_s r0,r37
L_922666:
	bbit0 r0,0x18,L_922694
L_92266a:
	mov_s r13,0x0
L_92266c:
	mov_s r1,0x1000ab4
L_922672:
	bl.d L_92d13c
L_922676:
	mov_s r0,r13
L_922678:
	b_s L_9226ea
	.global L_92267a
L_92267a:
	mov_s r0,r54
L_92267c:
	bbit0 r0,0x6,L_9226dc
L_922680:
	mov_s r0,0x800824
L_922686:
	ld_s r0,[r0,0x50]
L_922688:
	bbit0 r0,0x0,L_9226be
L_92268c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_92268e:
	extb_s r14,r14
L_922690:
	breq r14,0xa,L_9226a8
	.global L_922694
L_922694:
	mov_s r13,0x800824
L_92269a:
	ld_s r0,[r13,0x50]
L_92269c:
	btst_s r0,0x0
L_92269e:
	bne_s L_92255a
L_9226a0:
	ld_s r0,[r13,0x54]
L_9226a2:
	btst_s r0,0x2
L_9226a4:
	bne_s L_92255a
L_9226a6:
	b_s L_9226d8
	.global L_9226a8
L_9226a8:
	mov_s r1,0x801ed4
L_9226ae:
	ldw_s r0,[r1,0x14]
L_9226b0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9226b2:
	extw_s r0,r0
L_9226b4:
	stw_s r0,[r1,0x14]
L_9226b6:
	mov_s r1,0x1000ae8
L_9226bc:
	b_s L_92265a
	.global L_9226be
L_9226be:
	mov_s r1,0x801ed4
L_9226c4:
	ldw_s r0,[r1,0x16]
L_9226c6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9226c8:
	extw_s r0,r0
L_9226ca:
	stw_s r0,[r1,0x16]
L_9226cc:
	mov_s r1,0x1000b1c
L_9226d2:
	bl.d L_92d13c
L_9226d6:
	mov_s r0,0x0
	.global L_9226d8
L_9226d8:
	mov_s r13,0x1
L_9226da:
	b_s L_9226ea
	.global L_9226dc
L_9226dc:
	mov_s r13,0x0
L_9226de:
	mov_s r1,0x1000b50
L_9226e4:
	bl.d L_92d13c
L_9226e8:
	mov_s r0,0x0
	.global L_9226ea
L_9226ea:
	ldb r14,[r21, 0x24]
L_9226ee:
	bic.f 0x0,r14,0x3
L_9226f2:
	bne_s L_92271c
	.global L_9226f4
L_9226f4:
	mov_s r1,0x883b00
L_9226fa:
	ld_s r0,[r1,0x78]
L_9226fc:
	asl_s r14,r14,0x18
L_9226fe:
	bclr_s r0,r0,0x18
L_922700:
	bclr_s r0,r0,0x19
L_922702:
	or_s r14,r14,r0
L_922704:
	st_s r14,[r1,0x78]
L_922706:
	brlt r20,0x2,L_922716
L_92270a:
	mov_s r0,0x8006b4
L_922710:
	bl.d L_92ed5c
L_922714:
	ldb_s r0,[r0,0x5]
	.global L_922716
L_922716:
	b.d L_92026c
L_92271a:
	mov_s r0,r13
	.global L_92271c
L_92271c:
	mov_s r0,blink
L_92271e:
	bl.d L_926618
L_922722:
	mov_s r1,0xac
L_922724:
	b_s L_9226f4
L_922726:
	nop_s
