/* tx__send_and_await_rx_frame @ 0x9249b4, 708 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mtp__get_tx_permission, tx__cca_check_and_send
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, cf_end__send_frame, gp0__arm_usec_b, mac__program_rx_window, mac__set_rf_chain_state, rx_mode__configure, tx__await_rx_or_timeout, tx__submit_frame, uc_sleep_until_event, uc_spin_until_event, uc_sysassert
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__send_and_await_rx_frame
tx__send_and_await_rx_frame:
	.global L_9249b4
L_9249b4:
	push_s blink
L_9249b6:
	bl L_920224
L_9249ba:
	sub_s sp,sp,0xc
L_9249bc:
	mov_s r13,r0
L_9249be:
	mov.f r15,r1
L_9249c2:
	mov_s r17,r2
L_9249c4:
	mov_s r1,0x0
L_9249c6:
	mov_s r0,0x80242c
L_9249cc:
	stw_s r1,[r0,0x8]
L_9249ce:
	beq_s L_924a4e
L_9249d0:
	mov_s r0,0x0
L_9249d2:
	bset_s r0,r0,0x1d
L_9249d4:
	mov_s r32,r0
L_9249d6:
	st.ab r0,[r25,0x4]
L_9249da:
	bclr r25,r25,0xa
L_9249de:
	mov_s r0,0x802f80
L_9249e4:
	ldb r0,[r0,0x179]
L_9249ec:
	mov_s r1,0x0
L_9249ee:
	cmp_s r0,0x1
L_9249f0:
	mov_s r0,r13
L_9249f2:
	mov_s r2,0x1
L_9249f4:
	mov r3,0x400
L_9249f8:
	mov.ne r3,r1
L_9249fc:
	bl L_9396a0
L_924a00:
	mov_s r1,0x80242c
L_924a06:
	ldw_s r0,[r1,0x2]
L_924a08:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924a0a:
	stw_s r0,[r1,0x2]
L_924a0c:
	ld_s r0,[gp,-0x48]
L_924a0e:
	or r0,r0,0x27004000
L_924a16:
	mov_s r32,r0
L_924a18:
	st.ab r0,[r25,0x4]
L_924a1c:
	bclr r25,r25,0xa
L_924a20:
	mov_s r0,0x2004000
L_924a26:
	mov_s r32,r0
L_924a28:
	st.ab r0,[r25,0x4]
L_924a2c:
	bclr r25,r25,0xa
L_924a30:
	nop_s
L_924a32:
	nop_s
L_924a34:
	nop_s
L_924a36:
	mov_s r0,0x0
L_924a38:
	bset_s r0,r0,0xe
L_924a3a:
	bl.d L_93676c
L_924a3e:
	mov_s r1,0xa
L_924a40:
	mov_s r0,r42
L_924a42:
	bbit0 r0,0xe,L_924a6e
	.global L_924a46
L_924a46:
	mov_s r0,0x0
L_924a48:
	bl.d L_9366dc
L_924a4c:
	bset_s r0,r0,0xf
	.global L_924a4e
L_924a4e:
	ld_s r0,[r13]
L_924a50:
	mov_s r1,0x801106
L_924a56:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_924a58:
	add2_s r0,r0,r0
L_924a5a:
	ldw_s r0,[r1,r0]
L_924a5c:
	lsr_s r0,r0
L_924a5e:
	bxor r0,r0,0x0
L_924a62:
	bmsk r1,r0,0x0
L_924a66:
	bbit1 r0,0x0,L_924a78
L_924a6a:
	mov_s r0,0x22
L_924a6c:
	b_s L_924a7a
	.global L_924a6e
L_924a6e:
	mov_s r0,blink
L_924a70:
	bl.d L_926618
L_924a74:
	mov_s r1,0x92
L_924a76:
	b_s L_924a46
	.global L_924a78
L_924a78:
	mov_s r0,0x17
	.global L_924a7a
L_924a7a:
	add r16,r0,0x4
L_924a7e:
	ld_s r0,[gp,-0x34]
L_924a80:
	mov_s r14,0x1
L_924a82:
	cmp_s r0,0x0
L_924a84:
	mov.eq r14,r1
L_924a88:
	brne r17,0x0,L_924ac8
L_924a8c:
	ld_s r0,[gp,-0x44]
L_924a8e:
	and r0,r0,0xffff0fff
L_924a96:
	bset r1,r0,0xc
L_924a9a:
	bset_s r1,r1,0xd
L_924a9c:
	or r0,r0,0x1d003000
L_924aa4:
	st.as r1,[gp,-0x11]
L_924aa8:
	mov_s r32,r0
L_924aaa:
	st.ab r0,[r25,0x4]
L_924aae:
	bclr r25,r25,0xa
L_924ab2:
	nop_s
L_924ab4:
	nop_s
L_924ab6:
	nop_s
L_924ab8:
	extw r0,r40
L_924abc:
	cmp_s r0,r16
L_924abe:
	bls L_924ba4
L_924ac2:
	mov_s r0,r42
L_924ac4:
	btst_s r0,0x7
L_924ac6:
	bne_s L_924ba4
	.global L_924ac8
L_924ac8:
	mov_s r1,0x1
L_924aca:
	mov_s r0,0x80242c
L_924ad0:
	mov_s r16,r0
L_924ad2:
	stw_s r1,[r0,0x8]
L_924ad4:
	cmp_s r14,0x0
L_924ad6:
	mov_s r1,0x22
L_924ad8:
	mov.ne r1,0x17
L_924adc:
	ld_s r0,[gp,-0x34]
L_924ade:
	mov r18,0x1
L_924ae2:
	cmp_s r0,0x0
L_924ae4:
	mov.eq r18,0x12
L_924ae8:
	sub.ne r17,r17,r17
L_924aec:
	mov.eq r17,r1
L_924af0:
	breq_s r15,0,L_924b10
L_924af2:
	bl.d L_936588
L_924af6:
	mov_s r0,0x6
L_924af8:
	ld_s r0,[r13]
L_924afa:
	mov_s r1,0x80110c
L_924b00:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_924b02:
	add2_s r0,r0,r0
L_924b04:
	ld_s r1,[r1,r0]
L_924b06:
	mov_s r0,0x1
L_924b08:
	mov_s r2,r14
L_924b0a:
	bl.d L_92f798
L_924b0e:
	mov_s r3,0x0
	.global L_924b10
L_924b10:
	ldw r0,[r16, 0x4]
L_924b14:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924b16:
	stw r0,[r16, 0x4]
L_924b1a:
	mov_s r0,0x2008000
L_924b20:
	mov_s r32,r0
L_924b22:
	st.ab r0,[r25,0x4]
L_924b26:
	bclr r25,r25,0xa
L_924b2a:
	bset r0,r17,0x18
L_924b2e:
	bset_s r0,r0,0x1a
L_924b30:
	bset_s r0,r0,0x1c
L_924b32:
	mov_s r32,r0
L_924b34:
	st.ab r0,[r25,0x4]
L_924b38:
	bclr r25,r25,0xa
L_924b3c:
	mov_s r0,0x14000007
L_924b42:
	mov_s r32,r0
L_924b44:
	st.ab r0,[r25,0x4]
L_924b48:
	bclr r25,r25,0xa
L_924b4c:
	mov_s r0,r13
L_924b4e:
	mov_s r1,r14
L_924b50:
	mov_s r2,0xe
L_924b52:
	mov_s r3,0x1
L_924b54:
	bl.d L_938568
L_924b58:
	mov r4,sp
L_924b5c:
	ld_s r0,[gp,-0x48]
L_924b5e:
	or r0,r0,0x27004000
L_924b66:
	mov_s r32,r0
L_924b68:
	st.ab r0,[r25,0x4]
L_924b6c:
	bclr r25,r25,0xa
L_924b70:
	mov_s r0,0x2004000
L_924b76:
	mov_s r32,r0
L_924b78:
	st.ab r0,[r25,0x4]
L_924b7c:
	bclr r25,r25,0xa
L_924b80:
	nop_s
L_924b82:
	nop_s
L_924b84:
	nop_s
L_924b86:
	mov_s r0,0x0
L_924b88:
	bset_s r0,r0,0xe
L_924b8a:
	bl.d L_93676c
L_924b8e:
	mov_s r1,0xa
L_924b90:
	bl.d L_928384
L_924b94:
	mov_s r0,r18
L_924b96:
	mov_s r0,r42
L_924b98:
	bbit0 r0,0xe,L_924c56
	.global L_924b9c
L_924b9c:
	mov_s r0,0x0
L_924b9e:
	bl.d L_9366dc
L_924ba2:
	bset_s r0,r0,0xf
	.global L_924ba4
L_924ba4:
	brne_s r15,0,L_924bb0
L_924ba6:
	mov_s r0,0x80242c
L_924bac:
	ldw_s r0,[r0,0x8]
L_924bae:
	breq_s r0,0,L_924be8
	.global L_924bb0
L_924bb0:
	ld_s r0,[r13]
L_924bb2:
	mov_s r1,0x801108
L_924bb8:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_924bba:
	add2_s r0,r0,r0
L_924bbc:
	ld_s r1,[r1,r0]
L_924bbe:
	bl.d L_92f42c
L_924bc2:
	mov_s r0,0x1
L_924bc4:
	bl.d L_936588
L_924bc8:
	mov_s r0,0x6
L_924bca:
	ld_s r0,[gp,0x178]
L_924bcc:
	mov_s r1,0x802944
L_924bd2:
	bclr_s r0,r0,0x18
L_924bd4:
	ld_s r1,[r1]
L_924bd6:
	bclr_s r0,r0,0x19
L_924bd8:
	asl_s r1,r1,0x18
L_924bda:
	or_s r0,r0,r1
L_924bdc:
	st.as r0,[gp,0x5e]
L_924be0:
	mov_s r1,0x889480
L_924be6:
	st_s r0,[r1,0x8]
	.global L_924be8
L_924be8:
	mov_s r0,0x14
L_924bea:
	asl_s r0,r0,0x18
L_924bec:
	mov_s r32,r0
L_924bee:
	st.ab r0,[r25,0x4]
L_924bf2:
	bclr r25,r25,0xa
L_924bf6:
	ld_s r0,[r13]
L_924bf8:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_924bfa:
	add1_s r0,r0,r0
L_924bfc:
	add_s r0,r0,0x802610
L_924c02:
	ld_s r1,[r0]
L_924c04:
	brne r1,0x2,L_924c0c
L_924c08:
	mov_s r1,0x1
L_924c0a:
	st_s r1,[r0]
	.global L_924c0c
L_924c0c:
	mov_s r1,0x8010b0
L_924c12:
	ldw_s r0,[r1,0x3a]
L_924c14:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924c16:
	extw_s r0,r0
L_924c18:
	stw_s r0,[r1,0x3a]
L_924c1a:
	mov_s r0,0x80242c
L_924c20:
	ldw_s r0,[r0,0x8]
L_924c22:
	breq_s r0,0,L_924c70
L_924c24:
	bl L_924c78
L_924c28:
	mov_s r13,r0
L_924c2a:
	mov_s r0,0x2
L_924c2c:
	bl.d L_92f4bc
L_924c30:
	mov_s r1,0xff
L_924c32:
	breq_s r13,0,L_924c60
L_924c34:
	bl.d L_9366dc
L_924c38:
	mov_s r0,0x80
L_924c3a:
	ld_s r0,[gp,-0x3c]
L_924c3c:
	breq_s r0,0,L_924c70
L_924c3e:
	mov_s r0,0x1f000601
L_924c44:
	mov_s r32,r0
L_924c46:
	st.ab r0,[r25,0x4]
L_924c4a:
	bclr r25,r25,0xa
L_924c4e:
	mov_s r0,0x1
L_924c50:
	st.as r0,[gp,-0xe]
L_924c54:
	b_s L_924c70
	.global L_924c56
L_924c56:
	mov_s r0,blink
L_924c58:
	bl.d L_926618
L_924c5c:
	mov_s r1,0xaa
L_924c5e:
	b_s L_924b9c
	.global L_924c60
L_924c60:
	mov_s r0,0x14000100
L_924c66:
	mov_s r32,r0
L_924c68:
	st.ab r0,[r25,0x4]
L_924c6c:
	bclr r25,r25,0xa
	.global L_924c70
L_924c70:
	mov_s r0,0x1
L_924c72:
	b.d L_920284
L_924c76:
	add_s sp,sp,0xc
