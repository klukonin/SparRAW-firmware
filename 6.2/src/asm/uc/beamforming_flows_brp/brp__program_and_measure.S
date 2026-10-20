/* brp__program_and_measure @ 0x923678, 596 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_initiator_brp_transaction_flow, brp_responder_flow_enter
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, brp__pick_sector_cfg, brp__program_mac_sequence_uc, rf__select_sector_cmd41, sta__set_rx_sector, uc_shl64, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__program_and_measure
brp__program_and_measure:
	.global L_923678
L_923678:
	push_s blink
L_92367a:
	bl L_920220
L_92367e:
	st.a r0,[sp,-0x8]
L_923682:
	mov_s r1,0x802008
L_923688:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92368a:
	add2_s r0,r0,r0
L_92368c:
	ld_s r0,[r1,r0]
L_92368e:
	mov_s r0,r49
L_923690:
	btst_s r0,0xd
L_923692:
	mov_s r1,0x801e94
L_923698:
	beq.d L_9238b2
L_92369c:
	mov_s r15,r2
L_92369e:
	mov_s r0,0x85776c
L_9236a4:
	ld.as r19,[r0,r15]
L_9236a8:
	ldb_s r0,[r1]
L_9236aa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9236ac:
	stb_s r0,[r1]
L_9236ae:
	mov_s r0,0x49000002
L_9236b4:
	mov_s r32,r0
L_9236b6:
	st.ab r0,[r25,0x4]
L_9236ba:
	bclr r25,r25,0xa
L_9236be:
	mov_s r0,0x5000020
L_9236c4:
	mov_s r32,r0
L_9236c6:
	st.ab r0,[r25,0x4]
L_9236ca:
	bclr r25,r25,0xa
L_9236ce:
	mov_s r0,0x20
L_9236d0:
	bset_s r0,r0,0x1a
L_9236d2:
	mov_s r32,r0
L_9236d4:
	st.ab r0,[r25,0x4]
L_9236d8:
	bclr r25,r25,0xa
L_9236dc:
	mov_s r0,0x3d010000
L_9236e2:
	mov_s r32,r0
L_9236e4:
	st.ab r0,[r25,0x4]
L_9236e8:
	bclr r25,r25,0xa
L_9236ec:
	mov_s r0,0x58000003
L_9236f2:
	mov_s r32,r0
L_9236f4:
	st.ab r0,[r25,0x4]
L_9236f8:
	bclr r25,r25,0xa
L_9236fc:
	mov_s r14,0x0
L_9236fe:
	mov r17,0x0
L_923702:
	ld_s r0,[gp,-0x44]
L_923704:
	mov_s r13,0x0
L_923706:
	and r0,r0,0xffff0fff
L_92370e:
	bset r1,r0,0xc
L_923712:
	bset_s r1,r1,0xe
L_923714:
	bset_s r1,r1,0xf
L_923716:
	st.as r1,[gp,-0x11]
L_92371a:
	or r0,r0,0x1d00d000
L_923722:
	mov_s r32,r0
L_923724:
	st.ab r0,[r25,0x4]
L_923728:
	bclr r25,r25,0xa
L_92372c:
	nop_s
L_92372e:
	nop_s
L_923730:
	nop_s
L_923732:
	mov r18,0x20
	.global L_923736
L_923736:
	mov_s r0,r54
L_923738:
	bbit1 r0,0x1,L_923742
L_92373c:
	mov_s r0,r49
L_92373e:
	bbit0 r0,0x5,L_923736
	.global L_923742
L_923742:
	mov_s r0,r54
L_923744:
	bbit0 r0,0x1,L_9237de
L_923748:
	st r40,[sp, 0x4]
L_92374c:
	mov_s r0,0x49000002
L_923752:
	mov_s r32,r0
L_923754:
	st.ab r0,[r25,0x4]
L_923758:
	bclr r25,r25,0xa
L_92375c:
	brge r13,0x20,L_92376e
L_923760:
	b_s L_92376a
	.global L_923762
L_923762:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_923764:
	/* brge.d r13,0x20,0x0092376e */
	.byte 0x0b,0x0d,0x33,0x18
L_923768:
	/* _add_s r14,0x2 */
	.byte 0x02,0xe6
	.global L_92376a
L_92376a:
	bbit0 r19,r13,L_923762
	.global L_92376e
L_92376e:
	brge.d r13,0x20,L_9237b6
L_923772:
	ld r16,[sp, 0x4]
L_923776:
	lsr r0,r16,0xe
L_92377a:
	bmsk_s r0,r0,0x9
L_92377c:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_92377e:
	lsr_s r0,r0,0x2
L_923780:
	asl_s r1,r15,0x5
L_923782:
	add_s r1,r1,r13
L_923784:
	add r2,r1,0x801ef4
L_92378c:
	stb_s r0,[r2]
L_92378e:
	bmsk r0,r16,0x1
L_923792:
	mov_s r1,0x0
L_923794:
	bl.d L_920458
L_923798:
	mov_s r2,r14
L_92379a:
	mov_s r5,r0
L_92379c:
	mov_s r0,0x800824
L_9237a2:
	add3_s r0,r0,r15
L_9237a4:
	mov_s r4,r1
