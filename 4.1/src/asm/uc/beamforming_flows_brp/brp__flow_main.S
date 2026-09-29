/* brp__flow_main @ 0x924938, 1152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_flows_brp.c
 * Зовут его: brp__mode_step, brp_flow_step
 * Зовёт сам: __ld_r24_to_r13_ret_uc, __st_r24_to_r13_uc, brp__find_phase_index, brp__sum_sector_counts, brp__write_reg_pair, brp_copy_step, uc_sysassert
 */
	.section .text.brp__flow_main,"ax",@progbits
	.global brp__flow_main
brp__flow_main:
	.global L_924938
L_924938:
	push_s blink
L_92493a:
	bl L_9201ec
L_92493e:
	st.a r0,[sp,-0x3c]
L_924942:
	mov r18,0x800758
L_92494a:
	ld r1,[r18]
L_92494e:
	mov_s r13,0x0
L_924950:
	mov_s r0,0x800734
L_924956:
	st_s r0,[sp,0x10]
L_924958:
	breq_s r1,0,L_924986
L_92495a:
	mov_s r0,0x800a50
L_924960:
	ldb_s r1,[r0,0x2]
L_924962:
	ldb r0,[r18, 0x9]
L_924966:
	brlt r1,r0,L_924976
L_92496a:
	ldb r15,[r18, 0x8]
L_92496e:
	ldb.x r0,[r18, 0x6]
L_924972:
	st_s r0,[sp,0x4]
L_924974:
	b_s L_92498e
	.global L_924976
L_924976:
	ld_s r0,[sp,0x10]
L_924978:
	ld_s r15,[r0]
L_92497a:
	lsr_s r15,r15,0xf
L_92497c:
	ldb.x r0,[r18, 0x5]
L_924980:
	bmsk_s r15,r15,0x5
L_924982:
	st_s r0,[sp,0x4]
L_924984:
	b_s L_92498e
	.global L_924986
L_924986:
	ld_s r15,[r0]
L_924988:
	st_s r13,[sp,0x4]
L_92498a:
	lsr_s r15,r15,0xf
L_92498c:
	bmsk_s r15,r15,0x5
	.global L_92498e
L_92498e:
	ld_s r0,[sp,0x0]
L_924990:
	ld_s r1,[sp,0x10]
L_924992:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_924994:
	add1_s r0,r0,r0
L_924996:
	add_s r0,r0,0x4800
L_92499c:
	st_s r0,[sp,0x8]
L_92499e:
	add_s r0,r0,0x10020
L_9249a4:
	lsr_s r0,r0,0x3
L_9249a6:
	bic r0,r0,0x3
L_9249aa:
	bl.d L_92bcac
L_9249ae:
	ld_s r1,[r1,0x4]
L_9249b0:
	ld_s r0,[sp,0x10]
L_9249b2:
	mov r16,0x0
L_9249b6:
	ld_s r1,[r0,0x4]
L_9249b8:
	ld_s r0,[sp,0x0]
L_9249ba:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9249bc:
	add1_s r0,r0,r0
L_9249be:
	add_s r0,r0,0x80078c
L_9249c4:
	st_s r0,[sp,0x14]
L_9249c6:
	st_s r1,[r0]
L_9249c8:
	mov_s r14,r13
L_9249ca:
	st_s r13,[sp,0xc]
L_9249cc:
	mov_s r24,r13
L_9249ce:
	brlo.d r15,0x1,L_924a28
L_9249d2:
	mov_s r21,r13
	.global L_9249d4
L_9249d4:
	ld r3,[r18]
L_9249d8:
	mov_s r1,0x801050
L_9249de:
	add1 r2,r1,r16
L_9249e2:
	ldb_s r0,[r2,0x1]
L_9249e4:
	mov r4,0x0
L_9249e8:
	bset r4,r4,r0
L_9249ec:
	breq_s r3,0,L_924a1a
L_9249ee:
	ldb_s r1,[r1]
L_9249f0:
	add_s r0,sp,0x28
L_9249f2:
	ldb_s r2,[r2]
L_9249f4:
	mov_s r3,r4
L_9249f6:
	bl.d L_9232a8
