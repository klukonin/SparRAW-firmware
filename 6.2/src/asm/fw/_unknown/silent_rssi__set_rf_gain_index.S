/* silent_rssi__set_rf_gain_index @ 0x8c6c2c, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__find_rf_gain, calibrate_baseband_gain
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwm_analog__prepare_buf, marlon_r_if_class__rf_write_with_block_retries, rfc__write_gain_idx_reg504, txrx_sel
 * Глобалы (через gp): 0x800458, 0x80045c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global silent_rssi__set_rf_gain_index
silent_rssi__set_rf_gain_index:
	.global L_8c6c2c
L_8c6c2c:
	push_s blink
L_8c6c2e:
	bl.d L_8c01dc
L_8c6c32:
	add_s r3,r3,r2
L_8c6c34:
	sub_s sp,sp,0x8
L_8c6c36:
	mov_s r16,r1
L_8c6c38:
	mov_s r15,r4
L_8c6c3a:
	max r3,r3,0x1
L_8c6c3e:
	mov_s r14,0x8042c8
L_8c6c44:
	min r1,r3,0xf
L_8c6c48:
	breq r5,0x0,L_8c6c9a
L_8c6c4c:
	mov_s r0,r14
L_8c6c4e:
	add r0,r0,0x4f4
L_8c6c52:
	ld_s r1,[r0,0x78]
L_8c6c54:
	mov_s r13,sp
L_8c6c56:
	st_s r1,[sp,0x0]
L_8c6c58:
	add3_s r0,r0,r2
L_8c6c5a:
	ld_s r0,[r0,0x4]
L_8c6c5c:
	ld.as r6,[gp,0xb5]
L_8c6c60:
	st_s r0,[sp,0x4]
L_8c6c62:
	mov_s r0,r14
L_8c6c64:
	mov_s r1,0x0
L_8c6c66:
	mov_s r2,r13
L_8c6c68:
	mov_s r3,0x1
L_8c6c6a:
	mov_s r4,r3
L_8c6c6c:
	bl.d L_8e3418
L_8c6c70:
	mov r5,0x5
L_8c6c74:
	brne_s r0,0,L_8c6c98
L_8c6c76:
	ld_s r0,[gp,0x2d8]
L_8c6c78:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c6c7a:
	st.as r0,[gp,0xb6]
L_8c6c7e:
	bl.d L_8e2960
L_8c6c82:
	mov_s r0,0x1
L_8c6c84:
	mov_s r0,r14
L_8c6c86:
	mov_s r1,0x0
L_8c6c88:
	mov_s r2,r13
L_8c6c8a:
	mov_s r3,0x1
L_8c6c8c:
	mov_s r4,r3
L_8c6c8e:
	mov r5,0x5
L_8c6c92:
	bl.d L_8e3418
L_8c6c96:
	mov_s r6,r3
	.global L_8c6c98
L_8c6c98:
	mov_s r1,0xf
	.global L_8c6c9a
L_8c6c9a:
	mov_s r0,r14
L_8c6c9c:
	bl.d L_8e62dc
L_8c6ca0:
	mov_s r2,r15
L_8c6ca2:
	mov_s r0,r14
L_8c6ca4:
	ldb_s r1,[r14]
L_8c6ca6:
	mov_s r2,0x1
L_8c6ca8:
	bl.d L_8ea5f0
L_8c6cac:
	mov_s r3,r16
L_8c6cae:
	b.d L_8c0244
L_8c6cb2:
	add_s sp,sp,0x8
