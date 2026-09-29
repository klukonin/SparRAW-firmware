/* rx_funcs__handle_ppdu_report @ 0x9316cc, 1024 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__set_mode_0000, mac__set_mode_a000, mac_mode__switch_after_ppdu, phy_params__snapshot, rx__handle_brp_frame, rx__mac_prepare, rx__parse_ssw_field, rx__send_response_frame, rx__switch_to_rx_mode, rx_funcs__record_level_8020f8_8020fc__922168
 * Глобалы (через gp): 0x8005be, 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_funcs__handle_ppdu_report
rx_funcs__handle_ppdu_report:
	.global L_9316cc
L_9316cc:
	push_s blink
L_9316ce:
	bl.d L_920230
L_9316d2:
	mov_s r0,0x1
L_9316d4:
	sub_s sp,sp,0xc
L_9316d6:
	st.as r0,[gp,-0x10]
L_9316da:
	mov_s r0,0xeeee0a
L_9316e0:
	mov_s r32,r0
L_9316e2:
	st.ab r0,[r25,0x4]
L_9316e6:
	bclr r25,r25,0xa
L_9316ea:
	mov_s r0,0x0
L_9316ec:
	bset_s r0,r0,0x10
L_9316ee:
	bl.d L_9366e8
L_9316f2:
	mov_s r1,0x0
L_9316f4:
	ldb_s r0,[gp,-0xf2]
L_9316f6:
	brne_s r0,0,L_931714
L_9316f8:
	ldb_s r0,[gp,-0xf9]
L_9316fa:
	bmsk_s r0,r0,0x0
L_9316fc:
	bset_s r0,r0,0x19
L_9316fe:
	bset_s r0,r0,0x1c
L_931700:
	bset_s r0,r0,0x1d
L_931702:
	mov_s r32,r0
L_931704:
	st.ab r0,[r25,0x4]
L_931708:
	bclr r25,r25,0xa
L_93170c:
	ldb_s r0,[gp,-0xf9]
L_93170e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_931710:
	stb r0,[gp, -0xf9]
	.global L_931714
L_931714:
	mov_s r0,r38
L_931716:
	mov_s r13,0x802288
L_93171c:
	bbit0 r0,0xb,L_931728
L_931720:
	lsr r0,r38,0x8
L_931724:
	bmsk_s r0,r0,0x2
L_931726:
	b_s L_93174a
	.global L_931728
L_931728:
	mov_s r0,r36
L_93172a:
	bbit0 r0,0x7,L_93173a
L_93172e:
	mov_s r0,0x804014
	.global L_931734
L_931734:
	bl L_9349a0
L_931738:
	b_s L_93174a
	.global L_93173a
L_93173a:
	mov_s r0,r36
L_93173c:
	btst_s r0,0x6
L_93173e:
	mov.ne r0,0x80401a
L_931746:
	bne_s L_931734
L_931748:
	mov_s r0,0x8
	.global L_93174a
L_93174a:
	st_s r0,[r13]
L_93174c:
	mov_s r0,r37
L_93174e:
	mov_s r13,0x804010
L_931754:
	bbit0 r0,0x0,L_9317a4
L_931758:
	ld_s r0,[gp,0xcc]
L_93175a:
	bbit1 r0,0xa,L_93178c
L_93175e:
	mov_s r0,0x802288
L_931764:
	ld_s r0,[r0]
L_931766:
	mov_s r1,0x80110c
L_93176c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93176e:
	add2_s r0,r0,r0
L_931770:
	bl.d L_92f340
L_931774:
	ld_s r0,[r1,r0]
L_931776:
	bl L_936200
L_93177a:
	mov_s r0,0x802b10
L_931780:
	mov_s r1,0x8
L_931782:
	bl.d L_9336d8
L_931786:
	mov_s r2,0x0
L_931788:
	bl L_93e0dc
	.global L_93178c
L_93178c:
	mov_s r1,0x8021e0
L_931792:
	ld_s r0,[r1]
L_931794:
	bset_s r0,r0,0x4
L_931796:
	st_s r0,[r1]
L_931798:
	mov_s r1,0x8022c8
L_93179e:
	ld_s r0,[r1,0x74]
L_9317a0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9317a2:
	st_s r0,[r1,0x74]
	.global L_9317a4
L_9317a4:
	mov_s r2,0x80401a
L_9317aa:
	mov_s r1,0x80216c
L_9317b0:
	ldw_s r3,[r2]
L_9317b2:
	ldw_s r0,[r1,0x1c]
L_9317b4:
	cmp_s r3,r0
L_9317b6:
	bne L_931ab2
L_9317ba:
	ldw_s r3,[r2,0x2]
L_9317bc:
	ldw_s r0,[r1,0x1e]
L_9317be:
	cmp_s r3,r0
L_9317c0:
	bne L_931ab2
L_9317c4:
	ldw_s r2,[r2,0x4]
L_9317c6:
	ldw_s r0,[r1,0x20]
L_9317c8:
	cmp_s r2,r0
L_9317ca:
	bne L_931ab2
L_9317ce:
	ld_s r0,[gp,0xd0]
L_9317d0:
	bbit0 r0,0x15,L_9317e4
L_9317d4:
	mov_s r0,r37
L_9317d6:
	bbit0 r0,0x18,L_9317e4
L_9317da:
	mov_s r0,r39
L_9317dc:
	btst_s r0,0xf
L_9317de:
	bl.ne L_924fc4
L_9317e2:
	b_s L_93183e
	.global L_9317e4
L_9317e4:
	mov_s r0,r36
L_9317e6:
	bbit0 r0,0x6,L_931820
L_9317ea:
	mov_s r0,r37
L_9317ec:
	bbit0 r0,0x18,L_9317fc
L_9317f0:
	mov_s r1,0x8021e0
L_9317f6:
	ld_s r0,[r1]
L_9317f8:
	bset_s r0,r0,0x0
L_9317fa:
	b_s L_93183c
	.global L_9317fc
L_9317fc:
	mov_s r0,r37
L_9317fe:
	bbit0 r0,0x19,L_93180e
L_931802:
	mov_s r1,0x8021e0
L_931808:
	ld_s r0,[r1]
L_93180a:
	bset_s r0,r0,0x2
L_93180c:
	b_s L_93183c
	.global L_93180e
L_93180e:
	mov_s r0,r37
L_931810:
	bbit0 r0,0x1a,L_93183e
L_931814:
	mov_s r1,0x8021e0
L_93181a:
	ld_s r0,[r1]
L_93181c:
	bset_s r0,r0,0x3
L_93181e:
	b_s L_93183c
	.global L_931820
L_931820:
	mov_s r0,r36
L_931822:
	bbit0 r0,0x19,L_93182c
L_931826:
	bl L_92e16c
L_93182a:
	b_s L_93183e
	.global L_93182c
L_93182c:
	mov_s r0,r37
L_93182e:
	bbit0 r0,0x0,L_93183e
L_931832:
	mov_s r1,0x8021e0
L_931838:
	ld_s r0,[r1]
L_93183a:
	bset_s r0,r0,0x4
	.global L_93183c
L_93183c:
	st_s r0,[r1]
	.global L_93183e
L_93183e:
	ld_s r0,[gp,0xd0]
L_931840:
	cmp_s r0,0x800000
L_931846:
	beq L_931a26
L_93184a:
	bgt L_9318ca
L_93184e:
	cmp_s r0,0x100000
L_931854:
	beq_s L_931914
L_931856:
	bgt_s L_931866
L_931858:
	cmp_s r0,0x80000
L_93185e:
	beq L_931ab2
L_931862:
	b L_931aaa
	.global L_931866
L_931866:
	cmp_s r0,0x200000
L_93186c:
	beq_s L_931950
L_93186e:
	cmp_s r0,0x400000
L_931874:
	bne L_931aaa
L_931878:
	mov_s r0,r37
L_93187a:
	btst_s r0,0x1a
L_93187c:
	mov_s r14,0x8021e0
L_931882:
	beq L_931ab2
L_931886:
	mov_s r0,sp
L_931888:
	add_s r1,sp,0x4
L_93188a:
	bl.d L_927d0c
L_93188e:
	add_s r2,sp,0x8
L_931890:
	bl.d L_922168
L_931894:
	ldb.x r0,[sp, 0x8]
L_931898:
	ld_s r0,[r14]
L_93189a:
	bset_s r0,r0,0x3
L_93189c:
	st_s r0,[r14]
L_93189e:
	mov_s r0,0x802288
L_9318a4:
	ldb_s r1,[r13,0x13]
L_9318a6:
	ld_s r0,[r0]
L_9318a8:
	bmsk_s r1,r1,0x4
L_9318aa:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_9318ac:
	add2_s r0,r0,r0
L_9318ae:
	add_s r0,r0,0x801ffc
L_9318b4:
	stb_s r1,[r0,0x9]
L_9318b6:
	ldb_s r1,[r13,0x13]
L_9318b8:
	btst_s r1,0x6
L_9318ba:
	btst.eq r1,0x7
L_9318be:
	bne_s L_931a1e
L_9318c0:
	ldb_s r1,[r0,0xa]
L_9318c2:
	bset_s r1,r1,0x0
L_9318c4:
	stb_s r1,[r0,0xa]
L_9318c6:
	b L_931ab2
	.global L_9318ca
L_9318ca:
	cmp_s r0,0x8000000
L_9318d0:
	beq L_931ab2
L_9318d4:
	bgt_s L_9318f2
L_9318d6:
	cmp_s r0,0x4000000
L_9318dc:
	bne L_931aaa
L_9318e0:
	mov_s r0,0x8021e0
L_9318e6:
	ld_s r0,[r0]
L_9318e8:
	btst_s r0,0x5
L_9318ea:
	beq L_931ab2
L_9318ee:
	b L_931aa4
	.global L_9318f2
L_9318f2:
	cmp_s r0,0x10000000
L_9318f8:
	beq_s L_931a8c
L_9318fa:
	cmp_s r0,0x20000000
L_931900:
	bne L_931aaa
L_931904:
	mov_s r0,0x8021e0
L_93190a:
	ld_s r0,[r0]
L_93190c:
	btst_s r0,0xa
L_93190e:
	beq L_931ab2
L_931912:
	b_s L_931aa4
	.global L_931914
L_931914:
	mov_s r0,r37
L_931916:
	bbit0 r0,0x18,L_931950
L_93191a:
	mov_s r1,0x802968
L_931920:
	ldw_s r0,[gp,0x96]
L_931922:
	ldw_s r1,[r1,0xc]
L_931924:
	breq r0,r1,L_931950
L_931928:
	stw.as r1,[gp,0x4b]
L_93192c:
	or r1,r1,0x1730000
L_931934:
	mov_s r0,0x886d00
L_93193a:
	st_s r1,[r0]
L_93193c:
	sync
L_931940:
	mov_s r0,0x38000200
L_931946:
	mov_s r32,r0
L_931948:
	st.ab r0,[r25,0x4]
L_93194c:
	bclr r25,r25,0xa
	.global L_931950
L_931950:
	mov_s r0,r37
L_931952:
	btst_s r0,0x18
L_931954:
	mov_s r2,0x8021e0
L_93195a:
	beq_s L_931ab2
L_93195c:
	mov_s r0,0x804010
L_931962:
	ldw_s r3,[r0,0x10]
L_931964:
	ld_s r1,[r2]
L_931966:
	bbit1 r3,0x0,L_931970
L_93196a:
	ld_s r0,[gp,0xcc]
L_93196c:
	bbit1 r0,0x6,L_93197a
	.global L_931970
L_931970:
	bbit0 r3,0x0,L_931a00
L_931974:
	ld_s r0,[gp,0xcc]
L_931976:
	bbit0 r0,0x5,L_931a00
	.global L_93197a
L_93197a:
	bset_s r1,r1,0x0
L_93197c:
	st_s r1,[r2]
L_93197e:
	mov_s r0,sp
L_931980:
	add_s r1,sp,0x4
L_931982:
	bl.d L_93cedc
L_931986:
	mov_s r2,0x0
L_931988:
	mov_s r0,r39
L_93198a:
	ld.as r2,[gp,0x33]
L_93198e:
	bbit0 r0,0xf,L_931a06
L_931992:
	mov_s r14,0x802288
L_931998:
	ld_s r0,[r14]
L_93199a:
	mov_s r1,0x802aec
L_9319a0:
	ld.as r13,[r1,r0]
L_9319a4:
	mov_s r3,0x8021e0
L_9319aa:
	ld_s r1,[r3]
L_9319ac:
	bset_s r1,r1,0x1
L_9319ae:
	st_s r1,[r3]
L_9319b0:
	bbit0 r2,0x5,L_9319cc
L_9319b4:
	ld_s r1,[sp,0x0]
L_9319b6:
	ld_s r2,[sp,0x4]
L_9319b8:
	bl.d L_93d180
L_9319bc:
	mov_s r3,0x1
L_9319be:
	ld_s r0,[r14]
L_9319c0:
	mov_s r1,0x80110c
L_9319c6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9319c8:
	add2_s r0,r0,r0
L_9319ca:
	ld_s r13,[r1,r0]
	.global L_9319cc
L_9319cc:
	mov_s r0,0x37000005
L_9319d2:
	mov_s r32,r0
L_9319d4:
	st.ab r0,[r25,0x4]
L_9319d8:
	bclr r25,r25,0xa
L_9319dc:
	mov_s r0,0x37000002
L_9319e2:
	mov_s r32,r0
L_9319e4:
	st.ab r0,[r25,0x4]
L_9319e8:
	bclr r25,r25,0xa
L_9319ec:
	or r13,r13,0x3f000000
L_9319f4:
	mov_s r32,r13
L_9319f6:
	st.ab r13,[r25,0x4]
L_9319fa:
	bclr r25,r25,0xa
L_9319fe:
	b_s L_931ac6
	.global L_931a00
L_931a00:
	bclr_s r1,r1,0x0
L_931a02:
	st_s r1,[r2]
L_931a04:
	b_s L_931ab2
	.global L_931a06
L_931a06:
	bbit0 r2,0x5,L_931ab2
L_931a0a:
	mov_s r0,0x802288
L_931a10:
	ld_s r0,[r0]
L_931a12:
	ld_s r1,[sp,0x0]
L_931a14:
	ld_s r2,[sp,0x4]
L_931a16:
	bl.d L_93d180
L_931a1a:
	mov_s r3,0x1
L_931a1c:
	b_s L_931ab2
	.global L_931a1e
L_931a1e:
	ldb_s r1,[r0,0xa]
L_931a20:
	bclr_s r1,r1,0x0
L_931a22:
	stb_s r1,[r0,0xa]
L_931a24:
	b_s L_931ab2
	.global L_931a26
L_931a26:
	mov_s r0,r37
L_931a28:
	mov_s r14,0x8021e0
L_931a2e:
	bbit0 r0,0x19,L_931ab2
L_931a32:
	mov_s r0,sp
L_931a34:
	add_s r1,sp,0x4
L_931a36:
	bl.d L_927d0c
L_931a3a:
	add_s r2,sp,0x8
L_931a3c:
	bl L_924fc4
L_931a40:
	bl.d L_922168
L_931a44:
	ldb.x r0,[sp, 0x8]
L_931a48:
	mov_s r15,0x802288
L_931a4e:
	ld_s r0,[r15]
L_931a50:
	ld_s r1,[sp,0x0]
L_931a52:
	ld_s r2,[sp,0x4]
L_931a54:
	bl.d L_93d180
L_931a58:
	mov_s r3,0x1
L_931a5a:
	ld_s r0,[r14]
L_931a5c:
	ld_s r1,[r15]
L_931a5e:
	bset_s r0,r0,0x2
L_931a60:
	st_s r0,[r14]
L_931a62:
	ldb_s r0,[r13,0x13]
L_931a64:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_931a66:
	add2_s r1,r1,r1
L_931a68:
	bmsk_s r0,r0,0x4
L_931a6a:
	add_s r1,r1,0x801ffc
L_931a70:
	stb_s r0,[r1,0x9]
L_931a72:
	ldb_s r0,[r13,0x13]
L_931a74:
	btst_s r0,0x6
L_931a76:
	btst.eq r0,0x7
L_931a7a:
	bne_s L_931a84
L_931a7c:
	ldb_s r0,[r1,0xa]
L_931a7e:
	bset_s r0,r0,0x0
L_931a80:
	stb_s r0,[r1,0xa]
L_931a82:
	b_s L_931ac6
	.global L_931a84
L_931a84:
	ldb_s r0,[r1,0xa]
L_931a86:
	bclr_s r0,r0,0x0
L_931a88:
	stb_s r0,[r1,0xa]
L_931a8a:
	b_s L_931ac6
	.global L_931a8c
L_931a8c:
	mov_s r0,0x8021e0
L_931a92:
	ld_s r0,[r0]
L_931a94:
	btst_s r0,0xb
L_931a96:
	btst.ne r0,0xa
L_931a9a:
	btst.eq r0,0x2
L_931a9e:
	beq_s L_931ab2
L_931aa0:
	bbit0 r0,0x2,L_931ac6
	.global L_931aa4
L_931aa4:
	bl L_92a754
L_931aa8:
	b_s L_931ac6
	.global L_931aaa
L_931aaa:
	mov_s r0,blink
L_931aac:
	bl.d L_926618
L_931ab0:
	mov_s r1,0x18
	.global L_931ab2
L_931ab2:
	mov_s r0,0x8021e0
L_931ab8:
	ld_s r0,[r0]
L_931aba:
	cmp_s r0,0x0
L_931abc:
	bl.ne.d L_93c874
L_931ac0:
	sub_s.ne r0,r0,r0
L_931ac2:
	bl L_92f2bc
	.global L_931ac6
L_931ac6:
	b.d L_92029c
L_931aca:
	add_s sp,sp,0xc
