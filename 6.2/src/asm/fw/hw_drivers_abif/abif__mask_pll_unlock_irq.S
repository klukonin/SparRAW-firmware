/* abif__mask_pll_unlock_irq @ 0x8d00f4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__enable_pll
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__mask_pll_unlock_irq
abif__mask_pll_unlock_irq:
	.global L_8d00f4
L_8d00f4:
	mov_s r1,0x4
L_8d00f6:
	mov_s r0,0x889480
L_8d00fc:
	st_s r1,[r0]
L_8d00fe:
	j_s [blink]
