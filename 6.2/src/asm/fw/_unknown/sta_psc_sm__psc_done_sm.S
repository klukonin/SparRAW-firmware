/* sta_psc_sm__psc_done_sm @ 0x8e194c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::psc_done_sm. dpm: %d, success: %d
 * Зовут его: sta_psc_sm__action_8c318c, sta_psc_sm__action_8ea864, sta_psc_sm__max_retry_handler
 * Зовёт сам: PS_CONNECTION__psc_complete, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, sta_psc_sm__m_psc_req_tx_wb_timeout_event, sta_psc_sm__psc_resp_rx_wb_timeout_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__psc_done_sm
sta_psc_sm__psc_done_sm:
	.global L_8e194c
L_8e194c:
	push_s blink
L_8e194e:
	bl L_8c01e4
L_8e1952:
	mov_s r13,r0
L_8e1954:
	mov_s r14,r1
L_8e1956:
	ldb r2,[r13, 0x20]
L_8e195a:
	mov_s r1,0x1002d64
L_8e1960:
	mov_s r0,0x2e
L_8e1962:
	bl.d L_8dcc80
L_8e1966:
	mov_s r3,r14
L_8e1968:
	ldb r0,[r13, 0x20]
L_8e196c:
	add r3,r13,0x18
L_8e1970:
	sub.f r2,r0,0x0
L_8e1974:
	ld_s r0,[r13,0x14]
L_8e1976:
	mov.ne r2,0x1
L_8e197a:
	bl.d L_8e172c
L_8e197e:
	mov_s r1,r14
L_8e1980:
	bl.d L_8c69ac
L_8e1984:
	mov_s r0,r13
L_8e1986:
	bl.d L_8c6a0c
L_8e198a:
	mov_s r0,r13
L_8e198c:
	b L_8c0254
