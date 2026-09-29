/* pcp_psc_sm__m_psc_resp_tx_wb_timeout_event @ 0x8c69e8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::m_psc_resp_tx_wb_timeout_event delete pending TO.
 * Зовут его: pcp_psc_sm__action_8c69d0, pcp_psc_sm__psc_done, psc_if__psc_resp_tx_wb_cb
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__m_psc_resp_tx_wb_timeout_event
pcp_psc_sm__m_psc_resp_tx_wb_timeout_event:
	.global L_8c69e8
L_8c69e8:
	push_s blink
L_8c69ea:
	push_s r13
L_8c69ec:
	mov_s r13,r0
L_8c69ee:
	ld_s r0,[r0,0x8]
L_8c69f0:
	breq_s r0,0,L_8c6a04
L_8c69f2:
	mov_s r1,0x1002bc8
L_8c69f8:
	bl.d L_8dcba8
L_8c69fc:
	mov_s r0,0x27
L_8c69fe:
	bl.d L_8c8de0
L_8c6a02:
	ld_s r0,[r13,0x8]
	.global L_8c6a04
L_8c6a04:
	mov_s r0,0x0
L_8c6a06:
	b.d L_8c025c
L_8c6a0a:
	st_s r0,[r13,0x8]
