/* sta_psc_sm__m_psc_resp_rx_wb_timeout_event @ 0x8c5c0c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::m_psc_resp_rx_wb_timeout_event delete pending TO.
 * Зовут его: sta_psc_sm__on_close, sta_psc_sm__psc_done_sm, sta_psc_sm__psc_req_tx_complete, sta_psc_sm__psc_resp_rx
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, u_schd__cancel
 */
	.section .text.sta_psc_sm__m_psc_resp_rx_wb_timeout_event,"ax",@progbits
	.global sta_psc_sm__m_psc_resp_rx_wb_timeout_event
sta_psc_sm__m_psc_resp_rx_wb_timeout_event:
	.global L_8c5c0c
L_8c5c0c:
	push_s blink
L_8c5c0e:
	push_s r13
L_8c5c10:
	mov_s r13,r0
L_8c5c12:
	ld_s r0,[r0,0x30]
L_8c5c14:
	breq_s r0,0,L_8c5c2a
L_8c5c16:
	mov_s r2,0x1002f78
L_8c5c1c:
	mov_s r0,0xe
L_8c5c1e:
	bl.d L_8edfb0
L_8c5c22:
	mov_s r1,0x2
L_8c5c24:
	bl.d L_8c7794
L_8c5c28:
	ld_s r0,[r13,0x30]
	.global L_8c5c2a
L_8c5c2a:
	mov_s r0,0x0
L_8c5c2c:
	b.d L_8c033c
