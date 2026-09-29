/* rf_mask__count_modules @ 0x8ccb04, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi__step, calib_silent_rssi_sparrow__run_calibration_fragment
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_mask__count_modules
rf_mask__count_modules:
	.global L_8ccb04
L_8ccb04:
	ldb_s r2,[r0,0x4]
L_8ccb06:
	mov_s r0,0x0
L_8ccb08:
	b_s L_8ccb12
	.global L_8ccb0a
L_8ccb0a:
	sub_s r1,r2,0x1
L_8ccb0c:
	and_s r2,r2,r1
L_8ccb0e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ccb10:
	extw_s r0,r0
	.global L_8ccb12
L_8ccb12:
	brne_s r2,0,L_8ccb0a
L_8ccb14:
	j_s.d [blink]
L_8ccb16:
	extb_s r0,r0
