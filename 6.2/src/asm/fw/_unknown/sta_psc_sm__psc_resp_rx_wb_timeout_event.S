/* sta_psc_sm__psc_resp_rx_wb_timeout_event @ 0x8c69ac, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::m_psc_resp_rx_wb_timeout_event delete pending TO.
 * Зовут его: sta_psc_sm__IDLE, sta_psc_sm__action_8c69d4, sta_psc_sm__psc_done_sm, sta_psc_sm__psc_req_tx_complete_8e19c0
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__psc_resp_rx_wb_timeout_event
sta_psc_sm__psc_resp_rx_wb_timeout_event:
	.global L_8c69ac
L_8c69ac:
	push_s blink
L_8c69ae:
	push_s r13
L_8c69b0:
	mov_s r13,r0
L_8c69b2:
	ld_s r0,[r0,0xc]
L_8c69b4:
	breq_s r0,0,L_8c69c8
L_8c69b6:
	mov_s r1,0x1002d94
L_8c69bc:
	bl.d L_8dcba8
L_8c69c0:
	mov_s r0,0x2e
L_8c69c2:
	bl.d L_8c8de0
L_8c69c6:
	ld_s r0,[r13,0xc]
	.global L_8c69c8
L_8c69c8:
	mov_s r0,0x0
L_8c69ca:
	b.d L_8c025c
L_8c69ce:
	st_s r0,[r13,0xc]
