/* calib_if_gain__vt20 @ 0x8c6c00, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwf_calib__restore_path
 */
	.section .text.calib_if_gain__vt20,"ax",@progbits
	.global calib_if_gain__vt20
calib_if_gain__vt20:
L_8c6c00:
	sub_s sp,sp,0x4
L_8c6c02:
	push_s blink
L_8c6c04:
	bl.d L_8d3084
L_8c6c08:
	lsr r0,r1,0x14
L_8c6c0c:
	pop_s blink
L_8c6c0e:
	j_s.d [blink]
