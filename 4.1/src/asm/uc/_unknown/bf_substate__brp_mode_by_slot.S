/* bf_substate__brp_mode_by_slot @ 0x922cd0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__dispatch_by_state
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__reset_slot_table, brp__mode_step, stub_ret_93076c, stub_ret_937088
 */
	.section .text.bf_substate__brp_mode_by_slot,"ax",@progbits
	.global bf_substate__brp_mode_by_slot
bf_substate__brp_mode_by_slot:
	.global L_922cd0
L_922cd0:
	push_s blink
L_922cd2:
	push_s r13
L_922cd4:
	asl_s r1,r0,0x2
L_922cd6:
	add1_s r1,r1,r1
L_922cd8:
	mov_s r2,0x800ef8
L_922cde:
	ld_s r1,[r2,r1]
L_922ce0:
	breq_s r1,0,L_922cea
L_922ce2:
	breq r1,0x30,L_922cf6
L_922ce6:
	mov_s r13,0x2
L_922ce8:
	b_s L_922cf8
	.global L_922cea
L_922cea:
	bl.d L_93076c
L_922cee:
	mov_s r13,0x0
L_922cf0:
	bl L_922df8
L_922cf4:
	b_s L_922cf8
	.global L_922cf6
L_922cf6:
	mov_s r13,0x1
	.global L_922cf8
L_922cf8:
	breq_s r13,0,L_922d02
L_922cfa:
	bl L_937088
L_922cfe:
	bl L_928380
	.global L_922d02
L_922d02:
	b.d L_92028c
L_922d06:
	mov_s r0,r13
