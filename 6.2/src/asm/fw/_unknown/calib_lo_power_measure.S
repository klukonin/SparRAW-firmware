/* calib_lo_power_measure @ 0x8d6ca0, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_corr__estimate_and_apply_rx_gain, calib_lo_power_substep, calib_row_step, calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, abif__agc_field_rmw, calib_battery_phy_step, hwd_abif__rx_table_index_force_mode, hwd_abif__rx_table_read_vga_dc
 * Глобалы (через gp): 0x800217
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_power_measure
calib_lo_power_measure:
	.global L_8d6ca0
L_8d6ca0:
	push_s blink
L_8d6ca2:
	bl L_8c01cc
L_8d6ca6:
	sub_s sp,sp,0xc
L_8d6ca8:
	mov_s r17,r0
L_8d6caa:
	cmp_s r0,0x3f
L_8d6cac:
	mov_s r16,r1
L_8d6cae:
	mov_s r14,r2
L_8d6cb0:
	ble_s L_8d6cbe
L_8d6cb2:
	mov_s r2,sp
L_8d6cb4:
	mov_s r0,r16
L_8d6cb6:
	bl.d L_8d6b2c
L_8d6cba:
	mov_s r1,r14
L_8d6cbc:
	b_s L_8d6d40
	.global L_8d6cbe
L_8d6cbe:
	mov_s r0,0x1
L_8d6cc0:
	mov_s r18,r0
L_8d6cc2:
	stb_s r0,[r14,0x5]
L_8d6cc4:
	stb_s r0,[r14,0x4]
L_8d6cc6:
	ldb_s r0,[gp,0x93]
L_8d6cc8:
	mov_s r15,0x0
L_8d6cca:
	add r20,r0,0x2
L_8d6cce:
	extb r20,r20
L_8d6cd2:
	mov_s r0,r15
L_8d6cd4:
	bl.d L_8cf5a8
L_8d6cd8:
	mov_s r1,r15
L_8d6cda:
	mov_s r0,0x1
L_8d6cdc:
	bl.d L_8cf5a8
L_8d6ce0:
	mov_s r1,r17
L_8d6ce2:
	mov_s r13,r15
L_8d6ce4:
	mov_s r19,r15
L_8d6ce6:
	b_s L_8d6d0e
	.global L_8d6ce8
L_8d6ce8:
	mov_s r2,sp
L_8d6cea:
	mov_s r0,r16
L_8d6cec:
	bl.d L_8d6b2c
L_8d6cf0:
	mov_s r1,r14
L_8d6cf2:
	ldb_s r1,[r14,0x5]
L_8d6cf4:
	cmp_s r1,0x1
L_8d6cf6:
	cmp.eq r15,0x0
L_8d6cfa:
	beq_s L_8d6d46
L_8d6cfc:
	ldb_s r0,[r14,0x4]
L_8d6cfe:
	breq r0,0x1,L_8d6d72
L_8d6d02:
	cmp_s r1,0x1
L_8d6d04:
	cmp.eq r15,0x1
L_8d6d08:
	beq_s L_8d6d72
L_8d6d0a:
	breq r1,0x0,L_8d6da0
	.global L_8d6d0e
L_8d6d0e:
	ldb_s r0,[r14,0x5]
L_8d6d10:
	breq r0,0x1,L_8d6d1a
L_8d6d14:
	ldb_s r0,[r14,0x4]
L_8d6d16:
	brne r0,0x1,L_8d6d1e
	.global L_8d6d1a
L_8d6d1a:
	breq r19,0x0,L_8d6ce8
	.global L_8d6d1e
L_8d6d1e:
	brne r15,0x1,L_8d6d40
L_8d6d22:
	neg_s r3,r13
L_8d6d24:
	sexb_s r3,r3
L_8d6d26:
	mov_s r0,r17
L_8d6d28:
	mov_s r1,0x1
L_8d6d2a:
	bl.d L_8cf894
L_8d6d2e:
	mov_s r2,0x0
L_8d6d30:
	mov_s r0,0x0
L_8d6d32:
	bl.d L_8cf5a8
L_8d6d36:
	mov_s r1,0x0
L_8d6d38:
	mov_s r0,0x1
L_8d6d3a:
	bl.d L_8cf5a8
L_8d6d3e:
	mov_s r1,r17
	.global L_8d6d40
L_8d6d40:
	b.d L_8c0224
L_8d6d44:
	add_s sp,sp,0xc
	.global L_8d6d46
L_8d6d46:
	ld_s r0,[sp,0x0]
L_8d6d48:
	add r1,r16,0x2
L_8d6d4c:
	asr_s r0,r0,r1
L_8d6d4e:
	sub r13,r20,r0
L_8d6d52:
	sexb_s r13,r13
L_8d6d54:
	mov_s r0,r17
L_8d6d56:
	mov_s r1,0x1
L_8d6d58:
	bl.d L_8cf718
L_8d6d5c:
	mov_s r2,0x0
L_8d6d5e:
	sub r1,r0,r13
L_8d6d62:
	cmp r1,-0x1
L_8d6d66:
	bne_s L_8d6d6c
L_8d6d68:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d6d6a:
	sexb_s r13,r13
	.global L_8d6d6c
L_8d6d6c:
	sub_s r0,r0,r13
L_8d6d6e:
	brge r0,0x0,L_8d6d78
	.global L_8d6d72
L_8d6d72:
	mov r19,0x1
L_8d6d76:
	b_s L_8d6d0e
	.global L_8d6d78
L_8d6d78:
	brlt r0,0x3,L_8d6d80
L_8d6d7c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d6d7e:
	sexb_s r13,r13
	.global L_8d6d80
L_8d6d80:
	mov_s r0,r17
L_8d6d82:
	mov_s r1,0x1
L_8d6d84:
	mov_s r2,0x0
L_8d6d86:
	bl.d L_8cf894
L_8d6d8a:
	mov_s r3,r13
L_8d6d8c:
	mov_s r0,0x0
L_8d6d8e:
	bl.d L_8cf5a8
L_8d6d92:
	mov_s r1,0x0
L_8d6d94:
	mov_s r0,0x1
L_8d6d96:
	bl.d L_8cf5a8
L_8d6d9a:
	mov_s r1,r17
L_8d6d9c:
	mov_s r15,0x1
L_8d6d9e:
	b_s L_8d6d0e
	.global L_8d6da0
L_8d6da0:
	brne r15,0x1,L_8d6d0e
L_8d6da4:
	ld_s r0,[r14]
L_8d6da6:
	mov_s r1,0x0
L_8d6da8:
	bset_s r1,r1,0xf
L_8d6daa:
	cmp_s r0,0x0
L_8d6dac:
	add.ge r0,r0,r1
L_8d6db0:
	asr.ge r0,r0,0x10
L_8d6db4:
	bge_s L_8d6dbc
L_8d6db6:
	sub_s r1,r1,r0
L_8d6db8:
	asr_s r1,r1,0x10
L_8d6dba:
	neg_s r0,r1
	.global L_8d6dbc
L_8d6dbc:
	brge r0,0xfffffff1,L_8d6d0e
L_8d6dc4:
	stb r18,[r14, 0x5]
L_8d6dc8:
	b_s L_8d6d72
L_8d6dca:
	nop_s
