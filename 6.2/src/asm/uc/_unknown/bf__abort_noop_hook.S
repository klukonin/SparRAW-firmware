/* bf__abort_noop_hook @ 0x926ab0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__abort_noop_hook
bf__abort_noop_hook:
	.global L_926ab0
L_926ab0:
	j_s [blink]
L_926ab2:
	nop_s
