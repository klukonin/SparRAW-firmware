/* calib_bb_gain_dc__vt18 @ 0x8c6b70, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwf_calib__prepare_hw
 */
	.section .text.calib_bb_gain_dc__vt18,"ax",@progbits
	.global calib_bb_gain_dc__vt18
calib_bb_gain_dc__vt18:
L_8c6b70:
	sub_s sp,sp,0x4
L_8c6b72:
	push_s blink
L_8c6b74:
	bl.d L_8d1ebc
L_8c6b78:
	lsr r0,r1,0x14
L_8c6b7c:
	pop_s blink
L_8c6b7e:
	j_s.d [blink]
