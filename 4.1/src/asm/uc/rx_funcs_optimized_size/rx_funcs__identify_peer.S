/* rx_funcs__identify_peer @ 0x926608, 568 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_funcs_optimized_size.c
 * Зовут его: rx_flow__handle_frame
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, get_tx_eligibility, mac_mode__switch_core_and_rf, rf_sector__program_selected, rx__mac_prepare, rx_funcs__on_rx_type_0x14, rx_funcs__record_level_800fa0, rx_funcs_copy_step, rx_funcs_step, uc_sysassert
 * Глобалы (через gp): 0x8005d8, 0x800604, 0x800608
 */
	.section .text.rx_funcs__identify_peer,"ax",@progbits
	.global rx_funcs__identify_peer
rx_funcs__identify_peer:
	.global L_926608
L_926608:
	push_s blink
L_92660a:
	bl.d L_920214
L_92660e:
	mov_s r1,0x1
L_926610:
	sub_s sp,sp,0xc
L_926612:
	ld_s r0,[gp,0xdc]
L_926614:
	mov_s r3,0x80401a
L_92661a:
	and r13,r0,0x8
L_92661e:
	mov_s r0,0x0
L_926620:
	or.f 0x0,r13,r0
L_926624:
	st.as r1,[gp,-0x10]
L_926628:
	ld.as r2,[gp,0x38]
L_92662c:
	bne_s L_926642
L_92662e:
	mov_s r3,0x801458
L_926634:
	ld_s r0,[r3,0x68]
L_926636:
	bset_s r2,r2,0xa
L_926638:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92663a:
	st_s r0,[r3,0x68]
L_92663c:
	st.as r2,[gp,0x38]
L_926640:
	b_s L_926660
	.global L_926642
L_926642:
	mov_s r2,0x800ef4
L_926648:
	ld_s r0,[r2,0x6c]
L_92664a:
	mov_s r13,0x800fcc
L_926650:
	breq_s r0,0,L_92668a
L_926652:
	mov_s r13,0x80100c
L_926658:
	ldw_s r14,[r3]
L_92665a:
	ldw_s r0,[r13,0x1c]
L_92665c:
	breq r14,r0,L_926666
	.global L_926660
L_926660:
	b.d L_926838
L_926664:
	mov_s r0,r1
	.global L_926666
L_926666:
	ldw_s r14,[r3,0x2]
L_926668:
	ldw_s r0,[r13,0x1e]
L_92666a:
	brne r14,r0,L_926660
L_92666e:
	ldw_s r3,[r3,0x4]
L_926670:
	ldw_s r0,[r13,0x20]
L_926672:
	brne r3,r0,L_926660
L_926676:
	mov_s r0,0x801418
L_92667c:
	ld_s r0,[r0]
L_92667e:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_926680:
	add1_s r0,r0,r0
L_926682:
	ld_s r0,[r2,r0]
L_926684:
	brne r0,0x11,L_9266ea
L_926688:
	b_s L_926660
	.global L_92668a
L_92668a:
	mov_s r0,0x8009cc
L_926690:
	ld_s r0,[r0,0x1c]
L_926692:
	mov_s r1,0x800680
L_926698:
	brne_s r0,0,L_9266d2
L_92669a:
	ldb r0,[r13, 0x68]
L_92669e:
	breq_s r0,0,L_9266d2
L_9266a0:
	norm r0,r0
L_9266a4:
	rsub r2,r0,0x1e
L_9266a8:
	asl_s r0,r2,0x3
L_9266aa:
	add3_s r0,r0,r0
L_9266ac:
	add_s r0,r0,0x801190
L_9266b2:
	ldw_s r13,[r0,0x2c]
L_9266b4:
	ldw_s r2,[r3]
L_9266b6:
	brne r13,r2,L_9266ca
L_9266ba:
	ldw_s r13,[r0,0x2e]
L_9266bc:
	ldw_s r2,[r3,0x2]
L_9266be:
	brne r13,r2,L_9266ca
L_9266c2:
	ldw_s r2,[r0,0x30]
L_9266c4:
	ldw_s r0,[r3,0x4]
L_9266c6:
	breq r0,r2,L_9266d2
	.global L_9266ca
L_9266ca:
	ld_s r0,[r1,0x4]
L_9266cc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9266ce:
	st_s r0,[r1,0x4]
L_9266d0:
	b_s L_926832
	.global L_9266d2
L_9266d2:
	ld_s r0,[r1]
L_9266d4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9266d6:
	st_s r0,[r1]
L_9266d8:
	ldw_s r0,[r3]
L_9266da:
	mov_s r1,0x80100c
L_9266e0:
	stw_s r0,[r1,0x1c]
L_9266e2:
	ldw_s r0,[r3,0x2]
L_9266e4:
	stw_s r0,[r1,0x1e]
L_9266e6:
	ldw_s r0,[r3,0x4]
L_9266e8:
	stw_s r0,[r1,0x20]
	.global L_9266ea
L_9266ea:
	mov_s r0,r36
L_9266ec:
	btst_s r0,0x6
L_9266ee:
	beq_s L_92680e
L_9266f0:
	mov_s r0,r37
L_9266f2:
	bbit0 r0,0x18,L_926782
L_9266f6:
	mov_s r1,0x801a08
L_9266fc:
	ldw_s r0,[gp,0xb0]
