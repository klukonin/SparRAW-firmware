/* calib_lo_power_measure @ 0x8d3f40, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_bb_gain_dc__vga_dc_fine, calib_lo_power_step, calib_lo_power_substep, calib_row_step, hwf_calib_all
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, abif__agc_field_rmw, calib_battery_phy_step, hwd_abif__get_agc_field, hwd_abif__rgf_88a200_8cc674
 * Глобалы (через gp): 0x8001ff
 */
	.section .text.calib_lo_power_measure,"ax",@progbits
	.global calib_lo_power_measure
calib_lo_power_measure:
	.global L_8d3f40
L_8d3f40:
	push_s blink
L_8d3f42:
	bl L_8c02ac
L_8d3f46:
	sub_s sp,sp,0xc
L_8d3f48:
	mov_s r17,r0
L_8d3f4a:
	cmp_s r0,0x3f
L_8d3f4c:
	mov_s r16,r1
L_8d3f4e:
	mov_s r14,r2
L_8d3f50:
	ble_s L_8d3f5e
L_8d3f52:
	mov_s r2,sp
L_8d3f54:
	mov_s r0,r16
L_8d3f56:
	bl.d L_8d3dcc
L_8d3f5a:
	mov_s r1,r14
L_8d3f5c:
	b_s L_8d3fe0
	.global L_8d3f5e
L_8d3f5e:
	mov_s r0,0x1
L_8d3f60:
	mov_s r18,r0
L_8d3f62:
	stb_s r0,[r14,0x5]
L_8d3f64:
	stb_s r0,[r14,0x4]
L_8d3f66:
	ldb_s r0,[gp,0x8f]
L_8d3f68:
	mov_s r15,0x0
L_8d3f6a:
	add r20,r0,0x2
L_8d3f6e:
	extb r20,r20
L_8d3f72:
	mov_s r0,r15
L_8d3f74:
	bl.d L_8cc674
L_8d3f78:
	mov_s r1,r15
L_8d3f7a:
	mov_s r0,0x1
L_8d3f7c:
	bl.d L_8cc674
L_8d3f80:
	mov_s r1,r17
L_8d3f82:
	mov_s r13,r15
L_8d3f84:
	mov_s r19,r15
L_8d3f86:
	b_s L_8d3fae
	.global L_8d3f88
L_8d3f88:
	mov_s r2,sp
L_8d3f8a:
	mov_s r0,r16
L_8d3f8c:
	bl.d L_8d3dcc
L_8d3f90:
	mov_s r1,r14
L_8d3f92:
	ldb_s r1,[r14,0x5]
L_8d3f94:
	cmp_s r1,0x1
L_8d3f96:
	cmp.eq r15,0x0
L_8d3f9a:
	beq_s L_8d3fe6
L_8d3f9c:
	ldb_s r0,[r14,0x4]
L_8d3f9e:
	breq r0,0x1,L_8d4012
L_8d3fa2:
	cmp_s r1,0x1
L_8d3fa4:
	cmp.eq r15,0x1
L_8d3fa8:
	beq_s L_8d4012
L_8d3faa:
	breq r1,0x0,L_8d4040
	.global L_8d3fae
L_8d3fae:
	ldb_s r0,[r14,0x5]
L_8d3fb0:
	breq r0,0x1,L_8d3fba
L_8d3fb4:
	ldb_s r0,[r14,0x4]
L_8d3fb6:
	brne r0,0x1,L_8d3fbe
	.global L_8d3fba
L_8d3fba:
	breq r19,0x0,L_8d3f88
	.global L_8d3fbe
L_8d3fbe:
	brne r15,0x1,L_8d3fe0
L_8d3fc2:
	neg_s r3,r13
L_8d3fc4:
	sexb_s r3,r3
L_8d3fc6:
	mov_s r0,r17
L_8d3fc8:
	mov_s r1,0x1
L_8d3fca:
	bl.d L_8cca00
L_8d3fce:
	mov_s r2,0x0
L_8d3fd0:
	mov_s r0,0x0
L_8d3fd2:
	bl.d L_8cc674
L_8d3fd6:
	mov_s r1,0x0
L_8d3fd8:
	mov_s r0,0x1
L_8d3fda:
	bl.d L_8cc674
L_8d3fde:
	mov_s r1,r17
	.global L_8d3fe0
L_8d3fe0:
	b.d L_8c0304
L_8d3fe4:
	add_s sp,sp,0xc
	.global L_8d3fe6
L_8d3fe6:
	ld_s r0,[sp,0x0]
L_8d3fe8:
	add r1,r16,0x2
L_8d3fec:
	asr_s r0,r0,r1
L_8d3fee:
	sub r13,r20,r0
L_8d3ff2:
	sexb_s r13,r13
L_8d3ff4:
	mov_s r0,r17
L_8d3ff6:
	mov_s r1,0x1
L_8d3ff8:
	bl.d L_8cc834
L_8d3ffc:
	mov_s r2,0x0
L_8d3ffe:
	sub r1,r0,r13
L_8d4002:
	cmp r1,-0x1
L_8d4006:
	bne_s L_8d400c
L_8d4008:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d400a:
	sexb_s r13,r13
	.global L_8d400c
L_8d400c:
	sub_s r0,r0,r13
L_8d400e:
	brge r0,0x0,L_8d4018
	.global L_8d4012
L_8d4012:
	mov r19,0x1
L_8d4016:
	b_s L_8d3fae
	.global L_8d4018
L_8d4018:
	brlt r0,0x3,L_8d4020
L_8d401c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d401e:
	sexb_s r13,r13
	.global L_8d4020
L_8d4020:
	mov_s r0,r17
L_8d4022:
	mov_s r1,0x1
L_8d4024:
	mov_s r2,0x0
L_8d4026:
	bl.d L_8cca00
L_8d402a:
	mov_s r3,r13
L_8d402c:
	mov_s r0,0x0
L_8d402e:
	bl.d L_8cc674
L_8d4032:
	mov_s r1,0x0
L_8d4034:
	mov_s r0,0x1
L_8d4036:
	bl.d L_8cc674
L_8d403a:
	mov_s r1,r17
L_8d403c:
	mov_s r15,0x1
L_8d403e:
	b_s L_8d3fae
	.global L_8d4040
L_8d4040:
	brne r15,0x1,L_8d3fae
L_8d4044:
	ld_s r0,[r14]
L_8d4046:
	mov_s r1,0x0
L_8d4048:
	bset_s r1,r1,0xf
L_8d404a:
	cmp_s r0,0x0
L_8d404c:
	add.ge r0,r0,r1
L_8d4050:
	asr.ge r0,r0,0x10
L_8d4054:
	bge_s L_8d405c
L_8d4056:
	sub_s r1,r1,r0
L_8d4058:
	asr_s r1,r1,0x10
L_8d405a:
	neg_s r0,r1
	.global L_8d405c
L_8d405c:
	brge r0,0xfffffff1,L_8d3fae
L_8d4064:
	stb r18,[r14, 0x5]
L_8d4068:
	b_s L_8d4012
L_8d406a:
	nop_s
