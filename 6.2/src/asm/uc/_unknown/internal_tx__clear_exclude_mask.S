/* internal_tx__clear_exclude_mask @ 0x92ba48, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_isr
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__clear_exclude_mask
internal_tx__clear_exclude_mask:
	.global L_92ba48
L_92ba48:
	mov_s r1,0x0
L_92ba4a:
	mov_s r0,0x8006cc
L_92ba50:
	j_s.d [blink]
L_92ba52:
	st_s r1,[r0,0x8]
