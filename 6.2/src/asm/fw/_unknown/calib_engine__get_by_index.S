/* calib_engine__get_by_index @ 0x8cbb84, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_obj4__reset_d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__get_by_index
calib_engine__get_by_index:
	.global L_8cbb84
L_8cbb84:
	mov_s r1,0x800da4
L_8cbb8a:
	j_s.d [blink]
L_8cbb8c:
	ld.as r0,[r1,r0]