L_9266fe:
	ldw_s r1,[r1,0xc]
L_926700:
	breq r0,r1,L_92672c
L_926704:
	stw.as r1,[gp,0x58]
L_926708:
	or r1,r1,0x1730000
L_926710:
	mov_s r0,0x886d00
L_926716:
	st_s r1,[r0]
L_926718:
	sync
L_92671c:
	mov_s r0,0x38000200
L_926722:
	mov_s r32,r0
L_926724:
	st.ab r0,[r25,0x4]
L_926728:
	bclr r25,r25,0xa
	.global L_92672c
L_92672c:
	mov_s r0,0x804010
L_926732:
	ldw_s r0,[r0,0x10]
L_926734:
	btst_s r0,0x0
L_926736:
	bne_s L_926832
L_926738:
	mov_s r1,0x801038
L_92673e:
	ld_s r0,[r1]
L_926740:
	bset_s r0,r0,0x0
L_926742:
	st_s r0,[r1]
L_926744:
	mov_s r0,sp
L_926746:
	add_s r1,sp,0x4
L_926748:
	bl.d L_937238
L_92674c:
	mov_s r2,0x0
L_92674e:
	mov_s r0,r39
L_926750:
	bbit0 r0,0xf,L_926832
L_926754:
	bl L_92b7c4
L_926758:
	mov_s r0,0x801418
L_92675e:
	ld_s r1,[r0]
L_926760:
	mov_s r0,0x801b3c
L_926766:
	bl.d L_92a9f4
L_92676a:
	ld.as r0,[r0,r1]
L_92676e:
	mov_s r1,0x801038
L_926774:
	ld_s r0,[r1]
L_926776:
	bset_s r0,r0,0x1
L_926778:
	st_s r0,[r1]
L_92677a:
	mov_s r0,0x1
L_92677c:
	st.as r0,[gp,-0x1e]
L_926780:
	b_s L_926836
	.global L_926782
L_926782:
	mov_s r0,r37
L_926784:
	bbit0 r0,0x19,L_9267d6
L_926788:
	mov_s r13,0x801418
L_92678e:
	mov_s r0,0x80102c
L_926794:
	ld_s r1,[r13]
L_926796:
	ldb_s r0,[r0,0x6]
L_926798:
	btst r0,r1
L_92679c:
	mov_s r0,0x1
L_92679e:
	beq_s L_9267c8
L_9267a0:
	mov_s r0,sp
L_9267a2:
	add_s r1,sp,0x4
L_9267a4:
	bl.d L_92616c
L_9267a8:
	add_s r2,sp,0x8
L_9267aa:
	bl.d L_922a10
L_9267ae:
	ldb.x r0,[sp, 0x8]
L_9267b2:
	ld_s r0,[r13]
L_9267b4:
	ld_s r1,[sp,0x0]
L_9267b6:
	ld_s r2,[sp,0x4]
L_9267b8:
	bl.d L_937448
L_9267bc:
	mov_s r3,0x1
L_9267be:
	ld_s r0,[r13]
L_9267c0:
	bl.d L_92fc0c
L_9267c4:
	mov_s r1,0x1
L_9267c6:
	mov_s r0,0x0
	.global L_9267c8
L_9267c8:
	mov_s r2,0x801038
L_9267ce:
	ld_s r1,[r2]
L_9267d0:
	bset_s r1,r1,0x2
L_9267d2:
	st_s r1,[r2]
L_9267d4:
	b_s L_926838
	.global L_9267d6
L_9267d6:
	mov_s r0,r37
L_9267d8:
	bbit0 r0,0x1a,L_9267fc
L_9267dc:
	mov_s r0,sp
L_9267de:
	add_s r1,sp,0x4
L_9267e0:
	bl.d L_92616c
L_9267e4:
	add_s r2,sp,0x8
L_9267e6:
	bl.d L_922a10
L_9267ea:
	ldb.x r0,[sp, 0x8]
L_9267ee:
	mov_s r1,0x801038
L_9267f4:
	ld_s r0,[r1]
L_9267f6:
	bset_s r0,r0,0x3
L_9267f8:
	st_s r0,[r1]
L_9267fa:
	b_s L_926832
	.global L_9267fc
L_9267fc:
	mov_s r0,blink
L_9267fe:
	mov_s r2,0x1002428
L_926804:
	mov_s r1,0x11
L_926806:
	bl.d L_925548
L_92680a:
	mov_s r3,0x9e
L_92680c:
	b_s L_926832
	.global L_92680e
L_92680e:
	mov_s r0,0x801418
L_926814:
	ld_s r1,[r0]
L_926816:
	mov_s r0,0x80102c
L_92681c:
	ldb_s r0,[r0,0x8]
L_92681e:
	bbit0 r0,r1,L_926832
L_926822:
	bl L_92aa7c
L_926826:
	mov_s r0,0x801038
L_92682c:
	ld_s r0,[r0]
L_92682e:
	bbit1 r0,0x5,L_926836
	.global L_926832
L_926832:
	mov_s r0,0x1
L_926834:
	b_s L_926838
	.global L_926836
L_926836:
	mov_s r0,0x0
	.global L_926838
L_926838:
	b.d L_920284
L_92683c:
	add_s sp,sp,0xc
L_92683e:
	nop_s