L_9249fa:
	ld r4,[sp, 0x4]
L_9249fe:
	ld_s r1,[sp,0x28]
L_924a00:
	ld_s r2,[sp,0x2c]
L_924a02:
	or r21,r21,r1
L_924a06:
	ld_s r0,[sp,0x30]
L_924a08:
	ld_s r3,[sp,0xc]
L_924a0a:
	or r24,r24,r2
L_924a0e:
	or_s r3,r3,r0
L_924a10:
	st_s r3,[sp,0xc]
L_924a12:
	or_s r1,r1,r2
L_924a14:
	or_s r0,r0,r1
L_924a16:
	or_s r14,r14,r0
L_924a18:
	b_s L_924a1e
	.global L_924a1a
L_924a1a:
	or r14,r14,r4
	.global L_924a1e
L_924a1e:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_924a20:
	brhs.d r15,0x1,L_9249d4
L_924a24:
	add r16,r16,0x1
	.global L_924a28
L_924a28:
	mov_s r0,0x857000
L_924a2e:
	ld_s r0,[r0,0x4c]
L_924a30:
	tst_s r0,r14
L_924a32:
	beq_s L_924ab2
	.global L_924a34
L_924a34:
	ld_s r0,[sp,0x8]
L_924a36:
	ld_s r1,[sp,0x10]
L_924a38:
	add_s r0,r0,0x10000
L_924a3e:
	lsr_s r0,r0,0x3
L_924a40:
	bic r0,r0,0x3
L_924a44:
	bl.d L_92bcac
L_924a48:
	ld_s r1,[r1,0x8]
L_924a4a:
	ld_s r0,[sp,0x10]
L_924a4c:
	mov_s r2,0x0
L_924a4e:
	ld_s r1,[r0,0x8]
L_924a50:
	ld_s r0,[sp,0x14]
L_924a52:
	st_s r2,[sp,0x18]
L_924a54:
	st_s r1,[r0,0x4]
L_924a56:
	st_s r2,[sp,0x1c]
L_924a58:
	mov_s r4,r2
L_924a5a:
	b_s L_924a6a
	.global L_924a5c
L_924a5c:
	ld_s r0,[sp,0x1c]
L_924a5e:
	brge r0,r1,L_924a64
L_924a62:
	st_s r1,[sp,0x1c]
	.global L_924a64
L_924a64:
	/* add_s r2,0x4 */
	.byte 0x04,0xe2
L_924a66:
	add r4,r4,0x3
	.global L_924a6a
L_924a6a:
	brhs r2,0x20,L_924ad8
L_924a6e:
	lsr r3,r2,0x2
L_924a72:
	mov_s r1,0x0
L_924a74:
	mov_s r15,0xf
L_924a76:
	asl_s r15,r15,r2
L_924a78:
	tst_s r15,r14
L_924a7a:
	add r0,sp,r3
L_924a7e:
	stb r1,[r0, 0x34]
L_924a82:
	beq_s L_924a64
L_924a84:
	ld_s r15,[sp,0x18]
L_924a86:
	bset r15,r15,r3
L_924a8a:
	ld r3,[r18]
L_924a8e:
	extb_s r15,r15
L_924a90:
	st_s r15,[sp,0x18]
L_924a92:
	breq_s r3,0,L_924ac8
L_924a94:
	add_s r3,r2,0x4
L_924a96:
	brhs r2,r3,L_924a5c
L_924a9a:
	mov_s r15,r2
	.global L_924a9c
L_924a9c:
	bbit0 r14,r15,L_924aa8
L_924aa0:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_924aa2:
	extb_s r1,r1
L_924aa4:
	stb r1,[r0, 0x34]
	.global L_924aa8
L_924aa8:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_924aaa:
	add_s r3,r2,0x4
L_924aac:
	brlo r15,r3,L_924a9c
L_924ab0:
	b_s L_924a5c
	.global L_924ab2
L_924ab2:
	mov_s r0,blink
L_924ab4:
	mov_s r2,0x1000aac
L_924aba:
	mov_s r1,0x5
L_924abc:
	asl_s r1,r1,0xa
L_924abe:
	bl.d L_925548
