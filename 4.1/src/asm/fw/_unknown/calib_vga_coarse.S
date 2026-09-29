/* calib_vga_coarse @ 0x8d2590, 436 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, calib_vga_coarse_limit, hwd_abif__set_agc_column, memcpy_fw
 */
	.section .text.calib_vga_coarse,"ax",@progbits
	.global calib_vga_coarse
calib_vga_coarse:
	.global L_8d2590
L_8d2590:
	sub_s sp,sp,0x20
L_8d2592:
	push_s blink
L_8d2594:
	bl L_8c02a4
L_8d2598:
	sub_s sp,sp,0x28
L_8d259a:
	mov_s r21,r0
L_8d259c:
	mov_s r20,r1
L_8d259e:
	mov_s r19,r2
L_8d25a0:
	mov_s r18,r3
L_8d25a2:
	mov r17,r4
L_8d25a6:
	mov r16,r5
L_8d25aa:
	ldb r14,[sp, 0xa0]
L_8d25ae:
	st r7,[sp, 0x24]
L_8d25b2:
	st r6,[sp, 0x20]
L_8d25b6:
	mov_s r2,0x0
L_8d25b8:
	breq r14,0x1,L_8d25ea
L_8d25bc:
	ld r0,[sp, 0x8c]
L_8d25c0:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d25c2:
	ldb_s r0,[r0,r14]
L_8d25c4:
	breq r0,0x1,L_8d25dc
L_8d25c8:
	cmp_s r0,0x2
L_8d25ca:
	cmp.ne r0,0x3
L_8d25ce:
	beq_s L_8d25ea
L_8d25d0:
	ld r0,[sp, 0xac]
L_8d25d4:
	mov_s r1,0x2
L_8d25d6:
	st_s r1,[r0]
L_8d25d8:
	mov_s r1,r2
L_8d25da:
	b_s L_8d25f4
	.global L_8d25dc
L_8d25dc:
	mov_s r2,0xffff0000
L_8d25e2:
	mov_s r1,0xfff80000
L_8d25e8:
	b_s L_8d25f4
	.global L_8d25ea
L_8d25ea:
	mov_s r2,0x5
L_8d25ec:
	asl_s r2,r2,0x10
L_8d25ee:
	mov_s r1,0xfffe0000
	.global L_8d25f4
L_8d25f4:
	ldb_s r0,[sp,0x7c]
L_8d25f6:
	brne r0,0x1,L_8d2624
L_8d25fa:
	ldb r0,[sp, 0xa8]
L_8d25fe:
	ld r13,[sp, 0x90]
L_8d2602:
	ld r15,[sp, 0x98]
L_8d2606:
	brne r0,0x0,L_8d2696
L_8d260a:
	b_s L_8d2668
	.global L_8d260c
L_8d260c:
	mov_s r0,0x1
L_8d260e:
	ld_s r1,[sp,0x74]
L_8d2610:
	st_s r0,[r15]
L_8d2612:
	st_s r1,[sp,0x0]
	.global L_8d2614
L_8d2614:
	mov_s r1,0x0
L_8d2616:
	st_s r13,[sp,0x4]
	.global L_8d2618
L_8d2618:
	st_s r0,[sp,0x8]
L_8d261a:
	ld r0,[sp, 0x9c]
L_8d261e:
	st_s r0,[sp,0xc]
L_8d2620:
	st_s r14,[sp,0x10]
L_8d2622:
	b_s L_8d2648
	.global L_8d2624
L_8d2624:
	ldb r0,[sp, 0x7d]
L_8d2628:
	brne r0,0x1,L_8d264c
L_8d262c:
	ld_s r0,[sp,0x74]
L_8d262e:
	st_s r14,[sp,0x10]
L_8d2630:
	st_s r0,[sp,0x0]
L_8d2632:
	ld r0,[sp, 0x90]
L_8d2636:
	mov_s r1,0x0
L_8d2638:
	st_s r0,[sp,0x4]
L_8d263a:
	ld r0,[sp, 0x98]
L_8d263e:
	ld_s r0,[r0]
L_8d2640:
	st_s r0,[sp,0x8]
L_8d2642:
	ld r0,[sp, 0x9c]
L_8d2646:
	st_s r0,[sp,0xc]
	.global L_8d2648
L_8d2648:
	st_s r1,[sp,0x14]
L_8d264a:
	b_s L_8d26ac
	.global L_8d264c
L_8d264c:
	ld_s r3,[sp,0x78]
L_8d264e:
	brge r2,r3,L_8d26d8
L_8d2652:
	ldb r0,[sp, 0xa8]
L_8d2656:
	ld r13,[sp, 0x90]
L_8d265a:
	ld r15,[sp, 0x98]
L_8d265e:
	brne_s r0,0,L_8d2696
L_8d2660:
	ld r0,[sp, 0x80]
