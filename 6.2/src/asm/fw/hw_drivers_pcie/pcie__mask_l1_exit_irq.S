/* pcie__mask_l1_exit_irq @ 0x8d15fc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_18__pair
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__mask_l1_exit_irq
pcie__mask_l1_exit_irq:
	.global L_8d15fc
L_8d15fc:
	mov_s r0,0x882f80
L_8d1602:
	st 0x80000,[r0, 0x60]
L_8d160a:
	j_s [blink]
