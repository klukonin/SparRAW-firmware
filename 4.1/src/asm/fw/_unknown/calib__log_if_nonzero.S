/* calib__log_if_nonzero @ 0x8d3dc0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_sar__vt18, hwf_calib_all
 * Зовёт сам: hwf_calib__release_hw
 */
	.section .text.calib__log_if_nonzero,"ax",@progbits
	.global calib__log_if_nonzero
calib__log_if_nonzero:
	.global L_8d3dc0
L_8d3dc0:
	cmp_s r1,0x0
L_8d3dc2:
	push_s blink
L_8d3dc4:
	bl.ne L_8d3738
L_8d3dc8:
	pop_s blink
L_8d3dca:
	j_s [blink]
