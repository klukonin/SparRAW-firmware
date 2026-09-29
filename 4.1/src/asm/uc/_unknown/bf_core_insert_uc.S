/* bf_core_insert_uc @ 0x937e84, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_b_core_uc, bf_rmw_half_uc, bf_rmw_word_unaligned_uc, bf_u16_core_uc, bf_w_core_uc
 */
	.section .text.bf_core_insert_uc,"ax",@progbits
	.global bf_core_insert_uc
bf_core_insert_uc:
	.global L_937e84
L_937e84:
	push_s r0
L_937e86:
	push_s r1
L_937e88:
	mov r0,-0x1
L_937e8c:
	bmsk r0,r0,r11
L_937e90:
	and_s r1,r1,r0
L_937e92:
	asl r0,r0,r10
L_937e96:
	asl r1,r1,r10
L_937e9a:
	bic r12,r12,r0
L_937e9e:
	or_s r12,r12,r1
L_937ea0:
	pop_s r1
L_937ea2:
	j_s.d [blink]
