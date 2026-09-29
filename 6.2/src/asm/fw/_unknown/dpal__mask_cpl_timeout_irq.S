/* dpal__mask_cpl_timeout_irq @ 0x8f6b4c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dpal__cpl_timeout_log
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dpal__mask_cpl_timeout_irq
dpal__mask_cpl_timeout_irq:
	.global L_8f6b4c
L_8f6b4c:
	mov_s r0,0x882680
L_8f6b52:
	st 0x1000,[r0, 0x1c]
L_8f6b5a:
	j_s [blink]
