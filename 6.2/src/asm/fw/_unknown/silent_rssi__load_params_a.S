/* silent_rssi__load_params_a @ 0x8e7200, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__find_rf_gain, calibrate_baseband_gain
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global silent_rssi__load_params_a
silent_rssi__load_params_a:
	.global L_8e7200
L_8e7200:
	push_s r13
L_8e7202:
	add3 r1,r0,0x10
L_8e7206:
	ld_s r2,[r1,0x44]
L_8e7208:
	ldw_s r3,[r1,0x3e]
L_8e720a:
	bmsk r13,r2,0x0
L_8e720e:
	lsr_s r2,r2
L_8e7210:
	bclr_s r3,r3,0x0
L_8e7212:
	bmsk_s r2,r2,0x0
L_8e7214:
	or_s r3,r3,r13
L_8e7216:
	asl_s r2,r2
L_8e7218:
	bclr_s r3,r3,0x1
L_8e721a:
	or_s r2,r2,r3
L_8e721c:
	stw_s r2,[r1,0x3e]
L_8e721e:
	add3 r2,r0,0x18
L_8e7222:
	ldb_s r1,[r2,0x5]
L_8e7224:
	stb r1,[r0, 0xbf]
L_8e7228:
	ldw_s r0,[r2,0x6]
L_8e722a:
	stw_s r0,[r2]
L_8e722c:
	ldw_s r0,[r2,0x8]
L_8e722e:
	stw_s r0,[r2,0x2]
L_8e7230:
	j_s.d [blink]
L_8e7232:
	pop_s r13
