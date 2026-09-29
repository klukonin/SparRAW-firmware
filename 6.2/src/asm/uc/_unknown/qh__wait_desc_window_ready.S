/* qh__wait_desc_window_ready @ 0x924480, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq_desc__read_uc, macq_desc__write_uc, qh__pack_descriptor, qh__read_desc_window, qh__write_desc_window
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__wait_desc_window_ready
qh__wait_desc_window_ready:
	.global L_924480
L_924480:
	ldb r1,[gp, -0xde]
L_924484:
	cmp_s r1,0x0
L_924486:
	jne_s [blink]
L_924488:
	mov r2,0x886800
	.global L_924490
L_924490:
	ld.as r0,[r2,-0x7e]
L_924494:
	btst_s r0,0x1f
L_924496:
	jeq_s [blink]
L_924498:
	b_s L_924490
L_92449a:
	nop_s
