/* rx_api__drain_all_lists @ 0x8e6c60, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__configure_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, rx_api__drain_list, rx_buf__alloc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_api__drain_all_lists
rx_api__drain_all_lists:
	.global L_8e6c60
L_8e6c60:
	push_s blink
L_8e6c62:
	bl L_8c01e0
L_8e6c66:
	mov_s r15,r0
L_8e6c68:
	ld_s r13,[r0]
L_8e6c6a:
	ld_s r0,[r0,0x4]
L_8e6c6c:
	brlo.d r0,0x1,L_8e6c98
L_8e6c70:
	mov_s r14,0x0
	.global L_8e6c72
L_8e6c72:
	/* bl.d 0x008c3394 */
	.byte 0x26,0x0f,0x2f,0xee
L_8e6c76:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e6c78:
	mov_s r1,0x806000
L_8e6c7e:
	ld_s r1,[r1,0x8]
L_8e6c80:
	sub r3,r1,0x38
L_8e6c84:
	bmsk r1,r0,0x11
L_8e6c88:
	mov_s r0,r13
L_8e6c8a:
	bl.d L_8e39dc
L_8e6c8e:
	mov_s r2,0x0
L_8e6c90:
	ld_s r0,[r15,0x4]
L_8e6c92:
	brlo.d r14,r0,L_8e6c72
L_8e6c96:
	add_s r13,r13,0x20
	.global L_8e6c98
L_8e6c98:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e6c9a:
	b.d L_8c024c
L_8e6c9e:
	st_s r0,[r15,0xc]
L_8e6ca0:
	sub_s sp,sp,0x8
L_8e6ca2:
	push_s blink
L_8e6ca4:
	bl.d L_8c01e0
L_8e6ca8:
	mov_s r8,r3
L_8e6caa:
	sub_s sp,sp,0x28
L_8e6cac:
	mov_s r15,r2
L_8e6cae:
	mov_s r14,r5
L_8e6cb0:
	mov_s r13,r6
L_8e6cb2:
	mov_s r3,r7
L_8e6cb4:
	mov_s r2,0x0
L_8e6cb6:
	add_s r0,r0,0x28
L_8e6cb8:
	cmp_s r1,0x0
L_8e6cba:
	mov_s r1,0x8
L_8e6cbc:
	beq_s L_8e6cda
L_8e6cbe:
	st r8,[sp, 0x18]
L_8e6cc2:
	st r4,[sp, 0x1c]
L_8e6cc6:
	st_s r14,[sp,0x20]
L_8e6cc8:
	st_s r13,[sp,0xc]
L_8e6cca:
	st_s r2,[sp,0x8]
L_8e6ccc:
	st_s r15,[sp,0x0]
L_8e6cce:
	mov_s r1,0x1
L_8e6cd0:
	st_s r1,[sp,0x4]
L_8e6cd2:
	stb_s r3,[sp,0x24]
L_8e6cd4:
	mov_s r3,sp
L_8e6cd6:
	mov_s r1,r2
L_8e6cd8:
	mov_s r2,r3
	.global L_8e6cda
L_8e6cda:
	mov_s r3,0x0
L_8e6cdc:
	bl.d L_8d9b6c
L_8e6ce0:
	mov_s r4,r3
L_8e6ce2:
	mov_s r12,0xc
L_8e6ce4:
	b.d L_8c024e
L_8e6ce8:
	add_s sp,sp,0x28
L_8e6cea:
	nop_s
