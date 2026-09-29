/* ba_sm__action_8e0d9c @ 0x8e0d9c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ba_sm__get_param_byte7, basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8e0d9c
ba_sm__action_8e0d9c:
	.global L_8e0d9c
L_8e0d9c:
	push_s blink
L_8e0d9e:
	bl.d L_8c01e4
L_8e0da2:
	mov_s r6,r1
L_8e0da4:
	mov_s r13,r0
L_8e0da6:
	mov_s r5,r2
L_8e0da8:
	mov_s r4,r3
L_8e0daa:
	add r14,r0,0x8
L_8e0dae:
	mov_s r0,r14
L_8e0db0:
	mov_s r1,0x0
L_8e0db2:
	mov_s r2,r6
L_8e0db4:
	bl.d L_8d9b6c
L_8e0db8:
	mov_s r3,r5
L_8e0dba:
	bl.d L_8cce9c
L_8e0dbe:
	mov_s r0,r13
L_8e0dc0:
	cmp_s r0,0x9
L_8e0dc2:
	mov.ne r0,r14
L_8e0dc6:
	mov.ne r1,0x1
L_8e0dca:
	sub_s.ne r2,r2,r2
L_8e0dcc:
	sub_s.ne r3,r3,r3
L_8e0dce:
	bl.ne.d L_8d9b6c
L_8e0dd2:
	sub.ne r4,r4,r4
L_8e0dd6:
	b L_8c0254
L_8e0dda:
	nop_s
