/* txop_initiator_open_txop_flow @ 0x93a250, 940 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__run_txop
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bi_tx__check_idle_and_start_uc, direct_tx__program_cmd34, direct_tx__send_after_delay, mac__load_tx_key, mac__program_tx_with_qid, mac__program_tx_with_rate, mac__select_rf_module_cmd31, mac__set_rf_chain_state, mac_q__tx_ppdu, mac_q__tx_ppdu_3009
 * Глобалы (через gp): 0x80056c, 0x8005f4, 0x8005f8, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txop_initiator_open_txop_flow
txop_initiator_open_txop_flow:
	.global L_93a250
L_93a250:
	push_s blink
L_93a252:
	bl.d L_920230
L_93a256:
	mov_s r0,0x0
L_93a258:
	st.a r0,[sp,-0x14]
L_93a25c:
	ld_s r0,[gp,0xd0]
L_93a25e:
	mov_s r1,0x802978
L_93a264:
	and r0,r0,0x40000000
L_93a26c:
	sub.f r14,r0,0x0
L_93a270:
	ld_s r13,[r1,0x78]
L_93a272:
	mov_s r0,0x13
L_93a274:
	st_s r0,[r13,0x18]
L_93a276:
	ld_s r1,[r1,0x78]
L_93a278:
	mov.ne r14,0x1
L_93a27c:
	ld_s r0,[r1,0x4]
L_93a27e:
	mov_s r2,0x802228
L_93a284:
	add1_s r0,r0,r0
L_93a286:
	ldb_s r0,[r2,r0]
L_93a288:
	breq_s r0,0,L_93a290
L_93a28a:
	ld_s r0,[r1,0x18]
L_93a28c:
	bset_s r0,r0,0x6
L_93a28e:
	st_s r0,[r1,0x18]
	.global L_93a290
L_93a290:
	ld_s r0,[gp,-0x44]
L_93a292:
	and r0,r0,0xffff0fff
L_93a29a:
	bset r1,r0,0xc
L_93a29e:
	bset_s r1,r1,0xd
L_93a2a0:
	or r0,r0,0x1d003000
L_93a2a8:
	st.as r1,[gp,-0x11]
L_93a2ac:
	mov_s r32,r0
L_93a2ae:
	st.ab r0,[r25,0x4]
L_93a2b2:
	bclr r25,r25,0xa
L_93a2b6:
	nop_s
L_93a2b8:
	nop_s
L_93a2ba:
	nop_s
L_93a2bc:
	extw r15,r40
L_93a2c0:
	add_s r1,sp,0x4
L_93a2c2:
	mov_s r0,r13
L_93a2c4:
	mov_s r2,0x0
L_93a2c6:
	bl.d L_93ea40
L_93a2ca:
	mov_s r3,r14
L_93a2cc:
	brne_s r0,0,L_93a314
L_93a2ce:
	ld_s r1,[r13,0x18]
L_93a2d0:
	bic r1,r1,-0x41
L_93a2d4:
	extb r0,r45
L_93a2d8:
	and_s r0,r0,r1
L_93a2da:
	cmp_s r0,0x0
L_93a2dc:
	mov_s r0,0x1
L_93a2de:
	sub_s.ne r0,r0,r0
L_93a2e0:
	extb.f 0x0,r0
L_93a2e4:
	bne_s L_93a420
L_93a2e6:
	mov_s r0,0x1
L_93a2e8:
	st_s r0,[r13,0x20]
L_93a2ea:
	bl.d L_921760
L_93a2ee:
	mov_s r0,r13
L_93a2f0:
	bl.d L_92d93c
L_93a2f4:
	ld_s r0,[r13,0x4]
	.global L_93a2f6
L_93a2f6:
	mov_s r0,r43
L_93a2f8:
	bbit0 r0,0x1f,L_93a2f6
L_93a2fc:
	mov_s r0,r51
L_93a2fe:
	bmsk r1,r0,0x3
L_93a302:
	st.as r1,[gp,0x38]
L_93a306:
	lsr_s r0,r0,0x4
L_93a308:
	st.as r0,[gp,0x39]
	.global L_93a30c
L_93a30c:
	mov_s r0,r45
L_93a30e:
	bbit0 r0,0x1f,L_93a30c
L_93a312:
	b_s L_93a420
	.global L_93a314
L_93a314:
	ld_s r2,[r13,0x28]
L_93a316:
	ld_s r0,[r13,0x4]
L_93a318:
	mov_s r1,0x0
L_93a31a:
	bset r1,r1,r0
L_93a31e:
	mov_s r0,0x802948
L_93a324:
	ld_s r0,[r0]
L_93a326:
	bmsk_s r2,r2,0x1
L_93a328:
	and_s r0,r0,r1
L_93a32a:
	cmp_s r0,0x0
L_93a32c:
	mov_s r14,0x1
L_93a32e:
	mov.eq r14,r2
L_93a332:
	cmp_s r14,0x0
L_93a334:
	beq_s L_93a458
L_93a336:
	cmp_s r15,0x30
L_93a338:
	bls L_93a440
L_93a33c:
	brne r14,0x1,L_93a390
L_93a340:
	ld_s r0,[gp,0xd0]
L_93a342:
	mov_s r15,0x0
L_93a344:
	bset_s r0,r0,0x2
L_93a346:
	st.as r0,[gp,0x34]
L_93a34a:
	mov_s r0,0x10
L_93a34c:
	bl.d L_9257a8
L_93a350:
	mov_s r1,r0
L_93a352:
	bl.d L_92d8e8
L_93a356:
	mov_s r0,0x0
	.global L_93a358
L_93a358:
	mov_s r0,r43
L_93a35a:
	bbit0 r0,0x1f,L_93a358
L_93a35e:
	mov_s r0,r51
L_93a360:
	bmsk r1,r0,0x3
L_93a364:
	st.as r1,[gp,0x38]
L_93a368:
	lsr_s r0,r0,0x4
L_93a36a:
	st.as r0,[gp,0x39]
L_93a36e:
	st_s r15,[sp,0x4]
	.global L_93a370
L_93a370:
	mov_s r0,r45
L_93a372:
	bbit0 r0,0x1f,L_93a370
L_93a376:
	ld_s r0,[r13]
L_93a378:
	mov_s r1,0xb
L_93a37a:
	bl.d L_938218
L_93a37e:
	mov_s r2,0x0
L_93a380:
	ld_s r1,[r13,0x18]
L_93a382:
	extb r0,r45
L_93a386:
	and_s r0,r0,r1
L_93a388:
	cmp_s r0,0x0
L_93a38a:
	mov_s r0,0x1
L_93a38c:
	sub_s.ne r0,r0,r0
L_93a38e:
	b_s L_93a39a
	.global L_93a390
L_93a390:
	mov_s r0,blink
L_93a392:
	bl.d L_926618
L_93a396:
	mov_s r1,0x7a
L_93a398:
	mov_s r0,0x0
	.global L_93a39a
L_93a39a:
	breq r0,0x0,L_93a420
	.global L_93a39e
L_93a39e:
	ld_s r0,[gp,-0x34]
L_93a3a0:
	breq_s r0,0,L_93a3c4
L_93a3a2:
	ld_s r0,[r13,0xc]
L_93a3a4:
	bbit0 r0,0xb,L_93a3c4
L_93a3a8:
	ld_s r0,[r13]
L_93a3aa:
	mov_s r1,0x80113c
L_93a3b0:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93a3b2:
	add2_s r0,r0,r0
L_93a3b4:
	bl.d L_9294ac
L_93a3b8:
	add_s r0,r0,r1
L_93a3ba:
	bl L_92949c
L_93a3be:
	ld_s r0,[r13,0xc]
L_93a3c0:
	bclr_s r0,r0,0xb
L_93a3c2:
	st_s r0,[r13,0xc]
	.global L_93a3c4
L_93a3c4:
	ld_s r0,[gp,0xe0]
L_93a3c6:
	ld.as r1,[gp,0x39]
L_93a3ca:
	bic r0,r0,-0x3
L_93a3ce:
	cmp_s r0,0x2
L_93a3d0:
	mov_s r0,0x1
L_93a3d2:
	sub_s.ne r0,r0,r0
L_93a3d4:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_93a3d6:
	or r0,r0,0x19000b00
L_93a3de:
	asl_s r1,r1,0xe
L_93a3e0:
	or_s r0,r0,r1
L_93a3e2:
	mov_s r32,r0
L_93a3e4:
	st.ab r0,[r25,0x4]
L_93a3e8:
	bclr r25,r25,0xa
L_93a3ec:
	ld_s r0,[gp,-0x34]
L_93a3ee:
	brne r0,0x1,L_93a3fa
L_93a3f2:
	mov_s r0,0x0
L_93a3f4:
	bl.d L_92f4bc
L_93a3f8:
	ld_s r1,[r13]
	.global L_93a3fa
L_93a3fa:
	add_s r1,sp,0x4
L_93a3fc:
	bl.d L_9399a4
L_93a400:
	mov_s r0,r13
L_93a402:
	brne r0,0x0,L_93a47a
L_93a406:
	mov_s r1,0x8022c8
L_93a40c:
	ld_s r0,[r1,0x4]
L_93a40e:
	st.as 0x800,[gp,0x34]
L_93a416:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a418:
	st_s r0,[r1,0x4]
L_93a41a:
	b.d L_93a5f4
L_93a41e:
	mov_s r0,0x0
	.global L_93a420
L_93a420:
	bl.d L_93696c
L_93a424:
	mov_s r0,0x2
L_93a426:
	mov_s r1,0x8022c8
L_93a42c:
	ld_s r0,[r1,0x1c]
L_93a42e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a430:
	st_s r0,[r1,0x1c]
L_93a432:
	ld_s r0,[gp,0xd0]
L_93a434:
	bset_s r0,r0,0xd
L_93a436:
	st.as r0,[gp,0x34]
L_93a43a:
	b.d L_93a5f4
L_93a43e:
	mov_s r0,0x0
	.global L_93a440
L_93a440:
	ld_s r0,[gp,0xd0]
L_93a442:
	mov_s r1,0x8022c8
L_93a448:
	bset_s r0,r0,0xf
L_93a44a:
	st.as r0,[gp,0x34]
L_93a44e:
	ld_s r0,[r1,0x20]
L_93a450:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a452:
	st_s r0,[r1,0x20]
L_93a454:
	mov_s r0,0x0
L_93a456:
	b_s L_93a5f4
	.global L_93a458
L_93a458:
	and.f 0x0,r43,0xc000
L_93a460:
	beq_s L_93a468
L_93a462:
	mov_s r0,r43
L_93a464:
	bbit0 r0,0x1a,L_93a39e
	.global L_93a468
L_93a468:
	mov_s r0,0x20000400
L_93a46e:
	mov_s r32,r0
L_93a470:
	st.ab r0,[r25,0x4]
L_93a474:
	bclr r25,r25,0xa
L_93a478:
	b_s L_93a39e
	.global L_93a47a
L_93a47a:
	ld_s r0,[gp,-0x48]
L_93a47c:
	or r0,r0,0x27004000
L_93a484:
	mov_s r32,r0
L_93a486:
	st.ab r0,[r25,0x4]
L_93a48a:
	bclr r25,r25,0xa
L_93a48e:
	mov_s r0,0x2004000
L_93a494:
	mov_s r32,r0
L_93a496:
	st.ab r0,[r25,0x4]
L_93a49a:
	bclr r25,r25,0xa
L_93a49e:
	brne r14,0x0,L_93a520
L_93a4a2:
	mov_s r1,0x802978
L_93a4a8:
	ld_s r0,[r1,0x78]
L_93a4aa:
	mov_s r2,0x802229
L_93a4b0:
	ld_s r0,[r0,0x4]
L_93a4b2:
	add1_s r0,r0,r0
L_93a4b4:
	ldb_s r0,[r2,r0]
L_93a4b6:
	breq_s r0,0,L_93a4d2
L_93a4b8:
	lsr r0,r45,0x5
L_93a4bc:
	bxor r0,r0,0x0
L_93a4c0:
	ld_s r2,[r1,0x78]
L_93a4c2:
	bbit1 r0,0x0,L_93a4d2
L_93a4c6:
	ld_s r0,[r2,0xc]
L_93a4c8:
	bset_s r0,r0,0x1
L_93a4ca:
	st_s r0,[r2,0xc]
L_93a4cc:
	ld_s r0,[r1,0x78]
L_93a4ce:
	mov_s r2,0x0
L_93a4d0:
	st_s r2,[r0,0x20]
	.global L_93a4d2
L_93a4d2:
	ld_s r0,[r1,0x78]
L_93a4d4:
	ld_s r0,[r0,0xc]
L_93a4d6:
	bbit1 r0,0x8,L_93a520
L_93a4da:
	lsr r0,r43,0xe
L_93a4de:
	bmsk.f r0,r0,0x1
L_93a4e2:
	beq_s L_93a4fa
L_93a4e4:
	brne r0,0x1,L_93a520
L_93a4e8:
	mov_s r0,0x802978
L_93a4ee:
	ld_s r1,[r0,0x78]
L_93a4f0:
	ld_s r0,[r1,0xc]
L_93a4f2:
	or r0,r0,0xe
L_93a4f6:
	st_s r0,[r1,0xc]
L_93a4f8:
	b_s L_93a520
	.global L_93a4fa
L_93a4fa:
	mov_s r1,r43
L_93a4fc:
	ld_s r0,[gp,0xd0]
L_93a4fe:
	btst_s r1,0x1b
L_93a500:
	bset.ne r0,r0,0x1
L_93a504:
	bset.eq r0,r0,0x0
L_93a508:
	st.as r0,[gp,0x34]
L_93a50c:
	bbit1 r0,0x12,L_93a520
L_93a510:
	mov_s r0,0x802978
L_93a516:
	ld_s r1,[r0,0x78]
L_93a518:
	mov_s r0,0x1
L_93a51a:
	bl.d L_93cfdc
L_93a51e:
	ld_s r1,[r1,0x4]
	.global L_93a520
L_93a520:
	mov_s r0,0x0
L_93a522:
	bl.d L_9366dc
L_93a526:
	bset_s r0,r0,0xe
L_93a528:
	ld_s r1,[r13]
L_93a52a:
	mov_s r14,0x0
L_93a52c:
	ld_s r0,[gp,0xcc]
L_93a52e:
	st_s r14,[sp,0x0]
L_93a530:
	bic r0,r0,-0x3
L_93a534:
	or.f 0x0,r0,r14
L_93a538:
	mov_s r3,sp
L_93a53a:
	ld.as r2,[gp,0x34]
L_93a53e:
	beq_s L_93a54a
L_93a540:
	bic r2,r2,-0x120
L_93a544:
	cmp r2,0x100
L_93a548:
	beq_s L_93a57a
	.global L_93a54a
L_93a54a:
	mov_s r0,0x1
L_93a54c:
	st_s r0,[r3]
L_93a54e:
	ld_s r0,[gp,0x44]
L_93a550:
	mov_s r3,0x802978
L_93a556:
	ld_s r2,[r3,0x78]
L_93a558:
	breq_s r0,0,L_93a568
L_93a55a:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_93a55c:
	mov_s r0,0x801108
L_93a562:
	add2_s r1,r1,r1
L_93a564:
	ld_s r0,[r0,r1]
L_93a566:
	st_s r0,[r2,0x2c]
	.global L_93a568
L_93a568:
	ld_s r1,[r3,0x78]
L_93a56a:
	mov_s r0,0x1
L_93a56c:
	bl.d L_92f42c
L_93a570:
	ld_s r1,[r1,0x2c]
L_93a572:
	ld_s r0,[gp,0x44]
L_93a574:
	breq_s r0,0,L_93a57a
L_93a576:
	st.as r14,[gp,0x11]
	.global L_93a57a
L_93a57a:
	bl L_9364c8
L_93a57e:
	mov_s r1,0x8006e0
L_93a584:
	st_s r0,[r1]
L_93a586:
	mov_s r0,0xeeee02
L_93a58c:
	mov_s r32,r0
L_93a58e:
	st.ab r0,[r25,0x4]
L_93a592:
	bclr r25,r25,0xa
L_93a596:
	mov_s r0,0x0
L_93a598:
	bl.d L_9366dc
L_93a59c:
	bset_s r0,r0,0xf
L_93a59e:
	ld_s r0,[r13,0xc]
L_93a5a0:
	btst_s r0,0x3
L_93a5a2:
	mov.ne r0,r13
L_93a5a6:
	bl.ne.d L_939888
L_93a5aa:
	sub_s.ne r1,r1,r1
L_93a5ac:
	mov_s r0,0x2
L_93a5ae:
	st.as r0,[gp,0x33]
L_93a5b2:
	ld_s r0,[gp,0xd0]
L_93a5b4:
	bset_s r0,r0,0x8
L_93a5b6:
	st.as r0,[gp,0x34]
L_93a5ba:
	bl.d L_936588
L_93a5be:
	mov_s r0,0x6
L_93a5c0:
	ld_s r0,[sp,0x0]
L_93a5c2:
	brne r0,0x1,L_93a5e4
L_93a5c6:
	ld_s r0,[gp,0x178]
L_93a5c8:
	mov_s r1,0x802944
L_93a5ce:
	bclr_s r0,r0,0x18
L_93a5d0:
	ld_s r1,[r1]
L_93a5d2:
	bclr_s r0,r0,0x19
L_93a5d4:
	asl_s r1,r1,0x18
L_93a5d6:
	or_s r0,r0,r1
L_93a5d8:
	st.as r0,[gp,0x5e]
L_93a5dc:
	mov_s r1,0x889480
L_93a5e2:
	st_s r0,[r1,0x8]
	.global L_93a5e4
L_93a5e4:
	mov_s r1,0x8010b0
L_93a5ea:
	ldw_s r0,[r1,0x2e]
L_93a5ec:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a5ee:
	extw_s r0,r0
L_93a5f0:
	stw_s r0,[r1,0x2e]
L_93a5f2:
	mov_s r0,0x1
	.global L_93a5f4
L_93a5f4:
	b.d L_92029c
L_93a5f8:
	add_s sp,sp,0x14
L_93a5fa:
	nop_s
