/* rf_chain__program_sector_desc @ 0x8f2474, 784 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain_dist_config, sw_vring__setup_ba_win
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s0_w4, bf_w_s14_w2, bf_w_s16_w5, bf_w_s22_w2, bf_w_s24_w2, bf_w_s29_w2, bf_w_s2_w2, bf_w_s4_w4, bf_w_s4_w5, get_g_80001c
 * Глобалы (через gp): 0x800388
 */
	.section .text.rf_chain__program_sector_desc,"ax",@progbits
	.global rf_chain__program_sector_desc
rf_chain__program_sector_desc:
	.global L_8f2474
L_8f2474:
	push_s blink
L_8f2476:
	bl.d L_8c02bc
L_8f247a:
	bmsk_s r3,r3,0x0
L_8f247c:
	mov_s r13,r0
L_8f247e:
	mov_s r14,r1
L_8f2480:
	mov_s r16,r2
L_8f2482:
	mov_s r15,0x0
L_8f2484:
	st_s r15,[r0,0x8]
L_8f2486:
	st 0xa0a0a0a0,[r0, 0xc]
L_8f248e:
	ld_s r0,[r0,0x4]
L_8f2490:
	asl_s r3,r3,0x9
L_8f2492:
	bclr_s r0,r0,0x9
L_8f2494:
	or_s r0,r0,r3
L_8f2496:
	st_s r0,[r13,0x4]
L_8f2498:
	bmsk r1,r4,0x4
L_8f249c:
	add_s r0,r13,0x4
L_8f249e:
	bl.d L_8e8504
L_8f24a2:
	mov_s r2,r5
L_8f24a4:
	cmp_s r14,0xa
L_8f24a6:
	bhi L_8f277e
L_8f24aa:
	ldw.x.as r14,[0x802268,r14]
L_8f24b2:
	add r0,pcl,0xa
L_8f24b6:
	add1_s r0,r0,r14
L_8f24b8:
	j_s [r0]
L_8f24ba:
	mov_s r0,r13
L_8f24bc:
	mov_s r1,r15
L_8f24be:
	bl L_8e839c
L_8f24c2:
	ld_s r0,[r13]
L_8f24c4:
	mov.f r1,r2
L_8f24c8:
	bset_s r0,r0,0x15
L_8f24ca:
	st_s r0,[r13]
L_8f24cc:
	mov.ne r1,0x1
L_8f24d0:
	asl_s r1,r1
L_8f24d2:
	mov_s r0,r13
L_8f24d4:
	bl L_8e848c
L_8f24d8:
	mov_s r1,r15
L_8f24da:
	bl L_8e8438
L_8f24de:
	ld.as r1,[gp,0x86]
L_8f24e2:
	bmsk_s r1,r1,0x4
L_8f24e4:
	bl L_8e83d8
L_8f24e8:
	mov_s r1,0x1
L_8f24ea:
	bl L_8e84f8
L_8f24ee:
	mov_s r1,0x2
L_8f24f0:
	bl L_8e8420
L_8f24f4:
	mov_s r1,r15
L_8f24f6:
	bl L_8e8348
L_8f24fa:
	ld_s r0,[r13]
L_8f24fc:
	bmsk_s r0,r0,0x1e
L_8f24fe:
	st_s r0,[r13]
L_8f2500:
	ld_s r0,[r13,0x4]
L_8f2502:
	bclr_s r0,r0,0x1
L_8f2504:
	st_s r0,[r13,0x4]
L_8f2506:
	add_s r0,r13,0x4
L_8f2508:
	bl L_8e84a4
L_8f250c:
	ld_s r0,[r13,0x4]
L_8f250e:
	bclr_s r0,r0,0x9
L_8f2510:
	bl.d L_8ca0c4
L_8f2514:
	st_s r0,[r13,0x4]
L_8f2516:
	breq_s r0,0,L_8f252a
L_8f2518:
	bl L_8ca138
L_8f251c:
	ld_s r1,[r13,0x4]
L_8f251e:
	bmsk_s r0,r0,0x0
L_8f2520:
	bclr_s r1,r1,0x0
L_8f2522:
	or_s r0,r0,r1
