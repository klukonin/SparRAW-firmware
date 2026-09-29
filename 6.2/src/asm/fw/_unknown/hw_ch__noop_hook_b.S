/* hw_ch__noop_hook_b @ 0x8da7fc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_ch__enable_once
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_ch__noop_hook_b
hw_ch__noop_hook_b:
	.global L_8da7fc
L_8da7fc:
	j_s [blink]
L_8da7fe:
	nop_s
