/* nav_db__update @ 0x92a6f4, 560 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Received bigger NAV than Current. Frame type: %d, Frame subtype: %d, Extention: %d
 *   MAC Address ADD0: %x, ADD1: %x, ADD2: %x
 *   nav_db.c
 * Зовут его: rx_nav_bi_step, rx_nav_update
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, bi_ap_mon__window_code, nav__read_hw_duration_flag, peer__aid_mismatch_flag, uc_read_tsf_lo, uc_sysassert
 */
	.section .text.nav_db__update,"ax",@progbits
	.global nav_db__update
nav_db__update:
	.global L_92a6f4
L_92a6f4:
	push_s blink
L_92a6f6:
	bl L_92020c
L_92a6fa:
	mov_s r15,r0
L_92a6fc:
	st.a r1,[sp,-0x10]
L_92a700:
	mov_s r0,0x886e80
L_92a706:
	ld_s r0,[r0,0x4]
L_92a708:
	mov_s r13,r2
L_92a70a:
	mov_s r14,0x800994
L_92a710:
	ldw_s r1,[r14,0x18]
L_92a712:
	extw_s r0,r0
L_92a714:
	cmp_s r1,r0
L_92a716:
	mov.cs r0,r1
L_92a71a:
	brhs.d r1,r2,L_92a72c
L_92a71e:
	mov_s r16,r3
L_92a720:
	cmp_s r13,r0
L_92a722:
	beq_s L_92a88a
	.global L_92a724
L_92a724:
	ldw_s r0,[r14,0x1a]
L_92a726:
	ldw_s r13,[r14,0x18]
L_92a728:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92a72a:
	stw_s r0,[r14,0x1a]
	.global L_92a72c
L_92a72c:
	mov_s r0,0x4d
L_92a72e:
	asl_s r0,r0,0x18
L_92a730:
	mov_s r32,r0
L_92a732:
	st.ab r0,[r25,0x4]
L_92a736:
	bclr r25,r25,0xa
L_92a73a:
	nop_s
L_92a73c:
	nop_s
L_92a73e:
	nop_s
L_92a740:
	stw r55,[sp, 0x4]
L_92a744:
	bl L_9315e8
L_92a748:
	ldb r2,[sp, 0x5]
L_92a74c:
	add_s r0,r0,r13
L_92a74e:
	sub r1,r0,r2
L_92a752:
	ldb_s r0,[r14,0x1c]
L_92a754:
	add r4,r0,r1
L_92a758:
	ld_s r1,[sp,0x0]
L_92a75a:
	lsr_s r1,r1,0x2
L_92a75c:
	bmsk_s r1,r1,0x1
L_92a75e:
	mov_s r0,0x0
L_92a760:
	brne r1,0x1,L_92a770
L_92a764:
	ld_s r2,[sp,0x0]
L_92a766:
	lsr_s r2,r2,0x4
L_92a768:
	bmsk_s r2,r2,0x3
L_92a76a:
	cmp_s r2,0xe
L_92a76c:
	mov.eq r0,0x1
	.global L_92a770
L_92a770:
	cmp_s r15,0x0
L_92a772:
	beq_s L_92a91c
L_92a774:
	ld r5,[r14, 0x4]
L_92a778:
	brne_s r0,0,L_92a782
L_92a77a:
	sub r2,r4,r5
L_92a77e:
	btst_s r2,0x1f
L_92a780:
	bne_s L_92a91c
	.global L_92a782
L_92a782:
	ld_s r2,[r14]
L_92a784:
	mov_s r6,r2
L_92a786:
	bbit0 r2,0x0,L_92a864
L_92a78a:
	add r2,r5,0x32
L_92a78e:
	sub r3,r4,r2
L_92a792:
	btst_s r3,0x1f
L_92a794:
	cmp.eq r0,0x0
L_92a798:
	bne_s L_92a864
L_92a79a:
	ld_s r0,[gp,-0x90]
L_92a79c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92a79e:
	brlo.d r0,0xb,L_92a864
L_92a7a2:
	st.as r0,[gp,-0x24]
L_92a7a6:
	ld_s r0,[sp,0x0]
L_92a7a8:
	mov r9,0x1001b00
L_92a7b0:
	lsr_s r0,r0,0x4
L_92a7b2:
	bmsk r8,r0,0x3
L_92a7b6:
	ld_s r0,[sp,0x0]
L_92a7b8:
	mov_s r2,0x80209c
L_92a7be:
	lsr_s r0,r0,0x8
L_92a7c0:
	bmsk r10,r0,0x3
L_92a7c4:
	ldb_s r0,[r2,0x4]
L_92a7c6:
	mov_s r7,r0
L_92a7c8:
	bbit0 r0,0x2,L_92a80c
L_92a7cc:
	ld_s r0,[r2]
L_92a7ce:
	mov_s r3,0x8020b0
L_92a7d4:
	add_s r15,r0,0x3
L_92a7d6:
	extb_s r15,r15
L_92a7d8:
	add2 r15,r3,r15
L_92a7dc:
	st r10,[r15]
L_92a7e0:
	add_s r15,r0,0x2
L_92a7e2:
	extb_s r15,r15
L_92a7e4:
	add2 r15,r3,r15
L_92a7e8:
	st r8,[r15]
L_92a7ec:
	add_s r15,r0,0x1
L_92a7ee:
	extb_s r15,r15
