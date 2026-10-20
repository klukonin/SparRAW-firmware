/* bf_b_core_uc @ 0x937f40, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_b_s0_w5_uc, bf_b_s0_w7_uc
 * Зовёт сам: bf_core_insert_uc
 */
	.section .text.bf_b_core_uc,"ax",@progbits
	.global bf_b_core_uc
bf_b_core_uc:
	.global L_937f40
L_937f40:
	push_s r12
L_937f42:
	push_s blink
L_937f44:
	bl.d L_937e84
L_937f48:
	ldb_s r12,[r0]
L_937f4a:
	stb_s r12,[r0]
L_937f4c:
	ld.ab blink,[sp,0x4]
L_937f50:
	j_s.d [blink]
L_937f52:
	pop_s r12
