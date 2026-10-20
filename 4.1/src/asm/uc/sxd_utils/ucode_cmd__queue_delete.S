/* ucode_cmd__queue_delete @ 0x9354d4, 784 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/sxd_utils.h
 *   txrx_api_cmd_handler.c
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, bit_scan_msb, mac__program_tx_with_qid, mac_counter__program_400b, stub_ret_9329f8, tail_basic_if__alloc_evt_slot, tx_ctx__next_slot, uc_read_tsf_lo, uc_send_event, uc_sysassert
 * Глобалы (через gp): 0x80056c, 0x800610, 0x800614
 */
	.section .text.ucode_cmd__queue_delete,"ax",@progbits
	.global ucode_cmd__queue_delete
ucode_cmd__queue_delete:
	.global L_9354d4
L_9354d4:
	push_s blink
L_9354d6:
	bl L_92020c
L_9354da:
	mov_s r14,r0
L_9354dc:
	bl.d L_933414
L_9354e0:
	mov_s r0,0x1
L_9354e2:
	mov_s r13,r0
L_9354e4:
	ldb_s r0,[r14]
L_9354e6:
	st_s r0,[r13,0x4]
L_9354e8:
	ld_s r0,[r14,0x8]
L_9354ea:
	cmp_s r0,0x4
L_9354ec:
	bne_s L_9355e8
L_9354ee:
	mov_s r0,0x886500
L_9354f4:
	ld_s r0,[r0,0x6c]
L_9354f6:
	ldb_s r15,[r14]
L_9354f8:
	bmsk.f 0x0,r0,0x3
L_9354fc:
	ldb r16,[r14, 0x1]
L_935500:
	beq_s L_935514
L_935502:
	mov_s r0,blink
L_935504:
	mov_s r2,0x1001714
L_93550a:
	mov_s r1,0x3
L_93550c:
	bl.d L_925548
L_935510:
	mov r3,0x154
	.global L_935514
L_935514:
	mov_s r0,0x1c000006
L_93551a:
	mov_s r32,r0
L_93551c:
	st.ab r0,[r25,0x4]
L_935520:
	bclr r25,r25,0xa
L_935524:
	asl_s r0,r15,0x4
L_935526:
	or r0,r0,0x46004008
L_93552e:
	mov_s r32,r0
L_935530:
	st.ab r0,[r25,0x4]
L_935534:
	bclr r25,r25,0xa
L_935538:
	mov_s r1,0x801458
L_93553e:
	ld_s r0,[r1,0x14]
L_935540:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935542:
	st_s r0,[r1,0x14]
	.global L_935544
L_935544:
	mov_s r0,r53
L_935546:
	bbit0 r0,0x2,L_935544
L_93554a:
	ld_s r0,[gp,-0x44]
L_93554c:
	and r0,r0,0xfff0ffff
L_935554:
	bset r1,r0,0x10
L_935558:
	or r0,r0,0x1d010000
L_935560:
	st.as r1,[gp,-0x11]
L_935564:
	mov_s r32,r0
L_935566:
	st.ab r0,[r25,0x4]
L_93556a:
	bclr r25,r25,0xa
L_93556e:
	nop_s
L_935570:
	nop_s
L_935572:
	nop_s
	.global L_935574
L_935574:
	mov_s r0,r47
L_935576:
	bbit1 r0,0x0,L_935574
L_93557a:
	asl r0,r16,0x8
L_93557e:
	bset_s r0,r0,0x1a
L_935580:
	bset_s r0,r0,0x1e
L_935582:
	or_s r15,r15,r0
L_935584:
	bset_s r15,r15,0x13
L_935586:
	bset_s r15,r15,0x15
L_935588:
	mov_s r32,r15
L_93558a:
	st.ab r15,[r25,0x4]
L_93558e:
	bclr r25,r25,0xa
L_935592:
	mov_s r0,0x45000001
L_935598:
	mov_s r32,r0
L_93559a:
	st.ab r0,[r25,0x4]
L_93559e:
	bclr r25,r25,0xa
L_9355a2:
	mov_s r0,0x460001f1
L_9355a8:
	mov_s r32,r0
L_9355aa:
	st.ab r0,[r25,0x4]
L_9355ae:
	bclr r25,r25,0xa
L_9355b2:
	bl.d L_92a36c
L_9355b6:
	ld_s r0,[r13,0x4]
	.global L_9355b8
L_9355b8:
	mov_s r0,r43
L_9355ba:
	bbit0 r0,0x1f,L_9355b8
L_9355be:
	mov_s r0,r51
L_9355c0:
	bmsk r1,r0,0x3
L_9355c4:
	st.as r1,[gp,0x3a]
L_9355c8:
	lsr_s r0,r0,0x4
L_9355ca:
	st.as r0,[gp,0x3b]
	.global L_9355ce
L_9355ce:
	mov_s r0,r45
L_9355d0:
	bbit0 r0,0x1f,L_9355ce
L_9355d4:
	mov_s r0,r43
L_9355d6:
	btst_s r0,0x1b
