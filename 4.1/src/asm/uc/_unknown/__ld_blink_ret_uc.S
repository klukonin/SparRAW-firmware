/* __ld_blink_ret_uc @ 0x920294, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.__ld_blink_ret_uc,"ax",@progbits
	.global __ld_blink_ret_uc
__ld_blink_ret_uc:
L_920294:
	mov_s r12,0x4
L_920296:
	/* b_s 0x009202cc */
	.byte 0x1c,0xf0
