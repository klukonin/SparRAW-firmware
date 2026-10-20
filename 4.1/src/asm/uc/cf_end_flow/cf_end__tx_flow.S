/* cf_end__tx_flow @ 0x924578, 584 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   cf_end_flow.c
 * Зовут его: cf_end_mtp_step, tx_mtp__open_window
 * Зовёт сам: __ld_r17_to_r13_ret_uc, __st_r17_to_r13_uc, cf_end__pulse_883150, cf_end__send_frame, mac__build_tx_common_params, mac__set_duration_us, mac__set_rf_chain_state, rfc_ctrl__switch, tail_uc_wait_two_events, tx__read_tx_result, uc_sleep_until_event, uc_spin_until_event
 */
	.section .text.cf_end__tx_flow,"ax",@progbits
	.global cf_end__tx_flow
cf_end__tx_flow:
	.global L_924578
L_924578:
	push_s blink
L_92457a:
	bl.d L_920208
L_92457e:
	mov_s r1,0x0
L_924580:
	sub_s sp,sp,0xc
L_924582:
	mov_s r14,r0
L_924584:
	mov_s r0,0x8014dc
L_92458a:
	st_s r1,[r0,0x8]
L_92458c:
	mov_s r0,0x0
L_92458e:
	bset_s r0,r0,0x1d
L_924590:
	mov_s r32,r0
L_924592:
	st.ab r0,[r25,0x4]
L_924596:
	bclr r25,r25,0xa
L_92459a:
	mov_s r0,r14
L_92459c:
	mov_s r1,0x0
L_92459e:
	bl.d L_933e3c
L_9245a2:
	mov_s r2,0x1
L_9245a4:
	mov_s r1,0x8014dc
L_9245aa:
	ldw_s r0,[r1,0x2]
L_9245ac:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9245ae:
	stw_s r0,[r1,0x2]
L_9245b0:
	ld_s r0,[gp,-0x48]
L_9245b2:
	or r0,r0,0x27004000
L_9245ba:
	mov_s r32,r0
L_9245bc:
	st.ab r0,[r25,0x4]
L_9245c0:
	bclr r25,r25,0xa
L_9245c4:
	mov_s r0,0x2004000
L_9245ca:
	mov_s r32,r0
L_9245cc:
	st.ab r0,[r25,0x4]
L_9245d0:
	bclr r25,r25,0xa
L_9245d4:
	nop_s
L_9245d6:
	nop_s
L_9245d8:
	nop_s
L_9245da:
	mov_s r0,0x0
L_9245dc:
	bset_s r0,r0,0xe
L_9245de:
	bl.d L_93187c
L_9245e2:
	mov_s r1,0xa
L_9245e4:
	mov_s r0,r42
L_9245e6:
	bbit0 r0,0xe,L_92463e
	.global L_9245ea
L_9245ea:
	mov_s r0,0x0
L_9245ec:
	bl.d L_9317fc
L_9245f0:
	bset_s r0,r0,0xf
L_9245f2:
	ld_s r0,[r14]
L_9245f4:
	mov_s r1,0x801192
L_9245fa:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9245fc:
	add3_s r0,r0,r0
L_9245fe:
	ldw_s r13,[r1,r0]
L_924600:
	lsr_s r13,r13
L_924602:
	ld_s r0,[gp,-0x44]
L_924604:
	bxor r13,r13,0x0
L_924608:
	and r0,r0,0xffff0fff
L_924610:
	bset r1,r0,0xc
L_924614:
	bset_s r1,r1,0xd
L_924616:
	st.as r1,[gp,-0x11]
L_92461a:
	or r0,r0,0x1d003000
L_924622:
	mov_s r32,r0
L_924624:
	st.ab r0,[r25,0x4]
L_924628:
	bclr r25,r25,0xa
L_92462c:
	nop_s
L_92462e:
	nop_s
L_924630:
	nop_s
L_924632:
	extw r0,r40
L_924636:
	bbit1 r13,0x0,L_924650
L_92463a:
	mov_s r1,0x22
L_92463c:
	b_s L_924652
	.global L_92463e
L_92463e:
	mov_s r0,blink
L_924640:
	mov_s r2,0x1001c68
L_924646:
	mov_s r1,0x92
L_924648:
	bl.d L_925548
L_92464c:
	mov_s r3,0x44
L_92464e:
	b_s L_9245ea
	.global L_924650
L_924650:
	mov_s r1,0x17
	.global L_924652
L_924652:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_924654:
	cmp_s r0,r1
L_924656:
	bls L_924728
L_92465a:
	mov_s r0,r42
L_92465c:
	btst_s r0,0x7
L_92465e:
	bne_s L_924728
L_924660:
	btst_s r13,0x0
L_924662:
	mov_s r0,0x22
L_924664:
	mov.ne r0,0x17
L_924668:
	mov_s r17,r0
L_92466a:
	mov_s r0,0x1
L_92466c:
	mov_s r16,r0
L_92466e:
	mov_s r15,0x8014dc
L_924674:
	st_s r0,[r15,0x8]
L_924676:
	bl.d L_9316a8
L_92467a:
	mov_s r0,0x6
L_92467c:
	ldw_s r0,[r15,0x4]
L_92467e:
	mov_s r1,0x801198
