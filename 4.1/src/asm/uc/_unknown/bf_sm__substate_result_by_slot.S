/* bf_sm__substate_result_by_slot @ 0x922c88, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__substate_advance
 * Зовёт сам: __ld_r13_ret_uc, bf__enter_mode3
 */
	.section .text.bf_sm__substate_result_by_slot,"ax",@progbits
	.global bf_sm__substate_result_by_slot
bf_sm__substate_result_by_slot:
	.global L_922c88
L_922c88:
	push_s blink
L_922c8a:
	push_s r13
L_922c8c:
	mov_s r1,r0
L_922c8e:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_922c90:
	add1_s r0,r0,r0
L_922c92:
	mov_s r2,0x800ef8
L_922c98:
	ld_s r0,[r2,r0]
L_922c9a:
	mov_s r13,0x0
L_922c9c:
	breq_s r0,0,L_922caa
L_922c9e:
	breq r0,0x30,L_922cb8
L_922ca2:
	breq r0,0x31,L_922cbc
	.global L_922ca6
L_922ca6:
	mov_s r0,0x2
L_922ca8:
	b_s L_922ccc
	.global L_922caa
L_922caa:
	stb r13,[gp, -0xf8]
L_922cae:
	bl.d L_9218f4
L_922cb2:
	mov_s r0,0x9
L_922cb4:
	mov_s r0,r13
L_922cb6:
	b_s L_922ccc
	.global L_922cb8
L_922cb8:
	mov_s r0,0x1
L_922cba:
	b_s L_922ccc
	.global L_922cbc
L_922cbc:
	ldb_s r0,[gp,-0xf8]
L_922cbe:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922cc0:
	extb_s r0,r0
L_922cc2:
	brge.d r0,0x4,L_922ca6
L_922cc6:
	stb r0,[gp, -0xf8]
L_922cca:
	mov_s r0,0x4
	.global L_922ccc
L_922ccc:
	b L_92028c
