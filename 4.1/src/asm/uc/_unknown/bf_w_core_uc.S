/* bf_w_core_uc @ 0x937f2c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_w_s0_w2_uc, bf_w_s0_w4_uc, bf_w_s0_w6_uc, bf_w_s15_w6_uc, bf_w_s2_w2_uc, bf_w_s2_w4_uc, bf_w_s4_w3_uc, bf_w_s4_w4_uc, bf_w_s4_w5_uc, bf_w_s6_w2_uc
 * Зовёт сам: bf_core_insert_uc
 */
	.section .text.bf_w_core_uc,"ax",@progbits
	.global bf_w_core_uc
bf_w_core_uc:
	.global L_937f2c
L_937f2c:
	push_s r12
L_937f2e:
	push_s blink
L_937f30:
	bl.d L_937e84
L_937f34:
	ld_s r12,[r0]
L_937f36:
	st_s r12,[r0]
L_937f38:
	ld.ab blink,[sp,0x4]
L_937f3c:
	j_s.d [blink]
L_937f3e:
	pop_s r12
