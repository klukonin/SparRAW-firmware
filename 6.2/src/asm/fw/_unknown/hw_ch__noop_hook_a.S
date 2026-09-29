/* hw_ch__noop_hook_a @ 0x8da78c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_ch__enable_once
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_ch__noop_hook_a
hw_ch__noop_hook_a:
	.global L_8da78c
L_8da78c:
	j_s [blink]
L_8da78e:
	nop_s
