/* lo_power_calib__get_param_d0 @ 0x8cc390, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg
 * Глобалы (через gp): 0x800254
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lo_power_calib__get_param_d0
lo_power_calib__get_param_d0:
	.global L_8cc390
L_8cc390:
	j_s.d [blink]
L_8cc392:
	ldb_s r0,[gp,0xd0]
