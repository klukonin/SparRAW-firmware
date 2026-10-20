/* txss__program_tx_frame @ 0x93c2f8, 864 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_init__flow, txss_resp__wait_iss_end
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, bcon_txss_sweep_step, direct_tx__program_cmd34, mac__cmd_29000001, mac__program_tx_common, mac_evt__enable_bit_sync_b, txss__set_frame_half_s1_w2, txss__set_sweep_param, txss__sweep_timing, uc_sysassert, uc_wait_event_busy
 * Глобалы (через gp): 0x8005f4, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss__program_tx_frame
txss__program_tx_frame:
	.global L_93c2f8
L_93c2f8:
	push_s blink
L_93c2fa:
	bl L_92021c
L_93c2fe:
	mov_s r13,r0
L_93c300:
	mov_s r17,r1
L_93c302:
	mov_s r0,0x8014a4
L_93c308:
	ld_s r0,[r0,0x1c]
L_93c30a:
	mov_s r18,r3
L_93c30c:
	st.a r2,[sp,-0x14]
L_93c310:
	mov r19,r4
L_93c314:
	breq_s r0,0,L_93c34a
L_93c316:
	mov_s r0,0x857720
L_93c31c:
	ldb_s r0,[r0,0x1c]
L_93c31e:
	brlt r0,0x2,L_93c34a
L_93c322:
	breq_s r2,0,L_93c34a
L_93c324:
	breq r13,0x8,L_93c340
L_93c328:
	mov_s r1,0x801110
L_93c32e:
	asl_s r0,r13,0x4
L_93c330:
	add2_s r0,r0,r0
L_93c332:
	ld_s r0,[r1,r0]
L_93c334:
	mov_s r1,0x7fff00
L_93c33a:
	and_s r0,r0,r1
L_93c33c:
	brne r0,r1,L_93c34a
	.global L_93c340
L_93c340:
	mov r16,0x801694
L_93c348:
	b_s L_93c356
	.global L_93c34a
L_93c34a:
	mul64 r13,0x4c
L_93c34e:
	add r16,mlo,0x802b68
	.global L_93c356
L_93c356:
	add3 r15,r16,0x8
L_93c35a:
	ldb_s r0,[r15,0x9]
L_93c35c:
	mov_s r1,0x801150
L_93c362:
	st_s r0,[sp,0x4]
L_93c364:
	asl_s r0,r13,0x4
L_93c366:
	add2_s r0,r0,r0
L_93c368:
	ldb_s r14,[r1,r0]
L_93c36a:
	add r20,sp,0xc
L_93c36e:
	ldb_s r1,[r15,0x8]
L_93c370:
	mov_s r0,r20
L_93c372:
	bl.d L_939cc4
L_93c376:
	mov_s r2,r14
L_93c378:
	brne r17,0x1,L_93c40c
L_93c37c:
	mov_s r0,0x3e
L_93c37e:
	asl_s r0,r0,0x18
L_93c380:
	mov_s r32,r0
L_93c382:
	st.ab r0,[r25,0x4]
L_93c386:
	bclr r25,r25,0xa
L_93c38a:
	mov_s r0,0x37000020
L_93c390:
	mov_s r32,r0
L_93c392:
	st.ab r0,[r25,0x4]
L_93c396:
	bclr r25,r25,0xa
L_93c39a:
	mov_s r1,0x8022c8
L_93c3a0:
	ld_s r0,[r1,0xc]
L_93c3a2:
	mov_s r2,r14
L_93c3a4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93c3a6:
	st_s r0,[r1,0xc]
L_93c3a8:
	ld_s r0,[gp,0x178]
L_93c3aa:
	mov_s r1,0x802940
L_93c3b0:
	bclr_s r0,r0,0x18
L_93c3b2:
	ld_s r1,[r1]
L_93c3b4:
	bclr_s r0,r0,0x19
L_93c3b6:
	asl_s r1,r1,0x18
L_93c3b8:
	or_s r0,r0,r1
L_93c3ba:
	st.as r0,[gp,0x5e]
L_93c3be:
	mov_s r1,0x889480
L_93c3c4:
	st_s r0,[r1,0x8]
L_93c3c6:
	ldb_s r0,[r15,0x8]
L_93c3c8:
	mov_s r1,r16
L_93c3ca:
	mulu64 r0,r14
L_93c3ce:
	sub_s r15,r14,0x1
L_93c3d0:
	mov_s r0,r20
L_93c3d2:
	mov_s r3,0x0
L_93c3d4:
	add r4,r15,mlo
L_93c3d8:
	extb r4,r4
L_93c3dc:
	bl.d L_9357ec
L_93c3e0:
	ld r5,[sp, 0x4]
L_93c3e4:
	mov_s r0,0x802dec
L_93c3ea:
	ld_s r0,[r0,0x68]
L_93c3ec:
	bset_s r0,r0,0x18
L_93c3ee:
	bset_s r0,r0,0x1a
L_93c3f0:
	bset_s r0,r0,0x1c
L_93c3f2:
	mov_s r32,r0
L_93c3f4:
	st.ab r0,[r25,0x4]
L_93c3f8:
	bclr r25,r25,0xa
L_93c3fc:
	mov_s r0,0x14000007
L_93c402:
	mov_s r32,r0
L_93c404:
	st.ab r0,[r25,0x4]
L_93c408:
	bclr r25,r25,0xa
	.global L_93c40c
L_93c40c:
	mov_s r0,0x10
L_93c40e:
	bl.d L_9257a8
L_93c412:
	mov_s r1,0x16
L_93c414:
	bl L_92d990
L_93c418:
	brne r17,0x1,L_93c498
L_93c41c:
	bl.d L_936544
L_93c420:
	mov_s r0,0x6
L_93c422:
	mov_s r0,0x2008000
L_93c428:
	mov_s r32,r0
L_93c42a:
	st.ab r0,[r25,0x4]
L_93c42e:
	bclr r25,r25,0xa
L_93c432:
	ld_s r0,[gp,0xcc]
L_93c434:
	and r1,r0,0x10
L_93c438:
	mov_s r0,0x0
L_93c43a:
	or.f 0x0,r1,r0
L_93c43e:
	beq_s L_93c45e
L_93c440:
	ld_s r0,[gp,0xe0]
L_93c442:
	bic r0,r0,-0x3
L_93c446:
	cmp_s r0,0x2
L_93c448:
	mov_s r0,0x1
L_93c44a:
	sub_s.ne r0,r0,r0
L_93c44c:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_93c44e:
	or r1,r0,0x19800830
L_93c456:
	ld_s r0,[gp,0xe4]
L_93c458:
	asl_s r0,r0,0xe
L_93c45a:
	or_s r0,r0,r1
L_93c45c:
	b_s L_93c464
	.global L_93c45e
L_93c45e:
	mov_s r0,0x19000001
	.global L_93c464
L_93c464:
	mov_s r32,r0
L_93c466:
	st.ab r0,[r25,0x4]
L_93c46a:
	bclr r25,r25,0xa
	.global L_93c46e
L_93c46e:
	mov_s r0,r45
L_93c470:
	bbit0 r0,0x1f,L_93c46e
L_93c474:
	ld_s r0,[gp,0xcc]
L_93c476:
	and r1,r0,0x10
L_93c47a:
	mov_s r0,0x0
L_93c47c:
	or.f 0x0,r1,r0
L_93c480:
	mov_s r0,0x18
L_93c482:
	asl.ne r0,r0,0x18
L_93c486:
	mov.eq r0,0x18001000
L_93c48e:
	mov_s r32,r0
L_93c490:
	st.ab r0,[r25,0x4]
L_93c494:
	bclr r25,r25,0xa
	.global L_93c498
L_93c498:
	cmp r19,0x0
L_93c49c:
	jlne [r19]
L_93c4a0:
	mov_s r2,0x802b2c
L_93c4a6:
	stw 0x864,[r2, 0x20]
L_93c4ae:
	ld_s r0,[sp,0x0]
L_93c4b0:
	mov_s r3,0x802b4c
L_93c4b6:
	mov_s r15,0x0
L_93c4b8:
	breq_s r0,0,L_93c4dc
L_93c4ba:
	mov_s r1,0x80212c
L_93c4c0:
	ldb_s r0,[r1,0x1]
L_93c4c2:
	ldb r5,[r1]
L_93c4c6:
	asl r4,r0,0x6
L_93c4ca:
	or r0,r4,r5
L_93c4ce:
	stb_s r0,[r3,0x13]
L_93c4d0:
	ld_s r0,[r1,0x8]
L_93c4d2:
	sub_s r0,r0,0x13
L_93c4d4:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93c4d6:
	stb_s r0,[r3,0x14]
L_93c4d8:
	stb_s r15,[r3,0x15]
L_93c4da:
	b_s L_93c514
	.global L_93c4dc
L_93c4dc:
	mov_s r1,0x857280
L_93c4e2:
	ldb_s r0,[r1,0xd]
L_93c4e4:
	stb_s r15,[r3,0x14]
L_93c4e6:
	mulu64 r0,r14
L_93c4ea:
	sub r4,mlo,0x1
L_93c4ee:
	extw r5,r4
L_93c4f2:
	ldb_s r1,[r1,0xc]
L_93c4f4:
	stb r4,[r3, 0x13]
L_93c4f8:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_93c4fa:
	bmsk_s r1,r1,0x1
L_93c4fc:
	add r0,r3,0x14
L_93c500:
	bl.d L_93e384
L_93c504:
	stb_s r15,[r3,0x15]
L_93c506:
	lsr r1,r5,0x8
L_93c50a:
	ldw_s r0,[r3,0x14]
L_93c50c:
	bmsk_s r1,r1,0x0
L_93c50e:
	bclr_s r0,r0,0x0
L_93c510:
	or_s r0,r0,r1
L_93c512:
	stw_s r0,[r3,0x14]
	.global L_93c514
L_93c514:
	breq r18,0x0,L_93c524
L_93c518:
	breq r18,0x1,L_93c542
L_93c51c:
	breq r18,0x2,L_93c54a
L_93c520:
	mov_s r15,0x0
L_93c522:
	b_s L_93c550
	.global L_93c524
L_93c524:
	asl_s r0,r13,0x4
L_93c526:
	add2_s r0,r0,r0
L_93c528:
	add_s r0,r0,0x801104
L_93c52e:
	ldw_s r1,[r0,0x30]
L_93c530:
	mov_s r15,0x1b39c
L_93c536:
	stw_s r1,[r2,0x24]
L_93c538:
	ldw_s r1,[r0,0x32]
L_93c53a:
	ldw_s r0,[r0,0x34]
L_93c53c:
	stw_s r1,[r2,0x26]
L_93c53e:
	stw_s r0,[r2,0x28]
L_93c540:
	b_s L_93c550
	.global L_93c542
L_93c542:
	mov_s r15,0x1b404
L_93c548:
	b_s L_93c550
	.global L_93c54a
L_93c54a:
	mov_s r15,0x1b3fc
	.global L_93c550
L_93c550:
	cmp r17,0x5
L_93c554:
	bne_s L_93c608
L_93c556:
	ld_s r0,[gp,-0x48]
L_93c558:
	or r0,r0,0x27007e00
L_93c560:
	mov_s r32,r0
L_93c562:
	st.ab r0,[r25,0x4]
L_93c566:
	bclr r25,r25,0xa
L_93c56a:
	mov_s r0,0x2004002
L_93c570:
	mov_s r32,r0
L_93c572:
	st.ab r0,[r25,0x4]
L_93c576:
	bclr r25,r25,0xa
L_93c57a:
	ldb r0,[r16, 0x48]
L_93c57e:
	mov_s r1,r16
L_93c580:
	mulu64 r0,r14
L_93c584:
	sub_s r0,r14,0x1
L_93c586:
	mov_s r2,r14
L_93c588:
	mov_s r3,0x0
L_93c58a:
	add_s r0,r0,mlo
L_93c58c:
	extb_s r0,r0
L_93c58e:
	st_s r0,[sp,0x8]
L_93c590:
	ld r4,[sp, 0x8]
L_93c594:
	add_s r0,sp,0xc
L_93c596:
	bl.d L_9357ec
L_93c59a:
	ld r5,[sp, 0x4]
L_93c59e:
	ld_s r0,[gp,-0x44]
L_93c5a0:
	and r0,r0,0xffff0fff
L_93c5a8:
	bset r1,r0,0xd
L_93c5ac:
	bset_s r1,r1,0xf
L_93c5ae:
	or r0,r0,0x1d00a000
L_93c5b6:
	st.as r1,[gp,-0x11]
L_93c5ba:
	mov_s r32,r0
L_93c5bc:
	st.ab r0,[r25,0x4]
L_93c5c0:
	bclr r25,r25,0xa
L_93c5c4:
	mov_s r0,0x2
L_93c5c6:
	bset_s r0,r0,0xe
L_93c5c8:
	bl.d L_9366e8
L_93c5cc:
	mov_s r1,0x0
L_93c5ce:
	bl L_936520
L_93c5d2:
	mov_s r1,r40
L_93c5d4:
	mov_s r0,r42
L_93c5d6:
	bbit1 r0,0xe,L_93c5de
L_93c5da:
	bbit1 r1,0x18,L_93c5f8
	.global L_93c5de
L_93c5de:
	mov_s r0,r45
L_93c5e0:
	bbit0 r0,0x1f,L_93c5de
L_93c5e4:
	mov_s r0,0x29000002
L_93c5ea:
	mov_s r32,r0
L_93c5ec:
	st.ab r0,[r25,0x4]
L_93c5f0:
	bclr r25,r25,0xa
L_93c5f4:
	mov_s r13,0x0
L_93c5f6:
	b_s L_93c644
	.global L_93c5f8
L_93c5f8:
	mov_s r0,0x29000002
L_93c5fe:
	mov_s r32,r0
L_93c600:
	st.ab r0,[r25,0x4]
L_93c604:
	bclr r25,r25,0xa
	.global L_93c608
L_93c608:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_93c60a:
	mov_s r0,0x801ffc
L_93c610:
	add2_s r13,r13,r13
L_93c612:
	ld_s r0,[r0,r13]
L_93c614:
	brhs r0,0x12,L_93c64c
	.global L_93c618
L_93c618:
	ld r4,[sp]
L_93c61c:
	add_s r2,sp,0xc
L_93c61e:
	mov_s r0,0x802b10
L_93c624:
	mov_s r1,r17
L_93c626:
	mov_s r3,r15
L_93c628:
	bl.d L_93b430
L_93c62c:
	mov r5,0x1
L_93c630:
	mov_s r13,r0
L_93c632:
	brne r0,0x1,L_93c644
L_93c636:
	mov_s r0,0x81
L_93c638:
	asl_s r0,r0,0x12
L_93c63a:
	mov_s r32,r0
L_93c63c:
	st.ab r0,[r25,0x4]
L_93c640:
	bclr r25,r25,0xa
	.global L_93c644
L_93c644:
	mov_s r0,r13
L_93c646:
	b.d L_920274
L_93c64a:
	add_s sp,sp,0x14
	.global L_93c64c
L_93c64c:
	mov_s r0,blink
L_93c64e:
	bl.d L_926618
L_93c652:
	mov r1,0x103
L_93c656:
	b_s L_93c618
