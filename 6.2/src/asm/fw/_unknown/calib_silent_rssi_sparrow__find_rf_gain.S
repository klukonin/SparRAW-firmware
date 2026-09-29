/* calib_silent_rssi_sparrow__find_rf_gain @ 0x8ca8fc, 444 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_silent_rssi_sparrow::find_rf_gain(): RF RX gain calibration reached limit of RX gain index
 * Зовут его: silent_rssi__calibrate_single_rf_module
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log_emit0, silent_rssi__hist_window_index, silent_rssi__load_params_a, silent_rssi__load_params_b, silent_rssi__set_rf_gain_index, u_schd__now, update_rf_xx_gains_tables
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi_sparrow__find_rf_gain
calib_silent_rssi_sparrow__find_rf_gain:
	.global L_8ca8fc
L_8ca8fc:
	push_s blink
L_8ca8fe:
	bl L_8c01c8
L_8ca902:
	mov_s r14,r0
L_8ca904:
	mov_s r17,r1
L_8ca906:
	add r1,r0,0x20
L_8ca90a:
	add r0,r1,r17
L_8ca90e:
	ldb_s r0,[r0,0x8]
L_8ca910:
	mov_s r16,r3
L_8ca912:
	stb.a r0,[sp,-0x4]
L_8ca916:
	add_s r1,r1,r17
L_8ca918:
	ldb_s r0,[r1,0x10]
L_8ca91a:
	add3 r21,r14,0x14
L_8ca91e:
	stb r0,[sp, 0x1]
L_8ca922:
	mov_s r0,0x800508
L_8ca928:
	ldb_s r1,[r0]
L_8ca92a:
	ldb.x r0,[r14, 0x4c]
L_8ca92e:
	add2 r13,r14,r17
L_8ca932:
	add r18,r0,r1
L_8ca936:
	extb r18,r18
L_8ca93a:
	stb r18,[r21, 0x1c]
L_8ca93e:
	mov r20,0x0
L_8ca942:
	mov_s r0,r14
L_8ca944:
	breq_s r2,0,L_8ca950
L_8ca946:
	bl L_8e62a4
L_8ca94a:
	ld_s r0,[r13,0x54]
L_8ca94c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ca94e:
	b_s L_8ca956
	.global L_8ca950
L_8ca950:
	bl L_8e7200
L_8ca954:
	mov_s r0,r20
	.global L_8ca956
L_8ca956:
	st_s r0,[r13,0x54]
L_8ca958:
	add3 r19,r14,0x10
L_8ca95c:
	ldw r0,[r19, 0x3e]
L_8ca960:
	bbit1 r0,0x1,L_8ca96c
L_8ca964:
	mov_s r0,0x8
L_8ca966:
	stb r0,[sp, 0x1]
L_8ca96a:
	stb_s r0,[sp,0x0]
	.global L_8ca96c
L_8ca96c:
	bl L_8e9524
L_8ca970:
	ldb r4,[sp]
L_8ca974:
	mov_s r0,r14
L_8ca976:
	ld r1,[r19, 0x54]
L_8ca97a:
	mov_s r3,0x0
L_8ca97c:
	ldb r2,[sp, 0x1]
L_8ca980:
	bl.d L_8c6c2c
L_8ca984:
	mov r5,0x1
L_8ca988:
	mov_s r0,r14
L_8ca98a:
	bl.d L_8dde0c
L_8ca98e:
	mov_s r1,r18
L_8ca990:
	sub r13,r0,r16
L_8ca994:
	sexb_s r13,r13
L_8ca996:
	b_s L_8ca99e
	.global L_8ca998
L_8ca998:
	add r20,r20,0x1
L_8ca99c:
	mov_s r13,r0
	.global L_8ca99e
L_8ca99e:
	ldb r0,[r21, 0x1f]
L_8ca9a2:
	brhs.d r20,r0,L_8caa30
L_8ca9a6:
	ldb r15,[sp, 0x1]
L_8ca9aa:
	brlt r13,0x1,L_8ca9fe
L_8ca9ae:
	add_s r0,r15,0x1
L_8ca9b0:
	min r1,r0,0xf
	.global L_8ca9b4
L_8ca9b4:
	sub.f r0,r1,r15
L_8ca9b8:
	mov.ne r0,0x1
L_8ca9bc:
	extb.f 0x0,r0
L_8ca9c0:
	beq_s L_8caa30
L_8ca9c2:
	extb_s r2,r1
L_8ca9c4:
	stb r1,[sp, 0x1]
L_8ca9c8:
	ldb r4,[sp]
L_8ca9cc:
	mov_s r0,r14
L_8ca9ce:
	ld r1,[r19, 0x54]
L_8ca9d2:
	mov_s r3,0x0
L_8ca9d4:
	bl.d L_8c6c2c
L_8ca9d8:
	mov r5,0x1
L_8ca9dc:
	mov_s r0,r14
L_8ca9de:
	bl.d L_8dde0c
L_8ca9e2:
	mov_s r1,r18
L_8ca9e4:
	sub r0,r0,r16
L_8ca9e8:
	sexb_s r0,r0
L_8ca9ea:
	brge r0,0x0,L_8ca9f2
L_8ca9ee:
	brge r13,0x1,L_8caa0a
	.global L_8ca9f2
L_8ca9f2:
	brlt r0,0x1,L_8ca9fa
L_8ca9f6:
	brlt r13,0x0,L_8caa0a
	.global L_8ca9fa
L_8ca9fa:
	brne_s r0,0,L_8ca998
L_8ca9fc:
	b_s L_8caa4c
	.global L_8ca9fe
L_8ca9fe:
	brge r13,0x0,L_8caa30
L_8caa02:
	sub_s r0,r15,0x1
L_8caa04:
	max r1,r0,0x1
L_8caa08:
	b_s L_8ca9b4
	.global L_8caa0a
L_8caa0a:
	abs_s r2,r13
L_8caa0c:
	abs_s r1,r0
L_8caa0e:
	brge r2,r1,L_8caa4c
L_8caa12:
	stb r15,[sp, 0x1]
L_8caa16:
	ldb r4,[sp]
L_8caa1a:
	mov_s r0,r14
L_8caa1c:
	ld r1,[r19, 0x54]
L_8caa20:
	mov_s r2,r15
L_8caa22:
	mov_s r3,0x0
L_8caa24:
	bl.d L_8c6c2c
L_8caa28:
	mov r5,0x1
	.global L_8caa2c
L_8caa2c:
	ldb r15,[sp, 0x1]
	.global L_8caa30
L_8caa30:
	ldb.x r1,[r14, 0x4d]
L_8caa34:
	sexb_s r0,r15
L_8caa36:
	add_s r0,r0,r1
L_8caa38:
	mov_s r1,0x857700
L_8caa3e:
	ld_s r1,[r1,0x68]
L_8caa40:
	sexb_s r0,r0
L_8caa42:
	brne r1,0x2,L_8caa50
L_8caa46:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8caa48:
	sexb_s r0,r0
L_8caa4a:
	b_s L_8caa62
	.global L_8caa4c
L_8caa4c:
	mov_s r13,r0
L_8caa4e:
	b_s L_8caa2c
	.global L_8caa50
L_8caa50:
	brne r1,0x3,L_8caa5a
L_8caa54:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_8caa56:
	sexb_s r0,r0
L_8caa58:
	b_s L_8caa62
	.global L_8caa5a
L_8caa5a:
	brne r1,0x4,L_8caa62
L_8caa5e:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_8caa60:
	sexb_s r0,r0
	.global L_8caa62
L_8caa62:
	max r0,r0,0x1
L_8caa66:
	min r0,r0,0xf
L_8caa6a:
	stb_s r0,[sp,0x0]
L_8caa6c:
	cmp_s r15,0x1
L_8caa6e:
	cmp.ne r15,0xf
L_8caa72:
	bne_s L_8caa80
L_8caa74:
	mov_s r1,0x1009ba4
L_8caa7a:
	bl.d L_8dcba8
L_8caa7e:
	mov_s r0,0x16
	.global L_8caa80
L_8caa80:
	abs_s r13,r13
L_8caa82:
	cmp_s r13,0x1
L_8caa84:
	mov_s r13,0x1
L_8caa86:
	sub.le r13,r13,r13
L_8caa8a:
	add r2,sp,0x1
L_8caa8e:
	mov_s r3,sp
L_8caa90:
	mov_s r0,r14
L_8caa92:
	bl.d L_8ed9cc
L_8caa96:
	mov_s r1,r17
L_8caa98:
	ldb r4,[sp]
L_8caa9c:
	mov_s r0,r14
L_8caa9e:
	ld r1,[r19, 0x54]
L_8caaa2:
	mov_s r3,0x0
L_8caaa4:
	ldb r2,[sp, 0x1]
L_8caaa8:
	bl.d L_8c6c2c
L_8caaac:
	mov_s r5,r3
L_8caaae:
	add_s r0,r13,0x1
L_8caab0:
	b.d L_8c021c
L_8caab4:
	add_s sp,sp,0x4
L_8caab6:
	nop_s
