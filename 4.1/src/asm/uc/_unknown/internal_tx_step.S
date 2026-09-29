/* internal_tx_step @ 0x9339f0, 828 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__pending_sm
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf__trigger_if_pending, direct_tx__program_cmd34, internal_tx__await_rx_frame_a, internal_tx__await_rx_frame_b, internal_tx__clear_pending, internal_tx__peer_pending, mac__build_tx_common_params, mac__cmd_29000001, mac__program_tx_with_rate, mac__select_all_sectors_and_wait
 * Глобалы (через gp): 0x800574, 0x8005e0, 0x800610, 0x800614
 */
	.section .text.internal_tx_step,"ax",@progbits
	.global internal_tx_step
internal_tx_step:
	.global L_9339f0
L_9339f0:
	push_s blink
L_9339f2:
	bl L_920210
L_9339f6:
	sub_s sp,sp,0x8
L_9339f8:
	bl.d L_926354
L_9339fc:
	mov_s r0,sp
L_9339fe:
	cmp_s r0,0x0
L_933a00:
	mov_s r0,0x8
L_933a02:
	beq_s L_933a14
L_933a04:
	ld_s r0,[sp,0x0]
L_933a06:
	mov_s r13,0x8011a4
L_933a0c:
	asl_s r1,r0,0x3
L_933a0e:
	add3_s r1,r1,r1
L_933a10:
	ld_s r1,[r13,r1]
L_933a12:
	brne_s r1,0,L_933a1c
	.global L_933a14
L_933a14:
	bl L_933d78
L_933a18:
	b L_933d26
	.global L_933a1c
L_933a1c:
	bl.d L_933414
L_933a20:
	mov_s r0,0x1
L_933a22:
	ld_s r1,[sp,0x0]
L_933a24:
	mov_s r14,r0
L_933a26:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_933a28:
	add2_s r1,r1,r1
L_933a2a:
	add_s r1,r1,0x857838
L_933a30:
	ldw_s r0,[r1]
L_933a32:
	mov_s r15,0x0
L_933a34:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933a36:
	stw_s r0,[r1]
L_933a38:
	mov_s r1,0x857000
L_933a3e:
	ld_s r0,[r1]
L_933a40:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933a42:
	st_s r0,[r1]
L_933a44:
	ld_s r0,[gp,0x4c]
L_933a46:
	st.as r0,[r1,0x77]
L_933a4a:
	st_s r15,[r14,0x8]
L_933a4c:
	ld_s r0,[sp,0x0]
L_933a4e:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_933a50:
	add3_s r0,r0,r0
L_933a52:
	ld_s r0,[r13,r0]
L_933a54:
	norm r0,r0
L_933a58:
	rsub r1,r0,0x1e
L_933a5c:
	st_s r1,[r14,0x4]
L_933a5e:
	mov_s r0,0x801ed0
L_933a64:
	bl.d L_928fd0
L_933a68:
	ldb_s r1,[sp,0x0]
L_933a6a:
	mov_s r13,r0
L_933a6c:
	bl.d L_926560
L_933a70:
	mov_s r0,0x12
L_933a72:
	mov_s r0,0x15000028
L_933a78:
	mov_s r32,r0
L_933a7a:
	st.ab r0,[r25,0x4]
L_933a7e:
	bclr r25,r25,0xa
L_933a82:
	mov_s r0,0x14000007
L_933a88:
	mov_s r32,r0
L_933a8a:
	st.ab r0,[r25,0x4]
L_933a8e:
	bclr r25,r25,0xa
L_933a92:
	mov_s r0,0x10
L_933a94:
	bl.d L_924ea8
L_933a98:
	mov_s r1,r0
L_933a9a:
	bl.d L_92a318
L_933a9e:
	mov_s r0,0x0
	.global L_933aa0
L_933aa0:
	mov_s r0,r43
L_933aa2:
	bbit0 r0,0x1f,L_933aa0
