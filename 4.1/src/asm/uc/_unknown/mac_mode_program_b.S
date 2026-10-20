/* mac_mode_program_b @ 0x923628, 584 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_flow_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_b_s0_w5_uc, bf_s11_w5_uc, direct_tx__program_cmd34, hw_modes_mac__switch_core, mac__program_rf_mode, mac__program_tx_common, mac__select_sector_and_wait_b, mac__set_rf_chain_state, mac_mode__send_direct_frame, set_reg_884060
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.mac_mode_program_b,"ax",@progbits
	.global mac_mode_program_b
mac_mode_program_b:
	.global L_923628
L_923628:
	push_s blink
L_92362a:
	bl L_920214
L_92362e:
	mov_s r0,0x800734
L_923634:
	bl.d L_927944
L_923638:
	ldb_s r13,[r0,0x18]
L_92363a:
	bl.d L_9296c8
L_92363e:
	mov_s r0,0x0
L_923640:
	mov_s r0,0x1f006000
L_923646:
	mov_s r32,r0
L_923648:
	st.ab r0,[r25,0x4]
L_92364c:
	bclr r25,r25,0xa
L_923650:
	mov_s r1,0x801198
L_923656:
	asl_s r0,r13,0x3
L_923658:
	add3_s r0,r0,r0
L_92365a:
	ld_s r14,[r1,r0]
L_92365c:
	mov_s r0,0x38000300
L_923662:
	mov_s r32,r0
L_923664:
	st.ab r0,[r25,0x4]
L_923668:
	bclr r25,r25,0xa
L_92366c:
	mov_s r0,0x3600003f
L_923672:
	mov_s r32,r0
L_923674:
	st.ab r0,[r25,0x4]
L_923678:
	bclr r25,r25,0xa
L_92367c:
	mov_s r0,0x6000101
L_923682:
	mov_s r32,r0
L_923684:
	st.ab r0,[r25,0x4]
L_923688:
	bclr r25,r25,0xa
L_92368c:
	mov_s r0,0x37000005
L_923692:
	mov_s r32,r0
L_923694:
	st.ab r0,[r25,0x4]
L_923698:
	bclr r25,r25,0xa
L_92369c:
	mov_s r0,0x37000002
L_9236a2:
	mov_s r32,r0
L_9236a4:
	st.ab r0,[r25,0x4]
L_9236a8:
	bclr r25,r25,0xa
L_9236ac:
	or r14,r14,0x3f000000
L_9236b4:
	mov_s r32,r14
L_9236b6:
	st.ab r14,[r25,0x4]
L_9236ba:
	bclr r25,r25,0xa
L_9236be:
	mov_s r0,0x3e
L_9236c0:
	asl_s r0,r0,0x18
L_9236c2:
	mov_s r32,r0
L_9236c4:
	st.ab r0,[r25,0x4]
L_9236c8:
	bclr r25,r25,0xa
L_9236cc:
	mov_s r0,0x37000020
L_9236d2:
	mov_s r32,r0
L_9236d4:
	st.ab r0,[r25,0x4]
L_9236d8:
	bclr r25,r25,0xa
L_9236dc:
	mov_s r1,0x801458
L_9236e2:
	ld_s r0,[r1,0xc]
L_9236e4:
	mov_s r2,0x800764
L_9236ea:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9236ec:
	st_s r0,[r1,0xc]
L_9236ee:
	mov_s r0,0x0
L_9236f0:
	mov_s r1,r0
L_9236f2:
	stb_s r1,[r2,0x1b]
L_9236f4:
	lsr_s r1,r1,0x8
L_9236f6:
	stb_s r1,[r2,0x1c]
L_9236f8:
	lsr_s r1,r1,0x8
L_9236fa:
	stb_s r1,[r2,0x1d]
L_9236fc:
	lsr_s r1,r1,0x8
L_9236fe:
	stb_s r1,[r2,0x1e]
L_923700:
	st_s r0,[r2,0x20]
L_923702:
	stw_s r0,[r2,0x24]
L_923704:
	mov_s r0,0x886544
L_92370a:
	ld_s r1,[r0]
L_92370c:
	mov_s r3,0x886500
L_923712:
	bmsk_s r1,r1,0xb
L_923714:
	add_s r0,r1,0x1
L_923716:
	asl_s r0,r0,0x10
L_923718:
	and r0,r0,0xfff0000
L_923720:
	bset_s r0,r0,0x1c
L_923722:
	st_s r0,[r3,0x44]
L_923724:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_923726:
	/* asl_s r13,r13,0x3 */
	.byte 0x03,0xbd
L_923728:
	add3_s r13,r13,r13
L_92372a:
	add_s r13,r13,0x801190
L_923730:
	ldw_s r0,[r13,0x2c]
L_923732:
	stw_s r1,[r2,0x16]
L_923734:
	stw_s r0,[r2,0x4]
L_923736:
	ldw_s r0,[r13,0x2e]
L_923738:
	ld_s r1,[r13,0x8]
L_92373a:
	stw_s r0,[r2,0x6]
L_92373c:
	ldw_s r0,[r13,0x30]
