/* bf_word_set @ 0x8e8910, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_w_s0_w10, bf_w_s0_w12, bf_w_s0_w13, bf_w_s0_w2, bf_w_s0_w3, bf_w_s0_w4, bf_w_s0_w5, bf_w_s0_w6, bf_w_s0_w7, bf_w_s12_w12
 * Зовёт сам: bf_insert
 */
	.section .text.bf_word_set,"ax",@progbits
	.global bf_word_set
bf_word_set:
	.global L_8e8910
L_8e8910:
	push_s r12
L_8e8912:
	push_s blink
L_8e8914:
	bl.d L_8e8868
L_8e8918:
	ld_s r12,[r0]
L_8e891a:
	st_s r12,[r0]
L_8e891c:
	ld.ab blink,[sp,0x4]
L_8e8920:
	j_s.d [blink]
L_8e8922:
	pop_s r12
