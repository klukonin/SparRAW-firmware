/* rf_chain__program_sector_desc @ 0x8fa398, 812 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__addba_at_10, mac_bringup__init_seq
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w4, bits__set32_s14_w2, bits__set32_s16_w5, bits__set32_s24_w2, bits__set32_s2_w2, bits__set32_s4_w4, bits__set32_s4_w5, qdesc_cfg__is_override, rf_chain__bits_set32_s22_w2, rf_chain__bits_set32_s29_w2
 * Глобалы (через gp): 0x8003a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_chain__program_sector_desc
rf_chain__program_sector_desc:
	.global L_8fa398
L_8fa398:
	push_s blink
L_8fa39a:
	bl L_8c01dc
L_8fa39e:
	mov_s r13,r0
L_8fa3a0:
	mov_s r14,r1
L_8fa3a2:
	mov_s r16,r2
L_8fa3a4:
	mov_s r15,0x0
L_8fa3a6:
	st_s r15,[r0]
L_8fa3a8:
	st_s r15,[r0,0x4]
L_8fa3aa:
	st_s r15,[r0,0x8]
L_8fa3ac:
	st 0xa0a0a0a0,[r0, 0xc]
L_8fa3b4:
	bmsk r0,r3,0x0
L_8fa3b8:
	asl_s r0,r0,0x9
L_8fa3ba:
	st_s r0,[r13,0x4]
L_8fa3bc:
	bmsk r1,r4,0x4
L_8fa3c0:
	add_s r0,r13,0x4
L_8fa3c2:
	bl.d L_8ed52c
L_8fa3c6:
	mov_s r2,r5
L_8fa3c8:
	cmp_s r14,0xa
L_8fa3ca:
	bhi L_8fa6be
L_8fa3ce:
	ldw.x.as r14,[0x8027dc,r14]
L_8fa3d6:
	add r0,pcl,0xa
L_8fa3da:
	add1_s r0,r0,r14
L_8fa3dc:
	j_s [r0]
L_8fa3de:
	mov_s r0,r13
L_8fa3e0:
	mov_s r1,r15
L_8fa3e2:
	bl L_8ed3c4
L_8fa3e6:
	ld_s r0,[r13]
L_8fa3e8:
	mov.f r1,r2
L_8fa3ec:
	bset_s r0,r0,0x15
L_8fa3ee:
	st_s r0,[r13]
L_8fa3f0:
	mov.ne r1,0x1
L_8fa3f4:
	asl_s r1,r1
L_8fa3f6:
	mov_s r0,r13
L_8fa3f8:
	bl L_8ed4b4
L_8fa3fc:
	mov_s r1,r15
L_8fa3fe:
	bl L_8ed460
L_8fa402:
	ld.as r1,[gp,0x89]
L_8fa406:
	bmsk_s r1,r1,0x4
L_8fa408:
	bl L_8ed400
L_8fa40c:
	mov_s r1,0x1
L_8fa40e:
	bl L_8ed520
L_8fa412:
	mov_s r1,0x2
L_8fa414:
	bl L_8ed448
L_8fa418:
	mov_s r1,r15
L_8fa41a:
	bl L_8ed370
L_8fa41e:
	ld_s r0,[r13]
L_8fa420:
	bmsk_s r0,r0,0x1e
L_8fa422:
	st_s r0,[r13]
L_8fa424:
	ld_s r0,[r13,0x4]
L_8fa426:
	bclr_s r0,r0,0x1
L_8fa428:
	st_s r0,[r13,0x4]
L_8fa42a:
	add_s r0,r13,0x4
L_8fa42c:
	bl L_8ed4cc
L_8fa430:
	ld_s r0,[r13,0x4]
L_8fa432:
	bclr_s r0,r0,0x9
L_8fa434:
	bl.d L_8cc2e8
L_8fa438:
	st_s r0,[r13,0x4]
L_8fa43a:
	breq_s r0,0,L_8fa44e
L_8fa43c:
	bl L_8cc35c
L_8fa440:
	ld_s r1,[r13,0x4]
L_8fa442:
	bmsk_s r0,r0,0x0
L_8fa444:
	bclr_s r1,r1,0x0
L_8fa446:
	or_s r0,r0,r1
L_8fa448:
	b.d L_8fa6be
L_8fa44c:
	st_s r0,[r13,0x4]
	.global L_8fa44e
L_8fa44e:
	ld_s r0,[r13,0x4]
L_8fa450:
	bclr_s r0,r0,0x0
L_8fa452:
	b.d L_8fa6be
L_8fa456:
	st_s r0,[r13,0x4]
L_8fa458:
	mov_s r0,r13
L_8fa45a:
	mov_s r1,r15
L_8fa45c:
	bl L_8ed3c4
L_8fa460:
	ld_s r0,[r13]
L_8fa462:
	mov.f r1,r2
L_8fa466:
	bclr_s r0,r0,0x15
L_8fa468:
	st_s r0,[r13]
L_8fa46a:
	mov.ne r1,0x1
L_8fa46e:
	asl_s r1,r1
L_8fa470:
	mov_s r0,r13
L_8fa472:
	bl L_8ed4b4
L_8fa476:
	mov_s r1,r15
L_8fa478:
	bl L_8ed460
L_8fa47c:
	mov_s r1,0x1
L_8fa47e:
	bl L_8ed400
L_8fa482:
	ldb r1,[gp, 0xb1]
L_8fa486:
	bmsk_s r1,r1,0x3
L_8fa488:
	bl L_8ed520
L_8fa48c:
	mov_s r1,0x2
L_8fa48e:
	bl L_8ed448
L_8fa492:
	mov_s r1,r15
L_8fa494:
	bl L_8ed370
L_8fa498:
	ld_s r0,[r13]
L_8fa49a:
	bset_s r0,r0,0x1f
L_8fa49c:
	st_s r0,[r13]
L_8fa49e:
	ld_s r0,[r13,0x4]
L_8fa4a0:
	bclr_s r0,r0,0x1
L_8fa4a2:
	st_s r0,[r13,0x4]
L_8fa4a4:
	add_s r0,r13,0x4
L_8fa4a6:
	bl L_8ed4cc
L_8fa4aa:
	mov_s r0,0x803c00
L_8fa4b0:
	ld_s r0,[r0,0xc]
L_8fa4b2:
	brne_s r0,0,L_8fa4ba
L_8fa4b4:
	bl L_8ccec0
L_8fa4b8:
	mov_s r15,r0
	.global L_8fa4ba
L_8fa4ba:
	ld_s r0,[r13,0x4]
L_8fa4bc:
	bmsk_s r15,r15,0x0
L_8fa4be:
	bclr_s r0,r0,0x0
L_8fa4c0:
	or_s r0,r0,r15
	.global L_8fa4c2
L_8fa4c2:
	st_s r0,[r13,0x4]
L_8fa4c4:
	mov_s r0,r13
L_8fa4c6:
	bl.d L_8ea598
L_8fa4ca:
	mov_s r1,r16
L_8fa4cc:
	b L_8fa6be
L_8fa4d0:
	mov_s r0,r13
L_8fa4d2:
	mov_s r1,r15
L_8fa4d4:
	bl L_8ed3c4
L_8fa4d8:
	ld_s r0,[r13]
L_8fa4da:
	mov.f r1,r2
L_8fa4de:
	bclr_s r0,r0,0x15
L_8fa4e0:
	st_s r0,[r13]
L_8fa4e2:
	mov.ne r1,0x1
L_8fa4e6:
	asl_s r1,r1
L_8fa4e8:
	mov_s r0,r13
L_8fa4ea:
	bl L_8ed4b4
L_8fa4ee:
	mov_s r1,r15
L_8fa4f0:
	bl L_8ed460
L_8fa4f4:
	mov_s r1,0x1
L_8fa4f6:
	bl L_8ed400
L_8fa4fa:
	ldb r1,[gp, 0xb1]
L_8fa4fe:
	bmsk_s r1,r1,0x3
	.global L_8fa500
L_8fa500:
	mov_s r0,r13
L_8fa502:
	bl L_8ed520
L_8fa506:
	mov_s r1,0x0
L_8fa508:
	bl L_8ed370
L_8fa50c:
	ld_s r0,[r13]
L_8fa50e:
	bset_s r0,r0,0x1f
L_8fa510:
	st_s r0,[r13]
L_8fa512:
	ld_s r0,[r13,0x4]
L_8fa514:
	bclr_s r0,r0,0x1
L_8fa516:
	st_s r0,[r13,0x4]
L_8fa518:
	add_s r0,r13,0x4
L_8fa51a:
	bl L_8ed4cc
L_8fa51e:
	ld_s r0,[r13,0x4]
L_8fa520:
	bclr_s r0,r0,0x0
L_8fa522:
	b_s L_8fa4c2
L_8fa524:
	mov_s r0,r13
L_8fa526:
	mov_s r1,0x1
L_8fa528:
	bl L_8ed3c4
L_8fa52c:
	ld_s r0,[r13]
L_8fa52e:
	mov.f r1,r2
L_8fa532:
	bclr_s r0,r0,0x15
L_8fa534:
	st_s r0,[r13]
L_8fa536:
	mov.ne r1,0x1
L_8fa53a:
	asl_s r1,r1
L_8fa53c:
	mov_s r0,r13
L_8fa53e:
	bl L_8ed4b4
L_8fa542:
	mov_s r1,r15
L_8fa544:
	bl L_8ed460
L_8fa548:
	bl L_8ed400
L_8fa54c:
	b_s L_8fa500
L_8fa54e:
	mov_s r0,r13
L_8fa550:
	mov_s r1,r15
L_8fa552:
	bl L_8ed3c4
L_8fa556:
	ld_s r0,[r13]
L_8fa558:
	bclr_s r0,r0,0x15
L_8fa55a:
	st_s r0,[r13]
L_8fa55c:
	mov_s r0,r13
L_8fa55e:
	bl L_8ed4b4
L_8fa562:
	bl L_8ed460
L_8fa566:
	mov_s r1,0x1
L_8fa568:
	bl L_8ed400
L_8fa56c:
	bl L_8ed520
L_8fa570:
	bl L_8ed448
L_8fa574:
	mov_s r1,0x2
L_8fa576:
	b_s L_8fa5a0
L_8fa578:
	mov_s r0,r13
L_8fa57a:
	mov_s r1,r15
L_8fa57c:
	bl L_8ed3c4
L_8fa580:
	ld_s r0,[r13]
L_8fa582:
	bclr_s r0,r0,0x15
L_8fa584:
	st_s r0,[r13]
L_8fa586:
	mov_s r0,r13
L_8fa588:
	bl L_8ed4b4
L_8fa58c:
	bl L_8ed460
L_8fa590:
	mov_s r1,0x1
L_8fa592:
	bl L_8ed400
L_8fa596:
	bl L_8ed520
L_8fa59a:
	bl L_8ed448
L_8fa59e:
	mov_s r1,r15
	.global L_8fa5a0
L_8fa5a0:
	bl L_8ed370
L_8fa5a4:
	ld_s r0,[r13]
L_8fa5a6:
	mov_s r1,0x0
L_8fa5a8:
	bset_s r0,r0,0x1f
L_8fa5aa:
	st_s r0,[r13]
L_8fa5ac:
	ld_s r0,[r13,0x4]
L_8fa5ae:
	bclr_s r0,r0,0x1
L_8fa5b0:
	st_s r0,[r13,0x4]
L_8fa5b2:
	add_s r0,r13,0x4
L_8fa5b4:
	bl L_8ed4cc
L_8fa5b8:
	b_s L_8fa44e
L_8fa5ba:
	mov_s r0,r13
L_8fa5bc:
	mov_s r1,0x1
L_8fa5be:
	bl L_8ed3c4
L_8fa5c2:
	ld_s r0,[r13]
L_8fa5c4:
	mov_s r1,r15
L_8fa5c6:
	bclr_s r0,r0,0x15
L_8fa5c8:
	st_s r0,[r13]
L_8fa5ca:
	mov_s r0,r13
L_8fa5cc:
	bl L_8ed4b4
L_8fa5d0:
	bl L_8ed460
L_8fa5d4:
	mov_s r1,0x1
L_8fa5d6:
	bl L_8ed400
L_8fa5da:
	mov_s r1,r15
L_8fa5dc:
	bl L_8ed520
L_8fa5e0:
	mov_s r1,0x1
L_8fa5e2:
	bl L_8ed448
L_8fa5e6:
	mov_s r1,0x2
L_8fa5e8:
	bl L_8ed370
L_8fa5ec:
	ld_s r0,[r13]
L_8fa5ee:
	mov_s r1,r15
L_8fa5f0:
	bmsk_s r0,r0,0x1e
L_8fa5f2:
	st_s r0,[r13]
L_8fa5f4:
	ld_s r0,[r13,0x4]
L_8fa5f6:
	bclr_s r0,r0,0x1
L_8fa5f8:
	st_s r0,[r13,0x4]
L_8fa5fa:
	add_s r0,r13,0x4
L_8fa5fc:
	bl L_8ed4cc
L_8fa600:
	ld_s r0,[r13,0x4]
L_8fa602:
	bset_s r0,r0,0x0
	.global L_8fa604
L_8fa604:
	bclr_s r0,r0,0x9
L_8fa606:
	st_s r0,[r13,0x4]
L_8fa608:
	b_s L_8fa6be
L_8fa60a:
	mov_s r0,r13
L_8fa60c:
	mov_s r1,0x1
L_8fa60e:
	bl L_8ed3c4
L_8fa612:
	ld_s r0,[r13]
L_8fa614:
	mov_s r1,r15
L_8fa616:
	bclr_s r0,r0,0x15
L_8fa618:
	st_s r0,[r13]
L_8fa61a:
	mov_s r0,r13
L_8fa61c:
	bl L_8ed4b4
L_8fa620:
	bl L_8ed460
L_8fa624:
	mov_s r1,0x1
L_8fa626:
	bl L_8ed400
L_8fa62a:
	mov_s r1,r15
L_8fa62c:
	bl L_8ed520
L_8fa630:
	mov_s r1,0x1
L_8fa632:
	bl L_8ed448
L_8fa636:
	mov_s r1,0x2
L_8fa638:
	bl L_8ed370
L_8fa63c:
	ld_s r0,[r13]
L_8fa63e:
	mov_s r1,r15
L_8fa640:
	bmsk_s r0,r0,0x1e
L_8fa642:
	st_s r0,[r13]
L_8fa644:
	ld_s r0,[r13,0x4]
L_8fa646:
	bclr_s r0,r0,0x1
L_8fa648:
	st_s r0,[r13,0x4]
L_8fa64a:
	add_s r0,r13,0x4
L_8fa64c:
	bl L_8ed4cc
L_8fa650:
	ld_s r0,[r13,0x4]
L_8fa652:
	bclr_s r0,r0,0x0
L_8fa654:
	b_s L_8fa604
L_8fa656:
	mov_s r0,r13
L_8fa658:
	mov_s r1,r15
L_8fa65a:
	bl L_8ed3c4
L_8fa65e:
	ld_s r0,[r13]
L_8fa660:
	bclr_s r0,r0,0x15
L_8fa662:
	st_s r0,[r13]
L_8fa664:
	mov_s r0,r13
L_8fa666:
	bl L_8ed4b4
L_8fa66a:
	bl L_8ed460
L_8fa66e:
	mov_s r1,0x1
L_8fa670:
	bl L_8ed400
L_8fa674:
	mov_s r1,r15
L_8fa676:
	bl L_8ed520
L_8fa67a:
	bl L_8ed448
L_8fa67e:
	bl L_8ed370
L_8fa682:
	ld_s r0,[r13]
L_8fa684:
	bmsk_s r0,r0,0x1e
L_8fa686:
	st_s r0,[r13]
L_8fa688:
	ld_s r0,[r13,0x4]
L_8fa68a:
	bclr_s r0,r0,0x1
L_8fa68c:
	st_s r0,[r13,0x4]
L_8fa68e:
	add_s r0,r13,0x4
L_8fa690:
	bl L_8ed4cc
L_8fa694:
	mov_s r1,0x803c00
L_8fa69a:
	ld_s r1,[r1,0xc]
L_8fa69c:
	ld_s r2,[r13,0x4]
L_8fa69e:
	cmp_s r1,0x0
L_8fa6a0:
	mov_s r1,0x1
L_8fa6a2:
	sub_s.ne r1,r1,r1
L_8fa6a4:
	bclr_s r2,r2,0x0
L_8fa6a6:
	or_s r1,r1,r2
L_8fa6a8:
	st_s r1,[r13,0x4]
L_8fa6aa:
	mov_s r1,0x18
L_8fa6ac:
	bl L_8ed52c
L_8fa6b0:
	ld_s r0,[r13,0x4]
L_8fa6b2:
	st 0x1c36ffe0,[r13, 0xc]
L_8fa6ba:
	bclr_s r0,r0,0x9
L_8fa6bc:
	st_s r0,[r13,0x4]
	.global L_8fa6be
L_8fa6be:
	b L_8c0244
L_8fa6c2:
	nop_s
