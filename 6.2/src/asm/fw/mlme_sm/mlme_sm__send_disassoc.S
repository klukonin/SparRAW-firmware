/* mlme_sm__send_disassoc @ 0x8f6bc0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send DISASSOC request  len %d
 * Зовут его: mlme_sm__association_timeout_ev_handle, mlme_sm__disconnect_ev_handle_8f26a8
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_sysassert_fatal, tx_api__send_mgmt, tx_mgmt_srvs__build_disassoc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__send_disassoc
mlme_sm__send_disassoc:
	.global L_8f6bc0
L_8f6bc0:
	push_s blink
L_8f6bc2:
	bl L_8c01dc
L_8f6bc6:
	mov_s r13,r0
L_8f6bc8:
	mov_s r15,r1
L_8f6bca:
	mov_s r16,r2
L_8f6bcc:
	mov_s r0,0x0
L_8f6bce:
	bl.d L_8c3414
L_8f6bd2:
	push_s r0
L_8f6bd4:
	mov.f r14,r0
L_8f6bd8:
	beq_s L_8f6c18
	.global L_8f6bda
L_8f6bda:
	ld_s r3,[r13,0x20]
L_8f6bdc:
	mov_s r1,sp
L_8f6bde:
	extw r4,r15
L_8f6be2:
	mov_s r0,r14
L_8f6be4:
	bl.d L_8e9c9c
L_8f6be8:
	ld_s r2,[r3,0x18]
L_8f6bea:
	ld_s r0,[sp,0x0]
L_8f6bec:
	breq_s r0,0,L_8f6c26
	.global L_8f6bee
L_8f6bee:
	mov_s r1,0x1011514
L_8f6bf4:
	mov_s r0,0x2a
L_8f6bf6:
	bl.d L_8dcc10
L_8f6bfa:
	ld_s r2,[sp,0x0]
L_8f6bfc:
	mov_s r1,0x0
L_8f6bfe:
	ldw r4,[sp]
L_8f6c02:
	mov_s r2,0x1
L_8f6c04:
	ld_s r0,[r13,0x20]
L_8f6c06:
	mov_s r3,r14
L_8f6c08:
	mov r5,r16
L_8f6c0c:
	bl.d L_8e5874
L_8f6c10:
	mov_s r6,r1
L_8f6c12:
	b.d L_8c0244
L_8f6c16:
	add_s sp,sp,0x4
	.global L_8f6c18
L_8f6c18:
	mov_s r0,blink
L_8f6c1a:
	mov_s r1,0x1201
L_8f6c20:
	bl L_8c9b28
L_8f6c24:
	b_s L_8f6bda
	.global L_8f6c26
L_8f6c26:
	mov_s r0,blink
L_8f6c28:
	mov_s r1,0x1202
L_8f6c2e:
	bl L_8c9b28
L_8f6c32:
	b_s L_8f6bee
