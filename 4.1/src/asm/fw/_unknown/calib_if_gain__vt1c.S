/* calib_if_gain__vt1c @ 0x8c68e8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: hwf_if_gain_fin_est
 */
	.section .text.calib_if_gain__vt1c,"ax",@progbits
	.global calib_if_gain__vt1c
calib_if_gain__vt1c:
L_8c68e8:
	sub_s sp,sp,0x4
L_8c68ea:
	push_s blink
L_8c68ec:
	bl.d L_8d2d78
L_8c68f0:
	lsr r0,r1,0x14
L_8c68f4:
	pop_s blink
L_8c68f6:
	j_s.d [blink]