L_924ac2:
	mov r3,0x120
L_924ac6:
	b_s L_924a34
	.global L_924ac8
L_924ac8:
	ld_s r0,[sp,0x10]
L_924aca:
	ld_s r0,[r0]
L_924acc:
	lsr_s r0,r0,0x18
L_924ace:
	bmsk_s r0,r0,0x2
L_924ad0:
	asl r0,r0,r4
L_924ad4:
	or_s r13,r13,r0
L_924ad6:
	b_s L_924a64
	.global L_924ad8
L_924ad8:
	ld_s r0,[sp,0x1c]
L_924ada:
	mov r23,0x0
L_924ade:
	stb r0,[gp, -0xf4]
L_924ae2:
	ld r0,[r18]
L_924ae6:
	mov r20,0x0
L_924aea:
	cmp_s r0,0x0
L_924aec:
	mov r22,0x0
L_924af0:
	mov r17,0x0
L_924af4:
	beq_s L_924c6a
L_924af6:
	mov r16,0x0
L_924afa:
	mov_s r0,0x0
L_924afc:
	b_s L_924b06
	.global L_924afe
L_924afe:
	ld_s r0,[sp,0x20]
L_924b00:
	add r16,r16,0x1
L_924b04:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
	.global L_924b06
L_924b06:
	brhs.d r16,0x8,L_924b98
L_924b0a:
	st_s r0,[sp,0x20]
L_924b0c:
	add r0,sp,r16
L_924b10:
	ldb r0,[r0, 0x34]
L_924b14:
	brlt.d r0,0x1,L_924b3a
L_924b18:
	st_s r0,[sp,0x24]
L_924b1a:
	brhs r16,0x4,L_924b28
L_924b1e:
	add r22,r22,0x1
L_924b22:
	extb r22,r22
L_924b26:
	b_s L_924b30
	.global L_924b28
L_924b28:
	add r20,r20,0x1
L_924b2c:
	extb r20,r20
	.global L_924b30
L_924b30:
	ldb r0,[r18, 0x7]
L_924b34:
	ld_s r1,[sp,0x20]
L_924b36:
	asl_s r0,r0,r1
L_924b38:
	or_s r13,r13,r0
	.global L_924b3a
L_924b3a:
	ld_s r0,[sp,0x1c]
L_924b3c:
	ld_s r1,[sp,0x24]
L_924b3e:
	mov_s r15,0x0
L_924b40:
	sub r19,r0,r1
L_924b44:
	extb r19,r19
	.global L_924b48
L_924b48:
	brlt r19,0x1,L_924afe
L_924b4c:
	ld_s r0,[sp,0x24]
L_924b4e:
	brlt r0,0x1,L_924afe
L_924b52:
	add2 r1,r15,r16
L_924b56:
	mov_s r0,0x0
L_924b58:
	bset r0,r0,r1
L_924b5c:
	and r1,r0,r14
L_924b60:
	sub.f r1,r1,0x0
L_924b64:
	mov.ne r1,0x1
L_924b68:
	extb.f 0x0,r1
L_924b6c:
	bne_s L_924b7a
L_924b6e:
	or r23,r23,r0
L_924b72:
	sub r19,r19,0x1
L_924b76:
	extb r19,r19
	.global L_924b7a
L_924b7a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_924b7c:
	brlo r15,0x5,L_924b48
L_924b80:
	mov_s r0,blink
L_924b82:
	mov_s r2,0x1000aac
L_924b88:
	mov_s r1,0x13fd
L_924b8e:
	bl.d L_925548
L_924b92:
	mov r3,0x15b
L_924b96:
	b_s L_924b48
	.global L_924b98
L_924b98:
	mov_s r0,0x801050
L_924b9e:
	st r23,[r0, 0x7c]
L_924ba2:
	ld_s r0,[sp,0xc]
L_924ba4:
	or r0,r0,r24
L_924ba8:
	or r0,r0,r21
L_924bac:
	tst r0,r23
L_924bb0:
	bne_s L_924bd4
	.global L_924bb2
L_924bb2:
	brge.d r20,r22,L_924c2a