L_9355d8:
	beq L_9357e0
L_9355dc:
	ldb_s r0,[r14,0x1]
L_9355de:
	bl.d L_9329f8
L_9355e2:
	ldb_s r1,[r14]
L_9355e4:
	b L_9357e0
	.global L_9355e8
L_9355e8:
	brne r0,0x3,L_935634
L_9355ec:
	ldb_s r0,[r14]
L_9355ee:
	bl.d L_934cdc
L_9355f2:
	ldb_s r1,[r14,0x1]
L_9355f4:
	bl.d L_92a36c
L_9355f8:
	ld_s r0,[r13,0x4]
	.global L_9355fa
L_9355fa:
	mov_s r0,r43
L_9355fc:
	bbit0 r0,0x1f,L_9355fa
L_935600:
	mov_s r0,r51
L_935602:
	bmsk r1,r0,0x3
L_935606:
	st.as r1,[gp,0x3a]
L_93560a:
	lsr_s r0,r0,0x4
L_93560c:
	st.as r0,[gp,0x3b]
	.global L_935610
L_935610:
	mov_s r0,r45
L_935612:
	bbit0 r0,0x1f,L_935610
L_935616:
	ld_s r0,[r14,0x4]
L_935618:
	cmp_s r0,0x3
L_93561a:
	bne_s L_9357e0
L_93561c:
	mov_s r0,r43
L_93561e:
	btst_s r0,0x1b
L_935620:
	beq_s L_9357e0
L_935622:
	mov_s r1,0x8019e8
L_935628:
	ldb_s r2,[r14]
L_93562a:
	ld_s r0,[r1]
L_93562c:
	bset r0,r0,r2
L_935630:
	st_s r0,[r1]
L_935632:
	b_s L_9357e0
	.global L_935634
L_935634:
	brne r0,0x1,L_9356a6
L_935638:
	ld_s r0,[r14,0x10]
L_93563a:
	bbit0 r0,0x1,L_935668
L_93563e:
	ldb_s r0,[r14]
L_935640:
	bl.d L_934cdc
L_935644:
	ldb_s r1,[r14,0x1]
L_935646:
	bl.d L_92a36c
L_93564a:
	ld_s r0,[r13,0x4]
	.global L_93564c
L_93564c:
	mov_s r0,r43
L_93564e:
	bbit0 r0,0x1f,L_93564c
L_935652:
	mov_s r0,r51
L_935654:
	bmsk r1,r0,0x3
L_935658:
	st.as r1,[gp,0x3a]
L_93565c:
	lsr_s r0,r0,0x4
L_93565e:
	st.as r0,[gp,0x3b]
	.global L_935662
L_935662:
	mov_s r0,r45
L_935664:
	bbit0 r0,0x1f,L_935662
	.global L_935668
L_935668:
	ld_s r0,[r14,0x4]
L_93566a:
	brne r0,0x3,L_935688
L_93566e:
	ldb_s r0,[r14,0x1]
L_935670:
	mov_s r1,0x8011ac
L_935676:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935678:
	add3_s r0,r0,r0
L_93567a:
	ld_s r2,[r1,r0]
L_93567c:
	mov_s r1,0x8019e8
L_935682:
	ld_s r0,[r1]
L_935684:
	bic_s r0,r0,r2
L_935686:
	st_s r0,[r1]
	.global L_935688
L_935688:
	bl L_9259c0
L_93568c:
	mov_s r13,r0
L_93568e:
	ldb_s r0,[r14]
L_935690:
	bl.d L_9315e8
L_935694:
	st_s r0,[r13]
L_935696:
	st_s r0,[r13,0x4]
L_935698:
	mov_s r3,0x0
L_93569a:
	st_s r3,[r13,0x8]
L_93569c:
	mov_s r0,r13
L_93569e:
	mov_s r1,0x8
L_9356a0:
	bl.d L_925dd8
L_9356a4:
	mov_s r2,0xc
	.global L_9356a6
L_9356a6:
	ld_s r2,[r14,0x8]
L_9356a8:
	ldb_s r0,[r14]
L_9356aa:
	cmp_s r2,0x1
L_9356ac:
	mov_s r2,0x1
L_9356ae:
	ld_s r1,[r14,0xc]
L_9356b0:
	sub_s.ne r2,r2,r2
L_9356b2:
	lsr_s r1,r1,0x6
L_9356b4:
	bmsk r3,r1,0x0
L_9356b8:
	mov_s r1,0x801130
L_9356be:
	add1_s r0,r0,r0
L_9356c0:
	add_s r0,r0,r1
L_9356c2:
	stb_s r3,[r0]
L_9356c4:
	ld_s r3,[r14,0xc]
L_9356c6:
	ldb_s r0,[r14]
L_9356c8:
	lsr_s r3,r3,0x5
L_9356ca:
	add1_s r0,r0,r0
L_9356cc:
	add_s r13,r1,0x1
L_9356ce:
	add_s r13,r13,r0
L_9356d0:
	bmsk_s r3,r3,0x0
