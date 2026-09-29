/* mlme_sm_802458__action_8c7e88 @ 0x8c7e88, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   NEW_STA event handler
 *   injecting assoc_response event
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0, l2mgr__send_disconnect_evt, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8c7e88
mlme_sm_802458__action_8c7e88:
	.global L_8c7e88
L_8c7e88:
	push_s blink
L_8c7e8a:
	bl L_8c01e0
L_8c7e8e:
	mov_s r13,r0
L_8c7e90:
	mov_s r15,r1
L_8c7e92:
	mov_s r1,0x1011954
L_8c7e98:
	bl.d L_8dcba8
L_8c7e9c:
	mov_s r0,0x2a
L_8c7e9e:
	ld_s r0,[r13,0x18]
L_8c7ea0:
	breq_s r0,0,L_8c7ec6
L_8c7ea2:
	bl.d L_8c8de0
L_8c7ea6:
	mov_s r14,0x0
L_8c7ea8:
	st_s r14,[r13,0x18]
L_8c7eaa:
	mov_s r1,0x101196c
L_8c7eb0:
	bl.d L_8dcba8
L_8c7eb4:
	mov_s r0,0x2a
L_8c7eb6:
	mov_s r0,r13
L_8c7eb8:
	mov_s r1,0x4
L_8c7eba:
	mov_s r2,r14
L_8c7ebc:
	mov_s r3,r14
L_8c7ebe:
	bl.d L_8d9b6c
L_8c7ec2:
	mov_s r4,r14
L_8c7ec4:
	b_s L_8c7ed6
	.global L_8c7ec6
L_8c7ec6:
	ld_s r0,[r13,0x20]
L_8c7ec8:
	mov_s r1,0x1
L_8c7eca:
	ld_s r3,[r0,0x18]
L_8c7ecc:
	mov_s r0,r15
L_8c7ece:
	mov_s r2,0x6
L_8c7ed0:
	bl.d L_8e538c
L_8c7ed4:
	ldb_s r3,[r3,0x10]
	.global L_8c7ed6
L_8c7ed6:
	b L_8c024c
L_8c7eda:
	nop_s
