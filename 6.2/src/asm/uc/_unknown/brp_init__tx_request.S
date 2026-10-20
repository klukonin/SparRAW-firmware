/* brp_init__tx_request @ 0x9229c0, 876 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__exchange_request, brp_initiator_brp_transaction_flow
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, bits__set_u8_s0_w5_uc, brp__set_phy_884060, brp__set_tx_sector_id, direct_tx__program_cmd34, mac__program_tx_common, mac__rf_switch_cmd1f, mac__set_mode_a000, mac__set_rf_chain_state, mac_evt__enable_bit_sync_b, mac_mode__send_direct_frame
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_init__tx_request
brp_init__tx_request:
	.global L_9229c0
L_9229c0:
	push_s blink
L_9229c2:
	bl.d L_920218
L_9229c6:
	mov_s r1,0x0
L_9229c8:
	sub_s sp,sp,0xc
L_9229ca:
	mov_s r13,0x800824
L_9229d0:
	ldb r16,[r13, 0x48]
L_9229d4:
	mov_s r0,0x8006b4
L_9229da:
	bl.d L_928b8c
L_9229de:
	ldb_s r0,[r0,0x2]
L_9229e0:
	bl L_92a754
L_9229e4:
	ld_s r1,[r13,0x50]
L_9229e6:
	mov_s r15,0x38000300
L_9229ec:
	mov r17,0x3f000000
L_9229f4:
	mov_s r13,0x3e
L_9229f6:
	asl_s r13,r13,0x18
L_9229f8:
	mov_s r14,0x37000020
L_9229fe:
	mov r18,0x8022c8
L_922a06:
	mov r21,0xfcffffff
L_922a0e:
	mov r19,0x802940
L_922a16:
	asl r0,r16,0x4
L_922a1a:
	add2_s r0,r0,r0
L_922a1c:
	add_s r0,r0,0x801104
L_922a22:
	mov r20,0x889480
L_922a2a:
	st_s r0,[sp,0x0]
L_922a2c:
	bbit0 r1,0x10,L_922aa8
L_922a30:
	mov_s r0,0x2
L_922a32:
	bset_s r0,r0,0x19
L_922a34:
	mov_s r32,r0
L_922a36:
	st.ab r0,[r25,0x4]
L_922a3a:
	bclr r25,r25,0xa
L_922a3e:
	bl.d L_9366dc
L_922a42:
	mov_s r0,0x2
L_922a44:
	mov_s r0,0x14000100
L_922a4a:
	mov_s r32,r0
L_922a4c:
	st.ab r0,[r25,0x4]
L_922a50:
	bclr r25,r25,0xa
L_922a54:
	ld_s r0,[sp,0x0]
L_922a56:
	ld_s r0,[r0,0x8]
L_922a58:
	st_s r0,[sp,0x4]
L_922a5a:
	mov_s r32,r15
L_922a5c:
	st.ab r15,[r25,0x4]
L_922a60:
	bclr r25,r25,0xa
L_922a64:
	mov_s r0,0x3600003f
L_922a6a:
	mov_s r32,r0
L_922a6c:
	st.ab r0,[r25,0x4]
L_922a70:
	bclr r25,r25,0xa
L_922a74:
	mov_s r0,0x6000105
L_922a7a:
	mov_s r32,r0
L_922a7c:
	st.ab r0,[r25,0x4]
L_922a80:
	bclr r25,r25,0xa
L_922a84:
	mov_s r0,0x37000005
L_922a8a:
	mov_s r32,r0
L_922a8c:
	st.ab r0,[r25,0x4]
L_922a90:
	bclr r25,r25,0xa
L_922a94:
	mov_s r0,0x37000002
L_922a9a:
	mov_s r32,r0
L_922a9c:
	st.ab r0,[r25,0x4]
L_922aa0:
	bclr r25,r25,0xa
L_922aa4:
	ld_s r0,[sp,0x4]
L_922aa6:
	b_s L_922b10
	.global L_922aa8
L_922aa8:
	bl.d L_92c5e4
L_922aac:
	mov_s r0,0x0
L_922aae:
	mov_s r0,0x1f006000
L_922ab4:
	mov_s r32,r0
L_922ab6:
	st.ab r0,[r25,0x4]
L_922aba:
	bclr r25,r25,0xa
L_922abe:
	ld_s r0,[sp,0x0]
L_922ac0:
	ld_s r0,[r0,0x8]
L_922ac2:
	st_s r0,[sp,0x8]
L_922ac4:
	mov_s r32,r15
L_922ac6:
	st.ab r15,[r25,0x4]
L_922aca:
	bclr r25,r25,0xa
L_922ace:
	mov_s r0,0x3600003f
L_922ad4:
	mov_s r32,r0
L_922ad6:
	st.ab r0,[r25,0x4]
L_922ada:
	bclr r25,r25,0xa
L_922ade:
	mov_s r0,0x6000101
L_922ae4:
	mov_s r32,r0
L_922ae6:
	st.ab r0,[r25,0x4]
L_922aea:
	bclr r25,r25,0xa
L_922aee:
	mov_s r0,0x37000005
L_922af4:
	mov_s r32,r0
L_922af6:
	st.ab r0,[r25,0x4]
L_922afa:
	bclr r25,r25,0xa
L_922afe:
	mov_s r0,0x37000002
L_922b04:
	mov_s r32,r0
L_922b06:
	st.ab r0,[r25,0x4]
L_922b0a:
	bclr r25,r25,0xa
L_922b0e:
	ld_s r0,[sp,0x8]
	.global L_922b10
L_922b10:
	or r0,r0,r17
L_922b14:
	mov_s r32,r0
L_922b16:
	st.ab r0,[r25,0x4]
L_922b1a:
	bclr r25,r25,0xa
L_922b1e:
	mov_s r32,r13
L_922b20:
	st.ab r13,[r25,0x4]
L_922b24:
	bclr r25,r25,0xa
L_922b28:
	mov_s r32,r14
L_922b2a:
	st.ab r14,[r25,0x4]
L_922b2e:
	bclr r25,r25,0xa
L_922b32:
	ld r1,[r18, 0xc]
L_922b36:
	ld_s r0,[gp,0x178]
L_922b38:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_922b3a:
	st r1,[r18, 0xc]
L_922b3e:
	ld r1,[r19]
L_922b42:
	and r0,r0,r21
L_922b46:
	asl_s r1,r1,0x18
L_922b48:
	or_s r1,r1,r0
L_922b4a:
	st.as r1,[gp,0x5e]
L_922b4e:
	st r1,[r20, 0x8]
L_922b52:
	asl r0,r16,0x4
L_922b56:
	add2_s r0,r0,r0
L_922b58:
	mov_s r1,0x80110c
L_922b5e:
	ld_s r0,[r1,r0]
L_922b60:
	or r0,r0,0x3f000000
L_922b68:
	mov_s r32,r0
L_922b6a:
	st.ab r0,[r25,0x4]
L_922b6e:
	bclr r25,r25,0xa
L_922b72:
	mov_s r0,0x0
L_922b74:
	mov_s r2,0x800898
L_922b7a:
	mov_s r1,r0
L_922b7c:
	stb_s r1,[r2,0x1b]
L_922b7e:
	lsr_s r1,r1,0x8
L_922b80:
	stb_s r1,[r2,0x1c]
L_922b82:
	lsr_s r1,r1,0x8
L_922b84:
	stb_s r1,[r2,0x1d]
L_922b86:
	lsr_s r1,r1,0x8
L_922b88:
	stb_s r1,[r2,0x1e]
L_922b8a:
	st_s r0,[r2,0x20]
L_922b8c:
	stw_s r0,[r2,0x24]
L_922b8e:
	mov_s r0,0x886544
L_922b94:
	ld_s r0,[r0]
L_922b96:
	mov_s r3,0x886500
L_922b9c:
	bmsk_s r0,r0,0xb
L_922b9e:
	add_s r1,r0,0x1
L_922ba0:
	asl_s r1,r1,0x10
L_922ba2:
	and r1,r1,0xfff0000
L_922baa:
	bset_s r1,r1,0x1c
L_922bac:
	st_s r1,[r3,0x44]
L_922bae:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_922bb0:
	stw_s r0,[r2,0x16]
L_922bb2:
	asl r0,r16,0x4
L_922bb6:
	add2_s r0,r0,r0
L_922bb8:
	add_s r0,r0,0x801104
L_922bbe:
	ldw_s r1,[r0,0x30]
L_922bc0:
	stw_s r1,[r2,0x4]
L_922bc2:
	ldw_s r1,[r0,0x32]
L_922bc4:
	stw_s r1,[r2,0x6]
L_922bc6:
	ldw_s r1,[r0,0x34]
L_922bc8:
	stw_s r1,[r2,0x8]
L_922bca:
	ld_s r1,[r2,0x20]
L_922bcc:
	bset_s r1,r1,0x8
L_922bce:
	st_s r1,[r2,0x20]
L_922bd0:
	mov_s r1,0x5
L_922bd2:
	stb r1,[r2, 0x20]
L_922bd6:
	ld_s r1,[r0,0x8]
L_922bd8:
	add r0,r2,0x1b
L_922bdc:
	lsr_s r1,r1,0x8
L_922bde:
	bmsk_s r1,r1,0x5
L_922be0:
	bl L_93e33c
L_922be4:
	mov_s r0,0x800824
L_922bea:
	ld_s r0,[r0,0x50]
L_922bec:
	bbit0 r0,0x9,L_922c12
L_922bf0:
	ld_s r0,[r2,0x24]
L_922bf2:
	mov_s r1,0x10
L_922bf4:
	bset_s r0,r0,0xa
L_922bf6:
	st_s r0,[r2,0x24]
L_922bf8:
	add r0,r2,0x1b
L_922bfc:
	bl L_93e348
L_922c00:
	mov_s r0,0x20000400
L_922c06:
	mov_s r32,r0
L_922c08:
	st.ab r0,[r25,0x4]
L_922c0c:
	bclr r25,r25,0xa
L_922c10:
	b_s L_922c60
	.global L_922c12
L_922c12:
	bbit0 r0,0x0,L_922c30
L_922c16:
	add r0,r2,0x1b
L_922c1a:
	mov_s r1,0x10
L_922c1c:
	bl L_93e348
L_922c20:
	mov_s r0,0x20000400
L_922c26:
	mov_s r32,r0
L_922c28:
	st.ab r0,[r25,0x4]
L_922c2c:
	bclr r25,r25,0xa
	.global L_922c30
L_922c30:
	mov_s r0,0x800824
L_922c36:
	ld_s r0,[r0,0x54]
L_922c38:
	bbit0 r0,0x2,L_922c60
L_922c3c:
	lsr_s r0,r0,0x4
L_922c3e:
	bmsk_s r0,r0,0x4
L_922c40:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_922c42:
	bic r0,r0,-0x1f1
L_922c46:
	bset_s r0,r0,0xa
L_922c48:
	bset_s r0,r0,0x1d
L_922c4a:
	mov_s r32,r0
L_922c4c:
	st.ab r0,[r25,0x4]
L_922c50:
	bclr r25,r25,0xa
L_922c54:
	mov_s r1,0x800898
L_922c5a:
	ld_s r0,[r1,0x20]
L_922c5c:
	bset_s r0,r0,0xa
L_922c5e:
	st_s r0,[r1,0x20]
	.global L_922c60
L_922c60:
	mov_s r0,0x18
L_922c62:
	bl.d L_9257a8
L_922c66:
	mov_s r1,0x26
L_922c68:
	bl L_92d990
L_922c6c:
	mov_s r0,0x2008000
L_922c72:
	mov_s r32,r0
L_922c74:
	st.ab r0,[r25,0x4]
L_922c78:
	bclr r25,r25,0xa
L_922c7c:
	mov_s r0,0x19000001
L_922c82:
	mov_s r32,r0
L_922c84:
	st.ab r0,[r25,0x4]
L_922c88:
	bclr r25,r25,0xa
	.global L_922c8c
L_922c8c:
	mov_s r0,r45
L_922c8e:
	bbit0 r0,0x1f,L_922c8c
L_922c92:
	mov_s r0,0x18
L_922c94:
	asl_s r0,r0,0x18
L_922c96:
	mov_s r32,r0
L_922c98:
	st.ab r0,[r25,0x4]
L_922c9c:
	bclr r25,r25,0xa
L_922ca0:
	bl L_92e978
L_922ca4:
	bl.d L_936544
L_922ca8:
	mov_s r0,0x6
L_922caa:
	mov_s r0,0x2013800
L_922cb0:
	mov_s r32,r0
L_922cb2:
	st.ab r0,[r25,0x4]
L_922cb6:
	bclr r25,r25,0xa
L_922cba:
	mov_s r1,0x801024
L_922cc0:
	mov_s r0,0x1
L_922cc2:
	bl.d L_92f42c
L_922cc6:
	ld_s r1,[r1]
L_922cc8:
	mov_s r0,0x0
L_922cca:
	bl.d L_9366dc
L_922cce:
	bset_s r0,r0,0xf
L_922cd0:
	bl.d L_936588
L_922cd4:
	mov_s r0,0x6
L_922cd6:
	ld_s r0,[gp,0x178]
L_922cd8:
	mov_s r1,0x802944
L_922cde:
	bclr_s r0,r0,0x18
L_922ce0:
	ld_s r1,[r1]
L_922ce2:
	bclr_s r0,r0,0x19
L_922ce4:
	asl_s r1,r1,0x18
L_922ce6:
	or_s r0,r0,r1
L_922ce8:
	st.as r0,[gp,0x5e]
L_922cec:
	mov_s r1,0x889480
L_922cf2:
	st_s r0,[r1,0x8]
L_922cf4:
	bl.d L_929ee0
L_922cf8:
	mov_s r0,0x0
L_922cfa:
	mov_s r0,0x0
L_922cfc:
	bset_s r0,r0,0x1d
L_922cfe:
	mov_s r32,r0
L_922d00:
	st.ab r0,[r25,0x4]
L_922d04:
	bclr r25,r25,0xa
L_922d08:
	mov_s r1,0x800824
L_922d0e:
	ld_s r0,[r1,0x50]
L_922d10:
	bbit0 r0,0x10,L_922d26
L_922d14:
	bclr_s r0,r0,0x10
L_922d16:
	st_s r0,[r1,0x50]
L_922d18:
	mov_s r0,0x80
L_922d1a:
	bset_s r0,r0,0x19
L_922d1c:
	mov_s r32,r0
L_922d1e:
	st.ab r0,[r25,0x4]
L_922d22:
	bclr r25,r25,0xa
	.global L_922d26
L_922d26:
	b.d L_92026c
L_922d2a:
	add_s sp,sp,0xc
