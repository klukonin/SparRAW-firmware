/* fixed_sched__run_tx_slot @ 0x93768c, 432 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__start_tx_or_initiator, delay_800_iters, fsched__run_tx_slot_twice, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__set_chain_modes, mac__set_mode_0000, rx_mode__configure, tx_initiator_flow_fixed_scheduling, tx_slot__dispatch, uc_read_tsf_lo, uc_spin_until_event, uc_tx__is_idle
 * Глобалы (через gp): 0x80056c, 0x800588, 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__run_tx_slot
fixed_sched__run_tx_slot:
	.global L_93768c
L_93768c:
	push_s blink
L_93768e:
	bl L_920234
L_937692:
	mov_s r1,0x8010b0
L_937698:
	ldw_s r0,[r1,0x2c]
L_93769a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93769c:
	extw_s r0,r0
L_93769e:
	stw_s r0,[r1,0x2c]
L_9376a0:
	ld_s r0,[gp,0x60]
L_9376a2:
	cmp_s r0,0x1
L_9376a4:
	mov_s r0,0x1
L_9376a6:
	sub_s.ne r0,r0,r0
L_9376a8:
	extb.f 0x0,r0
L_9376ac:
	bne_s L_9376d4
L_9376ae:
	bl.d L_9369e0
L_9376b2:
	mov_s r0,0x2
L_9376b4:
	mov_s r0,0x81
L_9376b6:
	asl_s r0,r0,0x12
L_9376b8:
	mov_s r32,r0
L_9376ba:
	st.ab r0,[r25,0x4]
L_9376be:
	bclr r25,r25,0xa
L_9376c2:
	bl L_93c658
L_9376c6:
	mov_s r1,0x8014c8
L_9376cc:
	ld_s r0,[r1,0xc]
L_9376ce:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9376d0:
	st_s r0,[r1,0xc]
L_9376d2:
	b_s L_937836
	.global L_9376d4
L_9376d4:
	mov_s r1,0x8022c8
L_9376da:
	ld_s r0,[r1]
L_9376dc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9376de:
	st_s r0,[r1]
L_9376e0:
	mov_s r1,0x0
L_9376e2:
	mov_s r0,0x8006bc
L_9376e8:
	st_s r1,[r0]
L_9376ea:
	st_s r1,[r0,0x4]
L_9376ec:
	st.as r1,[gp,0x11]
L_9376f0:
	mov_s r0,0x14000100
L_9376f6:
	mov_s r32,r0
L_9376f8:
	st.ab r0,[r25,0x4]
L_9376fc:
	bclr r25,r25,0xa
L_937700:
	ld_s r0,[gp,-0x34]
L_937702:
	brne_s r0,0,L_93770a
L_937704:
	bl L_938e34
L_937708:
	b_s L_93770e
	.global L_93770a
L_93770a:
	bl L_938f10
	.global L_93770e
L_93770e:
	mov_s r0,0x8006bc
L_937714:
	ld_s r0,[r0]
L_937716:
	breq_s r0,0,L_937738
L_937718:
	bl.d L_9366dc
L_93771c:
	mov_s r0,0x80
L_93771e:
	ld_s r0,[gp,-0x3c]
L_937720:
	brne r0,0x1,L_937738
L_937724:
	ld_s r0,[gp,-0x38]
L_937726:
	brne_s r0,0,L_937738
L_937728:
	mov_s r0,0x1f000601
L_93772e:
	mov_s r32,r0
L_937730:
	st.ab r0,[r25,0x4]
L_937734:
	bclr r25,r25,0xa
	.global L_937738
L_937738:
	mov_s r0,0x0
L_93773a:
	st.as r0,[gp,-0xe]
L_93773e:
	mov_s r0,0x8006bc
L_937744:
	ld_s r0,[r0,0x4]
L_937746:
	breq_s r0,0,L_937760
L_937748:
	mov_s r0,0x802978
L_93774e:
	ld_s r0,[r0,0x78]
L_937750:
	ld_s r1,[r0]
L_937752:
	brhs r1,0x8,L_937760
L_937756:
	ldb_s r0,[gp,-0xe0]
L_937758:
	bset r0,r0,r1
L_93775c:
	stb r0,[gp, -0xe0]
	.global L_937760
L_937760:
	ld_s r0,[gp,0xd0]
L_937762:
	bbit1 r0,0x9,L_937776
L_937766:
	mov_s r0,0x14000100
L_93776c:
	mov_s r32,r0
L_93776e:
	st.ab r0,[r25,0x4]
L_937772:
	bclr r25,r25,0xa
	.global L_937776
L_937776:
	ldw_s r0,[gp,0xcc]
L_937778:
	or r0,r0,0xdb0000
L_937780:
	mov_s r32,r0
L_937782:
	st.ab r0,[r25,0x4]
L_937786:
	bclr r25,r25,0xa
L_93778a:
	ld_s r0,[gp,0xcc]
L_93778c:
	lsr_s r0,r0,0x10
L_93778e:
	or r0,r0,0xdb0000
L_937796:
	mov_s r32,r0
L_937798:
	st.ab r0,[r25,0x4]
L_93779c:
	bclr r25,r25,0xa
L_9377a0:
	ldw_s r0,[gp,0xd0]
L_9377a2:
	or r0,r0,0xdb0000
L_9377aa:
	mov_s r32,r0
L_9377ac:
	st.ab r0,[r25,0x4]
L_9377b0:
	bclr r25,r25,0xa
L_9377b4:
	ld_s r0,[gp,0xd0]
L_9377b6:
	lsr_s r0,r0,0x10
L_9377b8:
	or r0,r0,0xdb0000
L_9377c0:
	mov_s r32,r0
L_9377c2:
	st.ab r0,[r25,0x4]
L_9377c6:
	bclr r25,r25,0xa
L_9377ca:
	mov_s r0,0x81
L_9377cc:
	asl_s r0,r0,0x12
L_9377ce:
	mov_s r32,r0
L_9377d0:
	st.ab r0,[r25,0x4]
L_9377d4:
	bclr r25,r25,0xa
L_9377d8:
	bl L_93e0dc
L_9377dc:
	mov_s r14,0x80242c
L_9377e2:
	ldw_s r0,[r14,0x8]
L_9377e4:
	brne_s r0,0,L_937800
L_9377e6:
	mov_s r0,0x80141c
L_9377ec:
	ld_s r0,[r0,0x8]
L_9377ee:
	bbit1 r0,0x0,L_937800
L_9377f2:
	mov_s r1,0x802288
L_9377f8:
	mov_s r0,0x2
L_9377fa:
	bl.d L_92f4bc
L_9377fe:
	ld_s r1,[r1]
	.global L_937800
L_937800:
	mov_s r13,0x0
L_937802:
	stw_s r13,[r14,0x8]
L_937804:
	mov_s r0,0x802978
L_93780a:
	st_s r13,[r0,0xc]
L_93780c:
	st_s r13,[r0,0x48]
L_93780e:
	mov_s r14,0x8006e0
L_937814:
	ld_s r0,[r14]
L_937816:
	st.as r13,[gp,0x33]
L_93781a:
	st.as r13,[gp,0x34]
L_93781e:
	breq_s r0,0,L_937836
L_937820:
	bl L_9364c8
L_937824:
	ld_s r1,[r14]
L_937826:
	mov_s r2,0x8010b0
L_93782c:
	sub_s r0,r0,r1
L_93782e:
	ld_s r1,[r2,0x24]
L_937830:
	st_s r13,[r14]
L_937832:
	add_s r0,r0,r1
L_937834:
	st_s r0,[r2,0x24]
	.global L_937836
L_937836:
	b L_9202a4
L_93783a:
	nop_s
