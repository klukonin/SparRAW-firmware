/* calib__log_if_nonzero @ 0x8d6b20, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: hwf_calib__release_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__log_if_nonzero
calib__log_if_nonzero:
	.global L_8d6b20
L_8d6b20:
	cmp_s r1,0x0
L_8d6b22:
	push_s blink
L_8d6b24:
	bl.ne L_8d64c0
L_8d6b28:
	pop_s blink
L_8d6b2a:
	j_s [blink]
