/* sta_psc_sm__psc_req_tx_complete_8e19c0 @ 0x8e19c0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::psc_req_tx_complete. success: %d
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal, sta_psc_sm__psc_resp_rx_wb_timeout_event, sta_psc_sm__send_psc_req_flow_sm, u_schd__schedule
 * Глобалы (через gp): 0x800438
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__psc_req_tx_complete_8e19c0
sta_psc_sm__psc_req_tx_complete_8e19c0:
	.global L_8e19c0
L_8e19c0:
	push_s blink
L_8e19c2:
	bl L_8c01e4
L_8e19c6:
	mov_s r13,r0
L_8e19c8:
	mov_s r14,r1
L_8e19ca:
	mov_s r1,0x1002d14
L_8e19d0:
	mov_s r0,0x2e
L_8e19d2:
	bl.d L_8dcc10
L_8e19d6:
	mov_s r2,r14
L_8e19d8:
	ld_s r0,[r13,0x8]
L_8e19da:
	brne_s r0,0,L_8e1a00
	.global L_8e19dc
L_8e19dc:
	bl.d L_8c69ac
L_8e19e0:
	mov_s r0,r13
L_8e19e2:
	breq_s r14,0,L_8e1a0e
L_8e19e4:
	mov_s r0,L_8e1af8-0x8c0000
L_8e19ea:
	ld.as r4,[gp,0xad]
L_8e19ee:
	mov_s r1,r13
L_8e19f0:
	mov_s r2,0x0
L_8e19f2:
	mov_s r3,r2
L_8e19f4:
	mov_s r5,r2
L_8e19f6:
	bl.d L_8e0c0c
L_8e19fa:
	mov_s r6,r2
L_8e19fc:
	st_s r0,[r13,0xc]
L_8e19fe:
	b_s L_8e1a14
	.global L_8e1a00
L_8e1a00:
	mov_s r0,blink
L_8e1a02:
	mov_s r1,0x1422
L_8e1a08:
	bl L_8c9b28
L_8e1a0c:
	b_s L_8e19dc
	.global L_8e1a0e
L_8e1a0e:
	bl.d L_8e5bc0
L_8e1a12:
	mov_s r0,r13
	.global L_8e1a14
L_8e1a14:
	b L_8c0254
