/* sta_psc_sm__m_psc_req_tx_wb_timeout_event @ 0x8c6a0c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::m_psc_req_tx_wb_timeout_event delete pending TO.
 * Зовут его: psc_if__psc_req_tx_wb_cb, sta_psc_sm__action_8c69d4, sta_psc_sm__psc_done_sm
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__m_psc_req_tx_wb_timeout_event
sta_psc_sm__m_psc_req_tx_wb_timeout_event:
	.global L_8c6a0c
L_8c6a0c:
	push_s blink
L_8c6a0e:
	push_s r13
L_8c6a10:
	mov_s r13,r0
L_8c6a12:
	ld_s r0,[r0,0x8]
L_8c6a14:
	breq_s r0,0,L_8c6a28
L_8c6a16:
	mov_s r1,0x1002dd4
L_8c6a1c:
	bl.d L_8dcba8
L_8c6a20:
	mov_s r0,0x2e
L_8c6a22:
	bl.d L_8c8de0
L_8c6a26:
	ld_s r0,[r13,0x8]
	.global L_8c6a28
L_8c6a28:
	mov_s r0,0x0
L_8c6a2a:
	b.d L_8c025c
L_8c6a2e:
	st_s r0,[r13,0x8]
