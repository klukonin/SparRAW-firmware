/* tx_flow_size_step @ 0x93448c, 480 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bitstream__push, mac__prepare_txrx_window, memset0_words_uc, rate_search__pick_tx_params, rx_flow__run, sxd_hal__wait_slot2_busy2, tx_flow_substep, tx_flows__program_mac_tx, tx_mtp__open_window, tx_mtp_queue_gate
 * Глобалы (через gp): 0x800540, 0x8005e0, 0x800608
 */
	.section .text.tx_flow_size_step,"ax",@progbits
	.global tx_flow_size_step
tx_flow_size_step:
	.global L_93448c
L_93448c:
	push_s blink
L_93448e:
	bl.d L_920214
L_934492:
	mov_s r1,0x8
L_934494:
	sub_s sp,sp,0x8
L_934496:
	mov_s r14,r0
L_934498:
	bl.d L_92166c
L_93449c:
	mov_s r0,sp
L_93449e:
	mov_s r13,0x0
L_9344a0:
	b_s L_9345c4
	.global L_9344a2
L_9344a2:
	and.f 0x0,r0,0xe00
L_9344aa:
	bne_s L_9344ec
L_9344ac:
	bmsk.f 0x0,r0,0x4
L_9344b0:
	bne_s L_9345bc
L_9344b2:
	bbit1 r0,0x7,L_9344f4
L_9344b6:
	mov_s r0,0x801a18
L_9344bc:
	bl.d L_933568
L_9344c0:
	ld_s r0,[r0,0x60]
L_9344c2:
	cmp_s r13,0x0
L_9344c4:
	beq_s L_9345ba
L_9344c6:
	ld_s r0,[r14]
L_9344c8:
	mov_s r1,0x8016d8
L_9344ce:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9344d0:
	add1_s r0,r0,r0
L_9344d2:
	ld_s r0,[r1,r0]
L_9344d4:
	sub.f r0,r0,0x0
L_9344d8:
	mov.ne r0,0x1
L_9344dc:
	extb.f 0x0,r0
L_9344e0:
	beq_s L_93459e
L_9344e2:
	mov_s r0,r14
L_9344e4:
	bl.d L_92c44c
L_9344e8:
	mov_s r1,0x0
L_9344ea:
	b_s L_9345b0
	.global L_9344ec
L_9344ec:
	bclr_s r0,r0,0x8
L_9344ee:
	st.as r0,[gp,0x38]
L_9344f2:
	b_s L_9345d2
	.global L_9344f4
L_9344f4:
	ld_s r0,[r14]
L_9344f6:
	mov_s r1,0x8016d8
L_9344fc:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9344fe:
	add1_s r0,r0,r0
L_934500:
	ld_s r0,[r1,r0]
L_934502:
	sub.f r0,r0,0x0
L_934506:
	mov.ne r0,0x1
L_93450a:
	extb.f 0x0,r0
L_93450e:
	bne_s L_93455c
L_934510:
	mov_s r0,0x8009c0
L_934516:
	ld_s r0,[r0,0x8]
L_934518:
	mov_s r3,0x8010e8
L_93451e:
	bbit0 r0,0x9,L_934526
L_934522:
	ldb_s r1,[r3,0x17]
L_934524:
	b_s L_934528
	.global L_934526
L_934526:
	ldb_s r1,[r3,0x15]
	.global L_934528
L_934528:
	mov_s r0,sp
L_93452a:
	mov_s r2,0x1
L_93452c:
	bl.d L_93708c
L_934530:
	ld_s r3,[r3,0x18]
L_934532:
	breq r0,0x1,L_934544
	.global L_934536
L_934536:
	bl L_93413c
L_93453a:
	ld_s r0,[gp,0xe0]
L_93453c:
	bclr_s r0,r0,0x7
L_93453e:
	st.as r0,[gp,0x38]
L_934542:
	b_s L_9345ba
	.global L_934544
L_934544:
	ld_s r0,[gp,0xb8]
L_934546:
	bbit0 r0,0x3,L_93456e
L_93454a:
	ld_s r1,[r14]
L_93454c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93454e:
	add2_s r1,r1,r1
L_934550:
	add_s r1,r1,0x857838
L_934556:
	ldb_s r0,[r1,0x11]
L_934558:
	bset_s r0,r0,0x3
L_93455a:
	b_s L_93459a
	.global L_93455c
L_93455c:
	mov_s r0,r14
L_93455e:
	bl.d L_92c44c
L_934562:
	mov_s r1,0x1
L_934564:
	brne r0,0x2,L_934536
L_934568:
	ld_s r0,[gp,0xb8]
L_93456a:
	bbit1 r0,0x1,L_934578
	.global L_93456e
