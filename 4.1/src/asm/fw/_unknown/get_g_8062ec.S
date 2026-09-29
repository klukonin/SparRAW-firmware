/* get_g_8062ec @ 0x8df110, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion
 */
	.section .text.get_g_8062ec,"ax",@progbits
	.global get_g_8062ec
get_g_8062ec:
	.global L_8df110
L_8df110:
	mov_s r0,0x8062c4
L_8df116:
	j_s.d [blink]
L_8df118:
	ld_s r0,[r0,0x28]
L_8df11a:
	nop_s
