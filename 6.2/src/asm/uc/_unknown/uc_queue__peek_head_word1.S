/* uc_queue__peek_head_word1 @ 0x927f64, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_queue__dispatch_and_commit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_queue__peek_head_word1
uc_queue__peek_head_word1:
	.global L_927f64
L_927f64:
	ld_s r0,[r0]
L_927f66:
	j_s.d [blink]
L_927f68:
	ld_s r0,[r0,0x4]
L_927f6a:
	nop_s
