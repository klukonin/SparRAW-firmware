/* __ld_blink_ret @ 0x8c0344, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.__ld_blink_ret,"ax",@progbits
	.global __ld_blink_ret
__ld_blink_ret:
L_8c0344:
	mov_s r12,0x4
L_8c0346:
	/* b_s 0x008c037c */
	.byte 0x1c,0xf0
