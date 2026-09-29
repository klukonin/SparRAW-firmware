/* pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c @ 0x8c5c4c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::m_psc_resp_tx_wb_timeout_event delete pending TO.
 * Зовут его: PS_CONNECTION_MGR__psc_resp_tx_wb_cb, pcp_psc_sm__m_psc_resp_tx_wb_timeout_event, pcp_psc_sm__psc_done
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, u_schd__cancel
 */
	.section .text.pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c,"ax",@progbits
	.global pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c
pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c:
	.global L_8c5c4c
L_8c5c4c:
	push_s blink
L_8c5c4e:
	push_s r13
L_8c5c50:
	mov_s r13,r0
L_8c5c52:
	ld_s r0,[r0,0x2c]
L_8c5c54:
	breq_s r0,0,L_8c5c6a
L_8c5c56:
	mov_s r2,0x1003078
L_8c5c5c:
	mov_s r0,0x7
L_8c5c5e:
	bl.d L_8edfb0
L_8c5c62:
	mov_s r1,0x2
L_8c5c64:
	bl.d L_8c7794
L_8c5c68:
	ld_s r0,[r13,0x2c]
	.global L_8c5c6a
L_8c5c6a:
	mov_s r0,0x0
L_8c5c6c:
	b.d L_8c033c
L_8c5c70:
	st_s r0,[r13,0x2c]
L_8c5c72:
	nop_s
