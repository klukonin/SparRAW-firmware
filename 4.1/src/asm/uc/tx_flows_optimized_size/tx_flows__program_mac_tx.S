/* tx_flows__program_mac_tx @ 0x933568, 608 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_flows_optimized_size.c
 * Зовут его: rx_funcs__rx_flow, tx_flow_size_step, tx_initiator_substep
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, cf_end_mtp_step, mac__program_tx_rate, mac__set_rf_chain_state, mac_counter__program_0008, tail_uc_wait_two_events, tbl_801754__byte_by_index, uc_read_tsf_lo, uc_spin_until_event, uc_sysassert, uc_wait_event_busy
 * Глобалы (через gp): 0x800538, 0x800570, 0x800604, 0x800608, 0x800610, 0x800614
 */
	.section .text.tx_flows__program_mac_tx,"ax",@progbits
	.global tx_flows__program_mac_tx
tx_flows__program_mac_tx:
	.global L_933568
L_933568:
	push_s blink
L_93356a:
	bl L_920210
L_93356e:
	mov_s r14,r0
L_933570:
	ld_s r0,[r0,0xc]
L_933572:
	btst_s r0,0x5
L_933574:
	bne_s L_933680
L_933576:
	ld_s r0,[r14]
L_933578:
	mov_s r1,0x801198
L_93357e:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_933580:
	add3_s r0,r0,r0
L_933582:
	ld_s r13,[r1,r0]
L_933584:
	mov_s r0,0x37000005
L_93358a:
	mov_s r32,r0
L_93358c:
	st.ab r0,[r25,0x4]
L_933590:
	bclr r25,r25,0xa
L_933594:
	mov_s r0,0x37000002
L_93359a:
	mov_s r32,r0
L_93359c:
	st.ab r0,[r25,0x4]
L_9335a0:
	bclr r25,r25,0xa
L_9335a4:
	or r13,r13,0x3f000000
L_9335ac:
	mov_s r32,r13
L_9335ae:
	st.ab r13,[r25,0x4]
L_9335b2:
	bclr r25,r25,0xa
L_9335b6:
	ld_s r15,[r14,0x4]
L_9335b8:
	ld_s r1,[r14]
L_9335ba:
	ld_s r0,[gp,0xdc]
L_9335bc:
	asl_s r15,r15,0x10
L_9335be:
	mov_s r13,0x0
L_9335c0:
	bset_s r15,r15,0x0
L_9335c2:
	bbit0 r0,0x1,L_9335ec
L_9335c6:
	asl_s r0,r1,0x2
L_9335c8:
	add1_s r0,r0,r0
L_9335ca:
	mov_s r2,0x8016d8
L_9335d0:
	ld_s r0,[r2,r0]
L_9335d2:
	sub.f r0,r0,0x0
L_9335d6:
	mov.ne r0,0x1
L_9335da:
	extb.f 0x0,r0
L_9335de:
	beq_s L_9335ec
L_9335e0:
	bl.d L_92c1ec
L_9335e4:
	mov_s r0,r1
L_9335e6:
	asl_s r0,r0,0x8
L_9335e8:
	or r13,r0,0x3
	.global L_9335ec
L_9335ec:
	mov_s r0,0x1b001111
L_9335f2:
	mov_s r32,r0
L_9335f4:
	st.ab r0,[r25,0x4]
L_9335f8:
	bclr r25,r25,0xa
L_9335fc:
	bset_s r15,r15,0x19
L_9335fe:
	bset_s r15,r15,0x1a
L_933600:
	bset_s r15,r15,0x1c
L_933602:
	mov_s r32,r15
L_933604:
	st.ab r15,[r25,0x4]
L_933608:
	bclr r25,r25,0xa
L_93360c:
	or r13,r13,0x17000000
L_933614:
	mov_s r32,r13
L_933616:
	st.ab r13,[r25,0x4]
L_93361a:
	bclr r25,r25,0xa
L_93361e:
	nop_s
L_933620:
	nop_s
L_933622:
	nop_s
	.global L_933624
L_933624:
	mov_s r0,r43
L_933626:
	bbit0 r0,0x1f,L_933624
L_93362a:
	mov_s r0,r51
L_93362c:
	bmsk r1,r0,0x3
L_933630:
	st.as r1,[gp,0x3a]
L_933634:
	lsr_s r0,r0,0x4
L_933636:
	st.as r0,[gp,0x3b]
L_93363a:
	lsr r0,r43,0x10
L_93363e:
	bmsk r13,r0,0x4
L_933642:
	asl_s r0,r13,0x4
L_933644:
	or r0,r0,0x3e000000
L_93364c:
	mov_s r32,r0
L_93364e:
	st.ab r0,[r25,0x4]
L_933652:
	bclr r25,r25,0xa
L_933656:
	mov_s r0,0x37000020
L_93365c:
	mov_s r32,r0
L_93365e:
	st.ab r0,[r25,0x4]
L_933662:
	bclr r25,r25,0xa
L_933666:
	mov_s r1,0x801458
L_93366c:
	ld_s r0,[r1,0xc]
L_93366e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933670:
	st_s r0,[r1,0xc]
L_933672:
	mov_s r0,r14
L_933674:
	bl.d L_937a0c
L_933678:
	mov_s r1,r13
L_93367a:
	ld_s r0,[r14,0xc]
L_93367c:
	bset_s r0,r0,0x5
L_93367e:
	st_s r0,[r14,0xc]
	.global L_933680
L_933680:
	bclr_s r0,r0,0x5
L_933682:
	st_s r0,[r14,0xc]
L_933684:
	ld_s r0,[gp,0xe0]
L_933686:
	bbit0 r0,0x9,L_933690
	.global L_93368a
L_93368a:
	b.d L_92027c
