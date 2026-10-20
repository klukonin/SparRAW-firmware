/* uc_spin_until_event @ 0x9317fc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, bi_manager__rx_flow_body, bi_tx_initiator_wrap, brp_flow_step, cf_end__tx_flow, direct_tx_step, mac__select_sector_and_wait_a, mac__select_sector_and_wait_b, mac_mode_program_a
 */
	.section .text.uc_spin_until_event,"ax",@progbits
	.global uc_spin_until_event
uc_spin_until_event:
	.global L_9317fc
L_9317fc:
	tst r42,r0
L_931800:
	jne [blink]
L_931804:
	b_s L_9317fc
L_931806:
	nop_s
