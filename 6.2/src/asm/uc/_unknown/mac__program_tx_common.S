/* mac__program_tx_common @ 0x92d990, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, bcon_txss_sweep_step, brp_init__tx_request, brp_responder_transmission_flow, direct_tx_step, sls__send_ssw_ack, txss__program_tx_frame, txss_init__send_ssw_fdbk
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_tx_common
mac__program_tx_common:
	.global L_92d990
L_92d990:
	push_s r13
L_92d992:
	mov_s r13,blink
L_92d994:
	mov_s r2,0x1b001111
L_92d99a:
	mov_s r32,r2
L_92d99c:
	st.ab r2,[r25,0x4]
L_92d9a0:
	bclr r25,r25,0xa
L_92d9a4:
	mov_s r1,0x161f0040
L_92d9aa:
	mov_s r32,r1
L_92d9ac:
	st.ab r1,[r25,0x4]
L_92d9b0:
	bclr r25,r25,0xa
L_92d9b4:
	mov_s r0,0x17000003
L_92d9ba:
	mov_s r32,r0
L_92d9bc:
	st.ab r0,[r25,0x4]
L_92d9c0:
	bclr r25,r25,0xa
L_92d9c4:
	nop_s
L_92d9c6:
	nop_s
L_92d9c8:
	nop_s
L_92d9ca:
	mov_s blink,r13
L_92d9cc:
	j.d [blink]
L_92d9d0:
	pop_s r13
L_92d9d2:
	nop_s
