/* mlme_sm__assoc_reject_ev_handle @ 0x8f0eb4, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC REJECT event.
 *   mlme_sm::assoc_reject_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 * Зовёт сам: RADIO_MGR__remove_request, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, mgmt_pkt__release, mlme_notify, radio_mgr__call_method_10, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__assoc_reject_ev_handle
mlme_sm__assoc_reject_ev_handle:
	.global L_8f0eb4
L_8f0eb4:
	push_s blink
L_8f0eb6:
	bl L_8c01e0
L_8f0eba:
	mov_s r14,r0
L_8f0ebc:
	mov_s r13,r1
L_8f0ebe:
	mov_s r1,0x101168c
L_8f0ec4:
	bl.d L_8dcba8
L_8f0ec8:
	mov_s r0,0x2a
L_8f0eca:
	ld_s r0,[r14,0x14]
L_8f0ecc:
	mov_s r15,0x0
L_8f0ece:
	breq_s r0,0,L_8f0ed6
L_8f0ed0:
	bl L_8c8de0
L_8f0ed4:
	st_s r15,[r14,0x14]
	.global L_8f0ed6
L_8f0ed6:
	ld_s r2,[r14,0x10]
L_8f0ed8:
	mov_s r1,0x10116a0
L_8f0ede:
	mov_s r0,0x20
L_8f0ee0:
	bl.d L_8dcc80
L_8f0ee4:
	ld_s r3,[r14,0x8]
L_8f0ee6:
	ld_s r2,[r14,0x10]
L_8f0ee8:
	breq_s r2,0,L_8f0f14
L_8f0eea:
	ld_s r0,[r14,0x8]
L_8f0eec:
	breq_s r0,0,L_8f0f02
L_8f0eee:
	mov_s r1,0x101159c
L_8f0ef4:
	bl.d L_8dcc10
L_8f0ef8:
	mov_s r0,0x2c
L_8f0efa:
	bl.d L_8ea800
L_8f0efe:
	ld_s r0,[r14,0x10]
L_8f0f00:
	b_s L_8f0f14
	.global L_8f0f02
L_8f0f02:
	mov_s r1,0x10115c8
L_8f0f08:
	bl.d L_8dcc10
L_8f0f0c:
	mov_s r0,0x2c
L_8f0f0e:
	bl.d L_8e2798
L_8f0f12:
	ld_s r0,[r14,0x10]
	.global L_8f0f14
L_8f0f14:
	st_s r15,[r14,0x10]
L_8f0f16:
	ld_s r0,[r14,0x20]
L_8f0f18:
	st_s r15,[r14,0x8]
L_8f0f1a:
	ld_s r0,[r0,0x18]
L_8f0f1c:
	ld_s r0,[r0,0x50]
L_8f0f1e:
	cmp_s r0,0x1
L_8f0f20:
	mov_s r0,0x1
L_8f0f22:
	sub_s.ne r0,r0,r0
L_8f0f24:
	extb.f 0x0,r0
L_8f0f28:
	cmp.ne r13,0x0
L_8f0f2c:
	beq_s L_8f0f36
L_8f0f2e:
	st_s r13,[r14,0x2c]
L_8f0f30:
	bl.d L_8cb180
L_8f0f34:
	mov_s r0,r13
	.global L_8f0f36
L_8f0f36:
	ld_s r1,[r14,0x20]
L_8f0f38:
	mov_s r0,r14
L_8f0f3a:
	ldb_s r1,[r1,0x8]
L_8f0f3c:
	mov_s r2,0x1
L_8f0f3e:
	mov_s r3,0x5
L_8f0f40:
	bl.d L_8de394
L_8f0f44:
	mov r4,0x0
L_8f0f48:
	b L_8c024c
