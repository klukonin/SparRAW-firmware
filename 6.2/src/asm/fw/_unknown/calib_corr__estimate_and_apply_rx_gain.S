/* calib_corr__estimate_and_apply_rx_gain @ 0x8d5d98, 340 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_lo_power_measure, calib_lo_power_substep, hwd__args_to_regs_default, hwd_abif__caf_lpbk_mode, hwd_abif__rx_table_index_force_mode, hwd_mac__uses_rgf_886200, hwd_phy__rx_agc_index_force_mode, hwd_phy__rx_agc_steps_disable, hwd_phy__rx_cal_corr_config, hwd_phy__rx_enable
 * Глобалы (через gp): 0x800222, 0x800223
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_corr__estimate_and_apply_rx_gain
calib_corr__estimate_and_apply_rx_gain:
	.global L_8d5d98
L_8d5d98:
	push_s blink
L_8d5d9a:
	bl L_8c01e0
L_8d5d9e:
	bl.d L_8d65e8
L_8d5da2:
	sub_s sp,sp,0x8
L_8d5da4:
	bl.d L_8d219c
L_8d5da8:
	mov_s r0,0x0
L_8d5daa:
	bl.d L_8d21d0
L_8d5dae:
	mov_s r0,0x0
L_8d5db0:
	bl.d L_8ce5e8
L_8d5db4:
	mov_s r0,0x0
L_8d5db6:
	bl.d L_8d7560
L_8d5dba:
	mov_s r0,0x0
L_8d5dbc:
	bl L_8d2b38
L_8d5dc0:
	mov_s r0,0x8042c8
L_8d5dc6:
	bl L_8ccb3c
L_8d5dca:
	bl L_8d3380
L_8d5dce:
	bl.d L_8d7560
L_8d5dd2:
	mov_s r0,0x1
L_8d5dd4:
	bl L_8d2ba4
L_8d5dd8:
	ldb_s r0,[gp,0x9e]
L_8d5dda:
	mov_s r14,0x800508
L_8d5de0:
	mov_s r13,0x842464
L_8d5de6:
	ldb_s r15,[r14]
L_8d5de8:
	brne r0,0x1,L_8d5e30
L_8d5dec:
	mov_s r0,r14
L_8d5dee:
	mov_s r1,r15
L_8d5df0:
	bl.d L_8d530c
L_8d5df4:
	mov_s r2,0x0
L_8d5df6:
	ldb_s r1,[r14]
L_8d5df8:
	mov_s r0,0x8067bc
L_8d5dfe:
	sub r2,r1,r15
L_8d5e02:
	stb_s r2,[r0]
L_8d5e04:
	ldb_s r0,[gp,0x9f]
L_8d5e06:
	mov_s r3,sp
L_8d5e08:
	sub_s r1,r1,r0
L_8d5e0a:
	extb_s r1,r1
L_8d5e0c:
	sexb_s r2,r0
L_8d5e0e:
	bl.d L_8d530c
L_8d5e12:
	mov_s r0,r3
L_8d5e14:
	ldb_s r0,[sp,0x0]
L_8d5e16:
	ld_s r1,[sp,0x4]
L_8d5e18:
	stb_s r0,[r13,0x6]
L_8d5e1a:
	mov_s r0,0x0
L_8d5e1c:
	brlt.d r1,0x0,L_8d5e28
L_8d5e20:
	bset_s r0,r0,0xf
L_8d5e22:
	add_s r0,r0,r1
L_8d5e24:
	asr_s r0,r0,0x10
L_8d5e26:
	b_s L_8d5e86
	.global L_8d5e28
L_8d5e28:
	sub_s r0,r0,r1
L_8d5e2a:
	asr_s r0,r0,0x10
L_8d5e2c:
	neg_s r0,r0
L_8d5e2e:
	b_s L_8d5e86
	.global L_8d5e30
L_8d5e30:
	brne_s r0,0,L_8d5e56
L_8d5e32:
	ldb r1,[gp, 0x9f]
L_8d5e36:
	ld_s r2,[r14,0x4]
L_8d5e38:
	sub_s r15,r15,r1
L_8d5e3a:
	stb_s r15,[r13,0x6]
L_8d5e3c:
	mov_s r0,0x0
L_8d5e3e:
	brlt.d r2,0x0,L_8d5e4a
L_8d5e42:
	bset_s r0,r0,0xf
L_8d5e44:
	add_s r0,r0,r2
L_8d5e46:
	asr_s r0,r0,0x10
L_8d5e48:
	b_s L_8d5e50
	.global L_8d5e4a
L_8d5e4a:
	sub_s r0,r0,r2
L_8d5e4c:
	asr_s r0,r0,0x10
L_8d5e4e:
	neg_s r0,r0
	.global L_8d5e50
L_8d5e50:
	add_s r1,r1,r0
L_8d5e52:
	stb_s r1,[r13,0x7]
L_8d5e54:
	b_s L_8d5e8a
	.global L_8d5e56
L_8d5e56:
	brne r0,0x2,L_8d5e8a
L_8d5e5a:
	ldb_s r0,[gp,0x9f]
L_8d5e5c:
	mov_s r2,sp
L_8d5e5e:
	sub_s r15,r15,r0
L_8d5e60:
	extb_s r15,r15
L_8d5e62:
	stb_s r15,[r13,0x6]
L_8d5e64:
	mov_s r0,r15
L_8d5e66:
	bl.d L_8d6ca0
L_8d5e6a:
	ldb r1,[gp, 0xa0]
L_8d5e6e:
	mov_s r1,0x0
L_8d5e70:
	ld_s r0,[sp,0x0]
L_8d5e72:
	bset_s r1,r1,0xf
L_8d5e74:
	cmp_s r0,0x0
L_8d5e76:
	add.ge r0,r0,r1
L_8d5e7a:
	asr.ge r0,r0,0x10
L_8d5e7e:
	bge_s L_8d5e86
L_8d5e80:
	sub_s r1,r1,r0
L_8d5e82:
	asr_s r1,r1,0x10
L_8d5e84:
	neg_s r0,r1
	.global L_8d5e86
L_8d5e86:
	sexb_s r0,r0
L_8d5e88:
	stb_s r0,[r13,0x7]
	.global L_8d5e8a
L_8d5e8a:
	bl L_8d2b38
L_8d5e8e:
	mov_s r0,0x0
L_8d5e90:
	bl.d L_8cf5a8
L_8d5e94:
	mov_s r1,r0
L_8d5e96:
	bl.d L_8d7560
L_8d5e9a:
	mov_s r0,0x0
L_8d5e9c:
	mov_s r0,0xb
L_8d5e9e:
	mov_s r1,r0
L_8d5ea0:
	bl.d L_8d3090
L_8d5ea4:
	mov_s r2,0x6
L_8d5ea6:
	bl.d L_8d30f4
L_8d5eaa:
	mov_s r0,0x1
L_8d5eac:
	mov_s r0,0x0
L_8d5eae:
	bset_s r0,r0,0x10
L_8d5eb0:
	mov_s r1,0x1
L_8d5eb2:
	bl.d L_8d2418
L_8d5eb6:
	mov_s r2,0xb
L_8d5eb8:
	bl L_8d2be4
L_8d5ebc:
	bl L_8d2ba4
L_8d5ec0:
	bl.d L_8d1bc0
L_8d5ec4:
	mov_s r0,0x1
L_8d5ec6:
	mov_s r0,0x1
L_8d5ec8:
	bl.d L_8d2218
L_8d5ecc:
	ldb_s r1,[r13,0x6]
L_8d5ece:
	bl.d L_8d2260
L_8d5ed2:
	mov_s r0,0x1
L_8d5ed4:
	bl.d L_8d0fb4
L_8d5ed8:
	mov_s r0,0x1
L_8d5eda:
	mov_s r0,0x1
L_8d5edc:
	mov_s r1,0x1d
L_8d5ede:
	bl.d L_8d7528
L_8d5ee2:
	ldb_s r2,[r13,0x6]
L_8d5ee4:
	b.d L_8c024c
L_8d5ee8:
	add_s sp,sp,0x8
L_8d5eea:
	nop_s