L_93456e:
	mov_s r0,r14
L_934570:
	bl.d L_9247c0
L_934574:
	mov_s r1,0x1
L_934576:
	b_s L_9345c4
	.global L_934578
L_934578:
	ld_s r1,[r14]
L_93457a:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93457c:
	add2_s r1,r1,r1
L_93457e:
	add_s r1,r1,0x857838
L_934584:
	ldb_s r0,[r1,0x11]
L_934586:
	bset_s r0,r0,0x1
L_934588:
	b_s L_93459a
	.global L_93458a
L_93458a:
	ld_s r1,[r14]
L_93458c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93458e:
	add2_s r1,r1,r1
L_934590:
	add_s r1,r1,0x857838
L_934596:
	ldb_s r0,[r1,0x11]
L_934598:
	bset_s r0,r0,0x0
	.global L_93459a
L_93459a:
	stb_s r0,[r1,0x11]
L_93459c:
	b_s L_93456e
	.global L_93459e
L_93459e:
	mov_s r0,sp
L_9345a0:
	mov_s r3,0x8010e8
L_9345a6:
	ldb_s r1,[r3,0x15]
L_9345a8:
	mov_s r2,0x0
L_9345aa:
	bl.d L_93708c
L_9345ae:
	ld_s r3,[r3,0x18]
	.global L_9345b0
L_9345b0:
	mov_s r1,0x1
L_9345b2:
	mov_s r0,0x800664
L_9345b8:
	st_s r1,[r0]
	.global L_9345ba
L_9345ba:
	mov_s r13,0x0
	.global L_9345bc
L_9345bc:
	ld_s r0,[gp,0xe0]
L_9345be:
	bmsk.f 0x0,r0,0x4
L_9345c2:
	bne_s L_934604
	.global L_9345c4
L_9345c4:
	ld_s r0,[gp,0xe0]
L_9345c6:
	mov_s r1,r0
L_9345c8:
	bic r1,r1,-0x141
L_9345cc:
	cmp r1,0x100
L_9345d0:
	beq_s L_9344a2
	.global L_9345d2
L_9345d2:
	ld_s r0,[r14]
L_9345d4:
	mov_s r1,0x857849
L_9345da:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9345dc:
	add2_s r0,r0,r0
L_9345de:
	ldb_s r0,[r1,r0]
L_9345e0:
	brne_s r0,0,L_9345e8
L_9345e2:
	ld_s r0,[gp,0x18]
L_9345e4:
	bbit0 r0,0x1,L_9345fe
	.global L_9345e8
L_9345e8:
	mov_s r0,0x8014dc
L_9345ee:
	ld_s r0,[r0,0x8]
L_9345f0:
	cmp_s r0,0x0
L_9345f2:
	mov.eq r0,r14
L_9345f6:
	bl.eq.d L_9247c0
L_9345fa:
	mov.eq r1,0x1
	.global L_9345fe
L_9345fe:
	b.d L_920284
L_934602:
	add_s sp,sp,0x8
	.global L_934604
L_934604:
	ld_s r0,[r14]
L_934606:
	mov_s r1,0x8016d8
L_93460c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93460e:
	add1_s r0,r0,r0
L_934610:
	ld_s r0,[r1,r0]
L_934612:
	sub.f r0,r0,0x0
L_934616:
	mov.ne r0,0x1
L_93461a:
	extb.f 0x0,r0
L_93461e:
	beq_s L_934630
L_934620:
	bl.d L_92bdc8
L_934624:
	mov_s r0,r14
L_934626:
	brne r0,0x2,L_934630
L_93462a:
	ld_s r0,[gp,0xb8]
L_93462c:
	bbit1 r0,0x0,L_93458a
	.global L_934630
L_934630:
	mov_s r0,0x2
L_934632:
	bset_s r0,r0,0x19
L_934634:
	mov_s r32,r0
L_934636:
	st.ab r0,[r25,0x4]
L_93463a:
	bclr r25,r25,0xa
L_93463e:
	bl.d L_931dcc
L_934642:
	ldw_s r0,[gp,-0x22]
L_934644:
	breq_s r0,0,L_934656
L_934646:
	bl.d L_92ce9c
L_93464a:
	mov_s r13,0x1
L_93464c:
	mov_s r0,0x800664
L_934652:
	st_s r13,[r0,0x4]
L_934654:
	b_s L_9345c4
	.global L_934656
L_934656:
	mov_s r0,r14
L_934658:
	bl.d L_92177c
L_93465c:
	mov_s r1,0x2
L_93465e:
	mov_s r1,0x801118
L_934664:
	ld_s r0,[r1,0xc]
L_934666:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934668:
	st_s r0,[r1,0xc]
L_93466a:
	b_s L_9345c4
