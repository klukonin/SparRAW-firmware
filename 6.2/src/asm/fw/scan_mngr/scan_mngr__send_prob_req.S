/* scan_mngr__send_prob_req @ 0x8f8bcc, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::send_prob_req() to:  ADDR-%04X%08X
 *   scan_mngr::send_prob_req() NEW prob_resp_timeout_event_id:%d , p_dband_info=0x%X
 *   [NNL] ++ m_active_probs=%d
 * Зовут его: scan_mngr__dband_beacon_ind, scan_mngr__handle_link_up_event
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, tx_probe__send_probe_req, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__send_prob_req
scan_mngr__send_prob_req:
	.global L_8f8bcc
L_8f8bcc:
	push_s blink
L_8f8bce:
	bl L_8c01e0
L_8f8bd2:
	sub_s sp,sp,0x14
L_8f8bd4:
	mov_s r13,r0
L_8f8bd6:
	ld_s r15,[r1,0x44]
L_8f8bd8:
	mov_s r14,r1
L_8f8bda:
	add_s r15,r15,0x1c
L_8f8bdc:
	ldw_s r2,[r14,0xc]
L_8f8bde:
	mov_s r1,0x1015748
L_8f8be4:
	mov_s r0,0x29
L_8f8be6:
	bl.d L_8dcc80
L_8f8bea:
	ld_s r3,[r14,0x8]
L_8f8bec:
	add r0,r14,0x8
L_8f8bf0:
	st_s r0,[sp,0x4]
L_8f8bf2:
	add r0,r14,0x10
L_8f8bf6:
	mov_s r3,0x1
L_8f8bf8:
	st_s r15,[sp,0x0]
L_8f8bfa:
	st_s r3,[sp,0x10]
L_8f8bfc:
	st_s r0,[sp,0x8]
L_8f8bfe:
	ldb r0,[r14, 0x30]
L_8f8c02:
	st_s r0,[sp,0xc]
L_8f8c04:
	ld_s r0,[r14,0x48]
L_8f8c06:
	brne_s r0,0,L_8f8c76
L_8f8c08:
	mov_s r0,0x3
L_8f8c0a:
	stb r0,[r14, 0x41]
L_8f8c0e:
	mov_s r0,L_8f7670-0x8c0000
L_8f8c14:
	mov_s r1,0x8004e4
L_8f8c1a:
	ld r4,[r1, 0x4]
L_8f8c1e:
	mov_s r1,r13
L_8f8c20:
	mov_s r2,r14
L_8f8c22:
	mov r5,0x0
L_8f8c26:
	bl.d L_8e0c0c
L_8f8c2a:
	mov r6,r5
L_8f8c2e:
	mov_s r2,r0
L_8f8c30:
	st_s r0,[r14,0x48]
L_8f8c32:
	mov_s r1,0x1015778
L_8f8c38:
	mov_s r0,0x29
L_8f8c3a:
	bl.d L_8dcc80
L_8f8c3e:
	mov_s r3,r14
L_8f8c40:
	bl L_8c3414
L_8f8c44:
	mov.f r15,r0
L_8f8c48:
	beq_s L_8f8c7c
	.global L_8f8c4a
L_8f8c4a:
	ld_s r1,[r13,0x7c]
L_8f8c4c:
	mov_s r3,sp
L_8f8c4e:
	mov r4,0x37aa8
L_8f8c56:
	mov_s r0,r15
L_8f8c58:
	bl.d L_8f8cf8
L_8f8c5c:
	ld_s r2,[r14,0x44]
L_8f8c5e:
	add r13,r13,0x200
L_8f8c62:
	ldb_s r2,[r13,0x15]
L_8f8c64:
	mov_s r1,0x10157cc
L_8f8c6a:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f8c6c:
	extb_s r2,r2
L_8f8c6e:
	stb_s r2,[r13,0x15]
L_8f8c70:
	bl.d L_8dcc10
L_8f8c74:
	mov_s r0,0x29
	.global L_8f8c76
L_8f8c76:
	b.d L_8c024c
L_8f8c7a:
	add_s sp,sp,0x14
	.global L_8f8c7c
L_8f8c7c:
	mov_s r0,blink
L_8f8c7e:
	mov_s r1,0x124d
L_8f8c84:
	bl L_8c9b28
L_8f8c88:
	b_s L_8f8c4a
L_8f8c8a:
	nop_s
