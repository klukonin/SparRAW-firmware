/* mac__select_rf_module_cmd31 @ 0x93cfdc, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state4, mac__prepare_txrx_window, rx__program_mac_and_wait, rx_funcs__rx_flow, tx_mtp_queue_gate, tx_sta__run_txop, tx_sta__wait_slot_and_tx, txop_initiator_open_txop_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__select_rf_module_cmd31
mac__select_rf_module_cmd31:
	.global L_93cfdc
L_93cfdc:
	push_s r13
L_93cfde:
	mov_s r13,blink
L_93cfe0:
	stb r0,[gp, -0xe4]
L_93cfe4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93cfe6:
	or r0,r0,0x31000000
L_93cfee:
	asl_s r1,r1,0x9
L_93cff0:
	or_s r0,r0,r1
L_93cff2:
	mov_s r32,r0
L_93cff4:
	st.ab r0,[r25,0x4]
L_93cff8:
	bclr r25,r25,0xa
L_93cffc:
	mov_s blink,r13
L_93cffe:
	j_s.d [blink]
L_93d000:
	pop_s r13
L_93d002:
	nop_s