L_92373e:
	lsr_s r1,r1,0x8
L_923740:
	stw_s r0,[r2,0x8]
L_923742:
	ld_s r0,[r2,0x20]
L_923744:
	bmsk_s r1,r1,0x5
L_923746:
	bclr_s r0,r0,0x8
L_923748:
	st_s r0,[r2,0x20]
L_92374a:
	mov_s r0,0x5
L_92374c:
	stb r0,[r2, 0x20]
L_923750:
	add r0,r2,0x1b
L_923754:
	bl L_93794c
L_923758:
	mov_s r0,0x800734
L_92375e:
	ld_s r0,[r0,0x1c]
L_923760:
	bbit0 r0,0x0,L_92377e
L_923764:
	add r0,r2,0x1b
L_923768:
	mov_s r1,0x10
L_92376a:
	bl L_937958
L_92376e:
	mov_s r0,0x20000400
L_923774:
	mov_s r32,r0
L_923776:
	st.ab r0,[r25,0x4]
L_92377a:
	bclr r25,r25,0xa
	.global L_92377e
L_92377e:
	mov_s r0,0x800734
L_923784:
	ld_s r0,[r0,0x20]
L_923786:
	bbit0 r0,0x2,L_9237ae
L_92378a:
	lsr_s r0,r0,0x4
L_92378c:
	bmsk_s r0,r0,0x4
L_92378e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_923790:
	bic r0,r0,-0x1f1
L_923794:
	bset_s r0,r0,0xa
L_923796:
	bset_s r0,r0,0x1d
L_923798:
	mov_s r32,r0
L_92379a:
	st.ab r0,[r25,0x4]
L_92379e:
	bclr r25,r25,0xa
L_9237a2:
	mov_s r1,0x800764
L_9237a8:
	ld_s r0,[r1,0x20]
L_9237aa:
	bset_s r0,r0,0xa
L_9237ac:
	st_s r0,[r1,0x20]
	.global L_9237ae
L_9237ae:
	mov_s r0,0x18
L_9237b0:
	bl.d L_924ea8
L_9237b4:
	mov_s r1,0x26
L_9237b6:
	bl L_92a3c0
L_9237ba:
	mov_s r0,0x2008000
L_9237c0:
	mov_s r32,r0
L_9237c2:
	st.ab r0,[r25,0x4]
L_9237c6:
	bclr r25,r25,0xa
L_9237ca:
	ld_s r0,[gp,0xdc]
L_9237cc:
	and r1,r0,0x10
L_9237d0:
	mov_s r0,0x0
L_9237d2:
	or.f 0x0,r1,r0
L_9237d6:
	beq_s L_9237f8
L_9237d8:
	ld_s r0,[gp,0xe8]
L_9237da:
	ld.as r1,[gp,0x3b]
L_9237de:
	bic r0,r0,-0x3
L_9237e2:
	cmp_s r0,0x2
L_9237e4:
	mov_s r0,0x1
L_9237e6:
	sub_s.ne r0,r0,r0
L_9237e8:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_9237ea:
	or r0,r0,0x19800830
L_9237f2:
	asl_s r1,r1,0xe
L_9237f4:
	or_s r0,r0,r1
L_9237f6:
	b_s L_9237fe
	.global L_9237f8
L_9237f8:
	mov_s r0,0x19000001
	.global L_9237fe
L_9237fe:
	mov_s r32,r0
L_923800:
	st.ab r0,[r25,0x4]
L_923804:
	bclr r25,r25,0xa
	.global L_923808
L_923808:
	mov_s r0,r45
L_92380a:
	bbit0 r0,0x1f,L_923808
L_92380e:
	ld_s r0,[gp,0xdc]
L_923810:
	and r1,r0,0x10
L_923814:
	mov_s r0,0x0
L_923816:
	or.f 0x0,r1,r0
L_92381a:
	mov_s r0,0x18
L_92381c:
	asl.ne r0,r0,0x18
L_923820:
	mov.eq r0,0x18001000
L_923828:
	mov_s r32,r0
L_92382a:
	st.ab r0,[r25,0x4]
L_92382e:
	bclr r25,r25,0xa
L_923832:
	bl L_92b444
L_923836:
	bl.d L_931664
L_92383a:
	mov_s r0,0x6
L_92383c:
	mov_s r1,0x80087c
L_923842:
	mov_s r0,0x1
L_923844:
	bl.d L_92b934
L_923848:
	ld_s r1,[r1]
L_92384a:
	mov_s r0,0x0
L_92384c:
	bl.d L_9317fc
L_923850:
	bset_s r0,r0,0xf
L_923852:
	bl.d L_9316a8
L_923856:
	mov_s r0,0x6
L_923858:
	bl.d L_9274f0
L_92385c:
	mov_s r0,0x0
L_92385e:
	mov_s r0,0x0
L_923860:
	bset_s r0,r0,0x1d
L_923862:
	mov_s r32,r0
L_923864:
	st.ab r0,[r25,0x4]
L_923868:
	bclr r25,r25,0xa
L_92386c:
	b L_920284
