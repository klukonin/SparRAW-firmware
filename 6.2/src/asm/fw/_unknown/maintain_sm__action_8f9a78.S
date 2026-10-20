/* maintain_sm__action_8f9a78 @ 0x8f9a78, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, maintain_sm__release_radio_after_bf_evt, maintain_sm__reset_rate_params, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8f9a78
maintain_sm__action_8f9a78:
	.global L_8f9a78
L_8f9a78:
	push_s blink
L_8f9a7a:
	bl L_8c01e4
L_8f9a7e:
	mov_s r13,r0
L_8f9a80:
	mov_s r14,0x0
L_8f9a82:
	bl.d L_8f234c
L_8f9a86:
	st.as r14,[gp,-0x20]
L_8f9a8a:
	ld_s r0,[r13,0x1c]
L_8f9a8c:
	breq_s r0,0,L_8f9a94
L_8f9a8e:
	bl L_8c8de0
L_8f9a92:
	st_s r14,[r13,0x1c]
	.global L_8f9a94
L_8f9a94:
	ld_s r0,[r13,0x20]
L_8f9a96:
	breq_s r0,0,L_8f9a9e
L_8f9a98:
	bl L_8c8de0
L_8f9a9c:
	st_s r14,[r13,0x20]
	.global L_8f9a9e
L_8f9a9e:
	bl.d L_8e2520
L_8f9aa2:
	mov_s r0,r13
L_8f9aa4:
	add r0,r13,0x2c
L_8f9aa8:
	mov_s r1,0x3
L_8f9aaa:
	mov_s r2,0x0
L_8f9aac:
	mov_s r3,r2
L_8f9aae:
	bl.d L_8d9b6c
L_8f9ab2:
	mov_s r4,r2
L_8f9ab4:
	ld_s r0,[r13,0x8]
L_8f9ab6:
	mov_s r1,0x8
L_8f9ab8:
	mov_s r2,0x0
L_8f9aba:
	mov_s r3,r2
L_8f9abc:
	bl.d L_8d9b6c
L_8f9ac0:
	mov_s r4,r2
L_8f9ac2:
	b L_8c0254
L_8f9ac6:
	nop_s
