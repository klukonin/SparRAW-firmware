/* sta_psc_sm__action_8c69d4 @ 0x8c69d4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, sta_psc_sm__m_psc_req_tx_wb_timeout_event, sta_psc_sm__psc_resp_rx_wb_timeout_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__action_8c69d4
sta_psc_sm__action_8c69d4:
	.global L_8c69d4
L_8c69d4:
	push_s blink
L_8c69d6:
	push_s r13
L_8c69d8:
	bl.d L_8c69ac
L_8c69dc:
	mov_s r13,r0
L_8c69de:
	bl.d L_8c6a0c
L_8c69e2:
	mov_s r0,r13
L_8c69e4:
	b L_8c025c
