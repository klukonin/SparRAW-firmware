/* bcon_txss_sweep_step @ 0x93b430, 1040 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, txss__program_tx_frame
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bcon_txss__program_sector, mac__cmd_29000001, mac__program_rx_window, mac__program_tx_beacon, mac__program_tx_common, mac__select_all_sectors_and_wait, mac__set_rf_chain_state__with_sta_sector, mac_evt__enable_bit_sync, mac_evt__enable_bit_sync_b, mac_evt__select_timer_group
 * Глобалы (через gp): 0x8005f4, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bcon_txss_sweep_step
bcon_txss_sweep_step:
	.global L_93b430
L_93b430:
	push_s blink
L_93b432:
	bl L_920228
L_93b436:
	mov_s r16,r1
L_93b438:
	st.a r2,[sp,-0x18]
L_93b43c:
	mov_s r14,r3
L_93b43e:
	mov r17,r4
L_93b442:
	mov_s r13,r5
L_93b444:
	mov_s r15,0x1
L_93b446:
	breq r1,0x1,L_93b472
L_93b44a:
	mov_s r0,0x802dec
L_93b450:
	ld_s r0,[r0,0x68]
L_93b452:
	bset_s r0,r0,0x18
L_93b454:
	bset_s r0,r0,0x1a
L_93b456:
	bset_s r0,r0,0x1c
L_93b458:
	mov_s r32,r0
L_93b45a:
	st.ab r0,[r25,0x4]
L_93b45e:
	bclr r25,r25,0xa
L_93b462:
	mov_s r0,0x14000007
L_93b468:
	mov_s r32,r0
L_93b46a:
	st.ab r0,[r25,0x4]
L_93b46e:
	bclr r25,r25,0xa
	.global L_93b472
L_93b472:
	mov_s r0,0x802e4c
L_93b478:
	ldb_s r2,[r0,0x10]
L_93b47a:
	or r1,r17,0x2d000000
L_93b482:
	ldb_s r0,[r0,0x11]
L_93b484:
	asl_s r2,r2
L_93b486:
	or_s r1,r1,r2
L_93b488:
	asl_s r0,r0,0xa
L_93b48a:
	or_s r0,r0,r1
L_93b48c:
	mov_s r32,r0
L_93b48e:
	st.ab r0,[r25,0x4]
L_93b492:
	bclr r25,r25,0xa
L_93b496:
	cmp_s r14,0x0
L_93b498:
	jlne [r14]
L_93b49c:
	mov_s r0,0x0
L_93b49e:
	cmp r16,0x5
L_93b4a2:
	st_s r0,[sp,0x4]
L_93b4a4:
	st_s r0,[sp,0x8]
L_93b4a6:
	bne_s L_93b5c4
L_93b4a8:
	brne_s r13,0,L_93b4b0
L_93b4aa:
	bl L_92d8a4
L_93b4ae:
	b_s L_93b4b4
	.global L_93b4b0
L_93b4b0:
	bl L_92d990
	.global L_93b4b4
L_93b4b4:
	ld_s r0,[gp,-0x44]
L_93b4b6:
	and r0,r0,0xffff0fff
L_93b4be:
	bset r1,r0,0xd
L_93b4c2:
	bset_s r1,r1,0xf
L_93b4c4:
	or r0,r0,0x1d00a000
L_93b4cc:
	st.as r1,[gp,-0x11]
L_93b4d0:
	mov_s r32,r0
L_93b4d2:
	st.ab r0,[r25,0x4]
L_93b4d6:
	bclr r25,r25,0xa
L_93b4da:
	bl L_936870
L_93b4de:
	bl L_936520
L_93b4e2:
	mov_s r1,r40
L_93b4e4:
	mov_s r0,r42
L_93b4e6:
	bbit1 r0,0xe,L_93b4ee
L_93b4ea:
	bbit1 r1,0x18,L_93b50a
	.global L_93b4ee
L_93b4ee:
	mov_s r0,0x29000002
L_93b4f4:
	mov_s r32,r0
L_93b4f6:
	st.ab r0,[r25,0x4]
L_93b4fa:
	bclr r25,r25,0xa
	.global L_93b4fe
L_93b4fe:
	mov_s r0,r45
L_93b500:
	bbit0 r0,0x1f,L_93b4fe
L_93b504:
	b.d L_93b83a
L_93b508:
	mov_s r0,0x0
	.global L_93b50a
L_93b50a:
	mov_s r0,0x802e4c
L_93b510:
	ldb_s r2,[r0,0x12]
L_93b512:
	ld_s r0,[gp,-0xc]
L_93b514:
	asl_s r2,r2,0x8
L_93b516:
	or r1,r0,0x30
L_93b51a:
	or_s r1,r1,r2
L_93b51c:
	ld_s r2,[sp,0x4]
L_93b51e:
	mov_s r0,r16
L_93b520:
	bl.d L_92f798
L_93b524:
	ld_s r3,[sp,0x8]
L_93b526:
	bl.d L_936544
L_93b52a:
	mov_s r0,0x6
L_93b52c:
	brne_s r13,0,L_93b54c
L_93b52e:
	mov_s r0,0x14000005
L_93b534:
	mov_s r32,r0
L_93b536:
	st.ab r0,[r25,0x4]
L_93b53a:
	bclr r25,r25,0xa
L_93b53e:
	mov_s r0,0x80
L_93b540:
	bset_s r0,r0,0x19
L_93b542:
	mov_s r32,r0
L_93b544:
	st.ab r0,[r25,0x4]
L_93b548:
	bclr r25,r25,0xa
	.global L_93b54c
L_93b54c:
	mov_s r0,0x2008000
L_93b552:
	mov_s r32,r0
L_93b554:
	st.ab r0,[r25,0x4]
L_93b558:
	bclr r25,r25,0xa
L_93b55c:
	ld_s r0,[gp,0xcc]
L_93b55e:
	and r1,r0,0x10
L_93b562:
	mov_s r0,0x0
L_93b564:
	or.f 0x0,r1,r0
L_93b568:
	beq_s L_93b58a
L_93b56a:
	ld_s r0,[gp,0xe0]
L_93b56c:
	ld.as r1,[gp,0x39]
L_93b570:
	bic r0,r0,-0x3
L_93b574:
	cmp_s r0,0x2
L_93b576:
	mov_s r0,0x1
L_93b578:
	sub_s.ne r0,r0,r0
L_93b57a:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_93b57c:
	or r0,r0,0x19800830
L_93b584:
	asl_s r1,r1,0xe
L_93b586:
	or_s r0,r0,r1
L_93b588:
	b_s L_93b590
	.global L_93b58a
L_93b58a:
	mov_s r0,0x19000001
	.global L_93b590
L_93b590:
	mov_s r32,r0
L_93b592:
	st.ab r0,[r25,0x4]
L_93b596:
	bclr r25,r25,0xa
	.global L_93b59a
L_93b59a:
	mov_s r0,r45
L_93b59c:
	bbit0 r0,0x1f,L_93b59a
L_93b5a0:
	ld_s r0,[gp,0xcc]
L_93b5a2:
	and r1,r0,0x10
L_93b5a6:
	mov_s r0,0x0
L_93b5a8:
	or.f 0x0,r1,r0
L_93b5ac:
	mov_s r0,0x18
L_93b5ae:
	asl.ne r0,r0,0x18
L_93b5b2:
	mov.eq r0,0x18001000
L_93b5ba:
	mov_s r32,r0
L_93b5bc:
	st.ab r0,[r25,0x4]
L_93b5c0:
	bclr r25,r25,0xa
	.global L_93b5c4
L_93b5c4:
	mov_s r0,r45
L_93b5c6:
	bbit0 r0,0x1f,L_93b5c4
L_93b5ca:
	mov_s r0,0x0
L_93b5cc:
	b.d L_93b74a
L_93b5d0:
	st_s r0,[sp,0x10]
	.global L_93b5d2
L_93b5d2:
	mov_s r0,0x38000200
L_93b5d8:
	mov_s r32,r0
L_93b5da:
	st.ab r0,[r25,0x4]
L_93b5de:
	bclr r25,r25,0xa
L_93b5e2:
	mov_s r0,0x36000038
L_93b5e8:
	mov_s r32,r0
L_93b5ea:
	st.ab r0,[r25,0x4]
L_93b5ee:
	bclr r25,r25,0xa
L_93b5f2:
	mov_s r0,0x6000103
	.global L_93b5f8
L_93b5f8:
	mov_s r32,r0
L_93b5fa:
	st.ab r0,[r25,0x4]
L_93b5fe:
	bclr r25,r25,0xa
L_93b602:
	mov_s r0,0x0
L_93b604:
	bl.d L_9366dc
L_93b608:
	bset_s r0,r0,0xf
L_93b60a:
	mov_s r0,0x802e4c
L_93b610:
	ldb_s r2,[r0,0x10]
L_93b612:
	or r1,r17,0x2d000000
L_93b61a:
	ldb_s r0,[r0,0x11]
L_93b61c:
	asl_s r2,r2
L_93b61e:
	or_s r1,r1,r2
L_93b620:
	asl_s r0,r0,0xa
L_93b622:
	or_s r1,r1,r0
L_93b624:
	mov_s r32,r1
L_93b626:
	st.ab r1,[r25,0x4]
L_93b62a:
	bclr r25,r25,0xa
L_93b62e:
	breq_s r13,0,L_93b658
L_93b630:
	mov_s r0,0x802dec
L_93b636:
	ld_s r0,[r0,0x68]
L_93b638:
	bset_s r0,r0,0x18
L_93b63a:
	bset_s r0,r0,0x1a
L_93b63c:
	bset_s r0,r0,0x1c
L_93b63e:
	mov_s r32,r0
L_93b640:
	st.ab r0,[r25,0x4]
L_93b644:
	bclr r25,r25,0xa
L_93b648:
	mov_s r0,0x14000007
L_93b64e:
	mov_s r32,r0
L_93b650:
	st.ab r0,[r25,0x4]
L_93b654:
	bclr r25,r25,0xa
	.global L_93b658
L_93b658:
	cmp_s r14,0x0
L_93b65a:
	jlne [r14]
L_93b65e:
	mov_s r0,0x802e4c
L_93b664:
	ldb_s r1,[r0,0x12]
L_93b666:
	ld_s r0,[gp,-0xc]
L_93b668:
	asl_s r1,r1,0x8
L_93b66a:
	or r0,r0,0x30
L_93b66e:
	or r16,r1,r0
L_93b672:
	bl.d L_9361bc
L_93b676:
	mov_s r0,0x5
L_93b678:
	ld_s r0,[sp,0x10]
L_93b67a:
	breq r0,0x0,L_93b6cc
L_93b67e:
	mov_s r0,0x49010000
L_93b684:
	mov_s r32,r0
L_93b686:
	st.ab r0,[r25,0x4]
L_93b68a:
	bclr r25,r25,0xa
L_93b68e:
	mov_s r0,0x0
L_93b690:
	bl.d L_9366d0
L_93b694:
	bset_s r0,r0,0x10
L_93b696:
	bl.d L_9258e0
L_93b69a:
	mov_s r0,0x3
L_93b69c:
	mov_s r0,0x38000200
L_93b6a2:
	mov_s r32,r0
L_93b6a4:
	st.ab r0,[r25,0x4]
L_93b6a8:
	bclr r25,r25,0xa
L_93b6ac:
	mov_s r0,0x36000038
L_93b6b2:
	mov_s r32,r0
L_93b6b4:
	st.ab r0,[r25,0x4]
L_93b6b8:
	bclr r25,r25,0xa
L_93b6bc:
	mov_s r0,0x6000103
L_93b6c2:
	mov_s r32,r0
L_93b6c4:
	st.ab r0,[r25,0x4]
L_93b6c8:
	bclr r25,r25,0xa
	.global L_93b6cc
L_93b6cc:
	or r0,r16,0x3f000000
L_93b6d4:
	mov_s r32,r0
L_93b6d6:
	st.ab r0,[r25,0x4]
L_93b6da:
	bclr r25,r25,0xa
L_93b6de:
	ld_s r0,[sp,0x4]
L_93b6e0:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93b6e2:
	or r0,r0,0x3e000000
L_93b6ea:
	mov_s r32,r0
L_93b6ec:
	st.ab r0,[r25,0x4]
L_93b6f0:
	bclr r25,r25,0xa
L_93b6f4:
	mov_s r0,0x37000020
L_93b6fa:
	mov_s r32,r0
L_93b6fc:
	st.ab r0,[r25,0x4]
L_93b700:
	bclr r25,r25,0xa
L_93b704:
	mov_s r1,0x8022c8
L_93b70a:
	ld_s r0,[r1,0xc]
L_93b70c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93b70e:
	st_s r0,[r1,0xc]
L_93b710:
	ld_s r0,[gp,0x178]
L_93b712:
	mov_s r1,0x802940
L_93b718:
	bclr_s r0,r0,0x18
L_93b71a:
	ld_s r1,[r1]
L_93b71c:
	bclr_s r0,r0,0x19
L_93b71e:
	asl_s r1,r1,0x18
L_93b720:
	or_s r0,r0,r1
L_93b722:
	st.as r0,[gp,0x5e]
L_93b726:
	mov_s r1,0x889480
L_93b72c:
	st_s r0,[r1,0x8]
L_93b72e:
	mov_s r0,0x801030
L_93b734:
	ldb r1,[r0, 0x50]
L_93b738:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_93b73a:
	add2_s r1,r1,r1
L_93b73c:
	add_s r1,r1,0x801050
L_93b742:
	ldb_s r0,[r1,0x4]
L_93b744:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93b746:
	extb_s r0,r0
L_93b748:
	stb_s r0,[r1,0x4]
	.global L_93b74a
L_93b74a:
	cmp_s r15,0x1
L_93b74c:
	mov.eq r15,0x0
L_93b750:
	beq_s L_93b7f0
L_93b752:
	brne_s r13,0,L_93b75a
L_93b754:
	bl L_92d8a4
L_93b758:
	b_s L_93b75e
	.global L_93b75a
L_93b75a:
	bl L_92d990
	.global L_93b75e
L_93b75e:
	mov_s r0,r43
L_93b760:
	bbit0 r0,0x1f,L_93b75e
L_93b764:
	mov_s r0,r51
L_93b766:
	bmsk r1,r0,0x3
L_93b76a:
	st.as r1,[gp,0x38]
L_93b76e:
	lsr_s r0,r0,0x4
L_93b770:
	st.as r0,[gp,0x39]
L_93b774:
	bl.d L_936544
L_93b778:
	mov_s r0,0x6
L_93b77a:
	mov_s r0,0x2008000
L_93b780:
	mov_s r32,r0
L_93b782:
	st.ab r0,[r25,0x4]
L_93b786:
	bclr r25,r25,0xa
L_93b78a:
	ld_s r0,[gp,0xcc]
L_93b78c:
	and r1,r0,0x10
L_93b790:
	mov_s r0,0x0
L_93b792:
	or.f 0x0,r1,r0
L_93b796:
	beq_s L_93b7b6
L_93b798:
	ld_s r0,[gp,0xe0]
L_93b79a:
	bic r0,r0,-0x3
L_93b79e:
	cmp_s r0,0x2
L_93b7a0:
	mov_s r0,0x1
L_93b7a2:
	sub_s.ne r0,r0,r0
L_93b7a4:
	asl_s r1,r0,0x6
L_93b7a6:
	ld_s r0,[gp,0xe4]
L_93b7a8:
	or r1,r1,0x19800830
L_93b7b0:
	asl_s r0,r0,0xe
L_93b7b2:
	or_s r0,r0,r1
L_93b7b4:
	b_s L_93b7bc
	.global L_93b7b6
L_93b7b6:
	mov_s r0,0x19000001
	.global L_93b7bc
L_93b7bc:
	mov_s r32,r0
L_93b7be:
	st.ab r0,[r25,0x4]
L_93b7c2:
	bclr r25,r25,0xa
	.global L_93b7c6
L_93b7c6:
	mov_s r0,r45
L_93b7c8:
	bbit0 r0,0x1f,L_93b7c6
L_93b7cc:
	ld_s r0,[gp,0xcc]
L_93b7ce:
	and r1,r0,0x10
L_93b7d2:
	mov_s r0,0x0
L_93b7d4:
	or.f 0x0,r1,r0
L_93b7d8:
	mov_s r0,0x18
L_93b7da:
	asl.ne r0,r0,0x18
L_93b7de:
	mov.eq r0,0x18001000
L_93b7e6:
	mov_s r32,r0
L_93b7e8:
	st.ab r0,[r25,0x4]
L_93b7ec:
	bclr r25,r25,0xa
	.global L_93b7f0
L_93b7f0:
	add_s r1,sp,0x10
L_93b7f2:
	bl.d L_935878
L_93b7f6:
	ld_s r0,[sp,0x0]
L_93b7f8:
	breq_s r0,0,L_93b826
L_93b7fa:
	mov_s r0,0x3c000200
L_93b800:
	mov_s r32,r0
L_93b802:
	st.ab r0,[r25,0x4]
L_93b806:
	bclr r25,r25,0xa
L_93b80a:
	ld_s r0,[sp,0x10]
L_93b80c:
	cmp_s r0,0x0
L_93b80e:
	beq L_93b5d2
L_93b812:
	mov_s r0,0x3
L_93b814:
	mov_s r1,0x29
L_93b816:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_93b818:
	bl.d L_934ff0
L_93b81c:
	mov_s r2,0x4
L_93b81e:
	mov_s r0,0x83
L_93b820:
	b.d L_93b5f8
L_93b824:
	asl_s r0,r0,0x19
	.global L_93b826
L_93b826:
	bl L_935928
L_93b82a:
	bl.d L_9258e0
L_93b82e:
	mov_s r0,0x3
L_93b830:
	mov_s r0,0x0
L_93b832:
	bl.d L_9366dc
L_93b836:
	bset_s r0,r0,0xf
L_93b838:
	mov_s r0,0x1
	.global L_93b83a
L_93b83a:
	b.d L_92028c
L_93b83e:
	add_s sp,sp,0x18