L_933aa6:
	mov_s r0,r51
L_933aa8:
	bmsk r1,r0,0x3
L_933aac:
	st.as r1,[gp,0x3a]
L_933ab0:
	lsr_s r0,r0,0x4
L_933ab2:
	st.as r0,[gp,0x3b]
	.global L_933ab6
L_933ab6:
	mov_s r0,r45
L_933ab8:
	bbit0 r0,0x1f,L_933ab6
L_933abc:
	ld_s r0,[sp,0x0]
L_933abe:
	mov_s r1,0xb
L_933ac0:
	bl.d L_9332d4
L_933ac4:
	mov_s r2,0x0
L_933ac6:
	ld_s r0,[gp,-0x44]
L_933ac8:
	and r0,r0,0xffff0fff
L_933ad0:
	bset r1,r0,0xd
L_933ad4:
	bset_s r1,r1,0xf
L_933ad6:
	or r0,r0,0x1d00a000
L_933ade:
	st.as r1,[gp,-0x11]
L_933ae2:
	mov_s r32,r0
L_933ae4:
	st.ab r0,[r25,0x4]
L_933ae8:
	bclr r25,r25,0xa
L_933aec:
	bl L_931980
L_933af0:
	bl L_931640
L_933af4:
	mov_s r1,r40
L_933af6:
	mov_s r0,r42
L_933af8:
	bbit1 r0,0xe,L_933b00
L_933afc:
	bbit1 r1,0x18,L_933b2c
	.global L_933b00
L_933b00:
	mov_s r0,r45
L_933b02:
	bbit0 r0,0x1f,L_933b00
L_933b06:
	mov_s r0,0x29000002
L_933b0c:
	mov_s r32,r0
L_933b0e:
	st.ab r0,[r25,0x4]
L_933b12:
	bclr r25,r25,0xa
L_933b16:
	ld_s r0,[sp,0x0]
L_933b18:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_933b1a:
	add2_s r0,r0,r0
L_933b1c:
	add_s r0,r0,0x857838
L_933b22:
	ldb_s r1,[r0,0x9]
L_933b24:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_933b26:
	b.d L_933d26
L_933b2a:
	stb_s r1,[r0,0x9]
	.global L_933b2c
L_933b2c:
	ld_s r0,[sp,0x0]
L_933b2e:
	mov_s r1,0x801198
L_933b34:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_933b36:
	add3_s r0,r0,r0
L_933b38:
	ld_s r1,[r1,r0]
L_933b3a:
	mov_s r0,0x5
L_933b3c:
	mov_s r2,0x0
L_933b3e:
	bl.d L_92bb2c
L_933b42:
	mov_s r3,r2
L_933b44:
	mov_s r0,0x19000001
L_933b4a:
	mov_s r32,r0
L_933b4c:
	st.ab r0,[r25,0x4]
L_933b50:
	bclr r25,r25,0xa
L_933b54:
	mov_s r0,0x18
L_933b56:
	asl_s r0,r0,0x18
L_933b58:
	mov_s r32,r0
L_933b5a:
	st.ab r0,[r25,0x4]
L_933b5e:
	bclr r25,r25,0xa
L_933b62:
	bl.d L_931664
L_933b66:
	mov_s r0,0x6
L_933b68:
	ld_s r1,[sp,0x0]
L_933b6a:
	mov_s r0,0x801194
L_933b70:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_933b72:
	add3_s r1,r1,r1
L_933b74:
	ld_s r1,[r0,r1]
L_933b76:
	add_s r15,r0,0x4
L_933b78:
	bl.d L_92b934
L_933b7c:
	mov_s r0,0x1
L_933b7e:
	bl.d L_931338
L_933b82:
	mov_s r0,0x5
L_933b84:
	bl L_937780
L_933b88:
	cmp_s r0,0x0
L_933b8a:
	ld_s r1,[sp,0x0]
