/* bf_rmw_half_uc @ 0x937f54, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_s1_w1_uc
 * Зовёт сам: bf_core_insert_uc
 */
	.section .text.bf_rmw_half_uc,"ax",@progbits
	.global bf_rmw_half_uc
bf_rmw_half_uc:
	.global L_937f54
L_937f54:
	push_s r12
L_937f56:
	push_s blink
L_937f58:
	bl.d L_937e84
L_937f5c:
	ldw_s r12,[r0]
L_937f5e:
	stw_s r12,[r0]
L_937f60:
	ld.ab blink,[sp,0x4]
L_937f64:
	j_s.d [blink]
L_937f66:
	pop_s r12
