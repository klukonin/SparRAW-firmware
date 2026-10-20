/* hwf_if_gain_fin_est @ 0x8d2d78, 448 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ===== IF GAIN FinEst: CAL_CORRECTION_NON_CONVERGED (iter_cntr=%d) =====
 *   ===== IF GAIN status: CAL_CORRECTION_NON_CONVERGED =====
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_if_gain__vt1c, hwf_calib_all
 * Зовёт сам: IF_GAIN__GAIN, __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit1, fw_read_timer, hwf_if_gain__apply_agc_table, if_gain__apply_delta, if_gain__compute_correction, phy__report_gain_to_ucode
 * Глобалы (через gp): 0x80020b, 0x80020c, 0x800229
 */
	.section .text.hwf_if_gain_fin_est,"ax",@progbits
	.global hwf_if_gain_fin_est
hwf_if_gain_fin_est:
	.global L_8d2d78
L_8d2d78:
	push_s blink
L_8d2d7a:
	bl.d L_8c02b8
L_8d2d7e:
	mov_s r1,0x1d
L_8d2d80:
	mov.f r16,r0
L_8d2d84:
	mov_s r14,0x806764
L_8d2d8a:
	stb_s r1,[r14,0x4]
L_8d2d8c:
	mov_s r15,0x842720
L_8d2d92:
	ldb_s r1,[r15,0x6]
L_8d2d94:
	mov_s r0,0x0
L_8d2d96:
	stb_s r1,[r14,0x5]
L_8d2d98:
	ldb r1,[gp, 0x9d]
L_8d2d9c:
	stb_s r1,[r14,0x12]
L_8d2d9e:
	mov_s r2,0x8
L_8d2da0:
	bne_s L_8d2dba
L_8d2da2:
	mov_s r1,0x5
L_8d2da4:
	stb_s r1,[r14,0x6]
L_8d2da6:
	mov_s r1,0x48
L_8d2da8:
	stb_s r1,[r14,0x7]
L_8d2daa:
	stb_s r0,[r14,0x8]
L_8d2dac:
	stb_s r0,[r14,0x9]
L_8d2dae:
	stb_s r2,[r14,0xa]
L_8d2db0:
	mov_s r1,0x8004ec
L_8d2db6:
	stb_s r2,[r14,0xb]
L_8d2db8:
	b_s L_8d2dcc
	.global L_8d2dba
L_8d2dba:
	brne r16,0x1,L_8d2dce
L_8d2dbe:
	mov_s r0,0x1
L_8d2dc0:
	stb_s r0,[r14,0xb]
L_8d2dc2:
	mov_s r1,0x8004ec
L_8d2dc8:
	ld_s r0,[r1]
L_8d2dca:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d2dcc
L_8d2dcc:
	st_s r0,[r1]
	.global L_8d2dce
L_8d2dce:
	bl L_8e4694
L_8d2dd2:
	bl L_8e4694
L_8d2dd6:
	bl L_8e4694
L_8d2dda:
	brne r16,0x1,L_8d2e90
L_8d2dde:
	mov_s r0,0x0
L_8d2de0:
	stb_s r0,[r14,0x13]
L_8d2de2:
	mov_s r0,0x1
L_8d2de4:
	mov_s r1,0x2
L_8d2de6:
	mov_s r2,0x6
L_8d2de8:
	bl.d L_8d2828
L_8d2dec:
	add_s r3,r14,0x4
L_8d2dee:
	ldb_s r0,[r14,0xd]
L_8d2df0:
	bl.d L_8d2780
L_8d2df4:
	add_s r1,r14,0x4
L_8d2df6:
	mov_s r13,r0
L_8d2df8:
	brne r0,0x2,L_8d2e0e
L_8d2dfc:
	mov_s r2,0x1017f18
L_8d2e02:
	mov_s r0,0x6
L_8d2e04:
	mov_s r1,0x1
L_8d2e06:
	bl.d L_8edfcc
L_8d2e0a:
	ldb_s r3,[r14,0x14]
L_8d2e0c:
	b_s L_8d2e18
	.global L_8d2e0e
L_8d2e0e:
	brne r13,0x1,L_8d2e18
L_8d2e12:
	ldb_s r0,[r14,0x14]
L_8d2e14:
	breq r0,0x1,L_8d2e1c
	.global L_8d2e18
L_8d2e18:
	mov_s r0,0x0
L_8d2e1a:
	b_s L_8d2e1e
	.global L_8d2e1c
L_8d2e1c:
	mov_s r0,0x1
	.global L_8d2e1e
L_8d2e1e:
	mov_s r17,r0
L_8d2e20:
	breq r16,0x0,L_8d2e2e
L_8d2e24:
	cmp r16,0x1
L_8d2e28:
	cmp.eq r13,0x2
L_8d2e2c:
	bne_s L_8d2e4a
	.global L_8d2e2e
L_8d2e2e:
	bl L_8e4694
L_8d2e32:
	mov_s r0,0x1
L_8d2e34:
	stb_s r0,[r14,0x13]
L_8d2e36:
	mov_s r1,0x2
L_8d2e38:
	mov_s r2,0x3
L_8d2e3a:
	bl.d L_8d2828
L_8d2e3e:
	add_s r3,r14,0x4
L_8d2e40:
	ldb_s r0,[r14,0xd]
L_8d2e42:
	bl.d L_8d2780
L_8d2e46:
	add_s r1,r14,0x4
L_8d2e48:
	mov_s r13,r0
	.global L_8d2e4a
L_8d2e4a:
	ldb_s r0,[gp,0x9c]
L_8d2e4c:
	ldb_s r1,[r15,0xa]
