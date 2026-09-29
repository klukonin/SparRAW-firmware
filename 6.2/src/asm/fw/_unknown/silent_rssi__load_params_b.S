/* silent_rssi__load_params_b @ 0x8e62a4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__find_rf_gain, calibrate_baseband_gain
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global silent_rssi__load_params_b
silent_rssi__load_params_b:
	.global L_8e62a4
L_8e62a4:
	push_s r13
L_8e62a6:
	push_s r14
L_8e62a8:
	add3 r3,r0,0x18
L_8e62ac:
	ldw_s r14,[r3,0xa]
L_8e62ae:
	add3 r13,r0,0x10
L_8e62b2:
	ldw_s r2,[r13,0x3e]
L_8e62b4:
	bmsk r1,r14,0x0
L_8e62b8:
	lsr_s r14,r14
L_8e62ba:
	bclr_s r2,r2,0x0
L_8e62bc:
	or_s r1,r1,r2
L_8e62be:
	bmsk_s r14,r14,0x0
L_8e62c0:
	bclr_s r1,r1,0x1
L_8e62c2:
	asl_s r14,r14
L_8e62c4:
	or_s r1,r1,r14
L_8e62c6:
	stw_s r1,[r13,0x3e]
L_8e62c8:
	ldb_s r1,[r3,0xb]
L_8e62ca:
	stb r1,[r0, 0xbf]
L_8e62ce:
	ldw_s r0,[r3,0xc]
L_8e62d0:
	stw_s r0,[r3]
L_8e62d2:
	ldw_s r0,[r3,0xe]
L_8e62d4:
	stw_s r0,[r3,0x2]
L_8e62d6:
	pop_s r14
L_8e62d8:
	j_s.d [blink]
L_8e62da:
	pop_s r13
