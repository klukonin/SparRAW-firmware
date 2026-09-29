/* mlme_sm__association_timeout_ev_handle @ 0x8e9c54, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOCIATION TIMEOUT event.
 *   mlme_sm::association_timeout_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 * Зовёт сам: RADIO_MGR__remove_request, RADIO_MGR__unlock, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, mgmt_buf__free, mlme_notify, mlme_sm__send_disassoc
 */
	.section .text.mlme_sm__association_timeout_ev_handle,"ax",@progbits
	.global mlme_sm__association_timeout_ev_handle
mlme_sm__association_timeout_ev_handle:
L_8e9c54:
	push_s blink
L_8e9c56:
	bl.d L_8c02c0
L_8e9c5a:
	mov_s r1,0x2
L_8e9c5c:
	mov_s r14,r0
L_8e9c5e:
	mov_s r15,r3
L_8e9c60:
	mov_s r2,0x100f3e0
L_8e9c66:
	bl.d L_8edfb0
L_8e9c6a:
	mov_s r0,0xa
L_8e9c6c:
	mov_s r13,0x0
L_8e9c6e:
	ld_s r0,[r14,0x3c]
L_8e9c70:
	st_s r13,[r14,0x38]
L_8e9c72:
	ld_s r0,[r0,0xc]
L_8e9c74:
	ld_s r0,[r0,0x50]
L_8e9c76:
	cmp_s r0,0x1
L_8e9c78:
	mov_s r0,0x1
L_8e9c7a:
	sub_s.ne r0,r0,r0
L_8e9c7c:
	extb.f 0x0,r0
L_8e9c80:
	beq_s L_8e9c9c
L_8e9c82:
	mov_s r0,r14
L_8e9c84:
	mov_s r1,0x1
L_8e9c86:
	bl.d L_8ee7fc
L_8e9c8a:
	mov_s r2,r15
L_8e9c8c:
	ld_s r1,[r14,0x3c]
L_8e9c8e:
	mov_s r0,r14
L_8e9c90:
	ldb_s r1,[r1,0x8]
L_8e9c92:
	mov_s r2,0x1
L_8e9c94:
	mov_s r3,0x5
L_8e9c96:
	bl.d L_8da490
L_8e9c9a:
	mov_s r4,r13
	.global L_8e9c9c
L_8e9c9c:
	ld_s r0,[r14,0x48]
L_8e9c9e:
	st_s r13,[r14,0x30]
L_8e9ca0:
	breq_s r0,0,L_8e9ca8
L_8e9ca2:
	bl L_8c9538
L_8e9ca6:
	st_s r13,[r14,0x48]
	.global L_8e9ca8
L_8e9ca8:
	mov_s r2,0x100f3fc
L_8e9cae:
	ld r4,[r14, 0x2c]
L_8e9cb2:
	mov_s r0,0x0
L_8e9cb4:
	mov_s r1,0x2
L_8e9cb6:
	bl.d L_8edff8
L_8e9cba:
	ld_s r3,[r14,0x34]
L_8e9cbc:
	ld_s r3,[r14,0x34]
L_8e9cbe:
	breq_s r3,0,L_8e9cee
L_8e9cc0:
	ld_s r0,[r14,0x2c]
L_8e9cc2:
	breq_s r0,0,L_8e9cda
L_8e9cc4:
	mov_s r2,0x100f448
L_8e9cca:
	mov_s r0,0xc
L_8e9ccc:
	bl.d L_8edfcc
L_8e9cd0:
	mov_s r1,0x2
L_8e9cd2:
	bl.d L_8e54d8
L_8e9cd6:
	ld_s r0,[r14,0x34]
L_8e9cd8:
	b_s L_8e9cee
	.global L_8e9cda
L_8e9cda:
	mov_s r2,0x100f474
L_8e9ce0:
	mov_s r0,0xc
L_8e9ce2:
	bl.d L_8edfcc
L_8e9ce6:
	mov_s r1,0x2
L_8e9ce8:
	bl.d L_8de444
L_8e9cec:
	ld_s r0,[r14,0x34]
	.global L_8e9cee
L_8e9cee:
	st_s r13,[r14,0x34]
L_8e9cf0:
	b.d L_8c032c
