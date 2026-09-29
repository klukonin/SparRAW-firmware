/* silent_rssi__report_agc_tables @ 0x8dbec8, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__set_agc_start_val
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, agc__get_table_pair, bits__set32_s16_w4, calib_obj4__reset_d4, lmac_if__post_cmd, mem_pool__alloc_locked, rf__get_active_index, silent_rssi__agc_param_const_2, silent_rssi__agc_param_const_4, silent_rssi__bits_set32_s0_w6, silent_rssi__bits_set32_s12_w4
 * Глобалы (через gp): 0x8003c8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global silent_rssi__report_agc_tables
silent_rssi__report_agc_tables:
	.global L_8dbec8
L_8dbec8:
	push_s blink
L_8dbeca:
	bl L_8c01d8
L_8dbece:
	ld_s r0,[gp,0x244]
L_8dbed0:
	breq r0,0x0,L_8dbf7c
L_8dbed4:
	mov_s r0,0x804280
L_8dbeda:
	bl.d L_8c33d0
L_8dbede:
	mov_s r13,0x0
L_8dbee0:
	bl.d L_8cbb90
L_8dbee4:
	mov_s r14,r0
L_8dbee6:
	mov_s r17,r0
L_8dbee8:
	add r3,r14,0x8
L_8dbeec:
	mov_s r1,0x1
L_8dbeee:
	bl.d L_8cb804
L_8dbef2:
	mov_s r2,r14
L_8dbef4:
	add_s r2,r14,0x4
L_8dbef6:
	add r3,r14,0xc
L_8dbefa:
	mov_s r0,r17
L_8dbefc:
	bl.d L_8cb804
L_8dbf00:
	mov_s r1,r13
L_8dbf02:
	mov_s r15,0x8
	.global L_8dbf04
L_8dbf04:
	mov_s r0,r17
L_8dbf06:
	bl.d L_8ccb18
L_8dbf0a:
	mov_s r1,r13
L_8dbf0c:
	add r16,r14,r13
L_8dbf10:
	stb r0,[r16, 0x10]
L_8dbf14:
	mov_s r0,r17
L_8dbf16:
	bl.d L_8cca84
L_8dbf1a:
	mov_s r1,r13
L_8dbf1c:
	stb r0,[r16, 0x18]
L_8dbf20:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8dbf22:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8dbf24:
	brhs.d r15,0x1,L_8dbf04
L_8dbf28:
	extb_s r13,r13
L_8dbf2a:
	mov_s r0,0x8042c8
L_8dbf30:
	bl L_8ccb20
L_8dbf34:
	ld_s r1,[r14]
L_8dbf36:
	mov_s r16,r0
L_8dbf38:
	bmsk_s r1,r1,0x5
L_8dbf3a:
	mov_s r13,0x853880
L_8dbf40:
	add3 r0,r13,0xa
L_8dbf44:
	bl L_8ed388
L_8dbf48:
	mov_s r0,r17
L_8dbf4a:
	bl.d L_8ccb18
L_8dbf4e:
	mov_s r1,r16
L_8dbf50:
	bmsk r1,r0,0x3
L_8dbf54:
	add3 r0,r13,0xa
L_8dbf58:
	bl L_8ed3ac
L_8dbf5c:
	mov_s r0,r17
L_8dbf5e:
	bl.d L_8cca84
L_8dbf62:
	mov_s r1,r16
L_8dbf64:
	bmsk r1,r0,0x3
L_8dbf68:
	add3 r0,r13,0xa
L_8dbf6c:
	bl.d L_8ed3f4
L_8dbf70:
	mov_s r2,0x20
L_8dbf72:
	mov_s r0,r14
L_8dbf74:
	mov_s r1,0x11
L_8dbf76:
	bl.d L_8e5204
L_8dbf7a:
	mov_s r3,0x0
	.global L_8dbf7c
L_8dbf7c:
	b L_8c023c