L_9237a6:
	ld_s r1,[r0,0x8]
L_9237a8:
	ld_s r2,[r0,0xc]
L_9237aa:
	or r1,r1,r5
L_9237ae:
	or r2,r2,r4
L_9237b2:
	st_s r1,[r0,0x8]
L_9237b4:
	st_s r2,[r0,0xc]
	.global L_9237b6
L_9237b6:
	lsr r0,r16,0x18
L_9237ba:
	bmsk_s r0,r0,0x6
L_9237bc:
	brne r0,r17,L_9237d4
	.global L_9237c0
L_9237c0:
	add r17,r17,0x1
L_9237c4:
	sub r18,r18,0x1
L_9237c8:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_9237ca:
	brhs.d r18,0x1,L_923736
L_9237ce:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_9237d0:
	mov_s r13,0x1
L_9237d2:
	b_s L_9237ec
	.global L_9237d4
L_9237d4:
	mov_s r0,blink
L_9237d6:
	bl.d L_926618
L_9237da:
	mov_s r1,0x4
L_9237dc:
	b_s L_9237c0
	.global L_9237de
L_9237de:
	mov_s r1,0x801e94
L_9237e4:
	ldb_s r0,[r1,0x1]
L_9237e6:
	mov_s r13,0x0
L_9237e8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9237ea:
	stb_s r0,[r1,0x1]
	.global L_9237ec
L_9237ec:
	mov_s r0,0x80066c
L_9237f2:
	ld_s r0,[r0,0x4]
L_9237f4:
	breq_s r0,0,L_923820
L_9237f6:
	mov_s r2,0x883800
L_9237fc:
	ld.as r0,[r2,0xa9]
L_923800:
	mov_s r1,0x801504
L_923806:
	bmsk_s r0,r0,0x5
L_923808:
	stb_s r0,[r1]
L_92380a:
	ld r0,[r2, -0xc]
L_92380e:
	bmsk_s r0,r0,0x6
L_923810:
	stb_s r0,[r1,0x1]
L_923812:
	ld_s r0,[r2]
L_923814:
	bmsk_s r0,r0,0x4
L_923816:
	stb_s r0,[r1,0x2]
L_923818:
	ld.as r0,[r2,-0x4e]
L_92381c:
	bmsk_s r0,r0,0x15
L_92381e:
	st_s r0,[r1,0x4]
	.global L_923820
L_923820:
	mov_s r1,0x801ed4
L_923826:
	ldb_s r0,[r1,0x4]
L_923828:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92382a:
	extb_s r0,r0
L_92382c:
	stb_s r0,[r1,0x4]
L_92382e:
	mov_s r0,0x3d020000
L_923834:
	mov_s r32,r0
L_923836:
	st.ab r0,[r25,0x4]
L_92383a:
	bclr r25,r25,0xa
L_92383e:
	mov_s r0,0x800824
L_923844:
	add3_s r0,r0,r15
L_923846:
	ld_s r2,[r0,0x8]
L_923848:
	ld_s r1,[r0,0xc]
L_92384a:
	mov_s r0,0x801e94
L_923850:
	add3_s r0,r0,r15
L_923852:
	st_s r2,[r0,0x4]
L_923854:
	st_s r1,[r0,0x8]
L_923856:
	ld_s r0,[sp,0x0]
L_923858:
	bl.d L_93d140
L_92385c:
	add3 r1,r0,0xc
L_923860:
	mov_s r14,0x801024
L_923866:
	ld_s r0,[r14]
L_923868:
	lsr r1,r0,0x8
L_92386c:
	bmsk_s r1,r1,0xe
L_92386e:
	bl.d L_92f934
L_923872:
	bmsk_s r0,r0,0x3
L_923874:
	ld_s r0,[r14]
L_923876:
	st.as r0,[gp,-0xb]
L_92387a:
	ld_s r0,[gp,-0x44]
L_92387c:
	and r0,r0,0xfff0ffff
L_923884:
	bset r1,r0,0x10
L_923888:
	bset_s r1,r1,0x11
L_92388a:
	or r0,r0,0x1d030000
L_923892:
	st.as r1,[gp,-0x11]
L_923896:
	mov_s r32,r0
L_923898:
	st.ab r0,[r25,0x4]
L_92389c:
	bclr r25,r25,0xa
L_9238a0:
	nop_s
L_9238a2:
	nop_s
L_9238a4:
	nop_s
	.global L_9238a6
L_9238a6:
	mov_s r0,r47
L_9238a8:
	bbit1 r0,0x11,L_9238a6
L_9238ac:
	bl L_9259d0
L_9238b0:
	b_s L_9238ba
	.global L_9238b2
L_9238b2:
	ldb_s r0,[r1,0x2]
L_9238b4:
	mov_s r13,0x0
L_9238b6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9238b8:
	stb_s r0,[r1,0x2]
	.global L_9238ba
L_9238ba:
	breq_s r13,0,L_9238c2
L_9238bc:
	bl.d L_93cc90
L_9238c0:
	ld_s r0,[sp,0x0]
	.global L_9238c2
L_9238c2:
	extb_s r0,r13
L_9238c4:
	b.d L_92027c
L_9238c8:
	add_s sp,sp,0x8
L_9238ca:
	nop_s
