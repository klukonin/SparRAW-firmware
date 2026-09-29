/* ucode_cmd08__noop_hook @ 0x937840, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x08_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd08__noop_hook
ucode_cmd08__noop_hook:
	.global L_937840
L_937840:
	j_s [blink]
L_937842:
	nop_s
