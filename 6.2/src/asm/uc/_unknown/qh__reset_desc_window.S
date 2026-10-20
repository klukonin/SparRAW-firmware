/* qh__reset_desc_window @ 0x9246b0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq_desc__read_uc, macq_desc__write_uc, qh__pack_descriptor, qh__read_desc_window, qh__write_desc_window
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__reset_desc_window
qh__reset_desc_window:
	.global L_9246b0
L_9246b0:
	ldb r1,[gp, -0xde]
L_9246b4:
	cmp_s r1,0x0
L_9246b6:
	jne_s [blink]
L_9246b8:
	mov_s r0,0x0
L_9246ba:
	st r0,[0x886608]
L_9246c2:
	j_s [blink]