L_933b8c:
	beq_s L_933c9a
L_933b8e:
	asl_s r0,r1,0x3
L_933b90:
	add3_s r0,r0,r0
L_933b92:
	ld_s r1,[r15,r0]
L_933b94:
	mov_s r0,0x1
L_933b96:
	mov_s r2,r0
L_933b98:
	bl.d L_92bb2c
L_933b9c:
	mov_s r3,0x0
L_933b9e:
	mov_s r0,r14
L_933ba0:
	mov_s r1,0x1
L_933ba2:
	bl.d L_933e3c
L_933ba6:
	mov_s r2,0x0
L_933ba8:
	mov_s r0,0x20000400
L_933bae:
	mov_s r32,r0
L_933bb0:
	st.ab r0,[r25,0x4]
L_933bb4:
	bclr r25,r25,0xa
L_933bb8:
	bl.d L_926560
L_933bbc:
	mov_s r0,0xc
L_933bbe:
	mov_s r0,0x2008000
L_933bc4:
	mov_s r32,r0
L_933bc6:
	st.ab r0,[r25,0x4]
L_933bca:
	bclr r25,r25,0xa
L_933bce:
	mov_s r0,0x19000001
L_933bd4:
	mov_s r32,r0
L_933bd6:
	st.ab r0,[r25,0x4]
L_933bda:
	bclr r25,r25,0xa
	.global L_933bde
L_933bde:
	mov_s r0,r45
L_933be0:
	bbit0 r0,0x1f,L_933bde
L_933be4:
	cmp_s r13,0x0
L_933be6:
	mov.ne r0,0x18000020
L_933bee:
	mov.eq r0,0x18
L_933bf2:
	asl.eq r0,r0,0x18
L_933bf6:
	mov_s r32,r0
L_933bf8:
	st.ab r0,[r25,0x4]
L_933bfc:
	bclr r25,r25,0xa
L_933c00:
	bl.d L_931664
L_933c04:
	mov_s r0,0x6
L_933c06:
	ld_s r0,[sp,0x0]
L_933c08:
	mov_s r1,0x801194
L_933c0e:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_933c10:
	add3_s r0,r0,r0
L_933c12:
	ld_s r1,[r1,r0]
L_933c14:
	bl.d L_92b934
L_933c18:
	mov_s r0,0x1
L_933c1a:
	ld_s r0,[sp,0x0]
L_933c1c:
	mov_s r15,0x857838
L_933c22:
	stb r0,[gp, -0xea]
L_933c26:
	bl.d L_931338
L_933c2a:
	mov_s r0,0x5
L_933c2c:
	bl L_9375b0
L_933c30:
	ld_s r2,[sp,0x0]
L_933c32:
	mov_s r14,0x80092c
L_933c38:
	extb_s r1,r2
L_933c3a:
	breq_s r0,0,L_933c84
L_933c3c:
	mov_s r0,0x0
L_933c3e:
	bl.d L_924db8
L_933c42:
	mov_s r2,0x1f
L_933c44:
	bl.d L_933d78
L_933c48:
	ld_s r0,[sp,0x0]
L_933c4a:
	mov_s r0,0x857180
L_933c50:
	ld_s r1,[sp,0x0]
L_933c52:
	add2_s r0,r0,r1
L_933c54:
	ld_s r2,[r0,0x1c]
L_933c56:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_933c58:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_933c5a:
	st_s r2,[r0,0x1c]
L_933c5c:
	ldb_s r0,[r14,0x14]
L_933c5e:
	add2_s r1,r1,r1
L_933c60:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933c62:
	extb_s r0,r0
L_933c64:
	stb_s r0,[r14,0x14]
L_933c66:
	add_s r15,r15,r1
L_933c68:
	ldw_s r0,[r15,0x2]
L_933c6a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933c6c:
	stw_s r0,[r15,0x2]
L_933c6e:
	bl.d L_931ef8
