/* uc_wait_one_event @ 0x936588, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window, brp_init__tx_request, brp_responder_transmission_flow, fsched__tx_ctrl_frame, internal_tx__flow_sm4, rx__program_mac_and_wait, tx__send_and_await_rx_frame, tx_bcast_flow, tx_mtp_queue_gate, txop_initiator_open_txop_flow
 * Зовёт сам: uc_wait_two_events
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_wait_one_event
uc_wait_one_event:
	.global L_936588
L_936588:
	mov r1,r0
L_93658c:
	b.d L_936594
L_936590:
	mov_s r2,0x0
L_936592:
	nop_s