L_8d2664:
	brge r0,r2,L_8d2696
	.global L_8d2668
L_8d2668:
	ldb r0,[sp, 0x84]
L_8d266c:
	brne_s r0,0,L_8d2696
L_8d266e:
	ld r1,[sp, 0x88]
L_8d2672:
	mov_s r0,r13
L_8d2674:
	bl.d L_8c0460
L_8d2678:
	mov_s r2,0x4
L_8d267a:
	mov_s r0,0x28
L_8d267c:
	mov_s r1,0x0
L_8d267e:
	mov_s r22,r1
L_8d2680:
	bl.d L_8cc050
L_8d2684:
	ld r2,[sp, 0x94]
L_8d2688:
	brhs r14,0x2,L_8d260c
L_8d268c:
	ld_s r0,[r15]
L_8d268e:
	breq r0,0x1,L_8d260c
L_8d2692:
	mov_s r0,r22
L_8d2694:
	b_s L_8d271e
	.global L_8d2696
L_8d2696:
	ld_s r0,[sp,0x74]
L_8d2698:
	st_s r13,[sp,0x4]
L_8d269a:
	st_s r0,[sp,0x0]
L_8d269c:
	ld_s r0,[r15]
L_8d269e:
	st_s r14,[sp,0x10]
L_8d26a0:
	st_s r0,[sp,0x8]
L_8d26a2:
	ld r0,[sp, 0x9c]
L_8d26a6:
	st_s r0,[sp,0xc]
L_8d26a8:
	mov_s r0,0x1
L_8d26aa:
	st_s r0,[sp,0x14]
	.global L_8d26ac
L_8d26ac:
	ld r0,[sp, 0xa4]
L_8d26b0:
	mov_s r1,r20
L_8d26b2:
	st_s r0,[sp,0x18]
L_8d26b4:
	ld r0,[sp, 0xac]
L_8d26b8:
	mov_s r2,r19
L_8d26ba:
	st_s r0,[sp,0x1c]
L_8d26bc:
	ld r6,[sp, 0x20]
L_8d26c0:
	mov_s r0,r21
L_8d26c2:
	mov_s r3,r18
L_8d26c4:
	mov r4,r17
L_8d26c8:
	mov r5,r16
L_8d26cc:
	bl.d L_8d5274
L_8d26d0:
	ld r7,[sp, 0x24]
L_8d26d4:
	mov_s r0,0x0
L_8d26d6:
	b_s L_8d2728
	.global L_8d26d8
L_8d26d8:
	brge.d r3,r1,L_8d271e
L_8d26dc:
	mov_s r0,0x0
L_8d26de:
	ldb r1,[sp, 0xa8]
L_8d26e2:
	brne_s r1,0,L_8d270a
L_8d26e4:
	brlo r14,0x2,L_8d270a
L_8d26e8:
	ldb r0,[sp, 0x84]
L_8d26ec:
	breq r0,0x1,L_8d26f8
L_8d26f0:
	ld r0,[sp, 0x80]
L_8d26f4:
	brge r2,r0,L_8d270a
	.global L_8d26f8
L_8d26f8:
	ld r1,[sp, 0x98]
L_8d26fc:
	mov_s r0,0x1
L_8d26fe:
	st_s r0,[r1]
L_8d2700:
	ld_s r1,[sp,0x74]
L_8d2702:
	st_s r1,[sp,0x0]
L_8d2704:
	ld r13,[sp, 0x90]
L_8d2708:
	b_s L_8d2614
	.global L_8d270a
L_8d270a:
	breq r1,0x1,L_8d2730
L_8d270e:
	ldb r0,[sp, 0x84]
L_8d2712:
	brne_s r0,0,L_8d271c
L_8d2714:
	ld r0,[sp, 0x80]
L_8d2718:
	brlt r0,r2,L_8d2730
	.global L_8d271c
L_8d271c:
	mov_s r0,0x0
	.global L_8d271e
L_8d271e:
	ld r2,[sp, 0xa4]
L_8d2722:
	mov_s r1,0x1
L_8d2724:
	stb_s r0,[r2]
L_8d2726:
	mov_s r0,r1
	.global L_8d2728
L_8d2728:
	mov_s r12,0x24
L_8d272a:
	b.d L_8c02f6
L_8d272e:
	add_s sp,sp,0x28
	.global L_8d2730
L_8d2730:
	ld_s r0,[sp,0x74]
L_8d2732:
	st_s r0,[sp,0x0]
L_8d2734:
	ld r0,[sp, 0x90]
L_8d2738:
	st_s r0,[sp,0x4]
L_8d273a:
	ld r0,[sp, 0x98]
L_8d273e:
	ld_s r0,[r0]
L_8d2740:
	mov_s r1,0x0
L_8d2742:
	b_s L_8d2618
