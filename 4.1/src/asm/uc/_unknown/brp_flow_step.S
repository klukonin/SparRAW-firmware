/* brp_flow_step @ 0x923400, 412 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__post_slot_result
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, bf_sm__release_sta, bf_substate__set, brp__build_tx_params, brp__count_active_sectors, brp__flow_main, brp__program_and_measure, brp__reset_db_b, brp__rx_chain_from_r38, get_g_804010, mac_mode__wait_ppdu_and_kick_c
 * Глобалы (через gp): 0x8005d2, 0x800604, 0x800608
 */
	.section .text.brp_flow_step,"ax",@progbits
	.global brp_flow_step
brp_flow_step:
	.global L_923400
L_923400:
	push_s blink
L_923402:
	bl L_92020c
L_923406:
	mov_s r13,r0
L_923408:
	bl.d L_9282b0
L_92340c:
	extb_s r0,r0
L_92340e:
	ldw_s r0,[gp,0xaa]
L_923410:
	bbit0 r0,r13,L_92342a
L_923414:
	mov_s r15,0x80
L_923416:
	bset_s r15,r15,0xc
L_923418:
	mov_s r0,0x80
L_92341a:
	bset_s r0,r0,0x19
L_92341c:
	mov_s r32,r0
L_92341e:
	st.ab r0,[r25,0x4]
L_923422:
	bclr r25,r25,0xa
L_923426:
	mov_s r0,0x0
L_923428:
	b_s L_92343c
	.global L_92342a
L_92342a:
	mov_s r1,0x10d18
L_923430:
	bl.d L_9306ac
L_923434:
	mov_s r0,0x0
L_923436:
	mov_s r15,0x0
L_923438:
	bset_s r15,r15,0xc
L_92343a:
	mov_s r0,0x40
	.global L_92343c
L_92343c:
	mov_s r16,r0
L_92343e:
	b_s L_923444
	.global L_923440
L_923440:
	bl L_923628
	.global L_923444
L_923444:
	mov_s r1,0x0
L_923446:
	mov_s r0,0x800734
L_92344c:
	st_s r1,[r0,0x20]
L_92344e:
	mov_s r0,r15
L_923450:
	mov_s r1,r16
L_923452:
	bl.d L_9318f4
L_923456:
	mov_s r2,0x0
L_923458:
	mov_s r0,r42
L_92345a:
	btst_s r0,0xc
L_92345c:
	mov_s r14,0x800734
L_923462:
	beq_s L_923524
L_923464:
	bl L_92359c
L_923468:
	mov_s r0,r36
L_92346a:
	bbit0 r0,0x19,L_92351c
L_92346e:
	bl L_928fa0
L_923472:
	breq r0,0x0,L_92351c
L_923476:
	bl.d L_92ab1c
L_92347a:
	mov_s r0,r13
L_92347c:
	st_s r0,[r14,0x20]
L_92347e:
	bbit0 r0,0x0,L_92350e
L_923482:
	ld_s r0,[r14,0x1c]
L_923484:
	bbit0 r0,0x0,L_9234b0
L_923488:
	bl.d L_923930
L_92348c:
	ldb_s r0,[r14,0x18]
L_92348e:
	mov_s r1,0x0
L_923490:
	breq_s r0,0,L_9234ac
L_923492:
	ld_s r0,[r14,0x1c]
L_923494:
	mov_s r1,0x801090
L_92349a:
	bic r0,r0,0x3
L_92349e:
	bset_s r0,r0,0x1
L_9234a0:
	st_s r0,[r14,0x1c]
L_9234a2:
	ldw_s r0,[r1,0x18]
L_9234a4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9234a6:
	extw_s r0,r0
L_9234a8:
	stw_s r0,[r1,0x18]
L_9234aa:
	b_s L_92350e
	.global L_9234ac
L_9234ac:
	st_s r1,[r14,0x20]
L_9234ae:
	b_s L_92350e
	.global L_9234b0
