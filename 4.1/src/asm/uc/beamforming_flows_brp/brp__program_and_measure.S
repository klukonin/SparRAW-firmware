/* brp__program_and_measure @ 0x923930, 592 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_flows_brp.c
 * Зовут его: brp_flow_step, mac_mode_brp_step
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, brp__program_mac_sequence, brp__write_slot_txcfg, memset0_words_uc, rfc__issue_cmd_20, shl64, uc_sysassert
 */
	.section .text.brp__program_and_measure,"ax",@progbits
	.global brp__program_and_measure
brp__program_and_measure:
	.global L_923930
L_923930:
	push_s blink
L_923932:
	bl L_92020c
L_923936:
	st.a r0,[sp,-0x8]
L_92393a:
	mov_s r0,r49
L_92393c:
	mov_s r13,0x801050
L_923942:
	btst_s r0,0xd
L_923944:
	mov_s r1,0x801090
L_92394a:
	beq L_923b6c
L_92394e:
	ldb_s r0,[r1]
L_923950:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923952:
	extb_s r0,r0
L_923954:
	stb_s r0,[r1]
L_923956:
	mov_s r0,0x49000002
L_92395c:
	mov_s r32,r0
L_92395e:
	st.ab r0,[r25,0x4]
L_923962:
	bclr r25,r25,0xa
L_923966:
	mov_s r0,0x5000020
L_92396c:
	mov_s r32,r0
L_92396e:
	st.ab r0,[r25,0x4]
L_923972:
	bclr r25,r25,0xa
L_923976:
	mov_s r0,0x20
L_923978:
	bset_s r0,r0,0x1a
L_92397a:
	mov_s r32,r0
L_92397c:
	st.ab r0,[r25,0x4]
L_923980:
	bclr r25,r25,0xa
L_923984:
	mov_s r0,0x3d010000
L_92398a:
	mov_s r32,r0
L_92398c:
	st.ab r0,[r25,0x4]
L_923990:
	bclr r25,r25,0xa
L_923994:
	mov_s r0,0x58000003
L_92399a:
	mov_s r32,r0
L_92399c:
	st.ab r0,[r25,0x4]
L_9239a0:
	bclr r25,r25,0xa
L_9239a4:
	mov_s r0,r13
L_9239a6:
	bl.d L_92166c
L_9239aa:
	mov_s r1,0x40
L_9239ac:
	add2 r0,r13,0x17
L_9239b0:
	bl.d L_92166c
L_9239b4:
	mov_s r1,0x20
L_9239b6:
	mov_s r14,0x0
L_9239b8:
	mov r16,0x0
L_9239bc:
	ld_s r0,[gp,-0x44]
L_9239be:
	mov_s r13,0x0
L_9239c0:
	and r0,r0,0xffff0fff
L_9239c8:
	bset r1,r0,0xc
L_9239cc:
	bset_s r1,r1,0xe
L_9239ce:
	bset_s r1,r1,0xf
L_9239d0:
	st.as r1,[gp,-0x11]
L_9239d4:
	or r0,r0,0x1d00d000
L_9239dc:
	mov_s r32,r0
L_9239de:
	st.ab r0,[r25,0x4]
L_9239e2:
	bclr r25,r25,0xa
L_9239e6:
	nop_s
L_9239e8:
	nop_s
L_9239ea:
	nop_s
L_9239ec:
	mov_s r15,0x20
	.global L_9239ee
L_9239ee:
	mov_s r0,r54
L_9239f0:
	bbit1 r0,0x1,L_9239fa
L_9239f4:
	mov_s r0,r49
L_9239f6:
	bbit0 r0,0x5,L_9239ee
	.global L_9239fa
L_9239fa:
	mov_s r0,r54
L_9239fc:
	btst_s r0,0x1
L_9239fe:
	beq_s L_923b56
L_923a00:
	st r40,[sp, 0x4]
L_923a04:
	mov_s r0,0x49000002
L_923a0a:
	mov_s r32,r0
L_923a0c:
	st.ab r0,[r25,0x4]
L_923a10:
	bclr r25,r25,0xa
L_923a14:
	brge r13,0x20,L_923a2e
L_923a18:
	b_s L_923a22
	.global L_923a1a
L_923a1a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_923a1c:
	/* brge.d r13,0x20,0x00923a2e */
	.byte 0x13,0x0d,0x33,0x18
L_923a20:
	/* _add_s r14,0x2 */
	.byte 0x02,0xe6
	.global L_923a22
L_923a22:
	mov_s r0,0x857000
L_923a28:
	ld_s r0,[r0,0x4c]
L_923a2a:
	bbit0 r0,r13,L_923a1a
	.global L_923a2e
L_923a2e:
	brge r13,0x20,L_923a74
L_923a32:
	ld_s r0,[sp,0x4]
L_923a34:
	mov_s r2,0x801090
L_923a3a:
	lsr r1,r0,0xe
L_923a3e:
	bmsk_s r1,r1,0x9
L_923a40:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_923a42:
	lsr_s r1,r1,0x2
L_923a44:
	sub r2,r2,0x40
L_923a48:
	add_s r2,r2,r13
L_923a4a:
	stb r1,[r2, 0x5c]
L_923a4e:
	bmsk_s r0,r0,0x1
L_923a50:
	mov_s r1,0x0
L_923a52:
	bl.d L_920438