L_924bb6:
	or r21,r21,r23
L_924bba:
	brlt r20,0x1,L_924c0c
L_924bbe:
	mov_s r15,0x0
L_924bc0:
	sub r16,r22,r20
L_924bc4:
	ld_s r0,[sp,0x18]
L_924bc6:
	extb r16,r16
L_924bca:
	bic r0,r0,-0xf1
L_924bce:
	asr r19,r0,0x4
L_924bd2:
	b_s L_924c08
	.global L_924bd4
L_924bd4:
	mov_s r0,blink
L_924bd6:
	mov_s r2,0x1000aac
L_924bdc:
	mov_s r1,0x13fc
L_924be2:
	bl.d L_925548
L_924be6:
	mov r3,0x15f
L_924bea:
	b_s L_924bb2
	.global L_924bec
L_924bec:
	bbit1 r19,r15,L_924c02
L_924bf0:
	add_s r1,r15,0x4
L_924bf2:
	bset r0,r17,r1
L_924bf6:
	extb r17,r0
L_924bfa:
	sub r16,r16,0x1
L_924bfe:
	extb r16,r16
	.global L_924c02
L_924c02:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_924c04:
	brhs r15,0x5,L_924c12
	.global L_924c08
L_924c08:
	brge r16,0x1,L_924bec
	.global L_924c0c
L_924c0c:
	mov r20,r22
L_924c10:
	b_s L_924c6a
	.global L_924c12
L_924c12:
	mov_s r0,blink
L_924c14:
	mov_s r2,0x1000aac
L_924c1a:
	mov_s r1,0x13fe
L_924c20:
	bl.d L_925548
L_924c24:
	mov r3,0x16f
L_924c28:
	b_s L_924c08
	.global L_924c2a
L_924c2a:
	brge r22,r20,L_924c6a
L_924c2e:
	brlt r22,0x1,L_924c6a
L_924c32:
	mov_s r15,0x0
L_924c34:
	sub r16,r20,r22
L_924c38:
	extb r16,r16
L_924c3c:
	ld_s r0,[sp,0x18]
L_924c3e:
	bmsk r19,r0,0x3
L_924c42:
	b_s L_924c66
	.global L_924c44
L_924c44:
	mov_s r0,0x0
L_924c46:
	bset r0,r0,r15
L_924c4a:
	tst r19,r0
L_924c4e:
	bne_s L_924c60
L_924c50:
	or r0,r0,r17
L_924c54:
	extb r17,r0
L_924c58:
	sub r16,r16,0x1
L_924c5c:
	extb r16,r16
	.global L_924c60
L_924c60:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_924c62:
	brhs r15,0x5,L_924cd2
	.global L_924c66
L_924c66:
	brge r16,0x1,L_924c44
	.global L_924c6a
L_924c6a:
	stb r20,[gp, -0xf5]
L_924c6e:
	mov_s r15,0x0
L_924c70:
	mov_s r16,r15
L_924c72:
	b_s L_924ca2
	.global L_924c74
L_924c74:
	bbit0 r17,r15,L_924c9c
L_924c78:
	mov_s r0,0x7
L_924c7a:
	asl r0,r0,r16
L_924c7e:
	tst_s r0,r13
L_924c80:
	beq_s L_924c98
L_924c82:
	mov_s r0,blink
L_924c84:
	mov_s r2,0x1000aac
L_924c8a:
	mov_s r1,0x13fb
L_924c90:
	bl.d L_925548
L_924c94:
	mov r3,0x18a
	.global L_924c98
L_924c98:
	bset r13,r13,r16
	.global L_924c9c
L_924c9c:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_924c9e:
	add r16,r16,0x3
	.global L_924ca2
L_924ca2:
	brlo r15,0x8,L_924c74
L_924ca6:
	extw_s r1,r14
L_924ca8:
	cmp_s r1,0x0
L_924caa:
	bset r0,r13,0x1c
L_924cae:
	mov.eq r0,r13
L_924cb2:
	and r2,r14,0xffff0000
L_924cba:
	cmp_s r2,0x0
L_924cbc:
	bset r1,r0,0x1d
L_924cc0:
	mov.ne r13,r1
