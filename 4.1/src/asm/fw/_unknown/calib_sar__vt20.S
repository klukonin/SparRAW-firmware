/* calib_sar__vt20 @ 0x8c6bc4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: calib_sar__enable_path
 */
	.section .text.calib_sar__vt20,"ax",@progbits
	.global calib_sar__vt20
calib_sar__vt20:
L_8c6bc4:
	sub_s sp,sp,0x4
L_8c6bc6:
	push_s blink
L_8c6bc8:
	mov_s r0,0x1
L_8c6bca:
	bl.d L_8d36b4
L_8c6bce:
	mov_s r1,r0
L_8c6bd0:
	pop_s blink
L_8c6bd2:
	j_s.d [blink]
