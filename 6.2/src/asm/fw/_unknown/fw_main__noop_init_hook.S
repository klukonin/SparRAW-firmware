/* fw_main__noop_init_hook @ 0x8d9390, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_main__noop_init_hook
fw_main__noop_init_hook:
	.global L_8d9390
L_8d9390:
	j_s [blink]
L_8d9392:
	nop_s
