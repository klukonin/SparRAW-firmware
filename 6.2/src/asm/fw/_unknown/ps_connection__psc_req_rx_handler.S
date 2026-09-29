/* ps_connection__psc_req_rx_handler @ 0x8e1990, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Ignoring ps_connection::psc_req_rx_handler
 * Зовут его: sta_psc_sm__psc_req_tx_complete
 * Зовёт сам: fw_log_emit0, ps_connection__psc_req_rx
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_connection__psc_req_rx_handler
ps_connection__psc_req_rx_handler:
	.global L_8e1990
L_8e1990:
	push_s blink
L_8e1992:
	ld_s r2,[r0,0x34]
L_8e1994:
	brne_s r2,0,L_8e19a4
L_8e1996:
	mov_s r1,0x10026d4
L_8e199c:
	bl.d L_8dcba8
L_8e19a0:
	mov_s r0,0x2e
L_8e19a2:
	b_s L_8e19aa
	.global L_8e19a4
L_8e19a4:
	bl.d L_8d9d2c
L_8e19a8:
	add_s r0,r0,0x38
	.global L_8e19aa
L_8e19aa:
	pop_s blink
L_8e19ac:
	j_s [blink]
L_8e19ae:
	nop_s