L_9234b0:
	ld_s r0,[gp,-0x44]
L_9234b2:
	and r0,r0,0xffff0fff
L_9234ba:
	bset r1,r0,0xd
L_9234be:
	bset_s r1,r1,0xf
L_9234c0:
	or r0,r0,0x1d00a000
L_9234c8:
	st.as r1,[gp,-0x11]
L_9234cc:
	mov_s r32,r0
L_9234ce:
	st.ab r0,[r25,0x4]
L_9234d2:
	bclr r25,r25,0xa
L_9234d6:
	nop_s
L_9234d8:
	nop_s
L_9234da:
	nop_s
L_9234dc:
	ld_s r0,[gp,-0x48]
L_9234de:
	or r0,r0,0x27007300
L_9234e6:
	mov_s r32,r0
L_9234e8:
	st.ab r0,[r25,0x4]
L_9234ec:
	bclr r25,r25,0xa
L_9234f0:
	mov_s r0,0x2004000
L_9234f6:
	mov_s r32,r0
L_9234f8:
	st.ab r0,[r25,0x4]
L_9234fc:
	bclr r25,r25,0xa
L_923500:
	nop_s
L_923502:
	nop_s
L_923504:
	nop_s
L_923506:
	mov_s r0,0x0
L_923508:
	bl.d L_9317fc
L_92350c:
	bset_s r0,r0,0xe
	.global L_92350e
L_92350e:
	mov_s r0,0x800734
L_923514:
	ld_s r0,[r0,0x20]
L_923516:
	btst_s r0,0x2
L_923518:
	beq_s L_923444
L_92351a:
	b_s L_923440
	.global L_92351c
L_92351c:
	bl L_9235f0
L_923520:
	cmp_s r0,0x0
L_923522:
	beq_s L_923444
	.global L_923524
L_923524:
	ld_s r0,[r14,0x1c]
L_923526:
	bbit0 r0,0x1,L_923566
L_92352a:
	mov_s r13,0x0
L_92352c:
	mov_s r15,0x20
	.global L_92352e
L_92352e:
	mov_s r0,0x801090
L_923534:
	sub r0,r0,0x40
L_923538:
	add_s r0,r0,r13
L_92353a:
	ldb r0,[r0, 0x5c]
L_92353e:
	bl.d L_92b3e4
L_923542:
	extb_s r1,r13
L_923544:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_923546:
	/* brhs.d r15,0x1,0x0092352e */
	.byte 0xeb,0x0f,0x75,0x90
L_92354a:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_92354c:
	bl.d L_924938
L_923550:
	ldb_s r0,[r14,0x18]
L_923552:
	bl.d L_9250a8
L_923556:
	mov_s r0,0x0
L_923558:
	mov_s r0,0x52
L_92355a:
	asl_s r0,r0,0x18
L_92355c:
	mov_s r32,r0
L_92355e:
	st.ab r0,[r25,0x4]
L_923562:
	bclr r25,r25,0xa
	.global L_923566
L_923566:
	ld_s r1,[r14,0x1c]
L_923568:
	ldb_s r0,[r14,0x18]
L_92356a:
	btst_s r1,0x1
L_92356c:
	mov_s r1,0x33
L_92356e:
	mov.eq r1,0x34
L_923572:
	bl L_930dc4
L_923576:
	mov_s r0,0x0
L_923578:
	st.as r0,[gp,0x37]
L_92357c:
	bl.d L_9250a8
L_923580:
	st.as r0,[gp,0x38]
L_923584:
	mov_s r0,0x52
L_923586:
	asl_s r0,r0,0x18
L_923588:
	mov_s r32,r0
L_92358a:
	st.ab r0,[r25,0x4]
L_92358e:
	bclr r25,r25,0xa
L_923592:
	bl.d L_9224c4
L_923596:
	ldb_s r0,[r14,0x18]
L_923598:
	b L_920274
