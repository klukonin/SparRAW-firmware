/* sta_psc_sm__on_close @ 0x8c5c38, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, sta_psc_sm__m_psc_req_tx_wb_timeout_event, sta_psc_sm__m_psc_resp_rx_wb_timeout_event
 */
	.section .text.sta_psc_sm__on_close,"ax",@progbits
	.global sta_psc_sm__on_close
sta_psc_sm__on_close:
L_8c5c38:
	push_s blink
L_8c5c3a:
	push_s r13
L_8c5c3c:
	bl.d L_8c5c0c
L_8c5c40:
	mov_s r13,r0
L_8c5c42:
	bl.d L_8c5c74
L_8c5c46:
	mov_s r0,r13
L_8c5c48:
	b L_8c033c
