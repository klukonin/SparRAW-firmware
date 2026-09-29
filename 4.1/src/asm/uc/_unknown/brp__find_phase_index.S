/* brp__find_phase_index @ 0x921b58, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__flow_main
 */
	.section .text.brp__find_phase_index,"ax",@progbits
	.global brp__find_phase_index
brp__find_phase_index:
	.global L_921b58
L_921b58:
	push_s r13
L_921b5a:
	push_s r14
L_921b5c:
	mov_s r1,r0
L_921b5e:
	mov_s r13,0x0
L_921b60:
	mov_s r0,0x800a5c
L_921b66:
	add r3,r0,0x13
L_921b6a:
	b_s L_921b6e
	.global L_921b6c
L_921b6c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_921b6e
L_921b6e:
	brge.d r13,0xa,L_921b98
L_921b72:
	ldw.x.as r2,[r0,r1]
L_921b76:
	mov_s r14,0x800aa8
L_921b7c:
	ldw.x.as r14,[r14,r13]
L_921b80:
	brge r2,r14,L_921b6c
L_921b84:
	mov_s r0,0x800abc
L_921b8a:
	ldb.x r13,[r0,r13]
L_921b8e:
	ldb.x r0,[gp, -0xfa]
L_921b92:
	add_s r12,r3,r1
L_921b94:
	add_s r0,r0,r13
L_921b96:
	stb_s r0,[r12]
	.global L_921b98
L_921b98:
	asl_s r0,r1,0x4
L_921b9a:
	add3_s r0,r0,r0
L_921b9c:
	add_s r0,r0,0x854900
L_921ba2:
	ldb.x r1,[r3,r1]
L_921ba6:
	stw_s r2,[r0,0x14]
L_921ba8:
	stb_s r1,[r0,0x16]
L_921baa:
	pop_s r14
L_921bac:
	j_s.d [blink]
L_921bae:
	pop_s r13