L_8f2524:
	b.d L_8f277e
L_8f2528:
	st_s r0,[r13,0x4]
	.global L_8f252a
L_8f252a:
	ld_s r0,[r13,0x4]
L_8f252c:
	bclr_s r0,r0,0x0
L_8f252e:
	b.d L_8f277e
L_8f2532:
	st_s r0,[r13,0x4]
L_8f2534:
	mov_s r0,r13
L_8f2536:
	mov_s r1,r15
L_8f2538:
	bl L_8e839c
L_8f253c:
	ld_s r0,[r13]
L_8f253e:
	mov.f r1,r2
L_8f2542:
	bclr_s r0,r0,0x15
L_8f2544:
	st_s r0,[r13]
L_8f2546:
	mov.ne r1,0x1
L_8f254a:
	asl_s r1,r1
L_8f254c:
	mov_s r0,r13
L_8f254e:
	bl L_8e848c
L_8f2552:
	mov_s r1,r15
L_8f2554:
	bl L_8e8438
L_8f2558:
	mov_s r1,0x1
L_8f255a:
	bl L_8e83d8
L_8f255e:
	bl L_8e84f8
L_8f2562:
	mov_s r1,0x2
L_8f2564:
	bl L_8e8420
L_8f2568:
	mov_s r1,r15
L_8f256a:
	bl L_8e8348
L_8f256e:
	ld_s r0,[r13]
L_8f2570:
	bset_s r0,r0,0x1f
L_8f2572:
	st_s r0,[r13]
L_8f2574:
	ld_s r0,[r13,0x4]
L_8f2576:
	bclr_s r0,r0,0x1
L_8f2578:
	st_s r0,[r13,0x4]
L_8f257a:
	add_s r0,r13,0x4
L_8f257c:
	bl L_8e84a4
L_8f2580:
	mov_s r0,0x80345c
L_8f2586:
	ld_s r0,[r0,0xc]
L_8f2588:
	brne_s r0,0,L_8f2590
L_8f258a:
	bl L_8cabd8
L_8f258e:
	mov_s r15,r0
	.global L_8f2590
L_8f2590:
	ld_s r0,[r13,0x4]
L_8f2592:
	bmsk_s r15,r15,0x0
L_8f2594:
	bclr_s r0,r0,0x0
L_8f2596:
	or_s r0,r0,r15
	.global L_8f2598
L_8f2598:
	st_s r0,[r13,0x4]
L_8f259a:
	mov_s r0,r13
L_8f259c:
	bl.d L_8e5270
L_8f25a0:
	mov_s r1,r16
L_8f25a2:
	b_s L_8f277e
L_8f25a4:
	mov_s r0,r13
L_8f25a6:
	mov_s r1,r15
L_8f25a8:
	bl L_8e839c
L_8f25ac:
	ld_s r0,[r13]
L_8f25ae:
	mov.f r1,r2
L_8f25b2:
	bclr_s r0,r0,0x15
L_8f25b4:
	st_s r0,[r13]
L_8f25b6:
	mov.ne r1,0x1
L_8f25ba:
	asl_s r1,r1
L_8f25bc:
	mov_s r0,r13
L_8f25be:
	bl L_8e848c
L_8f25c2:
	mov_s r1,r15
L_8f25c4:
	bl L_8e8438
L_8f25c8:
	mov_s r1,0x1
	.global L_8f25ca
L_8f25ca:
	bl L_8e83d8
L_8f25ce:
	mov_s r0,r13
L_8f25d0:
	bl L_8e84f8
L_8f25d4:
	mov_s r1,0x0
L_8f25d6:
	bl L_8e8348
L_8f25da:
	ld_s r0,[r13]
L_8f25dc:
	bset_s r0,r0,0x1f
L_8f25de:
	st_s r0,[r13]
L_8f25e0:
	ld_s r0,[r13,0x4]
L_8f25e2:
	bclr_s r0,r0,0x1
L_8f25e4:
	st_s r0,[r13,0x4]
L_8f25e6:
	add_s r0,r13,0x4
L_8f25e8:
	bl L_8e84a4
