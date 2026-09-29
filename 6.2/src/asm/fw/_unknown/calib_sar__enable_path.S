/* calib_sar__enable_path @ 0x8d6460, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_phy__rx_sar_cal_measurement_config, hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_sar__enable_path
calib_sar__enable_path:
	.global L_8d6460
L_8d6460:
	push_s blink
L_8d6462:
	push_s r13
L_8d6464:
	mov_s r13,r1
L_8d6466:
	cmp_s r0,0x0
L_8d6468:
	sub_s.ne r0,r0,r0
L_8d646a:
	mov.ne r1,r0
L_8d646e:
	mov.ne r2,0x1
L_8d6472:
	mov.ne r3,r0
L_8d6476:
	mov.ne r4,0x2000
L_8d647e:
	bl.ne.d L_8d28ec
L_8d6482:
	mov.ne r5,r0
L_8d6486:
	cmp_s r13,0x0
L_8d6488:
	bl.ne L_8d64c0
L_8d648c:
	b L_8c025c
