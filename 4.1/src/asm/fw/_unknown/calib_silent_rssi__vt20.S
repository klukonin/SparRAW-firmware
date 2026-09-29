/* calib_silent_rssi__vt20 @ 0x8c6c28, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwf_calib__release_hw
 */
	.section .text.calib_silent_rssi__vt20,"ax",@progbits
	.global calib_silent_rssi__vt20
calib_silent_rssi__vt20:
L_8c6c28:
	sub_s sp,sp,0x4
L_8c6c2a:
	push_s blink
L_8c6c2c:
	bl L_8d3738
L_8c6c30:
	pop_s blink
L_8c6c32:
	j_s.d [blink]
