/* if_gain @ 0x8d5b64, 564 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ===== IF GAIN FinEst: CAL_CORRECTION_NON_CONVERGED (iter_cntr=%d) =====
 *   ===== IF GAIN status: CAL_CORRECTION_NON_CONVERGED =====
 *   if_gain: forced to %d
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: IF_GAIN__GAIN, __ld_r19_to_r13_ret, __st_r19_to_r13, agc__get_table_pair, calib_obj4__reset_d4, calib_silent_rssi_sparrow__set_agc_start_val, fw_log_emit0, fw_log_emit1, hwf_if_gain__apply_agc_table, if_gain__apply_delta, if_gain__compute_correction, rf_cfg__get_rf_mask_45e
 * Глобалы (через gp): 0x800225, 0x800226, 0x800227
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global if_gain
if_gain:
	.global L_8d5b64
L_8d5b64:
	push_s blink
L_8d5b66:
	bl.d L_8c01d0
L_8d5b6a:
	mov_s r1,0x1d
L_8d5b6c:
	mov.f r16,r0
L_8d5b70:
	mov_s r14,0x8067bc
L_8d5b76:
	stb_s r1,[r14,0x4]
L_8d5b78:
	mov_s r15,0x842464
L_8d5b7e:
	ldb_s r1,[r15,0x6]
L_8d5b80:
	mov_s r0,0x0
L_8d5b82:
	stb_s r1,[r14,0x5]
L_8d5b84:
	ldb r1,[gp, 0xa4]
L_8d5b88:
	sub_s sp,sp,0x8
L_8d5b8a:
	stb_s r1,[r14,0x12]
L_8d5b8c:
	mov_s r2,0x8
L_8d5b8e:
	bne_s L_8d5ba8
L_8d5b90:
	mov_s r1,0x5
L_8d5b92:
	stb_s r1,[r14,0x6]
L_8d5b94:
	mov_s r1,0x48
L_8d5b96:
	stb_s r1,[r14,0x7]
L_8d5b98:
	stb_s r0,[r14,0x8]
L_8d5b9a:
	stb_s r0,[r14,0x9]
L_8d5b9c:
	stb_s r2,[r14,0xa]
L_8d5b9e:
	mov_s r1,0x80051c
L_8d5ba4:
	stb_s r2,[r14,0xb]
L_8d5ba6:
	b_s L_8d5bba
	.global L_8d5ba8
L_8d5ba8:
	brne r16,0x1,L_8d5bbc
L_8d5bac:
	mov_s r0,0x1
L_8d5bae:
	stb_s r0,[r14,0xb]
L_8d5bb0:
	mov_s r1,0x80051c
L_8d5bb6:
	ld_s r0,[r1]
L_8d5bb8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d5bba
L_8d5bba:
	st_s r0,[r1]
	.global L_8d5bbc
L_8d5bbc:
	bl L_8e9524
L_8d5bc0:
	bl L_8e9524
L_8d5bc4:
	bl L_8e9524
L_8d5bc8:
	brne r16,0x1,L_8d5c7c
L_8d5bcc:
	mov_s r0,0x0
L_8d5bce:
	stb_s r0,[r14,0x13]
L_8d5bd0:
	mov_s r0,0x1
L_8d5bd2:
	mov_s r1,0x2
L_8d5bd4:
	mov_s r2,0x6
L_8d5bd6:
	bl.d L_8d565c
L_8d5bda:
	add_s r3,r14,0x4
L_8d5bdc:
	ldb_s r0,[r14,0xd]
L_8d5bde:
	bl.d L_8d55b4
L_8d5be2:
	add_s r1,r14,0x4
L_8d5be4:
	mov_s r13,r0
L_8d5be6:
	brne r0,0x2,L_8d5bfa
L_8d5bea:
	mov_s r1,0x101cc88
L_8d5bf0:
	mov_s r0,0x16
L_8d5bf2:
	bl.d L_8dcc10
L_8d5bf6:
	ldb_s r2,[r14,0x14]
L_8d5bf8:
	b_s L_8d5c04
	.global L_8d5bfa
L_8d5bfa:
	brne r13,0x1,L_8d5c04
L_8d5bfe:
	ldb_s r0,[r14,0x14]
L_8d5c00:
	breq r0,0x1,L_8d5c08
	.global L_8d5c04
L_8d5c04:
	mov_s r0,0x0
L_8d5c06:
	b_s L_8d5c0a
	.global L_8d5c08
L_8d5c08:
	mov_s r0,0x1
	.global L_8d5c0a
L_8d5c0a:
	mov_s r17,r0
L_8d5c0c:
	breq r16,0x0,L_8d5c1a
L_8d5c10:
	cmp r16,0x1
L_8d5c14:
	cmp.eq r13,0x2
L_8d5c18:
	bne_s L_8d5c36
	.global L_8d5c1a
L_8d5c1a:
	bl L_8e9524
L_8d5c1e:
	mov_s r0,0x1
L_8d5c20:
	stb_s r0,[r14,0x13]
L_8d5c22:
	mov_s r1,0x2
L_8d5c24:
	mov_s r2,0x3
L_8d5c26:
	bl.d L_8d565c
L_8d5c2a:
	add_s r3,r14,0x4
L_8d5c2c:
	ldb_s r0,[r14,0xd]
L_8d5c2e:
	bl.d L_8d55b4
L_8d5c32:
	add_s r1,r14,0x4
L_8d5c34:
	mov_s r13,r0
	.global L_8d5c36
L_8d5c36:
	ldb_s r0,[gp,0xa3]
L_8d5c38:
	ldb_s r1,[r15,0xa]
L_8d5c3a:
	ldb.x r2,[r14, 0xd]
L_8d5c3e:
	sub_s r0,r0,r1
L_8d5c40:
	ldb_s r1,[r14,0x12]
L_8d5c42:
	sub_s r1,r1,r2
L_8d5c44:
	sub_s r0,r0,r1
L_8d5c46:
	sexb_s r0,r0
L_8d5c48:
	neg_s r0,r0
L_8d5c4a:
	sexb_s r0,r0
L_8d5c4c:
	bl.d L_8d561c
L_8d5c50:
	add_s r1,r14,0x4
L_8d5c52:
	brne r13,0x2,L_8d5c74
L_8d5c56:
	bl L_8e9524
L_8d5c5a:
	mov_s r0,0x0
L_8d5c5c:
	stb_s r0,[r14,0x13]
L_8d5c5e:
	mov_s r0,0x1
L_8d5c60:
	mov_s r1,0x2
L_8d5c62:
	mov_s r2,0x6
L_8d5c64:
	bl.d L_8d565c
L_8d5c68:
	add_s r3,r14,0x4
L_8d5c6a:
	ldb_s r0,[r14,0xd]
L_8d5c6c:
	bl.d L_8d55b4
L_8d5c70:
	add_s r1,r14,0x4
L_8d5c72:
	mov_s r13,r0
	.global L_8d5c74
L_8d5c74:
	breq r17,0x0,L_8d5ca0
L_8d5c78:
	mov_s r13,0x0
L_8d5c7a:
	b_s L_8d5cb4
	.global L_8d5c7c
L_8d5c7c:
	cmp r16,0x0
L_8d5c80:
	sub_s.ne r13,r13,r13
L_8d5c82:
	bne_s L_8d5c04
L_8d5c84:
	mov_s r0,0x3
L_8d5c86:
	stb_s r0,[r14,0x13]
L_8d5c88:
	mov_s r0,0x1
L_8d5c8a:
	mov_s r1,r0
L_8d5c8c:
	mov_s r2,0x6
L_8d5c8e:
	bl.d L_8d565c
L_8d5c92:
	add_s r3,r14,0x4
L_8d5c94:
	ldb_s r0,[r14,0xd]
L_8d5c96:
	bl.d L_8d55b4
L_8d5c9a:
	add_s r1,r14,0x4
L_8d5c9c:
	mov_s r13,r0
L_8d5c9e:
	b_s L_8d5c04
	.global L_8d5ca0
L_8d5ca0:
	breq r13,0x1,L_8d5cb4
L_8d5ca4:
	brne r13,0x2,L_8d5cb4
L_8d5ca8:
	mov_s r1,0x101ccd0
L_8d5cae:
	bl.d L_8dcba8
L_8d5cb2:
	mov_s r0,0x16
	.global L_8d5cb4
L_8d5cb4:
	ldb_s r1,[r14,0xa]
L_8d5cb6:
	mov_s r0,0x889480
L_8d5cbc:
	stb_s r1,[r15,0xb]
L_8d5cbe:
	ld_s r2,[r0,0x70]
L_8d5cc0:
	lsr_s r2,r2,0xc
L_8d5cc2:
	bmsk_s r2,r2,0x3
L_8d5cc4:
	stb_s r2,[r15]
L_8d5cc6:
	ld_s r2,[r0,0x70]
L_8d5cc8:
	lsr_s r2,r2,0x10
L_8d5cca:
	bmsk_s r2,r2,0x3
L_8d5ccc:
	stb_s r2,[r15,0x1]
L_8d5cce:
	ld_s r2,[r0,0x70]
L_8d5cd0:
	lsr_s r2,r2,0x14
L_8d5cd2:
	bmsk_s r2,r2,0x3
L_8d5cd4:
	stb_s r2,[r15,0x2]
L_8d5cd6:
	mov_s r2,0x884100
L_8d5cdc:
	ld_s r2,[r2,0x34]
L_8d5cde:
	stb_s r2,[r15,0x3]
L_8d5ce0:
	ld_s r0,[r0,0x64]
L_8d5ce2:
	lsr_s r0,r0,0x10
L_8d5ce4:
	bmsk_s r0,r0,0x5
L_8d5ce6:
	stb_s r0,[r15,0x4]
L_8d5ce8:
	st_s r13,[r15,0x10]
L_8d5cea:
	breq r16,0x0,L_8d5cf4
L_8d5cee:
	ldb_s r0,[gp,0xa1]
L_8d5cf0:
	brne r0,0x1,L_8d5cfc
	.global L_8d5cf4
L_8d5cf4:
	bl.d L_8d5f08
L_8d5cf8:
	mov_s r0,r1
L_8d5cfa:
	b_s L_8d5d64
	.global L_8d5cfc
L_8d5cfc:
	brne r16,0x1,L_8d5d64
L_8d5d00:
	ldb.x r0,[r14]
L_8d5d04:
	breq_s r0,0,L_8d5d5c
L_8d5d06:
	mov r17,0x8042c8
L_8d5d0e:
	ld r1,[r17,0x468]
L_8d5d16:
	mov_s r0,0x0
L_8d5d18:
	mov_s r18,r0
L_8d5d1a:
	breq_s r1,0,L_8d5d58
L_8d5d1c:
	st_s r0,[sp,0x0]
L_8d5d1e:
	bl.d L_8cbb90
L_8d5d22:
	st_s r0,[sp,0x4]
L_8d5d24:
	mov_s r19,r0
L_8d5d26:
	mov_s r2,sp
L_8d5d28:
	add_s r3,sp,0x4
L_8d5d2a:
	bl.d L_8cb804
L_8d5d2e:
	mov_s r1,0x1
L_8d5d30:
	ld_s r0,[sp,0x0]
L_8d5d32:
	ldb.x r1,[r14]
L_8d5d36:
	add r16,r0,r1
L_8d5d3a:
	bl.d L_8ccb3c
L_8d5d3e:
	mov_s r0,r17
L_8d5d40:
	mov_s r2,r18
L_8d5d42:
	b_s L_8d5d4c
	.global L_8d5d44
L_8d5d44:
	sub_s r1,r0,0x1
L_8d5d46:
	and_s r0,r0,r1
L_8d5d48:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8d5d4a:
	extw_s r2,r2
	.global L_8d5d4c
L_8d5d4c:
	brne_s r0,0,L_8d5d44
L_8d5d4e:
	extb_s r2,r2
L_8d5d50:
	mov_s r0,r19
L_8d5d52:
	bl.d L_8ea8d8
L_8d5d56:
	mov_s r1,r16
	.global L_8d5d58
L_8d5d58:
	stb r18,[r14]
	.global L_8d5d5c
L_8d5d5c:
	brne r13,0x1,L_8d5d64
L_8d5d60:
	ldb_s r1,[r15,0xb]
L_8d5d62:
	b_s L_8d5cf4
	.global L_8d5d64
L_8d5d64:
	mov_s r0,0x8042c8
L_8d5d6a:
	ld r0,[r0,0x468]
L_8d5d72:
	brne r0,0x3,L_8d5d90
L_8d5d76:
	ldb r2,[gp, 0xa2]
L_8d5d7a:
	brlt r2,0x1,L_8d5d90
L_8d5d7e:
	mov_s r1,0x101cd0c
L_8d5d84:
	bl.d L_8dcc10
L_8d5d88:
	mov_s r0,0x26
L_8d5d8a:
	bl.d L_8d5f08
L_8d5d8e:
	ldb_s r0,[gp,0xa2]
	.global L_8d5d90
L_8d5d90:
	mov_s r0,r13
L_8d5d92:
	b.d L_8c022c
L_8d5d96:
	add_s sp,sp,0x8