L_933c72:
	mov_s r0,0x0
L_933c74:
	breq_s r13,0,L_933cc2
L_933c76:
	mov_s r0,0x801ed0
L_933c7c:
	bl.d L_925208
L_933c80:
	ldb_s r1,[sp,0x0]
L_933c82:
	b_s L_933cc2
	.global L_933c84
L_933c84:
	ldb_s r0,[r14,0x15]
L_933c86:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_933c88:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933c8a:
	extb_s r0,r0
L_933c8c:
	add2_s r2,r2,r2
L_933c8e:
	stb_s r0,[r14,0x15]
L_933c90:
	add_s r15,r15,r2
L_933c92:
	ldb_s r0,[r15,0x8]
L_933c94:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933c96:
	stb_s r0,[r15,0x8]
L_933c98:
	b_s L_933cba
	.global L_933c9a
L_933c9a:
	asl_s r0,r1,0x2
L_933c9c:
	add2_s r0,r0,r0
L_933c9e:
	add_s r0,r0,0x857838
L_933ca4:
	ldb_s r2,[r0,0x7]
L_933ca6:
	extb_s r1,r1
L_933ca8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_933caa:
	stb_s r2,[r0,0x7]
L_933cac:
	mov_s r2,0x80092c
L_933cb2:
	ldb_s r0,[r2,0x15]
L_933cb4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933cb6:
	extb_s r0,r0
L_933cb8:
	stb_s r0,[r2,0x15]
	.global L_933cba
L_933cba:
	mov_s r0,0x1
L_933cbc:
	bl.d L_924db8
L_933cc0:
	mov_s r2,0x1f
	.global L_933cc2
L_933cc2:
	mov_s r0,0x0
L_933cc4:
	bset_s r0,r0,0x1d
L_933cc6:
	mov_s r32,r0
L_933cc8:
	st.ab r0,[r25,0x4]
L_933ccc:
	bclr r25,r25,0xa
L_933cd0:
	mov_s r0,0x8009c0
L_933cd6:
	ld_s r1,[r0,0x8]
L_933cd8:
	mov_s r0,0x8010e8
L_933cde:
	bbit0 r1,0x9,L_933ce6
L_933ce2:
	ldb_s r3,[r0,0x16]
L_933ce4:
	b_s L_933ce8
	.global L_933ce6
L_933ce6:
	ldb_s r3,[r0,0x14]
	.global L_933ce8
L_933ce8:
	ld_s r2,[sp,0x0]
L_933cea:
	asl_s r1,r2,0x2
L_933cec:
	add2_s r1,r1,r1
L_933cee:
	add_s r1,r1,0x857838
L_933cf4:
	ldb_s r0,[r1,0x7]
L_933cf6:
	brlt r0,r3,L_933d1e
L_933cfa:
	ld_s r0,[gp,0xb8]
L_933cfc:
	bbit0 r0,0x4,L_933d0c
L_933d00:
	ldb_s r0,[r1,0x11]
L_933d02:
	bset_s r0,r0,0x5
L_933d04:
	stb_s r0,[r1,0x11]
L_933d06:
	mov_s r0,0x0
L_933d08:
	stb_s r0,[r1,0x7]
L_933d0a:
	stb_s r0,[r1,0x9]
	.global L_933d0c
L_933d0c:
	mov_s r3,0x857000
L_933d12:
	ld_s r0,[r3,0x10]
L_933d14:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933d16:
	st_s r0,[r3,0x10]
L_933d18:
	ldb_s r0,[r1,0x6]
L_933d1a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933d1c:
	stb_s r0,[r1,0x6]
	.global L_933d1e
L_933d1e:
	mov_s r0,r2
L_933d20:
	bl.d L_926840
L_933d24:
	mov_s r1,0x0
	.global L_933d26
L_933d26:
	b.d L_92027c
L_933d2a:
	add_s sp,sp,0x8
