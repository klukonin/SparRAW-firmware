/* mac__cmd_29000001 @ 0x931640, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, bi_manager__rx_flow_body, internal_tx_step, mac__rx_off_seq, tx_mtp__open_window, tx_rate_select_and_program, txop__open_window, txss__tx_sector_frame
 */
	.section .text.mac__cmd_29000001,"ax",@progbits
	.global mac__cmd_29000001
mac__cmd_29000001:
	.global L_931640
L_931640:
	push_s r13
L_931642:
	mov_s r13,blink
L_931644:
	mov_s r0,0x29000001
L_93164a:
	mov_s r32,r0
L_93164c:
	st.ab r0,[r25,0x4]
L_931650:
	bclr r25,r25,0xa
L_931654:
	nop_s
L_931656:
	nop_s
L_931658:
	nop_s
L_93165a:
	mov_s blink,r13
L_93165c:
	j.d [blink]
L_931660:
	pop_s r13
L_931662:
	nop_s