L_8f25ec:
	ld_s r0,[r13,0x4]
L_8f25ee:
	bclr_s r0,r0,0x0
L_8f25f0:
	b_s L_8f2598
L_8f25f2:
	mov_s r0,r13
L_8f25f4:
	mov_s r1,0x1
L_8f25f6:
	bl L_8e839c
L_8f25fa:
	ld_s r0,[r13]
L_8f25fc:
	mov_s r1,r15
L_8f25fe:
	bclr_s r0,r0,0x15
L_8f2600:
	st_s r0,[r13]
L_8f2602:
	mov_s r0,r13
L_8f2604:
	bl L_8e848c
L_8f2608:
	bl L_8e8438
L_8f260c:
	b_s L_8f25ca
L_8f260e:
	mov_s r0,r13
L_8f2610:
	mov_s r1,r15
L_8f2612:
	bl L_8e839c
L_8f2616:
	ld_s r0,[r13]
L_8f2618:
	bclr_s r0,r0,0x15
L_8f261a:
	st_s r0,[r13]
L_8f261c:
	mov_s r0,r13
L_8f261e:
	bl L_8e848c
L_8f2622:
	bl L_8e8438
L_8f2626:
	mov_s r1,0x1
L_8f2628:
	bl L_8e83d8
L_8f262c:
	bl L_8e84f8
L_8f2630:
	bl L_8e8420
L_8f2634:
	mov_s r1,0x2
L_8f2636:
	b_s L_8f2660
L_8f2638:
	mov_s r0,r13
L_8f263a:
	mov_s r1,r15
L_8f263c:
	bl L_8e839c
L_8f2640:
	ld_s r0,[r13]
L_8f2642:
	bclr_s r0,r0,0x15
L_8f2644:
	st_s r0,[r13]
L_8f2646:
	mov_s r0,r13
L_8f2648:
	bl L_8e848c
L_8f264c:
	bl L_8e8438
L_8f2650:
	mov_s r1,0x1
L_8f2652:
	bl L_8e83d8
L_8f2656:
	bl L_8e84f8
L_8f265a:
	bl L_8e8420
L_8f265e:
	mov_s r1,r15
	.global L_8f2660
L_8f2660:
	bl L_8e8348
L_8f2664:
	ld_s r0,[r13]
L_8f2666:
	mov_s r1,0x0
L_8f2668:
	bset_s r0,r0,0x1f
L_8f266a:
	st_s r0,[r13]
L_8f266c:
	ld_s r0,[r13,0x4]
L_8f266e:
	bclr_s r0,r0,0x1
L_8f2670:
	st_s r0,[r13,0x4]
L_8f2672:
	add_s r0,r13,0x4
L_8f2674:
	bl L_8e84a4
L_8f2678:
	b_s L_8f252a
L_8f267a:
	mov_s r0,r13
L_8f267c:
	mov_s r1,0x1
L_8f267e:
	bl L_8e839c
L_8f2682:
	ld_s r0,[r13]
L_8f2684:
	mov_s r1,r15
L_8f2686:
	bclr_s r0,r0,0x15
L_8f2688:
	st_s r0,[r13]
L_8f268a:
	mov_s r0,r13
L_8f268c:
	bl L_8e848c
L_8f2690:
	bl L_8e8438
L_8f2694:
	mov_s r1,0x1
L_8f2696:
	bl L_8e83d8
L_8f269a:
	mov_s r1,r15
L_8f269c:
	bl L_8e84f8
L_8f26a0:
	mov_s r1,0x1
L_8f26a2:
	bl L_8e8420
L_8f26a6:
	mov_s r1,0x2
L_8f26a8:
	bl L_8e8348
L_8f26ac:
	ld_s r0,[r13]
L_8f26ae:
	mov_s r1,r15
L_8f26b0:
	bmsk_s r0,r0,0x1e
L_8f26b2:
	st_s r0,[r13]
L_8f26b4:
	ld_s r0,[r13,0x4]
L_8f26b6:
	bclr_s r0,r0,0x1
L_8f26b8:
	st_s r0,[r13,0x4]
L_8f26ba:
	add_s r0,r13,0x4
