/* ps_connection__psc_rsp_rx_handler @ 0x8e1be4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Ignoring ps_connection::psc_rsp_rx_handler
 * Зовут его: pcp_psc_sm__psc_start_flow
 * Зовёт сам: fw_log_emit0, sta_psc_sm__IDLE
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_connection__psc_rsp_rx_handler
ps_connection__psc_rsp_rx_handler:
	.global L_8e1be4
L_8e1be4:
	push_s blink
L_8e1be6:
	ld_s r2,[r0,0x34]
L_8e1be8:
	brne_s r2,0,L_8e1bf8
L_8e1bea:
	mov_s r1,0x1002700
L_8e1bf0:
	bl.d L_8dcba8
L_8e1bf4:
	mov_s r0,0x2e
L_8e1bf6:
	b_s L_8e1bfe
	.global L_8e1bf8
L_8e1bf8:
	bl.d L_8d9da4
L_8e1bfc:
	add_s r0,r0,0x38
	.global L_8e1bfe
L_8e1bfe:
	pop_s blink
L_8e1c00:
	j_s [blink]
L_8e1c02:
	nop_s