L_923a56:
	mov_s r2,r14
L_923a58:
	mov_s r4,r1
L_923a5a:
	mov_s r1,0x800734
L_923a60:
	mov_s r5,r0
L_923a62:
	ld_s r0,[r1,0x4]
L_923a64:
	ld_s r2,[r1,0x8]
L_923a66:
	or r0,r0,r5
L_923a6a:
	or r2,r2,r4
L_923a6e:
	st_s r0,[r1,0x4]
L_923a70:
	st_s r2,[r1,0x8]
L_923a72:
	b_s L_923a9e
	.global L_923a74
L_923a74:
	mov_s r1,0x883800
L_923a7a:
	ld.as r0,[r1,0xa9]
L_923a7e:
	mov_s r2,0x800a50
L_923a84:
	bmsk_s r0,r0,0x5
L_923a86:
	stb_s r0,[r2]
L_923a88:
	ld r0,[r1, -0xc]
L_923a8c:
	bmsk_s r0,r0,0x6
L_923a8e:
	stb_s r0,[r2,0x1]
L_923a90:
	ld_s r0,[r1]
L_923a92:
	bmsk_s r0,r0,0x4
L_923a94:
	stb_s r0,[r2,0x2]
L_923a96:
	ld.as r0,[r1,-0x4e]
L_923a9a:
	bmsk_s r0,r0,0x15
L_923a9c:
	st_s r0,[r2,0x4]
	.global L_923a9e
L_923a9e:
	ld_s r0,[sp,0x4]
L_923aa0:
	lsr_s r0,r0,0x18
L_923aa2:
	bmsk_s r0,r0,0x6
L_923aa4:
	brne r0,r16,L_923b42
	.global L_923aa8
L_923aa8:
	add r16,r16,0x1
L_923aac:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_923aae:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_923ab0:
	/* brhs.d r15,0x1,0x009239ee */
	.byte 0x3f,0x0f,0x75,0x90
L_923ab4:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_923ab6:
	mov_s r1,0x801090
L_923abc:
	ldb_s r0,[r1,0xc]
L_923abe:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923ac0:
	extb_s r0,r0
L_923ac2:
	stb_s r0,[r1,0xc]
L_923ac4:
	mov_s r0,0x3d020000
L_923aca:
	mov_s r32,r0
L_923acc:
	st.ab r0,[r25,0x4]
L_923ad0:
	bclr r25,r25,0xa
L_923ad4:
	mov_s r0,0x800734
L_923ada:
	ld_s r2,[r0,0x4]
L_923adc:
	ld_s r1,[r0,0x8]
L_923ade:
	mov_s r0,0x801050
L_923ae4:
	st_s r2,[r0,0x44]
L_923ae6:
	st_s r1,[r0,0x48]
L_923ae8:
	ld_s r0,[sp,0x0]
L_923aea:
	bl.d L_937404
L_923aee:
	add3 r1,r0,0xc
L_923af2:
	mov_s r13,0x80087c
L_923af8:
	ld_s r0,[r13]
L_923afa:
	lsr r1,r0,0x8
L_923afe:
	bmsk_s r1,r1,0xe
L_923b00:
	bl.d L_92bc40
L_923b04:
	bmsk_s r0,r0,0x3
L_923b06:
	ld_s r0,[r13]
L_923b08:
	st.as r0,[gp,-0xc]
L_923b0c:
	ld_s r0,[gp,-0x44]
L_923b0e:
	and r0,r0,0xfff0ffff
L_923b16:
	bset r1,r0,0x10
L_923b1a:
	bset_s r1,r1,0x11
L_923b1c:
	or r0,r0,0x1d030000
L_923b24:
	st.as r1,[gp,-0x11]
L_923b28:
	mov_s r32,r0
L_923b2a:
	st.ab r0,[r25,0x4]
L_923b2e:
	bclr r25,r25,0xa
L_923b32:
	nop_s
L_923b34:
	nop_s
L_923b36:
	nop_s
	.global L_923b38
L_923b38:
	mov_s r0,r47
L_923b3a:
	bbit1 r0,0x11,L_923b38
L_923b3e:
	mov_s r13,0x1
L_923b40:
	b_s L_923b66
	.global L_923b42
L_923b42:
	mov_s r0,blink
L_923b44:
	mov_s r2,0x1000aac
L_923b4a:
	mov_s r1,0x4
L_923b4c:
	bl.d L_925548
L_923b50:
	mov r3,0x24f
L_923b54:
	b_s L_923aa8
	.global L_923b56
L_923b56:
	mov_s r1,0x801090
L_923b5c:
	ldb_s r0,[r1,0x1]
L_923b5e:
	mov_s r13,0x0
L_923b60:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923b62:
	extb_s r0,r0
L_923b64:
	stb_s r0,[r1,0x1]
	.global L_923b66
L_923b66:
	bl L_9250e0
L_923b6a:
	b_s L_923b76
	.global L_923b6c
L_923b6c:
	ldb_s r0,[r1,0x2]
L_923b6e:
	mov_s r13,0x0
L_923b70:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923b72:
	extb_s r0,r0
L_923b74:
	stb_s r0,[r1,0x2]
	.global L_923b76
L_923b76:
	extb_s r0,r13
L_923b78:
	b.d L_920274
L_923b7c:
	add_s sp,sp,0x8
L_923b7e:
	nop_s
