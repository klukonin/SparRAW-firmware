/* calib_lo_power__step_save_mode @ 0x8dc64c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: calib_lo_power__step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_power__step_save_mode
calib_lo_power__step_save_mode:
	.global L_8dc64c
L_8dc64c:
	b.d L_8d5f78
L_8dc650:
	st.as r2,[gp,-0x22]
