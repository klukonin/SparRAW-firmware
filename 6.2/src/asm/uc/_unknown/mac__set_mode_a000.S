/* mac__set_mode_a000 @ 0x92a754, 556 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow, brp_init__tx_request, brp_responder_transmission_flow, mac_mode__enter_idle_seq, mac_mode__switch_after_ppdu, mac_mode__switch_core_and_rf, mac_mode_program_c, rf__power_seq_and_save, rx__switch_to_rx_mode, rx_funcs__handle_ppdu_report
 * Зовёт сам: uc_sysassert
 * Глобалы (через gp): 0x800578, 0x800590, 0x800594
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_mode_a000
mac__set_mode_a000:
	.global L_92a754
L_92a754:
	st.a r13,[sp,-0x8]
L_92a758:
	st_s r14,[sp,0x4]
L_92a75a:
	mov_s r14,blink
L_92a75c:
	mov r5,0x0
L_92a760:
	ld.as r9,[gp,-0x11]
L_92a764:
	st.as r5,[gp,-0x22]
L_92a768:
	and r9,r9,0xffff0fff
L_92a770:
	or r4,r9,0xa000
L_92a778:
	st.as r4,[gp,-0x11]
L_92a77c:
	or r9,r9,0x1d00a000
L_92a784:
	mov r32,r9
L_92a788:
	st.ab r9,[r25,0x4]
L_92a78c:
	bclr r25,r25,0xa
L_92a790:
	nop_s
L_92a792:
	nop_s
L_92a794:
	nop_s
L_92a796:
	asr r3,r49,0x10
L_92a79a:
	bmsk_s r3,r3,0x3
L_92a79c:
	cmp_s r3,0x6
L_92a79e:
	bcc L_92a888
L_92a7a2:
	mov_s r3,0x800628
L_92a7a8:
	st 0xff2f,[r3]
	.global L_92a7b0
L_92a7b0:
	mov_s r2,r40
L_92a7b2:
	bbit0 r2,0x18,L_92a7b0
L_92a7b6:
	mov r11,0x0
L_92a7ba:
	st r11,[0x800628]
L_92a7c2:
	nop_s
L_92a7c4:
	mov r13,r40
	.global L_92a7c8
L_92a7c8:
	mov r10,r40
L_92a7cc:
	bbit1 r10,0x3,L_92a7c8
L_92a7d0:
	mov 0x0,0x0
L_92a7d4:
	mov r9,0x3d000004
L_92a7dc:
	mov r32,r9
L_92a7e0:
	st.ab r9,[r25,0x4]
L_92a7e4:
	bclr r25,r25,0xa
L_92a7e8:
	nop_s
L_92a7ea:
	nop_s
L_92a7ec:
	nop_s
L_92a7ee:
	st.as r49,[gp,-0x23]
L_92a7f2:
	mov_s r2,r40
L_92a7f4:
	bbit1 r2,0x3,L_92a878
	.global L_92a7f8
L_92a7f8:
	mov_s r1,r40
L_92a7fa:
	bbit1 r1,0x18,L_92a808
L_92a7fe:
	mov_s r0,blink
L_92a800:
	bl.d L_926618
L_92a804:
	mov r1,0x94
	.global L_92a808
L_92a808:
	mov r8,0x2093800
L_92a810:
	mov r32,r8
L_92a814:
	st.ab r8,[r25,0x4]
L_92a818:
	bclr r25,r25,0xa
L_92a81c:
	mov_s r1,0x1
L_92a81e:
	stb r1,[gp, -0xf5]
L_92a822:
	ld.as r1,[gp,-0x11]
L_92a826:
	and r1,r1,0xffff0fff
L_92a82e:
	or r10,r1,0xa000
L_92a836:
	or r1,r1,0x1d00a000
L_92a83e:
	st.as r10,[gp,-0x11]
L_92a842:
	mov_s r32,r1
L_92a844:
	st.ab r1,[r25,0x4]
L_92a848:
	bclr r25,r25,0xa
L_92a84c:
	nop_s
L_92a84e:
	nop_s
L_92a850:
	mov 0x0,0x0
L_92a854:
	lsr r6,r40,0x8
L_92a858:
	bmsk r6,r6,0x5
L_92a85c:
	bbit0.d r13,0x3,L_92a870
L_92a860:
	st.as r6,[gp,0x14]
L_92a864:
	ld.as r4,[gp,0x1a]
L_92a868:
	add r4,r4,0x1
L_92a86c:
	st.as r4,[gp,0x1a]
	.global L_92a870
L_92a870:
	b.d L_92a974
L_92a874:
	mov r0,0x1
	.global L_92a878
L_92a878:
	mov r0,blink
L_92a87c:
	bl.d L_926618
L_92a880:
	mov r1,0x93
L_92a884:
	b L_92a7f8
	.global L_92a888
L_92a888:
	mov r0,0x1
L_92a88c:
	st.as r0,[gp,-0x22]
	.global L_92a890
L_92a890:
	asr r2,r49,0x10
L_92a894:
	bmsk r2,r2,0x3
L_92a898:
	brlo r2,0x6,L_92a8a0
L_92a89c:
	brlo r2,0xe,L_92a890
	.global L_92a8a0
L_92a8a0:
	mov r11,0x800628
L_92a8a8:
	st 0xff30,[r11]
	.global L_92a8b0
L_92a8b0:
	mov_s r0,r40
L_92a8b2:
	bbit0 r0,0x18,L_92a8b0
L_92a8b6:
	mov r4,0x0
L_92a8ba:
	st r4,[0x800628]
L_92a8c2:
	nop_s
	.global L_92a8c4
L_92a8c4:
	mov r5,r40
L_92a8c8:
	bbit1 r5,0x3,L_92a8c4
L_92a8cc:
	nop_s
L_92a8ce:
	nop_s
L_92a8d0:
	mov 0x0,0x0
L_92a8d4:
	mov r7,0x3d000004
L_92a8dc:
	mov r32,r7
L_92a8e0:
	st.ab r7,[r25,0x4]
L_92a8e4:
	bclr r25,r25,0xa
L_92a8e8:
	nop_s
L_92a8ea:
	nop_s
L_92a8ec:
	mov 0x0,0x0
L_92a8f0:
	mov r6,r40
L_92a8f4:
	bbit0 r6,0x18,L_92a900
L_92a8f8:
	mov r7,r40
L_92a8fc:
	bbit0 r7,0x3,L_92a90c
	.global L_92a900
L_92a900:
	mov r0,blink
L_92a904:
	bl.d L_926618
L_92a908:
	mov r1,0x8d
	.global L_92a90c
L_92a90c:
	mov r6,0x2093800
L_92a914:
	mov r32,r6
L_92a918:
	st.ab r6,[r25,0x4]
L_92a91c:
	bclr r25,r25,0xa
L_92a920:
	mov r8,0x0
L_92a924:
	ld.as r7,[gp,-0x11]
L_92a928:
	stb r8,[gp, -0xf5]
L_92a92c:
	and r7,r7,0xffff0fff
L_92a934:
	or r9,r7,0xa000
L_92a93c:
	st.as r9,[gp,-0x11]
L_92a940:
	or r7,r7,0x1d00a000
L_92a948:
	mov r32,r7
L_92a94c:
	st.ab r7,[r25,0x4]
L_92a950:
	bclr r25,r25,0xa
L_92a954:
	nop_s
L_92a956:
	nop_s
L_92a958:
	nop_s
L_92a95a:
	lsr r8,r40,0x8
L_92a95e:
	bmsk r8,r8,0x5
L_92a962:
	ld.as r5,[gp,0x1b]
L_92a966:
	st.as r8,[gp,0x14]
L_92a96a:
	add r5,r5,0x1
L_92a96e:
	st.as r5,[gp,0x1b]
L_92a972:
	mov_s r0,0x0
	.global L_92a974
L_92a974:
	mov_s blink,r14
L_92a976:
	ld_s r14,[sp,0x4]
L_92a978:
	j.d [blink]
L_92a97c:
	ld.ab r13,[sp,0x8]