L_8d2e4e:
	ldb.x r2,[r14, 0xd]
L_8d2e52:
	sub_s r0,r0,r1
L_8d2e54:
	ldb_s r1,[r14,0x12]
L_8d2e56:
	sub_s r1,r1,r2
L_8d2e58:
	sub_s r0,r0,r1
L_8d2e5a:
	sexb_s r0,r0
L_8d2e5c:
	neg_s r0,r0
L_8d2e5e:
	sexb_s r0,r0
L_8d2e60:
	bl.d L_8d27e8
L_8d2e64:
	add_s r1,r14,0x4
L_8d2e66:
	brne r13,0x2,L_8d2e88
L_8d2e6a:
	bl L_8e4694
L_8d2e6e:
	mov_s r0,0x0
L_8d2e70:
	stb_s r0,[r14,0x13]
L_8d2e72:
	mov_s r0,0x1
L_8d2e74:
	mov_s r1,0x2
L_8d2e76:
	mov_s r2,0x6
L_8d2e78:
	bl.d L_8d2828
L_8d2e7c:
	add_s r3,r14,0x4
L_8d2e7e:
	ldb_s r0,[r14,0xd]
L_8d2e80:
	bl.d L_8d2780
L_8d2e84:
	add_s r1,r14,0x4
L_8d2e86:
	mov_s r13,r0
	.global L_8d2e88
L_8d2e88:
	breq r17,0x0,L_8d2eb4
L_8d2e8c:
	mov_s r13,0x0
L_8d2e8e:
	b_s L_8d2eca
	.global L_8d2e90
L_8d2e90:
	cmp r16,0x0
L_8d2e94:
	sub_s.ne r13,r13,r13
L_8d2e96:
	bne_s L_8d2e18
L_8d2e98:
	mov_s r0,0x3
L_8d2e9a:
	stb_s r0,[r14,0x13]
L_8d2e9c:
	mov_s r0,0x1
L_8d2e9e:
	mov_s r1,r0
L_8d2ea0:
	mov_s r2,0x6
L_8d2ea2:
	bl.d L_8d2828
L_8d2ea6:
	add_s r3,r14,0x4
L_8d2ea8:
	ldb_s r0,[r14,0xd]
L_8d2eaa:
	bl.d L_8d2780
L_8d2eae:
	add_s r1,r14,0x4
L_8d2eb0:
	mov_s r13,r0
L_8d2eb2:
	b_s L_8d2e18
	.global L_8d2eb4
L_8d2eb4:
	breq r13,0x1,L_8d2eca
L_8d2eb8:
	brne r13,0x2,L_8d2eca
L_8d2ebc:
	mov_s r2,0x1017f60
L_8d2ec2:
	mov_s r0,0x6
L_8d2ec4:
	bl.d L_8edfb0
L_8d2ec8:
	mov_s r1,0x1
	.global L_8d2eca
L_8d2eca:
	ldb_s r1,[r14,0xa]
L_8d2ecc:
	mov_s r0,0x889480
L_8d2ed2:
	ld_s r2,[r0,0x70]
L_8d2ed4:
	stb_s r1,[r15,0xb]
L_8d2ed6:
	lsr_s r2,r2,0xc
L_8d2ed8:
	bmsk_s r2,r2,0x3
L_8d2eda:
	stb_s r2,[r15]
L_8d2edc:
	ld_s r2,[r0,0x70]
L_8d2ede:
	lsr_s r2,r2,0x10
L_8d2ee0:
	bmsk_s r2,r2,0x3
L_8d2ee2:
	stb_s r2,[r15,0x1]
L_8d2ee4:
	ld_s r2,[r0,0x70]
L_8d2ee6:
	lsr_s r2,r2,0x14
L_8d2ee8:
	bmsk_s r2,r2,0x3
L_8d2eea:
	stb_s r2,[r15,0x2]
L_8d2eec:
	mov_s r2,0x884100
L_8d2ef2:
	ld_s r2,[r2,0x34]
L_8d2ef4:
	ld_s r0,[r0,0x64]
L_8d2ef6:
	stb_s r2,[r15,0x3]
L_8d2ef8:
	lsr_s r0,r0,0x10
L_8d2efa:
	bmsk_s r0,r0,0x5
L_8d2efc:
	stb_s r0,[r15,0x4]
L_8d2efe:
	st_s r13,[r15,0x10]
L_8d2f00:
	breq r16,0x0,L_8d2f0a
L_8d2f04:
	ldb_s r0,[gp,0x9b]
L_8d2f06:
	brne r0,0x1,L_8d2f12
	.global L_8d2f0a
L_8d2f0a:
	bl.d L_8d30a0
L_8d2f0e:
	mov_s r0,r1
L_8d2f10:
	b_s L_8d2f32
	.global L_8d2f12
L_8d2f12:
	brne r16,0x1,L_8d2f32
L_8d2f16:
	ldb.x r1,[r14]
L_8d2f1a:
	breq_s r1,0,L_8d2f2a
L_8d2f1c:
	ldb_s r0,[gp,0xb9]
L_8d2f1e:
	add_s r0,r0,r1
L_8d2f20:
	bl.d L_8d1964
L_8d2f24:
	extb_s r0,r0
L_8d2f26:
	mov_s r0,0x0
L_8d2f28:
	stb_s r0,[r14]
	.global L_8d2f2a
L_8d2f2a:
	brne r13,0x1,L_8d2f32
L_8d2f2e:
	ldb_s r1,[r15,0xb]
L_8d2f30:
	b_s L_8d2f0a
	.global L_8d2f32
L_8d2f32:
	b.d L_8c031c
L_8d2f36:
	mov_s r0,r13
