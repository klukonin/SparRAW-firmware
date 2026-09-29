/* sta_psc_sm__psc_req_tx_complete @ 0x8dd840, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::psc_req_tx_complete. success: %d
 *   sta_psc_sm.cpp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal, sta_psc_sm__m_psc_resp_rx_wb_timeout_event, sta_psc_sm__send_psc_req_flow_sm, u_schd__schedule
 * Глобалы (через gp): 0x800420
 */
	.section .text.sta_psc_sm__psc_req_tx_complete,"ax",@progbits
	.global sta_psc_sm__psc_req_tx_complete
sta_psc_sm__psc_req_tx_complete:
L_8dd840:
	push_s blink
L_8dd842:
	bl L_8c02c4
L_8dd846:
	mov_s r13,r0
L_8dd848:
	mov_s r14,r1
L_8dd84a:
	mov_s r2,0x1003048
L_8dd850:
	mov_s r0,0xe
L_8dd852:
	mov_s r1,0x2
L_8dd854:
	bl.d L_8edfcc
L_8dd858:
	mov_s r3,r14
L_8dd85a:
	ld_s r0,[r13,0x2c]
L_8dd85c:
	brne_s r0,0,L_8dd882
	.global L_8dd85e
L_8dd85e:
	bl.d L_8c5c0c
L_8dd862:
	mov_s r0,r13
L_8dd864:
	breq_s r14,0,L_8dd898
L_8dd866:
	mov_s r0,0x1d99c
L_8dd86c:
	ld.as r4,[gp,0xac]
L_8dd870:
	mov_s r1,r13
L_8dd872:
	mov_s r2,0x0
L_8dd874:
	mov_s r3,r2
L_8dd876:
	mov_s r5,r2
L_8dd878:
	bl.d L_8dc92c
L_8dd87c:
	mov_s r6,r2
L_8dd87e:
	st_s r0,[r13,0x30]
L_8dd880:
	b_s L_8dd89e
	.global L_8dd882
L_8dd882:
	mov_s r0,blink
L_8dd884:
	mov_s r2,0x1002f44
L_8dd88a:
	mov_s r1,0x1422
L_8dd890:
	bl.d L_8c82c0
L_8dd894:
	mov_s r3,0x83
L_8dd896:
	b_s L_8dd85e
	.global L_8dd898
L_8dd898:
	bl.d L_8e0f04
L_8dd89c:
	mov_s r0,r13
	.global L_8dd89e
L_8dd89e:
	b L_8c0334
L_8dd8a2:
	nop_s