L_9356d2:
	stb_s r3,[r13]
L_9356d4:
	ldb_s r0,[r14]
L_9356d6:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_9356d8:
	add1_s r0,r0,r0
L_9356da:
	ldb_s r3,[r14,0x1]
L_9356dc:
	add_s r1,r1,r0
L_9356de:
	stb_s r3,[r1]
L_9356e0:
	ld_s r0,[r14,0x4]
L_9356e2:
	cmp_s r0,0x0
L_9356e4:
	cmp.ne r0,0x1
L_9356e8:
	beq_s L_935702
L_9356ea:
	breq r0,0x3,L_93571e
L_9356ee:
	mov_s r0,blink
L_9356f0:
	mov_s r2,0x1001830
L_9356f6:
	mov_s r1,0x83
L_9356f8:
	bl.d L_925548
L_9356fc:
	mov r3,0x2cd
L_935700:
	b_s L_9357e0
	.global L_935702
L_935702:
	mov_s r3,0x800414
L_935708:
	ldb_s r0,[r14,0x1]
L_93570a:
	mov_s r1,0x801190
L_935710:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935712:
	add3_s r0,r0,r0
L_935714:
	add r13,r1,0x10
L_935718:
	add_s r13,r13,r0
L_93571a:
	mov_s r0,0x4
L_93571c:
	b_s L_935748
	.global L_93571e
L_93571e:
	ldb_s r0,[r14,0x1]
L_935720:
	mov_s r1,0x801190
L_935726:
	add r13,r1,0x14
L_93572a:
	brne r0,0x8,L_935738
L_93572e:
	mov_s r0,0xff
L_935730:
	brne_s r2,0,L_935734
L_935732:
	ldb_s r0,[r14]
	.global L_935734
L_935734:
	st.as r0,[gp,-0x31]
	.global L_935738
L_935738:
	ldb_s r0,[r14,0x1]
L_93573a:
	mov_s r3,0x800424
L_935740:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_935742:
	add3_s r0,r0,r0
L_935744:
	add_s r13,r13,r0
L_935746:
	mov_s r0,0x6
	.global L_935748
L_935748:
	mov_s r5,r0
L_93574a:
	add r16,r1,0x20
L_93574e:
	add r6,r1,0x18
L_935752:
	ldb_s r15,[r14]
L_935754:
	mov r4,0x0
L_935758:
	bset r4,r4,r15
L_93575c:
	breq_s r2,0,L_93576a
L_93575e:
	ld_s r0,[gp,0x44]
L_935760:
	bic r0,r0,r4
L_935764:
	st.as r0,[gp,0x11]
L_935768:
	ldb_s r15,[r14]
	.global L_93576a
L_93576a:
	ld r4,[r3]
L_93576e:
	mov_s r0,0x0
L_935770:
	bset r0,r0,r15
L_935774:
	cmp_s r2,0x0
L_935776:
	mov_s r15,r4
L_935778:
	bic.ne r15,r15,r0
L_93577c:
	or.eq r15,r15,r0
L_935780:
	mov_s r0,0x886d8c
L_935786:
	st_s r15,[r3]
L_935788:
	add2 r0,r0,r5
L_93578c:
	st_s r15,[r0]
L_93578e:
	ldb_s r15,[r14]
L_935790:
	mov_s r3,0x0
L_935792:
	ld_s r0,[r13]
L_935794:
	bset r3,r3,r15
L_935798:
	cmp_s r2,0x0
L_93579a:
	bic.ne r0,r0,r3
L_93579e:
	or.eq r0,r0,r3
L_9357a2:
	st_s r0,[r13]
L_9357a4:
	ldb_s r0,[r14,0x1]
L_9357a6:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9357a8:
	add3_s r0,r0,r0
L_9357aa:
	add_s r1,r1,r0
L_9357ac:
	ld_s r0,[r1,0x10]
L_9357ae:
	ld_s r2,[r1,0x18]
L_9357b0:
	or_s r0,r0,r2
L_9357b2:
	ld_s r2,[r1,0x14]
L_9357b4:
	or_s r0,r0,r2
L_9357b6:
	st_s r0,[r1,0x1c]
L_9357b8:
	ldb_s r0,[r14,0x1]
L_9357ba:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9357bc:
	add3_s r0,r0,r0
L_9357be:
	bl.d L_929ee8
L_9357c2:
	ld r0,[r6,r0]
L_9357c6:
	ldb_s r1,[r14,0x1]
L_9357c8:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_9357ca:
	add3_s r1,r1,r1
L_9357cc:
	add_s r1,r1,r16
L_9357ce:
	st_s r0,[r1]
L_9357d0:
	ld_s r0,[r14,0x8]
L_9357d2:
	brne_s r0,0,L_9357e0
L_9357d4:
	ld_s r0,[r14,0x4]
L_9357d6:
	brne r0,0x3,L_9357e0
L_9357da:
	mov_s r0,0x1
L_9357dc:
	stb r0,[gp, -0xe4]
	.global L_9357e0
L_9357e0:
	b L_920274
