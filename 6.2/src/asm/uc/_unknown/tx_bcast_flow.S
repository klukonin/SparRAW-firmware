/* tx_bcast_flow @ 0x937844, 1128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_bcast_flow: Broadcast queue is empty, aborting transmission
 * Зовут его: tx_initiator_flow_fixed_scheduling, tx_non_data_flow_fixed_scheduling, tx_slot__dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, direct_tx__program_cmd34, direct_tx__send_after_delay, mac__cmd_29000001, mac__load_tx_key, mac__program_rx_window, mac__program_tx_with_qid, mac__program_tx_with_rate, mac__select_all_sectors_and_wait, mac__set_rf_chain_state, mac_evt__enable_bit_sync_b
 * Глобалы (через gp): 0x8005b0, 0x8005f4, 0x8005f8, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_bcast_flow
tx_bcast_flow:
	.global L_937844
L_937844:
	push_s blink
L_937846:
	bl.d L_920230
L_93784a:
	mov_s r1,0x2
L_93784c:
	st.as r1,[gp,0x33]
L_937850:
	mov_s r13,0x802eac
L_937856:
	ld_s r1,[r13,0xc]
L_937858:
	mov_s r0,0x0
L_93785a:
	sub_s sp,sp,0x10
L_93785c:
	st.as r0,[gp,0x34]
L_937860:
	brne_s r1,0,L_93786c
L_937862:
	mov_s r0,0x80218c
L_937868:
	ldb_s r1,[r0,0x8]
L_93786a:
	st_s r1,[r13,0xc]
	.global L_93786c
L_93786c:
	norm r0,r1
L_937870:
	rsub r15,r0,0x1e
L_937874:
	breq_s r1,0,L_937888
L_937876:
	asl_s r0,r15,0x4
L_937878:
	add2_s r0,r0,r0
L_93787a:
	mov_s r1,0x80110c
L_937880:
	ld_s r0,[r1,r0]
L_937882:
	lsr_s r0,r0,0x8
L_937884:
	bmsk_s r0,r0,0xe
L_937886:
	b_s L_93788a
	.global L_937888
L_937888:
	mov_s r0,0x1
	.global L_93788a
L_93788a:
	st_s r0,[r13,0x10]
L_93788c:
	bl.d L_92dab8
L_937890:
	ld_s r0,[gp,-0xc0]
L_937892:
	brne_s r0,0,L_9378da
L_937894:
	mov_s r0,0x0
L_937896:
	st_s r0,[r13,0xc]
L_937898:
	stw.as r0,[gp,0x44]
L_93789c:
	bl.d L_9384d4
L_9378a0:
	mov_s r0,0x1
L_9378a2:
	ld.as r1,[gp,-0x30]
L_9378a6:
	st_s r1,[r0,0x4]
L_9378a8:
	bl.d L_92d93c
L_9378ac:
	mov_s r0,r1
	.global L_9378ae
L_9378ae:
	mov_s r0,r43
L_9378b0:
	bbit0 r0,0x1f,L_9378ae
L_9378b4:
	mov_s r0,r51
L_9378b6:
	bmsk r1,r0,0x3
L_9378ba:
	st.as r1,[gp,0x38]
L_9378be:
	lsr_s r0,r0,0x4
L_9378c0:
	st.as r0,[gp,0x39]
	.global L_9378c4
L_9378c4:
	mov_s r0,r45
L_9378c6:
	bbit0 r0,0x1f,L_9378c4
L_9378ca:
	mov_s r1,0x1001a6c
L_9378d0:
	bl.d L_92d13c
L_9378d4:
	mov_s r0,0x21
L_9378d6:
	b L_937ca6
	.global L_9378da
L_9378da:
	ld_s r0,[gp,-0x44]
L_9378dc:
	and r0,r0,0xfff0ffff
L_9378e4:
	bset r1,r0,0x13
L_9378e8:
	or r0,r0,0x1d080000
L_9378f0:
	st.as r1,[gp,-0x11]
L_9378f4:
	mov_s r32,r0
L_9378f6:
	st.ab r0,[r25,0x4]
L_9378fa:
	bclr r25,r25,0xa
L_9378fe:
	nop_s
L_937900:
	nop_s
L_937902:
	nop_s
	.global L_937904
L_937904:
	mov_s r0,r47
L_937906:
	bbit0 r0,0x1f,L_937904
L_93790a:
	extw r13,r47
L_93790e:
	ld_s r0,[gp,-0x44]
L_937910:
	and r0,r0,0xffff0fff
L_937918:
	bset r1,r0,0xd
L_93791c:
	bset_s r1,r1,0xf
L_93791e:
	or r0,r0,0x1d00a000
L_937926:
	st.as r1,[gp,-0x11]
L_93792a:
	mov_s r32,r0
L_93792c:
	st.ab r0,[r25,0x4]
L_937930:
	bclr r25,r25,0xa
L_937934:
	bl L_936870
L_937938:
	bl L_936520
L_93793c:
	mov_s r1,r40
L_93793e:
	mov_s r0,r42
L_937940:
	bbit1 r0,0xe,L_937948
L_937944:
	bbit1 r1,0x18,L_937976
	.global L_937948
L_937948:
	mov_s r0,r45
L_93794a:
	bbit0 r0,0x1f,L_937948
L_93794e:
	mov_s r0,0x29000002
L_937954:
	mov_s r32,r0
L_937956:
	st.ab r0,[r25,0x4]
L_93795a:
	bclr r25,r25,0xa
L_93795e:
	mov_s r1,0x802eac
L_937964:
	ldb_s r0,[r1]
L_937966:
	st.as 0x800,[gp,0x34]
L_93796e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937970:
	b.d L_937ca6
L_937974:
	stb_s r0,[r1]
	.global L_937976
L_937976:
	mov_s r0,0x802eac
L_93797c:
	ld_s r2,[r0,0x10]
L_93797e:
	ld_s r0,[gp,-0xc]
L_937980:
	asl_s r2,r2,0x8
L_937982:
	or r1,r0,0x30
L_937986:
	mov_s r0,0x5
L_937988:
	or_s r1,r1,r2
L_93798a:
	mov_s r2,0x0
L_93798c:
	bl.d L_92f798
L_937990:
	mov_s r3,r2
L_937992:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_937994:
	bset_s r13,r13,0x18
L_937996:
	bset_s r13,r13,0x1a
L_937998:
	bset_s r13,r13,0x1c
L_93799a:
	mov_s r32,r13
L_93799c:
	st.ab r13,[r25,0x4]
L_9379a0:
	bclr r25,r25,0xa
L_9379a4:
	mov_s r0,0x14000007
L_9379aa:
	mov_s r32,r0
L_9379ac:
	st.ab r0,[r25,0x4]
L_9379b0:
	bclr r25,r25,0xa
L_9379b4:
	mov_s r0,0x10
L_9379b6:
	bl.d L_9257a8
L_9379ba:
	mov_s r1,r0
L_9379bc:
	bl.d L_92d8e8
L_9379c0:
	mov_s r0,0x0
	.global L_9379c2
L_9379c2:
	mov_s r0,r43
L_9379c4:
	bbit0 r0,0x1f,L_9379c2
L_9379c8:
	mov_s r0,r51
L_9379ca:
	bmsk r1,r0,0x3
L_9379ce:
	st.as r1,[gp,0x38]
L_9379d2:
	lsr_s r0,r0,0x4
L_9379d4:
	st.as r0,[gp,0x39]
	.global L_9379d8
L_9379d8:
	mov_s r0,r45
L_9379da:
	bbit0 r0,0x1f,L_9379d8
L_9379de:
	mov_s r0,0x18001000
L_9379e4:
	mov_s r32,r0
L_9379e6:
	st.ab r0,[r25,0x4]
L_9379ea:
	bclr r25,r25,0xa
L_9379ee:
	mov_s r0,r15
L_9379f0:
	mov_s r1,0x6
L_9379f2:
	bl.d L_938218
L_9379f6:
	mov_s r2,0x5
L_9379f8:
	mov_s r0,0x2008000
L_9379fe:
	mov_s r32,r0
L_937a00:
	st.ab r0,[r25,0x4]
L_937a04:
	bclr r25,r25,0xa
L_937a08:
	mov_s r0,0x19000001
L_937a0e:
	mov_s r32,r0
L_937a10:
	st.ab r0,[r25,0x4]
L_937a14:
	bclr r25,r25,0xa
L_937a18:
	bl.d L_936544
L_937a1c:
	mov_s r0,0x6
L_937a1e:
	mov_s r1,0x801304
L_937a24:
	ldb r0,[r1, 0xcb]
L_937a28:
	breq_s r0,0,L_937a36
L_937a2a:
	bl.d L_9294ac
L_937a2e:
	add3 r0,r1,0x17
L_937a32:
	bl L_92949c
	.global L_937a36
L_937a36:
	mov_s r0,0x0
L_937a38:
	bl.d L_9366dc
L_937a3c:
	bset_s r0,r0,0xf
L_937a3e:
	bl.d L_936588
L_937a42:
	mov_s r0,0x6
L_937a44:
	mov_s r1,0x802eac
L_937a4a:
	ldb_s r0,[r1,0x3]
L_937a4c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937a4e:
	stb_s r0,[r1,0x3]
L_937a50:
	mov_s r0,0x14
L_937a52:
	asl_s r0,r0,0x18
L_937a54:
	mov_s r32,r0
L_937a56:
	st.ab r0,[r25,0x4]
L_937a5a:
	bclr r25,r25,0xa
L_937a5e:
	ld_s r0,[gp,-0xc0]
L_937a60:
	asl_s r0,r0,0x10
L_937a62:
	bset r13,r0,0x0
L_937a66:
	mov_s r0,0x1b001111
L_937a6c:
	mov_s r32,r0
L_937a6e:
	st.ab r0,[r25,0x4]
L_937a72:
	bclr r25,r25,0xa
L_937a76:
	bset_s r13,r13,0x19
L_937a78:
	bset_s r13,r13,0x1a
L_937a7a:
	bset_s r13,r13,0x1c
L_937a7c:
	mov_s r32,r13
L_937a7e:
	st.ab r13,[r25,0x4]
L_937a82:
	bclr r25,r25,0xa
L_937a86:
	mov_s r0,0x17
L_937a88:
	asl_s r0,r0,0x18
L_937a8a:
	mov_s r32,r0
L_937a8c:
	st.ab r0,[r25,0x4]
L_937a90:
	bclr r25,r25,0xa
L_937a94:
	nop_s
L_937a96:
	nop_s
L_937a98:
	nop_s
	.global L_937a9a
L_937a9a:
	mov_s r0,r43
L_937a9c:
	bbit0 r0,0x1f,L_937a9a
L_937aa0:
	mov_s r0,r51
L_937aa2:
	bmsk r1,r0,0x3
L_937aa6:
	st.as r1,[gp,0x38]
L_937aaa:
	lsr_s r0,r0,0x4
L_937aac:
	st.as r0,[gp,0x39]
L_937ab0:
	lsr r0,r43,0x10
L_937ab4:
	bmsk.f r2,r0,0x4
L_937ab8:
	mov.eq r2,0x1
L_937abc:
	mov_s r0,0x802eac
L_937ac2:
	ld_s r3,[r0,0x10]
L_937ac4:
	ld_s r0,[gp,-0xc]
L_937ac6:
	asl_s r3,r3,0x8
L_937ac8:
	or r1,r0,0x30
L_937acc:
	mov_s r0,0x1
L_937ace:
	or_s r1,r1,r3
L_937ad0:
	bl.d L_92f798
L_937ad4:
	mov_s r3,0x0
L_937ad6:
	mov_s r0,0x2008000
L_937adc:
	mov_s r32,r0
L_937ade:
	st.ab r0,[r25,0x4]
L_937ae2:
	bclr r25,r25,0xa
L_937ae6:
	mov_s r0,0x19000001
L_937aec:
	mov_s r32,r0
L_937aee:
	st.ab r0,[r25,0x4]
L_937af2:
	bclr r25,r25,0xa
	.global L_937af6
L_937af6:
	mov_s r0,r45
L_937af8:
	bbit0 r0,0x1f,L_937af6
L_937afc:
	mov_s r0,0x18001000
L_937b02:
	mov_s r32,r0
L_937b04:
	st.ab r0,[r25,0x4]
L_937b08:
	bclr r25,r25,0xa
L_937b0c:
	bl.d L_936544
L_937b10:
	mov_s r0,0x6
L_937b12:
	mov_s r14,0x802eac
L_937b18:
	ldb_s r0,[r14,0x4]
L_937b1a:
	mov_s r1,0x801024
L_937b20:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937b22:
	stb_s r0,[r14,0x4]
L_937b24:
	mov_s r13,0x1
L_937b26:
	mov_s r0,r13
L_937b28:
	bl.d L_92f42c
L_937b2c:
	ld_s r1,[r1]
L_937b2e:
	mov_s r0,0x0
L_937b30:
	bl.d L_9366dc
L_937b34:
	bset_s r0,r0,0xf
L_937b36:
	ldb_s r0,[r14,0x2]
L_937b38:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937b3a:
	stb_s r0,[r14,0x2]
L_937b3c:
	bl.d L_936588
L_937b40:
	mov_s r0,0x6
L_937b42:
	ld_s r0,[gp,0x178]
L_937b44:
	mov_s r1,0x802944
L_937b4a:
	bclr_s r0,r0,0x18
L_937b4c:
	ld_s r1,[r1]
L_937b4e:
	bclr_s r0,r0,0x19
L_937b50:
	asl_s r1,r1,0x18
L_937b52:
	or_s r0,r0,r1
L_937b54:
	st.as r0,[gp,0x5e]
L_937b58:
	mov_s r1,0x889480
L_937b5e:
	st_s r0,[r1,0x8]
L_937b60:
	mov_s r0,0x8006c0
L_937b66:
	st_s r13,[r0]
L_937b68:
	ld_s r0,[r14,0xc]
L_937b6a:
	bclr.f r0,r0,r15
L_937b6e:
	st_s r0,[r14,0xc]
L_937b70:
	bne_s L_937c7a
L_937b72:
	mov_s r0,0x0
L_937b74:
	stw.as r0,[gp,0x44]
L_937b78:
	bl.d L_9384d4
L_937b7c:
	mov_s r0,r13
L_937b7e:
	mov_s r13,r0
L_937b80:
	ld_s r0,[gp,-0xc0]
L_937b82:
	bl.d L_92dab8
L_937b86:
	st_s r0,[r13,0x4]
L_937b88:
	cmp_s r0,0x0
L_937b8a:
	beq_s L_937c70
	.global L_937b8c
L_937b8c:
	mov_s r0,0x886500
L_937b92:
	ld_s r0,[r0,0x6c]
L_937b94:
	bmsk.f 0x0,r0,0x3
L_937b98:
	mov.ne r0,blink
L_937b9c:
	bl.ne.d L_926618
L_937ba0:
	mov.ne r1,0x3
L_937ba4:
	mov_s r0,0x1c000006
L_937baa:
	mov_s r32,r0
L_937bac:
	st.ab r0,[r25,0x4]
L_937bb0:
	bclr r25,r25,0xa
L_937bb4:
	ld_s r0,[gp,-0xc0]
L_937bb6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_937bb8:
	or r0,r0,0x46000008
L_937bc0:
	mov_s r32,r0
L_937bc2:
	st.ab r0,[r25,0x4]
L_937bc6:
	bclr r25,r25,0xa
L_937bca:
	mov_s r1,0x8022c8
L_937bd0:
	ld_s r0,[r1,0x14]
L_937bd2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937bd4:
	st_s r0,[r1,0x14]
	.global L_937bd6
L_937bd6:
	mov_s r0,r53
L_937bd8:
	bbit0 r0,0x2,L_937bd6
L_937bdc:
	ld_s r0,[gp,-0x44]
L_937bde:
	and r0,r0,0xfff0ffff
L_937be6:
	bset r1,r0,0x10
L_937bea:
	or r0,r0,0x1d010000
L_937bf2:
	st.as r1,[gp,-0x11]
L_937bf6:
	mov_s r32,r0
L_937bf8:
	st.ab r0,[r25,0x4]
L_937bfc:
	bclr r25,r25,0xa
L_937c00:
	nop_s
L_937c02:
	nop_s
L_937c04:
	nop_s
	.global L_937c06
L_937c06:
	mov_s r0,r47
L_937c08:
	bbit1 r0,0x0,L_937c06
L_937c0c:
	ld_s r0,[gp,-0xc0]
L_937c0e:
	or r0,r0,0x44280800
L_937c16:
	mov_s r32,r0
L_937c18:
	st.ab r0,[r25,0x4]
L_937c1c:
	bclr r25,r25,0xa
L_937c20:
	mov_s r0,0x45000001
L_937c26:
	mov_s r32,r0
L_937c28:
	st.ab r0,[r25,0x4]
L_937c2c:
	bclr r25,r25,0xa
L_937c30:
	mov_s r0,0x460001f1
L_937c36:
	mov_s r32,r0
L_937c38:
	st.ab r0,[r25,0x4]
L_937c3c:
	bclr r25,r25,0xa
L_937c40:
	bl.d L_92d93c
L_937c44:
	ld_s r0,[r13,0x4]
	.global L_937c46
L_937c46:
	mov_s r0,r43
L_937c48:
	bbit0 r0,0x1f,L_937c46
L_937c4c:
	mov_s r0,r51
L_937c4e:
	bmsk r1,r0,0x3
L_937c52:
	st.as r1,[gp,0x38]
L_937c56:
	lsr_s r0,r0,0x4
L_937c58:
	st.as r0,[gp,0x39]
	.global L_937c5c
L_937c5c:
	mov_s r0,r45
L_937c5e:
	bbit0 r0,0x1f,L_937c5c
L_937c62:
	mov_s r1,0x802eac
L_937c68:
	ldb_s r0,[r1,0x1]
L_937c6a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937c6c:
	stb_s r0,[r1,0x1]
L_937c6e:
	b_s L_937ca6
	.global L_937c70
L_937c70:
	mov_s r0,blink
L_937c72:
	bl.d L_926618
L_937c76:
	mov_s r1,0x7
L_937c78:
	b_s L_937b8c
	.global L_937c7a
L_937c7a:
	ldw_s r0,[gp,0x88]
L_937c7c:
	brne_s r0,0,L_937c98
L_937c7e:
	mov_s r0,sp
L_937c80:
	ld.as r1,[gp,-0x30]
L_937c84:
	mov_s r2,0x2
L_937c86:
	mov_s r3,0x0
L_937c88:
	bl.d L_92449c
L_937c8c:
	mov_s r4,r13
L_937c8e:
	ld_s r0,[sp,0x8]
L_937c90:
	lsr_s r0,r0,0xc
L_937c92:
	bmsk_s r0,r0,0xb
L_937c94:
	stw.as r0,[gp,0x44]
	.global L_937c98
L_937c98:
	bl L_9245b0
L_937c9c:
	bset r1,r0,0x13
L_937ca0:
	bl.d L_92462c
L_937ca4:
	ldw_s r0,[gp,0x88]
	.global L_937ca6
L_937ca6:
	b.d L_92029c
L_937caa:
	add_s sp,sp,0x10