L_92a7f0:
	add2 r15,r3,r15
L_92a7f4:
	st_s r1,[r15]
L_92a7f6:
	bmsk r1,r9,0x13
L_92a7fa:
	or r1,r1,0xae000000
L_92a802:
	extb_s r15,r0
L_92a804:
	add2_s r3,r3,r15
L_92a806:
	st_s r1,[r3]
L_92a808:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_92a80a:
	st_s r0,[r2]
	.global L_92a80c
L_92a80c:
	mov r9,0x1001b54
L_92a814:
	ldw r8,[r16]
L_92a818:
	ldw r10,[r16, 0x2]
L_92a81c:
	ldw r15,[r16, 0x4]
L_92a820:
	bbit0 r7,0x2,L_92a864
L_92a824:
	ld_s r1,[r2]
L_92a826:
	mov_s r3,0x8020b0
L_92a82c:
	add_s r0,r1,0x3
L_92a82e:
	extb_s r0,r0
L_92a830:
	add2 r0,r3,r0
L_92a834:
	st_s r15,[r0]
L_92a836:
	add_s r0,r1,0x2
L_92a838:
	extb_s r0,r0
L_92a83a:
	add2 r0,r3,r0
L_92a83e:
	st r10,[r0]
L_92a842:
	add_s r0,r1,0x1
L_92a844:
	extb_s r0,r0
L_92a846:
	add2 r0,r3,r0
L_92a84a:
	st r8,[r0]
L_92a84e:
	bmsk r0,r9,0x13
L_92a852:
	or r0,r0,0xae000000
L_92a85a:
	extb_s r15,r1
L_92a85c:
	add2_s r3,r3,r15
L_92a85e:
	st_s r0,[r3]
L_92a860:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_92a862:
	st_s r1,[r2]
	.global L_92a864
L_92a864:
	sub r0,r4,r5
L_92a868:
	min r13,r0,r13
L_92a86c:
	st r4,[r14, 0x4]
L_92a870:
	bset r0,r6,0x0
L_92a874:
	bl.d L_926490
L_92a878:
	st_s r0,[r14]
L_92a87a:
	extb_s r0,r0
L_92a87c:
	mov_s r1,0xfffff0ff
L_92a882:
	brne r0,0x2,L_92a89c
L_92a886:
	st_s r1,[r14,0xc]
L_92a888:
	b_s L_92a8ae
	.global L_92a88a
L_92a88a:
	mov_s r0,blink
L_92a88c:
	mov_s r2,0x1001b80
L_92a892:
	mov_s r1,0x63
L_92a894:
	bl.d L_925548
L_92a898:
	mov_s r3,0x74
L_92a89a:
	b_s L_92a724
	.global L_92a89c
L_92a89c:
	ld_s r0,[gp,-0xd8]
L_92a89e:
	st_s r1,[r14,0x8]
L_92a8a0:
	and_s r0,r0,r1
L_92a8a2:
	bset_s r0,r0,0x1b
L_92a8a4:
	mov_s r32,r0
L_92a8a6:
	st.ab r0,[r25,0x4]
L_92a8aa:
	bclr r25,r25,0xa
	.global L_92a8ae
L_92a8ae:
	mov lp_count,0x3
L_92a8b2:
	mov_s r0,0x0
L_92a8b4:
	lp L_92a8c8
L_92a8b8:
	ldw.as r2,[r16,r0]
L_92a8bc:
	mov_s r1,0x8009a4
L_92a8c2:
	add1_s r1,r1,r0
L_92a8c4:
	stw_s r2,[r1]
L_92a8c6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_92a8c8
L_92a8c8:
	mov_s r3,0x8009c0
L_92a8ce:
	ld_s r2,[r3]
L_92a8d0:
	asr r1,r13,0x1f
L_92a8d4:
	ld_s r0,[r3,0x4]
L_92a8d6:
	add.f r2,r2,r13
L_92a8da:
	adc r0,r0,r1
L_92a8de:
	st_s r0,[r3,0x4]
L_92a8e0:
	mov_s r0,0x854880
L_92a8e6:
	st_s r2,[r0,0x74]
L_92a8e8:
	mov_s r0,0xff
L_92a8ea:
	st_s r2,[r3]
L_92a8ec:
	st_s r0,[sp,0x8]
L_92a8ee:
	bl.d L_926b9c
L_92a8f2:
	add_s r0,sp,0x8
L_92a8f4:
	breq_s r0,0,L_92a910
L_92a8f6:
	mov_s r0,0x0
L_92a8f8:
	st_s r0,[sp,0xc]
L_92a8fa:
	add_s r1,sp,0xc
L_92a8fc:
	bl.d L_9374d0
L_92a900:
	ldb_s r0,[sp,0x8]
L_92a902:
	mov_s r1,0x857180
L_92a908:
	add2_s r1,r1,r0
L_92a90a:
	ld_s r0,[r1,0x3c]
L_92a90c:
	add_s r0,r0,r13
L_92a90e:
	st_s r0,[r1,0x3c]
	.global L_92a910
L_92a910:
	mov_s r1,0x80090c
L_92a916:
	ld_s r0,[r1,0x20]
L_92a918:
	add_s r0,r0,r13
L_92a91a:
	st_s r0,[r1,0x20]
	.global L_92a91c
L_92a91c:
	b.d L_920274
L_92a920:
	add_s sp,sp,0x10
L_92a922:
	nop_s
