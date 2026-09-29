/* stream_mgr__delba_handler @ 0x8c8c18, 252 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DELBA frame from STA %d for TID %d.
 *   DELBA frame from STA %d, stream_p == NULL
 *   Reason: %d. (36-LEAV,37-END_BA,38-UNKNWN_BA,39-T/O)
 *   stream_mgr::delba_handler AFTER DISCONNECTION
 *   DELBA -> DISCONNECT
 *   Initiator DELBA message - moved on thru Driver.
 *   <<---- [HOST EVENT] WMI_DELBA_EVENTID for midid %d.
 * Зовут его: stream_mgr__action
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, ba_sm_evt_type, conn__disconnect, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, fw_log_emit2, host_if__send_pair, low_sme__send_evt2sw, vring_tbl__find_by_tid_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__delba_handler
stream_mgr__delba_handler:
	.global L_8c8c18
L_8c8c18:
	push_s blink
L_8c8c1a:
	bl L_8c01d8
L_8c8c1e:
	mov_s r14,r0
L_8c8c20:
	mov_s r15,r1
L_8c8c22:
	ldb_s r0,[r0,0x3]
L_8c8c24:
	bl.d L_8cce44
L_8c8c28:
	lsr_s r0,r0,0x4
L_8c8c2a:
	mov_s r13,r0
L_8c8c2c:
	bl.d L_8cbffc
L_8c8c30:
	mov_s r0,r15
L_8c8c32:
	mov_s r16,r0
L_8c8c34:
	breq_s r13,0,L_8c8c48
L_8c8c36:
	mov_s r1,0x1010590
L_8c8c3c:
	mov_s r0,0x2b
L_8c8c3e:
	mov_s r2,r15
L_8c8c40:
	bl.d L_8dcc80
L_8c8c44:
	ldb_s r3,[r13,0x4]
L_8c8c46:
	b_s L_8c8c56
	.global L_8c8c48
L_8c8c48:
	mov_s r1,0x10105b4
L_8c8c4e:
	mov_s r0,0x2b
L_8c8c50:
	bl.d L_8dcc10
L_8c8c54:
	mov_s r2,r15
	.global L_8c8c56
L_8c8c56:
	mov_s r1,0x10105e0
L_8c8c5c:
	mov_s r0,0x2b
L_8c8c5e:
	bl.d L_8dcc10
L_8c8c62:
	ldw_s r2,[r14,0x4]
L_8c8c64:
	cmp_s r13,0x0
L_8c8c66:
	cmp.ne r16,0x0
L_8c8c6a:
	bne_s L_8c8c7a
L_8c8c6c:
	mov_s r1,0x1010614
L_8c8c72:
	bl.d L_8dcba8
L_8c8c76:
	mov_s r0,0x1b
L_8c8c78:
	b_s L_8c8d10
	.global L_8c8c7a
L_8c8c7a:
	ldb_s r0,[r13,0x7]
L_8c8c7c:
	brne r0,0x9,L_8c8c98
L_8c8c80:
	mov_s r1,0x1010644
L_8c8c86:
	bl.d L_8dcba8
L_8c8c8a:
	mov_s r0,0x2b
L_8c8c8c:
	mov_s r0,r16
L_8c8c8e:
	mov_s r1,0x3
L_8c8c90:
	bl.d L_8f2540
L_8c8c94:
	mov_s r2,r1
L_8c8c96:
	b_s L_8c8d10
	.global L_8c8c98
L_8c8c98:
	ldb_s r1,[r14,0x3]
L_8c8c9a:
	lsr r0,r1,0x3
L_8c8c9e:
	bmsk r17,r0,0x0
L_8c8ca2:
	mov_s r3,0x0
L_8c8ca4:
	bbit0 r1,0x3,L_8c8d02
L_8c8ca8:
	mov_s r1,0x1010658
L_8c8cae:
	bl.d L_8dcba8
L_8c8cb2:
	mov_s r0,0x2b
L_8c8cb4:
	bl.d L_8c32d8
L_8c8cb8:
	bmsk_s r15,r15,0x3
L_8c8cba:
	mov_s r13,r0
L_8c8cbc:
	ldb_s r0,[r14,0x3]
L_8c8cbe:
	stb r17,[r13, 0x1]
L_8c8cc2:
	lsr_s r0,r0,0x4
L_8c8cc4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c8cc6:
	or_s r15,r15,r0
L_8c8cc8:
	stb_s r15,[r13]
L_8c8cca:
	ldw_s r0,[r14,0x4]
L_8c8ccc:
	mov_s r1,0x1010688
L_8c8cd2:
	stw_s r0,[r13,0x2]
L_8c8cd4:
	ld r2,[r16, 0x18]
L_8c8cd8:
	mov_s r0,0x2b
L_8c8cda:
	bl.d L_8dcc10
L_8c8cde:
	ldb_s r2,[r2,0x10]
L_8c8ce0:
	ld r3,[r16, 0x18]
L_8c8ce4:
	mov_s r0,r13
L_8c8ce6:
	mov_s r1,0x1826
L_8c8cec:
	mov_s r2,0x4
L_8c8cee:
	ldb_s r3,[r3,0x10]
L_8c8cf0:
	mov r4,0x0
L_8c8cf4:
	mov r5,0x0
L_8c8cf8:
	bl.d L_8e5474
L_8c8cfc:
	mov r6,0x0
L_8c8d00:
	b_s L_8c8d10
	.global L_8c8d02
L_8c8d02:
	st_s r3,[r13,0x54]
L_8c8d04:
	ldw_s r2,[r14,0x4]
L_8c8d06:
	mov_s r0,r13
L_8c8d08:
	mov_s r1,0x5
L_8c8d0a:
	bl.d L_8d9c4c
L_8c8d0e:
	mov_s r4,r3
	.global L_8c8d10
L_8c8d10:
	b L_8c023c
