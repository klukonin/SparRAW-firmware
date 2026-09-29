/* l1_task__entry @ 0x929738, 572 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l1_task.c
 *   L1_TASK PRE TBTT
 * Зовут его: uc_isr_l1_task0, uc_isr_l1_task1, uc_isr_l1_task2, uc_isr_l1_task3
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__check_request_timeout, bi_ap_mon_if__trigger, bi_manager__l1_entry_b, bi_manager__l1_rx_entry, bi_manager__run_rx_flow_by_kind, grant_detect_step, l1_bi_trigger_step, l1_task__check_pending, l1_task__kick_and_dispatch, power_manager__tick_if_elapsed, set_reg_886d80_925b34
 * Глобалы (через gp): 0x80055c, 0x80058c, 0x8005d6
 */
	.section .text.l1_task__entry,"ax",@progbits
	.global l1_task__entry
l1_task__entry:
	.global L_929738
L_929738:
	push_s blink
L_92973a:
	push_s r13
L_92973c:
	breq_s r0,0,L_929788
L_92973e:
	cmp_s r0,0x1
L_929740:
	beq_s L_9297ee
L_929742:
	cmp_s r0,0x2
L_929744:
	beq L_929900
L_929748:
	cmp_s r0,0x3
L_92974a:
	bne L_929956
L_92974e:
	ldb_s r0,[gp,-0xe5]
L_929750:
	cmp_s r0,0x0
L_929752:
	bne L_92995a
	.global L_929756
L_929756:
	mov_s r1,0x8006a4
L_92975c:
	ld_s r2,[r1,0xc]
L_92975e:
	ld_s r0,[r1,0x4]
L_929760:
	sr r2,[r0]
L_929764:
	ld_s r0,[r1,0x10]
L_929766:
	sr 0x0,[r0]
L_92976e:
	bl L_9220a4
L_929772:
	bl L_92b220
L_929776:
	mov_s r0,0x0
L_929778:
	mov_s r1,r0
L_92977a:
	bl.d L_92a558
L_92977e:
	mov_s r2,0x1
L_929780:
	bl L_92ce0c
L_929784:
	b L_929956
	.global L_929788
L_929788:
	mov_s r0,0xcafcaf
L_92978e:
	mov_s r32,r0
L_929790:
	st.ab r0,[r25,0x4]
L_929794:
	bclr r25,r25,0xa
L_929798:
	mov_s r0,0x886d80
L_92979e:
	ld_s r13,[r0,0x54]
L_9297a0:
	or r0,r13,0xf000
L_9297a8:
	mov_s r32,r0
L_9297aa:
	st.ab r0,[r25,0x4]
L_9297ae:
	bclr r25,r25,0xa
	.global L_9297b2
L_9297b2:
	bbit0 r13,0x0,L_9297be
L_9297b6:
	bl.d L_925a08
L_9297ba:
	bclr_s r13,r13,0x0
L_9297bc:
	b_s L_9297ea
	.global L_9297be
L_9297be:
	bbit0 r13,0x1,L_9297ca
L_9297c2:
	bl.d L_925b34
L_9297c6:
	bclr_s r13,r13,0x1
L_9297c8:
	b_s L_9297ea
	.global L_9297ca
L_9297ca:
	bbit0 r13,0x2,L_9297d6
L_9297ce:
	bl.d L_925b48
L_9297d2:
	bclr_s r13,r13,0x2
L_9297d4:
	b_s L_9297ea
	.global L_9297d6
L_9297d6:
	mov_s r0,blink
L_9297d8:
	mov_s r2,0x1000600
L_9297de:
	mov_s r1,0x1315
L_9297e4:
	bl.d L_925548
L_9297e8:
	mov_s r3,0x36
	.global L_9297ea
L_9297ea:
	brne_s r13,0,L_9297b2
L_9297ec:
	b_s L_929956
	.global L_9297ee
L_9297ee:
	mov_s r0,0xcafcaa
L_9297f4:
	mov_s r32,r0
L_9297f6:
	st.ab r0,[r25,0x4]
L_9297fa:
	bclr r25,r25,0xa
L_9297fe:
	bmsk r0,r42,0x17
L_929802:
	mov_s r32,r0
L_929804:
	st.ab r0,[r25,0x4]
L_929808:
	bclr r25,r25,0xa
L_92980c:
	mov_s r0,0x8006a4
L_929812:
	ld_s r0,[r0,0x10]
L_929814:
	lr r0,[r0]
L_929818:
	bmsk_s r0,r0,0x17
L_92981a:
	mov_s r32,r0
L_92981c:
	st.ab r0,[r25,0x4]
L_929820:
	bclr r25,r25,0xa
L_929824:
	ldb_s r0,[gp,-0xe5]
L_929826:
	brne_s r0,0,L_92984c
	.global L_929828
L_929828:
	ldw_s r0,[gp,0xae]
L_92982a:
	breq_s r0,0,L_929862
	.global L_92982c
L_92982c:
	mov_s r0,r42
L_92982e:
	bbit0 r0,0x13,L_929886
