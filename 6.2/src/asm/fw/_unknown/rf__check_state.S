/* rf__check_state @ 0x8c74b4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Checking RF state: com_test=%d, RX_GAIN_RTYPE_TBL_[13]=0x%x (expected 0xc45)
 * Зовут его: calib_silent_rssi_sparrow__find_agc_start
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, hwd_rfc_read_rgf, rf_comm_test
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__check_state
rf__check_state:
	.global L_8c74b4
L_8c74b4:
	push_s blink
L_8c74b6:
	bl L_8c01e4
L_8c74ba:
	mov_s r13,0x8042c8
L_8c74c0:
	mov_s r0,r13
L_8c74c2:
	bl.d L_8c6a40
L_8c74c6:
	ldb_s r1,[r13]
L_8c74c8:
	mov_s r14,r0
L_8c74ca:
	ldb_s r0,[r13]
L_8c74cc:
	bl.d L_8d3588
L_8c74d0:
	mov r1,0x1b4
L_8c74d4:
	mov_s r3,r0
L_8c74d6:
	mov_s r1,0x1009f2c
L_8c74dc:
	mov_s r0,0x6
L_8c74de:
	bl.d L_8dcc80
L_8c74e2:
	mov_s r2,r14
L_8c74e4:
	b L_8c0254
