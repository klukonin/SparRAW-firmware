/* ps_connection__psc_rsp_ignore @ 0x8ddaa8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Ignoring ps_connection::psc_rsp_rx_handler
 * Зовут его: psc__rsp_ignore_by_index
 * Зовёт сам: fw_log__emit0, sta_psc_sm__psc_resp_rx
 */
	.section .text.ps_connection__psc_rsp_ignore,"ax",@progbits
	.global ps_connection__psc_rsp_ignore
ps_connection__psc_rsp_ignore:
	.global L_8ddaa8
L_8ddaa8:
	push_s blink
L_8ddaaa:
	ld_s r2,[r0,0x58]
L_8ddaac:
	brne_s r2,0,L_8ddabe
L_8ddaae:
	mov_s r2,0x1002a88
L_8ddab4:
	mov_s r0,0xe
L_8ddab6:
	bl.d L_8edfb0
L_8ddaba:
	mov_s r1,0x2
L_8ddabc:
	b_s L_8ddac4
	.global L_8ddabe
L_8ddabe:
	bl.d L_8d6c70
L_8ddac2:
	add_s r0,r0,0x5c
	.global L_8ddac4
L_8ddac4:
	pop_s blink
L_8ddac6:
	j_s [blink]