L_93368e:
	mov_s r0,0x1
	.global L_933690
L_933690:
	ld_s r0,[gp,-0x48]
L_933692:
	or r0,r0,0x27004000
L_93369a:
	mov_s r32,r0
L_93369c:
	st.ab r0,[r25,0x4]
L_9336a0:
	bclr r25,r25,0xa
L_9336a4:
	mov_s r0,0x2004000
L_9336aa:
	mov_s r32,r0
L_9336ac:
	st.ab r0,[r25,0x4]
L_9336b0:
	bclr r25,r25,0xa
L_9336b4:
	mov_s r0,0x801a18
L_9336ba:
	ld_s r1,[r0,0x60]
L_9336bc:
	mov_s r2,0x801131
L_9336c2:
	ld_s r0,[r1,0x4]
L_9336c4:
	add1_s r0,r0,r0
L_9336c6:
	ldb_s r0,[r2,r0]
L_9336c8:
	breq_s r0,0,L_9336e0
L_9336ca:
	lsr r0,r45,0x5
L_9336ce:
	bxor r0,r0,0x0
L_9336d2:
	ld_s r2,[r1,0xc]
L_9336d4:
	bbit1 r0,0x0,L_9336e0
L_9336d8:
	bset_s r2,r2,0x1
L_9336da:
	st_s r2,[r1,0xc]
L_9336dc:
	mov_s r0,0x0
L_9336de:
	st_s r0,[r1,0x1c]
	.global L_9336e0
L_9336e0:
	ld_s r0,[r1,0xc]
L_9336e2:
	bbit1 r0,0x8,L_93371c
L_9336e6:
	lsr r0,r43,0xe
L_9336ea:
	bmsk.f r0,r0,0x1
L_9336ee:
	beq_s L_9336fe
L_9336f0:
	brne r0,0x1,L_93371c
L_9336f4:
	ld_s r0,[r1,0xc]
L_9336f6:
	or r0,r0,0xe
L_9336fa:
	st_s r0,[r1,0xc]
L_9336fc:
	b_s L_93371c
	.global L_9336fe
L_9336fe:
	mov_s r2,r43
L_933700:
	ld_s r0,[gp,0xe0]
L_933702:
	btst_s r2,0x1b
L_933704:
	bset.ne r0,r0,0x1
L_933708:
	bset.eq r0,r0,0x0
L_93370c:
	st.as r0,[gp,0x38]
L_933710:
	bbit1 r0,0x12,L_93371c
L_933714:
	mov_s r0,0x1
L_933716:
	bl.d L_9372dc
L_93371a:
	ld_s r1,[r1,0x4]
	.global L_93371c
L_93371c:
	mov_s r0,r42
L_93371e:
	btst_s r0,0xe
L_933720:
	mov.ne r13,0x1
L_933724:
	bne_s L_933732
L_933726:
	mov_s r0,0x0
L_933728:
	bset_s r0,r0,0xe
L_93372a:
	bl.d L_931808
L_93372e:
	mov_s r1,0x6
L_933730:
	mov_s r13,r0
	.global L_933732
L_933732:
	ld_s r0,[gp,0xdc]
L_933734:
	ld_s r1,[r14]
L_933736:
	and r3,r0,0x2
L_93373a:
	mov_s r0,0x0
L_93373c:
	or.f 0x0,r3,r0
L_933740:
	ld.as r2,[gp,0x38]
L_933744:
	beq_s L_933750
L_933746:
	bic r2,r2,-0x120
L_93374a:
	cmp r2,0x100
L_93374e:
	beq_s L_93377e
	.global L_933750
L_933750:
	ld_s r0,[gp,0x48]
L_933752:
	mov_s r3,0x801a18
L_933758:
	ld_s r2,[r3,0x60]
L_93375a:
	breq_s r0,0,L_93376a
L_93375c:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_93375e:
	mov_s r0,0x801194
L_933764:
	add3_s r1,r1,r1
L_933766:
	ld_s r0,[r0,r1]
L_933768:
	st_s r0,[r2,0x28]
	.global L_93376a
L_93376a:
	ld_s r1,[r3,0x60]
L_93376c:
	mov_s r0,0x1
L_93376e:
	bl.d L_92b934
L_933772:
	ld_s r1,[r1,0x28]
L_933774:
	ld_s r0,[gp,0x48]
L_933776:
	breq_s r0,0,L_93377e
L_933778:
	mov_s r0,0x0
L_93377a:
	st.as r0,[gp,0x12]
	.global L_93377e
L_93377e:
	breq_s r13,0,L_9337b4
	.global L_933780
L_933780:
	ld_s r0,[r14,0xc]
L_933782:
	mov_s r13,0x0
L_933784:
	bic r0,r0,0x120
L_933788:
	st_s r0,[r14,0xc]
L_93378a:
	st_s r13,[r14,0x20]
L_93378c:
	mov_s r0,0x0
L_93378e:
	bl.d L_9317fc
L_933792:
	bset_s r0,r0,0xf
L_933794:
	ld_s r0,[r14,0xc]
L_933796:
	btst_s r0,0x3
L_933798:
	mov.ne r0,r14
L_93379c:
	bl.ne.d L_933f90
L_9337a0:
	mov.ne r1,r13
L_9337a4:
	bl.d L_9316a8
L_9337a8:
	mov_s r0,0x6
L_9337aa:
	bl L_9315e8
L_9337ae:
	st.as r0,[gp,0x4]
L_9337b2:
	b_s L_93368a
	.global L_9337b4
L_9337b4:
	mov_s r0,blink
L_9337b6:
	mov_s r2,0x1001d54
L_9337bc:
	mov_s r1,0x91
L_9337be:
	bl.d L_925548
L_9337c2:
	mov r3,0x444
L_9337c6:
	b_s L_933780