L_924cc4:
	mov.eq r13,r0
L_924cc8:
	ld r0,[r18]
L_924ccc:
	breq_s r0,0,L_924cea
L_924cce:
	ld_s r14,[sp,0xc]
L_924cd0:
	b_s L_924d0e
	.global L_924cd2
L_924cd2:
	mov_s r0,blink
L_924cd4:
	mov_s r2,0x1000aac
L_924cda:
	mov_s r1,0x13ff
L_924ce0:
	bl.d L_925548
L_924ce4:
	mov r3,0x17e
L_924ce8:
	b_s L_924c66
	.global L_924cea
L_924cea:
	ld_s r0,[sp,0x10]
L_924cec:
	ld_s r0,[r0]
L_924cee:
	lsr r1,r0,0x15
L_924cf2:
	bmsk_s r1,r1,0x2
L_924cf4:
	btst_s r0,0x15
L_924cf6:
	mov.ne r21,r14
L_924cfa:
	mov.eq r21,0x0
L_924cfe:
	btst_s r1,0x1
L_924d00:
	mov.ne r24,r14
L_924d04:
	mov.eq r24,0x0
L_924d08:
	btst_s r1,0x2
L_924d0a:
	mov.eq r14,0x0
	.global L_924d0e
L_924d0e:
	ld_s r0,[sp,0x8]
L_924d10:
	add_s r0,r0,0x10060
L_924d16:
	lsr_s r0,r0,0x3
L_924d18:
	bic r0,r0,0x3
L_924d1c:
	bl.d L_92bcac
L_924d20:
	mov_s r1,r21
L_924d22:
	ld_s r1,[sp,0x14]
L_924d24:
	ld_s r0,[sp,0x8]
L_924d26:
	st r21,[r1, 0x8]
L_924d2a:
	add_s r0,r0,0x10040
L_924d30:
	lsr_s r0,r0,0x3
L_924d32:
	bic r0,r0,0x3
L_924d36:
	bl.d L_92bcac
L_924d3a:
	mov_s r1,r24
L_924d3c:
	ld_s r1,[sp,0x14]
L_924d3e:
	ld_s r0,[sp,0x8]
L_924d40:
	st r24,[r1, 0xc]
L_924d44:
	add_s r0,r0,0x100a0
L_924d4a:
	lsr_s r0,r0,0x3
L_924d4c:
	bic r0,r0,0x3
L_924d50:
	bl.d L_92bcac
L_924d54:
	mov_s r1,r14
L_924d56:
	ld_s r0,[sp,0x14]
L_924d58:
	st_s r14,[r0,0x10]
L_924d5a:
	bl.d L_921bb0
L_924d5e:
	ld_s r0,[sp,0x0]
L_924d60:
	ld_s r0,[sp,0x8]
L_924d62:
	add_s r0,r0,0x10080
L_924d68:
	lsr_s r0,r0,0x3
L_924d6a:
	bic r0,r0,0x3
L_924d6e:
	bl.d L_92bcac
L_924d72:
	mov_s r1,r13
L_924d74:
	ld_s r0,[sp,0x14]
L_924d76:
	st_s r13,[r0,0x14]
L_924d78:
	bl.d L_921b58
L_924d7c:
	ld_s r0,[sp,0x0]
L_924d7e:
	ld_s r0,[gp,-0x44]
L_924d80:
	and r0,r0,0xfff0ffff
L_924d88:
	bset r1,r0,0x10
L_924d8c:
	bset_s r1,r1,0x11
L_924d8e:
	or r0,r0,0x1d030000
L_924d96:
	st.as r1,[gp,-0x11]
L_924d9a:
	mov_s r32,r0
L_924d9c:
	st.ab r0,[r25,0x4]
L_924da0:
	bclr r25,r25,0xa
L_924da4:
	nop_s
L_924da6:
	nop_s
L_924da8:
	nop_s
	.global L_924daa
L_924daa:
	mov_s r0,r47
L_924dac:
	bbit1 r0,0x11,L_924daa
L_924db0:
	b.d L_920234
L_924db4:
	add_s sp,sp,0x3c
L_924db6:
	nop_s
