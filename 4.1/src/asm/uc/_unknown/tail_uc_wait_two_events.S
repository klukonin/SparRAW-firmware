/* tail_uc_wait_two_events @ 0x9316a8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__rx_flow_body, cf_end__tx_flow, mac_mode_program_a, mac_mode_program_b, tx_flows__program_mac_tx, tx_mtp_queue_gate, tx_rate_select_and_program, txop_initiator_open_txop_flow
 * Зовёт сам: uc_wait_two_events
 */
	.section .text.tail_uc_wait_two_events,"ax",@progbits
	.global tail_uc_wait_two_events
tail_uc_wait_two_events:
	.global L_9316a8
L_9316a8:
	mov r1,r0
L_9316ac:
	b.d L_9316b4
L_9316b0:
	mov_s r2,0x0
L_9316b2:
	nop_s
