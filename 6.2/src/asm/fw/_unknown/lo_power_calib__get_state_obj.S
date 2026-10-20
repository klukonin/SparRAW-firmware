/* lo_power_calib__get_state_obj @ 0x8cc3a4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg
 * Глобалы (через gp): 0x800255
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lo_power_calib__get_state_obj
lo_power_calib__get_state_obj:
	.global L_8cc3a4
L_8cc3a4:
	j_s.d [blink]
L_8cc3a6:
	ldb_s r0,[gp,0xd1]
