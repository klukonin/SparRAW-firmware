/* psc_if__psc_resp_tx_wb_cb @ 0x8e1b70, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_if::psc_resp_tx_wb_cb. received WB after disconnect
 *   psc_if::psc_resp_tx_wb_cb, success:%d
 * Зовут его: ps_conn_mgr__psc_resp_tx_wb_cb
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, pcp_psc_sm__m_psc_resp_tx_wb_timeout_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global psc_if__psc_resp_tx_wb_cb
psc_if__psc_resp_tx_wb_cb:
	.global L_8e1b70
L_8e1b70:
	push_s blink
L_8e1b72:
	bl L_8c01e4
L_8e1b76:
	mov_s r14,r0
L_8e1b78:
	bl.d L_8c69e8
L_8e1b7c:
	mov_s r13,r2
L_8e1b7e:
	ld_s r0,[r14,0x44]
L_8e1b80:
	brne_s r0,0,L_8e1b90
L_8e1b82:
	mov_s r1,0x1002a34
L_8e1b88:
	bl.d L_8dcba8
L_8e1b8c:
	mov_s r0,0x2e
L_8e1b8e:
	b_s L_8e1bb2
	.global L_8e1b90
L_8e1b90:
	mov_s r1,0x1002a6c
L_8e1b96:
	cmp_s r13,0x0
L_8e1b98:
	mov_s r13,0x1
L_8e1b9a:
	sub_s.ne r13,r13,r13
L_8e1b9c:
	mov_s r0,0x2e
L_8e1b9e:
	bl.d L_8dcc10
L_8e1ba2:
	mov_s r2,r13
L_8e1ba4:
	mov_s r0,r14
L_8e1ba6:
	mov_s r1,0x2
L_8e1ba8:
	mov_s r2,r13
L_8e1baa:
	mov_s r3,0x0
L_8e1bac:
	bl.d L_8d9b6c
L_8e1bb0:
	mov_s r4,r3
	.global L_8e1bb2
L_8e1bb2:
	b L_8c0254
L_8e1bb6:
	nop_s
L_8e1bb8:
	push_s blink
L_8e1bba:
	push_s r13
L_8e1bbc:
	mov.f r13,r0
L_8e1bc0:
	beq_s L_8e1bd6
	.global L_8e1bc2
L_8e1bc2:
	mov_s r2,0x0
L_8e1bc4:
	st_s r2,[r13,0x8]
L_8e1bc6:
	mov_s r0,r13
L_8e1bc8:
	mov_s r1,0x3
L_8e1bca:
	mov_s r3,r2
L_8e1bcc:
	bl.d L_8d9b6c
L_8e1bd0:
	mov_s r4,r2
L_8e1bd2:
	b L_8c025c
	.global L_8e1bd6
L_8e1bd6:
	mov_s r0,blink
L_8e1bd8:
	mov_s r1,0x1427
L_8e1bde:
	bl L_8c9b28
L_8e1be2:
	b_s L_8e1bc2
