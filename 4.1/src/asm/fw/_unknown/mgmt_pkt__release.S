/* mgmt_pkt__release @ 0x8c955c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_pkt_handler, mlme_sm__assoc_reject_ev_handle, mlme_sm__assoc_req_handle, mlme_sm__assoc_resp_event, mlme_sm__disconnect_ev_handle, mlme_sm__handle_disassoc, rx_pkt_handler
 * Зовёт сам: __ld_r13_ret, mgmt_pkt__clear
 */
	.section .text.mgmt_pkt__release,"ax",@progbits
	.global mgmt_pkt__release
mgmt_pkt__release:
	.global L_8c955c
L_8c955c:
	push_s blink
L_8c955e:
	push_s r13
L_8c9560:
	mov_s r13,r0
L_8c9562:
	mov_s r0,0x842aa0
L_8c9568:
	bl.d L_8c953c
L_8c956c:
	ld_s r1,[r13,0xc]
L_8c956e:
	mov_s r0,0x0
L_8c9570:
	b.d L_8c033c
L_8c9574:
	st_s r0,[r13,0xc]
L_8c9576:
	nop_s