L_8f26bc:
	bl L_8e84a4
L_8f26c0:
	ld_s r0,[r13,0x4]
L_8f26c2:
	bset_s r0,r0,0x0
	.global L_8f26c4
L_8f26c4:
	bclr_s r0,r0,0x9
L_8f26c6:
	st_s r0,[r13,0x4]
L_8f26c8:
	b_s L_8f277e
L_8f26ca:
	mov_s r0,r13
L_8f26cc:
	mov_s r1,0x1
L_8f26ce:
	bl L_8e839c
L_8f26d2:
	ld_s r0,[r13]
L_8f26d4:
	mov_s r1,r15
L_8f26d6:
	bclr_s r0,r0,0x15
L_8f26d8:
	st_s r0,[r13]
L_8f26da:
	mov_s r0,r13
L_8f26dc:
	bl L_8e848c
L_8f26e0:
	bl L_8e8438
L_8f26e4:
	mov_s r1,0x1
L_8f26e6:
	bl L_8e83d8
L_8f26ea:
	mov_s r1,r15
L_8f26ec:
	bl L_8e84f8
L_8f26f0:
	mov_s r1,0x1
L_8f26f2:
	bl L_8e8420
L_8f26f6:
	mov_s r1,0x2
L_8f26f8:
	bl L_8e8348
L_8f26fc:
	ld_s r0,[r13]
L_8f26fe:
	mov_s r1,r15
L_8f2700:
	bmsk_s r0,r0,0x1e
L_8f2702:
	st_s r0,[r13]
L_8f2704:
	ld_s r0,[r13,0x4]
L_8f2706:
	bclr_s r0,r0,0x1
L_8f2708:
	st_s r0,[r13,0x4]
L_8f270a:
	add_s r0,r13,0x4
L_8f270c:
	bl L_8e84a4
L_8f2710:
	ld_s r0,[r13,0x4]
L_8f2712:
	bclr_s r0,r0,0x0
L_8f2714:
	b_s L_8f26c4
L_8f2716:
	mov_s r0,r13
L_8f2718:
	mov_s r1,r15
L_8f271a:
	bl L_8e839c
L_8f271e:
	ld_s r0,[r13]
L_8f2720:
	bclr_s r0,r0,0x15
L_8f2722:
	st_s r0,[r13]
L_8f2724:
	mov_s r0,r13
L_8f2726:
	bl L_8e848c
L_8f272a:
	bl L_8e8438
L_8f272e:
	mov_s r1,0x1
L_8f2730:
	bl L_8e83d8
L_8f2734:
	mov_s r1,r15
L_8f2736:
	bl L_8e84f8
L_8f273a:
	bl L_8e8420
L_8f273e:
	bl L_8e8348
L_8f2742:
	ld_s r0,[r13]
L_8f2744:
	bmsk_s r0,r0,0x1e
L_8f2746:
	st_s r0,[r13]
L_8f2748:
	ld_s r0,[r13,0x4]
L_8f274a:
	bclr_s r0,r0,0x1
L_8f274c:
	st_s r0,[r13,0x4]
L_8f274e:
	add_s r0,r13,0x4
L_8f2750:
	bl L_8e84a4
L_8f2754:
	mov_s r1,0x80345c
L_8f275a:
	ld_s r1,[r1,0xc]
L_8f275c:
	ld_s r2,[r13,0x4]
L_8f275e:
	cmp_s r1,0x0
L_8f2760:
	mov_s r1,0x1
L_8f2762:
	sub_s.ne r1,r1,r1
L_8f2764:
	bclr_s r2,r2,0x0
L_8f2766:
	or_s r1,r1,r2
L_8f2768:
	st_s r1,[r13,0x4]
L_8f276a:
	mov_s r1,0x18
L_8f276c:
	bl L_8e8504
L_8f2770:
	ld_s r0,[r13,0x4]
L_8f2772:
	st 0x1c36ffe0,[r13, 0xc]
L_8f277a:
	bclr_s r0,r0,0x9
L_8f277c:
	st_s r0,[r13,0x4]
	.global L_8f277e
L_8f277e:
	b L_8c0324
L_8f2782:
	nop_s
