/* calib_bb_gain_dc__vt20 @ 0x8c6c14, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: tail_hwf_calib__release_hw
 */
	.section .text.calib_bb_gain_dc__vt20,"ax",@progbits
	.global calib_bb_gain_dc__vt20
calib_bb_gain_dc__vt20:
L_8c6c14:
	sub_s sp,sp,0x4
L_8c6c16:
	push_s blink
L_8c6c18:
	bl.d L_8d1f28
L_8c6c1c:
	lsr r0,r1,0x14
L_8c6c20:
	pop_s blink
L_8c6c22:
	j_s.d [blink]
