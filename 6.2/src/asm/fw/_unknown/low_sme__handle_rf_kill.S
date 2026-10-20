/* low_sme__handle_rf_kill @ 0x8cdb28, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::handle_rf_kill(is_graceful=%d)
 *   Setting m_termination_events[DISCONNECT]=1, m_termination_events=0x%x
 *   Setting m_termination_events[SCAN_ABORT]=1, m_termination_events=0x%x
 *   Setting m_termination_events[PCP_STOP]=2, m_termination_events=0x%x
 * Зовут его: rf_mgmt_sm__action_8c8fcc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, l2_mgr__pcp_stop, l2_mgr__scan_abort, mid__state_is_2_or_3, mid_list__by_mid_fw, vring_schd__disconnect_notify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__handle_rf_kill
low_sme__handle_rf_kill:
	.global L_8cdb28
L_8cdb28:
	push_s blink
L_8cdb2a:
	bl L_8c01e0
L_8cdb2e:
	mov_s r15,r0
L_8cdb30:
	mov_s r1,0x100b874
L_8cdb36:
	mov_s r0,0x20
L_8cdb38:
	bl.d L_8dcc10
L_8cdb3c:
	mov_s r2,r15
L_8cdb3e:
	ld_s r0,[gp,-0xc]
L_8cdb40:
	mov_s r1,0x100b89c
L_8cdb46:
	bset r2,r0,0x0
L_8cdb4a:
	st.as r2,[gp,-0x3]
L_8cdb4e:
	bl.d L_8dcc10
L_8cdb52:
	mov_s r0,0x20
L_8cdb54:
	bl.d L_8c91b8
L_8cdb58:
	mov_s r0,r15
L_8cdb5a:
	ld_s r0,[gp,-0xc]
L_8cdb5c:
	mov_s r1,0x100b8e4
L_8cdb62:
	bset r2,r0,0x1
L_8cdb66:
	st.as r2,[gp,-0x3]
L_8cdb6a:
	bl.d L_8dcc10
L_8cdb6e:
	mov_s r0,0x20
L_8cdb70:
	bl.d L_8e4588
L_8cdb74:
	mov_s r14,0x0
L_8cdb76:
	b_s L_8cdbaa
	.global L_8cdb78
L_8cdb78:
	bl.d L_8cc3dc
L_8cdb7c:
	mov_s r0,r14
L_8cdb7e:
	mov.f r13,r0
L_8cdb82:
	beq_s L_8cdba8
L_8cdb84:
	bl.d L_8da488
L_8cdb88:
	ldb_s r0,[r13,0x10]
L_8cdb8a:
	breq_s r0,0,L_8cdba8
L_8cdb8c:
	ld_s r0,[gp,-0xc]
L_8cdb8e:
	mov_s r1,0x100b92c
L_8cdb94:
	bset r2,r0,0x2
L_8cdb98:
	st.as r2,[gp,-0x3]
L_8cdb9c:
	bl.d L_8dcc10
L_8cdba0:
	mov_s r0,0x20
L_8cdba2:
	bl.d L_8f7160
L_8cdba6:
	ldb_s r0,[r13,0x10]
	.global L_8cdba8
L_8cdba8:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8cdbaa
L_8cdbaa:
	brlt r14,0x1,L_8cdb78
L_8cdbae:
	b L_8c024c
L_8cdbb2:
	nop_s
