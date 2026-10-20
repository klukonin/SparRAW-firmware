/* maintain_sm__action_8e2b9c @ 0x8e2b9c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, channels_switch__check_g800104, schedule_long_term_trigger
 * Глобалы (через gp): 0x80022a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8e2b9c
maintain_sm__action_8e2b9c:
	.global L_8e2b9c
L_8e2b9c:
	push_s blink
L_8e2b9e:
	bl L_8c01e4
L_8e2ba2:
	mov_s r13,r0
L_8e2ba4:
	ld_s r0,[gp,-0x80]
L_8e2ba6:
	breq_s r0,0,L_8e2bde
L_8e2ba8:
	mov_s r14,0x0
L_8e2baa:
	st.as r14,[gp,-0x20]
L_8e2bae:
	add r0,r13,0x2c
L_8e2bb2:
	mov_s r1,0x5
L_8e2bb4:
	mov_s r2,r14
L_8e2bb6:
	mov_s r3,r14
L_8e2bb8:
	bl.d L_8d9b6c
L_8e2bbc:
	mov_s r4,r14
L_8e2bbe:
	ld r0,[r13, 0x80]
L_8e2bc2:
	breq_s r0,0,L_8e2bd2
L_8e2bc4:
	ldb_s r1,[r13,0x19]
L_8e2bc6:
	mov_s r0,r13
L_8e2bc8:
	bl.d L_8e476c
L_8e2bcc:
	ld_s r2,[r13,0x78]
L_8e2bce:
	st r14,[r13, 0x80]
	.global L_8e2bd2
L_8e2bd2:
	ldb_s r0,[gp,0xa6]
L_8e2bd4:
	cmp_s r0,0x0
L_8e2bd6:
	bl.ne.d L_8e46f4
L_8e2bda:
	mov.ne r0,r13
	.global L_8e2bde
L_8e2bde:
	b L_8c0254
L_8e2be2:
	nop_s
