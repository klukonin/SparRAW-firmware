/* calib__release_hw_thunk @ 0x8d4e04, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__release_hw_thunk
calib__release_hw_thunk:
	.global L_8d4e04
L_8d4e04:
	b L_8d64c0
