/* calib_silent_rssi_sparrow__set_agc_start_val @ 0x8ea8d8, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_silent_rssi_sparrow::set_agc_start_val(): rf_modules_num=%d must be in [1,%d] range. agc_start_val_omni=%d
 *   silent_rssi: update_agc_gains(): agc_start_omni %d, agc_start_direct %d
 * Зовут его: calibrate_baseband_gain, if_gain, maintain_ctx__set_field_9c
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, hwd_phy__uses_rgf_883100, silent_rssi__report_agc_tables, silent_rssi__set_agc_search_window
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi_sparrow__set_agc_start_val
calib_silent_rssi_sparrow__set_agc_start_val:
	.global L_8ea8d8
L_8ea8d8:
	push_s blink
L_8ea8da:
	bl L_8c01dc
L_8ea8de:
	sub_s sp,sp,0x8
L_8ea8e0:
	mov_s r13,r0
L_8ea8e2:
	mov_s r16,r1
L_8ea8e4:
	brlt.d r2,0x1,L_8ea918
L_8ea8e8:
	mov_s r14,r2
L_8ea8ea:
	brge r14,0x9,L_8ea918
	.global L_8ea8ee
L_8ea8ee:
	mov_s r0,0x8042c8
L_8ea8f4:
	ld r0,[r0,0x468]
L_8ea8fc:
	st r16,[r13, 0x38]
L_8ea900:
	brne r0,0x3,L_8ea93a
L_8ea904:
	mov_s r0,0x800508
L_8ea90a:
	ldb_s r3,[r0]
L_8ea90c:
	ldb.x r0,[gp, 0xc2]
L_8ea910:
	sub_s r3,r3,0xb
L_8ea912:
	add_s r3,r3,r0
L_8ea914:
	st_s r3,[r13,0x3c]
L_8ea916:
	b_s L_8ea972
	.global L_8ea918
L_8ea918:
	mov_s r1,0x1009468
L_8ea91e:
	mov_s r0,0x0
L_8ea920:
	mov_s r2,r14
L_8ea922:
	mov_s r3,0x8
L_8ea924:
	bl.d L_8dcd00
L_8ea928:
	mov r4,r16
L_8ea92c:
	mov_s r0,blink
L_8ea92e:
	mov_s r1,0x145c
L_8ea934:
	bl L_8c9b28
L_8ea938:
	b_s L_8ea8ee
	.global L_8ea93a
L_8ea93a:
	cmp_s r0,0x2
L_8ea93c:
	cmp.ne r0,0x1
L_8ea940:
	bne_s L_8ea96c
L_8ea942:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8ea944:
	sexb_s r14,r14
L_8ea946:
	cmp_s r14,0x0
L_8ea948:
	mov.lt r14,0x0
L_8ea94c:
	blt_s L_8ea952
L_8ea94e:
	min r14,r14,0x7
	.global L_8ea952
L_8ea952:
	mov_s r0,0x802224
L_8ea958:
	ld_s r1,[r0]
L_8ea95a:
	ld_s r0,[r0,0x4]
L_8ea95c:
	st_s r1,[sp,0x0]
L_8ea95e:
	st_s r0,[sp,0x4]
L_8ea960:
	ldb r0,[sp,r14]
L_8ea964:
	sub r3,r16,r0
L_8ea968:
	st_s r3,[r13,0x3c]
L_8ea96a:
	b_s L_8ea972
	.global L_8ea96c
L_8ea96c:
	st r16,[r13, 0x3c]
L_8ea970:
	mov_s r3,r16
	.global L_8ea972
L_8ea972:
	mov_s r1,0x10094dc
L_8ea978:
	mov_s r0,0x26
L_8ea97a:
	bl.d L_8dcc80
L_8ea97e:
	mov_s r2,r16
L_8ea980:
	add3 r14,r13,0x14
L_8ea984:
	ldb r4,[r14, 0x1b]
L_8ea988:
	ldb r0,[r13, 0x38]
L_8ea98c:
	ldb_s r1,[r14,0x18]
L_8ea98e:
	ldb_s r2,[r14,0x19]
L_8ea990:
	bl.d L_8d2568
L_8ea994:
	ldb_s r3,[r14,0x1a]
L_8ea996:
	st_s r0,[r13,0x40]
L_8ea998:
	ldb r4,[r14, 0x1b]
L_8ea99c:
	ldb r0,[r13, 0x3c]
L_8ea9a0:
	ldb_s r1,[r14,0x18]
L_8ea9a2:
	ldb_s r2,[r14,0x19]
L_8ea9a4:
	bl.d L_8d2568
L_8ea9a8:
	ldb_s r3,[r14,0x1a]
L_8ea9aa:
	st_s r0,[r13,0x44]
L_8ea9ac:
	ld_s r0,[r13,0x38]
L_8ea9ae:
	bl.d L_8d49d0
L_8ea9b2:
	ld_s r1,[r13,0x40]
L_8ea9b4:
	bl L_8dbec8
L_8ea9b8:
	b.d L_8c0244
L_8ea9bc:
	add_s sp,sp,0x8
L_8ea9be:
	nop_s
	.global L_8ea9c0
L_8ea9c0:
	j_s.d [blink]
L_8ea9c2:
	st r1,[r0, 0x9c]
L_8ea9c6:
	nop_s
