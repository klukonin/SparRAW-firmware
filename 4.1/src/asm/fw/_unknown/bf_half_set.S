/* bf_half_set @ 0x8e8938, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_h_s0_w12, bf_h_s0_w2, bf_h_s0_w3, bf_h_s0_w4, bf_h_s2_w2, bf_h_s4_w2, bf_h_s4_w4, bf_h_s4_w5, bf_h_s5_w2, bf_h_s8_w2
 * Зовёт сам: bf_insert
 */
	.section .text.bf_half_set,"ax",@progbits
	.global bf_half_set
bf_half_set:
	.global L_8e8938
L_8e8938:
	push_s r12
L_8e893a:
	push_s blink
L_8e893c:
	bl.d L_8e8868
L_8e8940:
	ldw_s r12,[r0]
L_8e8942:
	stw_s r12,[r0]
L_8e8944:
	ld.ab blink,[sp,0x4]
L_8e8948:
	j_s.d [blink]
L_8e894a:
	pop_s r12
