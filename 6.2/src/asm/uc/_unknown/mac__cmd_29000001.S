/* mac__cmd_29000001 @ 0x936520, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, bi_rx__start_rx_window, direct_tx__send_from_desc, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, mac__rx_off_seq, tx__cca_check_and_send, tx_bcast_flow, txop__await_cts_ppdu
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__cmd_29000001
mac__cmd_29000001:
	.global L_936520
L_936520:
	push_s r13
L_936522:
	mov_s r13,blink
L_936524:
	mov_s r0,0x29000001
L_93652a:
	mov_s r32,r0
L_93652c:
	st.ab r0,[r25,0x4]
L_936530:
	bclr r25,r25,0xa
L_936534:
	nop_s
L_936536:
	nop_s
L_936538:
	nop_s
L_93653a:
	mov_s blink,r13
L_93653c:
	j.d [blink]
L_936540:
	pop_s r13
L_936542:
	nop_s
