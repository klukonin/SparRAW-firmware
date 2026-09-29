/* internal_tx__noop_isr_hook @ 0x93783c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_isr
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__noop_isr_hook
internal_tx__noop_isr_hook:
	.global L_93783c
L_93783c:
	j_s [blink]
L_93783e:
	nop_s
