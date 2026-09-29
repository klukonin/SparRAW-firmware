/* bf_byte_set @ 0x8e8924, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_b_s0_w2, bf_b_s0_w4, bf_b_s0_w5, bf_b_s0_w6, bf_b_s1_w3, bf_b_s2_w3, bf_b_s2_w4, bf_b_s2_w5, bf_b_s2_w6, bf_b_s4_w2
 * Зовёт сам: bf_insert
 */
	.section .text.bf_byte_set,"ax",@progbits
	.global bf_byte_set
bf_byte_set:
	.global L_8e8924
L_8e8924:
	push_s r12
L_8e8926:
	push_s blink
L_8e8928:
	bl.d L_8e8868
L_8e892c:
	ldb_s r12,[r0]
L_8e892e:
	stb_s r12,[r0]
L_8e8930:
	ld.ab blink,[sp,0x4]
L_8e8934:
	j_s.d [blink]
L_8e8936:
	pop_s r12
