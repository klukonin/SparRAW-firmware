/* sta_psc_sm__m_psc_req_tx_wb_timeout_event @ 0x8c5c74, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::m_psc_req_tx_wb_timeout_event delete pending TO.
 * Зовут его: PS_CONNECTION_MGR__psc_req_tx_wb_cb, sta_psc_sm__on_close, sta_psc_sm__psc_done_sm
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, u_schd__cancel
 */
	.section .text.sta_psc_sm__m_psc_req_tx_wb_timeout_event,"ax",@progbits
	.global sta_psc_sm__m_psc_req_tx_wb_timeout_event
sta_psc_sm__m_psc_req_tx_wb_timeout_event:
	.global L_8c5c74
L_8c5c74:
	push_s blink
L_8c5c76:
	push_s r13
L_8c5c78:
	mov_s r13,r0
L_8c5c7a:
	ld_s r0,[r0,0x2c]
L_8c5c7c:
	breq_s r0,0,L_8c5c92
L_8c5c7e:
	mov_s r2,0x1002fb8
L_8c5c84:
	mov_s r0,0xe
L_8c5c86:
	bl.d L_8edfb0
L_8c5c8a:
	mov_s r1,0x2
L_8c5c8c:
	bl.d L_8c7794
L_8c5c90:
	ld_s r0,[r13,0x2c]
	.global L_8c5c92
L_8c5c92:
	mov_s r0,0x0
L_8c5c94:
	b.d L_8c033c
L_8c5c98:
	st_s r0,[r13,0x2c]
L_8c5c9a:
	nop_s
