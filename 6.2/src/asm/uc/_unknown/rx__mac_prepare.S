/* rx__mac_prepare @ 0x92f2bc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window, internal_tx__flow_sm4, mac__prepare_txrx_window, rx_flow__handle_frame, rx_flow__run, rx_flow_step, rx_funcs__handle_ppdu_report, sls__rx_ssw_frame
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__mac_prepare
rx__mac_prepare:
	.global L_92f2bc
L_92f2bc:
	push_s blink
L_92f2be:
	mov_s r0,0x3d000400
L_92f2c4:
	mov_s r32,r0
L_92f2c6:
	st.ab r0,[r25,0x4]
L_92f2ca:
	bclr r25,r25,0xa
L_92f2ce:
	mov_s r0,0x1f003000
L_92f2d4:
	mov_s r32,r0
L_92f2d6:
	st.ab r0,[r25,0x4]
L_92f2da:
	bclr r25,r25,0xa
L_92f2de:
	mov_s r0,0x83
L_92f2e0:
	asl_s r0,r0,0x19
L_92f2e2:
	mov_s r32,r0
L_92f2e4:
	st.ab r0,[r25,0x4]
L_92f2e8:
	bclr r25,r25,0xa
L_92f2ec:
	pop_s blink
L_92f2ee:
	j_s [blink]
