/* mac__select_sector_and_wait_b @ 0x931664, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, bi_manager__rx_flow_body, direct_tx_step, internal_tx_step, mac__rx_off_seq, mac_mode_program_a, mac_mode_program_b, rx_funcs_step, rx_rfc_step
 * Зовёт сам: uc_spin_until_event
 */
	.section .text.mac__select_sector_and_wait_b,"ax",@progbits
	.global mac__select_sector_and_wait_b
mac__select_sector_and_wait_b:
	.global L_931664
L_931664:
	asl r1,0x1,r0
L_93166c:
	asl_s r1,r1,0x8
L_93166e:
	or r2,r1,0x27000000
L_931676:
	ld.as r1,[gp,-0x12]
L_93167a:
	or_s r1,r1,r2
L_93167c:
	mov r32,r1
L_931680:
	st.ab r1,[r25,0x4]
L_931684:
	bclr r25,r25,0xa
L_931688:
	mov_s r2,0x2004000
L_93168e:
	mov_s r32,r2
L_931690:
	st.ab r2,[r25,0x4]
L_931694:
	bclr r25,r25,0xa
L_931698:
	nop_s
L_93169a:
	nop_s
L_93169c:
	nop_s
L_93169e:
	mov_s r0,0x0
L_9316a0:
	b.d L_9317fc
L_9316a4:
	bset_s r0,r0,0xe
L_9316a6:
	nop_s
