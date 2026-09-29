/* calib_if_gain__vt18 @ 0x8c6b5c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: calib_lo_power_step
 */
	.section .text.calib_if_gain__vt18,"ax",@progbits
	.global calib_if_gain__vt18
calib_if_gain__vt18:
L_8c6b5c:
	sub_s sp,sp,0x4
L_8c6b5e:
	push_s blink
L_8c6b60:
	bl.d L_8d2f38
L_8c6b64:
	lsr r0,r1,0x14
L_8c6b68:
	pop_s blink
L_8c6b6a:
	j_s.d [blink]