L_924684:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924686:
	stw_s r0,[r15,0x4]
L_924688:
	ld_s r0,[r14]
L_92468a:
	bmsk r2,r13,0x0
L_92468e:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_924690:
	add3_s r0,r0,r0
L_924692:
	ld_s r1,[r1,r0]
L_924694:
	mov_s r0,r16
L_924696:
	bl.d L_92bb2c
L_92469a:
	mov_s r3,0x0
L_92469c:
	mov_s r0,0x2008000
L_9246a2:
	mov_s r32,r0
L_9246a4:
	st.ab r0,[r25,0x4]
L_9246a8:
	bclr r25,r25,0xa
L_9246ac:
	bset r0,r17,0x18
L_9246b0:
	bset_s r0,r0,0x1a
L_9246b2:
	bset_s r0,r0,0x1c
L_9246b4:
	mov_s r32,r0
L_9246b6:
	st.ab r0,[r25,0x4]
L_9246ba:
	bclr r25,r25,0xa
L_9246be:
	mov_s r0,0x14000007
L_9246c4:
	mov_s r32,r0
L_9246c6:
	st.ab r0,[r25,0x4]
L_9246ca:
	bclr r25,r25,0xa
L_9246ce:
	mov r4,sp
L_9246d2:
	mov_s r0,r14
L_9246d4:
	bmsk r1,r13,0x0
L_9246d8:
	mov_s r2,0xe
L_9246da:
	bl.d L_933454
L_9246de:
	mov_s r3,0x1
L_9246e0:
	ld_s r0,[gp,-0x48]
L_9246e2:
	or r0,r0,0x27004000
L_9246ea:
	mov_s r32,r0
L_9246ec:
	st.ab r0,[r25,0x4]
L_9246f0:
	bclr r25,r25,0xa
L_9246f4:
	mov_s r0,0x2004000
L_9246fa:
	mov_s r32,r0
L_9246fc:
	st.ab r0,[r25,0x4]
L_924700:
	bclr r25,r25,0xa
L_924704:
	nop_s
L_924706:
	nop_s
L_924708:
	nop_s
L_92470a:
	mov_s r0,0x0
L_92470c:
	bset_s r0,r0,0xe
L_92470e:
	bl.d L_93187c
L_924712:
	mov_s r1,0xa
L_924714:
	bl.d L_926560
L_924718:
	mov_s r0,0x12
L_92471a:
	mov_s r0,r42
L_92471c:
	bbit0 r0,0xe,L_9247ac
	.global L_924720
L_924720:
	mov_s r0,0x0
L_924722:
	bl.d L_9317fc
L_924726:
	bset_s r0,r0,0xf
	.global L_924728
L_924728:
	mov_s r1,0x80087c
L_92472e:
	mov_s r0,0x1
L_924730:
	bl.d L_92b934
L_924734:
	ld_s r1,[r1]
L_924736:
	bl.d L_9316a8
L_92473a:
	mov_s r0,0x6
L_92473c:
	mov_s r0,0x14
L_92473e:
	asl_s r0,r0,0x18
L_924740:
	mov_s r32,r0
L_924742:
	st.ab r0,[r25,0x4]
L_924746:
	bclr r25,r25,0xa
L_92474a:
	ld_s r0,[r14]
L_92474c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92474e:
	add1_s r0,r0,r0
L_924750:
	add_s r0,r0,0x8016d8
L_924756:
	ld_s r1,[r0]
L_924758:
	brne r1,0x2,L_924760
L_92475c:
	mov_s r1,0x1
L_92475e:
	st_s r1,[r0]
	.global L_924760
L_924760:
	mov_s r1,0x80090c
L_924766:
	ldw_s r0,[r1,0x32]
L_924768:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92476a:
	extw_s r0,r0
L_92476c:
	stw_s r0,[r1,0x32]
L_92476e:
	mov_s r0,0x8014dc
L_924774:
	ld_s r0,[r0,0x8]
L_924776:
	breq_s r0,0,L_9247a4
L_924778:
	bl L_92b27c
L_92477c:
	mov_s r0,0x2
L_92477e:
	bl.d L_92b9d0
L_924782:
	mov_s r1,0xff
L_924784:
	bl.d L_9317fc
L_924788:
	mov_s r0,0x80
L_92478a:
	ld_s r0,[gp,-0x3c]
L_92478c:
	breq_s r0,0,L_9247a4
L_92478e:
	mov_s r0,0x1f000601
L_924794:
	mov_s r32,r0
L_924796:
	st.ab r0,[r25,0x4]
L_92479a:
	bclr r25,r25,0xa
L_92479e:
	mov_s r0,0x1
L_9247a0:
	st.as r0,[gp,-0xe]
	.global L_9247a4
L_9247a4:
	mov_s r0,0x1
L_9247a6:
	b.d L_92026c
L_9247aa:
	add_s sp,sp,0xc
	.global L_9247ac
L_9247ac:
	mov_s r0,blink
L_9247ae:
	mov_s r2,0x1001c68
L_9247b4:
	mov_s r1,0x92
L_9247b6:
	bl.d L_925548
L_9247ba:
	mov_s r3,0x65
L_9247bc:
	b_s L_924720
L_9247be:
	nop_s
