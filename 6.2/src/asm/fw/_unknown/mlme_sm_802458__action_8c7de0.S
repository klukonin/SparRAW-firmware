/* mlme_sm_802458__action_8c7de0 @ 0x8c7de0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEL_STA event handler
 *   ctrl_del_sta_timeout_cb
 *   clearing disassoc pkt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, l2mgr__send_disconnect_evt, mem_pool__free_thunk, mgmt_pkt__release, mid__disconnect_cmd, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_802458__action_8c7de0
mlme_sm_802458__action_8c7de0:
	.global L_8c7de0
L_8c7de0:
	push_s blink
L_8c7de2:
	bl L_8c01e4
L_8c7de6:
	mov_s r13,r0
L_8c7de8:
	mov_s r14,r1
L_8c7dea:
	mov_s r1,0x10119f0
L_8c7df0:
	bl.d L_8dcba8
L_8c7df4:
	mov_s r0,0x2a
L_8c7df6:
	ld_s r0,[r13,0x1c]
L_8c7df8:
	breq_s r0,0,L_8c7e2a
L_8c7dfa:
	bl L_8c8de0
L_8c7dfe:
	ldw_s r0,[r13,0x2a]
L_8c7e00:
	mov_s r3,0x0
L_8c7e02:
	st_s r3,[r13,0x1c]
L_8c7e04:
	brne r0,0x8,L_8c7e1c
L_8c7e08:
	ld_s r2,[r13,0x30]
L_8c7e0a:
	st_s r3,[r13,0x30]
L_8c7e0c:
	mov_s r0,0x1
L_8c7e0e:
	stw_s r0,[r13,0x2a]
L_8c7e10:
	mov_s r0,r13
L_8c7e12:
	mov_s r1,0x2
L_8c7e14:
	bl.d L_8d9b6c
L_8c7e18:
	mov_s r4,r3
L_8c7e1a:
	b_s L_8c7e3a
	.global L_8c7e1c
L_8c7e1c:
	ld_s r1,[r13,0x20]
L_8c7e1e:
	mov_s r2,0x2
L_8c7e20:
	ld_s r0,[r1,0x18]
L_8c7e22:
	bl.d L_8c9360
L_8c7e26:
	ldw_s r3,[r14,0x6]
L_8c7e28:
	brne_s r0,0,L_8c7e3a
	.global L_8c7e2a
L_8c7e2a:
	ld_s r0,[r13,0x20]
L_8c7e2c:
	mov_s r1,0x1
L_8c7e2e:
	ld_s r0,[r0,0x18]
L_8c7e30:
	ldb_s r3,[r0,0x10]
L_8c7e32:
	mov_s r0,r14
L_8c7e34:
	bl.d L_8e538c
L_8c7e38:
	mov_s r2,0x2
	.global L_8c7e3a
L_8c7e3a:
	b L_8c0254
L_8c7e3e:
	nop_s
L_8c7e40:
	push_s blink
L_8c7e42:
	bl L_8c01e4
L_8c7e46:
	mov_s r13,r0
L_8c7e48:
	mov_s r1,0x10113e8
L_8c7e4e:
	bl.d L_8dcba8
L_8c7e52:
	mov_s r0,0x1a
L_8c7e54:
	mov_s r14,0x0
L_8c7e56:
	ld_s r1,[r13,0x20]
L_8c7e58:
	st_s r14,[r13,0x1c]
L_8c7e5a:
	ld_s r0,[r1,0x18]
L_8c7e5c:
	mov_s r2,0x2
L_8c7e5e:
	bl.d L_8c9360
L_8c7e62:
	mov_s r3,0x3
L_8c7e64:
	ld_s r0,[r13,0x30]
L_8c7e66:
	breq_s r0,0,L_8c7e82
L_8c7e68:
	mov_s r1,0x1011404
L_8c7e6e:
	bl.d L_8dcba8
L_8c7e72:
	mov_s r0,0x2a
L_8c7e74:
	bl.d L_8cb180
L_8c7e78:
	ld_s r0,[r13,0x30]
L_8c7e7a:
	bl.d L_8cb15c
L_8c7e7e:
	ld_s r0,[r13,0x30]
L_8c7e80:
	st_s r14,[r13,0x30]
	.global L_8c7e82
L_8c7e82:
	b.d L_8c0254
L_8c7e86:
	st_s r14,[r13,0xc]
