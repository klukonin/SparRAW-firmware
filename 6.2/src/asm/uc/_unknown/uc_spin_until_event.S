/* uc_spin_until_event @ 0x9366dc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, bi_rx__start_rx_window, brp_init__tx_request, brp_responder_flow_enter, brp_responder_transmission_flow, direct_tx__send_from_desc, direct_tx_step, fixed_sched__run_tx_slot, fsched__tx_ctrl_frame
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_spin_until_event
uc_spin_until_event:
	.global L_9366dc
L_9366dc:
	tst r42,r0
L_9366e0:
	jne [blink]
L_9366e4:
	b_s L_9366dc
L_9366e6:
	nop_s