L_929832:
	ld_s r0,[gp,0x64]
L_929834:
	cmp_s r0,0x1
L_929836:
	mov_s r0,0x1
L_929838:
	sub_s.ne r0,r0,r0
L_92983a:
	extb.f 0x0,r0
L_92983e:
	beq_s L_929874
	.global L_929840
L_929840:
	mov_s r0,0x801e94
L_929846:
	bl L_928730
L_92984a:
	b_s L_9298de
	.global L_92984c
L_92984c:
	mov_s r0,blink
L_92984e:
	mov_s r2,0x1000600
L_929854:
	mov_s r1,0x1314
L_92985a:
	bl.d L_925548
L_92985e:
	mov_s r3,0x4c
L_929860:
	b_s L_929828
	.global L_929862
L_929862:
	mov_s r0,blink
L_929864:
	mov_s r2,0x1000600
L_92986a:
	mov_s r1,0x27
L_92986c:
	bl.d L_925548
L_929870:
	mov_s r3,0x58
L_929872:
	b_s L_92982c
	.global L_929874
L_929874:
	mov_s r0,blink
L_929876:
	mov_s r2,0x1000600
L_92987c:
	mov_s r1,0x28
L_92987e:
	bl.d L_925548
L_929882:
	mov_s r3,0x5e
L_929884:
	b_s L_929840
	.global L_929886
L_929886:
	mov_s r0,r42
L_929888:
	bbit0 r0,0x4,L_9298ce
L_92988c:
	mov_s r1,0x801e14
L_929892:
	ldw_s r0,[r1]
L_929894:
	mov_s r2,0x80209c
L_92989a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92989c:
	stw_s r0,[r1]
L_92989e:
	ldb_s r1,[r2,0x4]
L_9298a0:
	mov_s r0,0x100060c
L_9298a6:
	bbit0 r1,0x2,L_9298c4
L_9298aa:
	bmsk_s r0,r0,0x13
L_9298ac:
	bset_s r0,r0,0x19
L_9298ae:
	bset_s r0,r0,0x1d
L_9298b0:
	ld_s r1,[r2]
L_9298b2:
	bset_s r0,r0,0x1f
L_9298b4:
	extb_s r13,r1
L_9298b6:
	mov_s r3,0x8020b0
L_9298bc:
	add2_s r3,r3,r13
L_9298be:
	st_s r0,[r3]
L_9298c0:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9298c2:
	st_s r1,[r2]
	.global L_9298c4
L_9298c4:
	mov_s r0,0x0
L_9298c6:
	bl.d L_9304c8
L_9298ca:
	mov_s r1,r0
L_9298cc:
	b_s L_9298de
	.global L_9298ce
L_9298ce:
	mov_s r0,r42
L_9298d0:
	bbit0 r0,0x12,L_9298de
L_9298d4:
	mov_s r0,0x801e94
L_9298da:
	bl L_928534
	.global L_9298de
L_9298de:
	mov_s r1,0x80062c
L_9298e4:
	ld_s r0,[r1]
L_9298e6:
	st.as r25,[gp,0xd]
L_9298ea:
	breq_s r0,0,L_9298f4
L_9298ec:
	mov_s r0,0x0
L_9298ee:
	bl.d L_926984
L_9298f2:
	st_s r0,[r1]
	.global L_9298f4
L_9298f4:
	and.f 0x0,r42,0xc0010
L_9298fc:
	bne_s L_92982c
L_9298fe:
	b_s L_929956
	.global L_929900
L_929900:
	mov_s r0,r54
L_929902:
	bbit0 r0,0xf,L_929920
L_929906:
	mov_s r0,0x49008000
L_92990c:
	mov_s r32,r0
L_92990e:
	st.ab r0,[r25,0x4]
L_929912:
	bclr r25,r25,0xa
L_929916:
	mov_s r0,0x4
L_929918:
	bl.d L_9304c8
L_92991c:
	mov_s r1,0x0
L_92991e:
	b_s L_929956
	.global L_929920
L_929920:
	mov_s r0,r54
L_929922:
	bbit0 r0,0x4,L_929942
L_929926:
	mov_s r0,0x49000010
L_92992c:
	mov_s r32,r0
L_92992e:
	st.ab r0,[r25,0x4]
L_929932:
	bclr r25,r25,0xa
L_929936:
	mov_s r0,0x801e94
L_92993c:
	bl L_928948
L_929940:
	b_s L_929956
	.global L_929942
L_929942:
	mov_s r0,blink
L_929944:
	mov_s r2,0x1000600
L_92994a:
	mov_s r1,0x1368
L_929950:
	bl.d L_925548
L_929954:
	mov_s r3,0x8f
	.global L_929956
L_929956:
	b L_92028c
	.global L_92995a
L_92995a:
	mov_s r0,blink
L_92995c:
	mov_s r2,0x1000600
L_929962:
	mov_s r1,0x1313
L_929968:
	bl.d L_925548
L_92996c:
	mov_s r3,0x93
L_92996e:
	b L_929756
L_929972:
	nop_s
