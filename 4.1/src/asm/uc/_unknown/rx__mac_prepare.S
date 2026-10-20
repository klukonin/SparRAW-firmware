/* rx__mac_prepare @ 0x92b7c4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__prepare_txrx_window, rx_flow__handle_frame, rx_flow__run, rx_flow_step, rx_funcs__handle_ppdu_report, rx_funcs__identify_peer
 */
	.section .text.rx__mac_prepare,"ax",@progbits
	.global rx__mac_prepare
rx__mac_prepare:
	.global L_92b7c4
L_92b7c4:
	push_s blink
L_92b7c6:
	mov_s r0,0x3d000400
L_92b7cc:
	mov_s r32,r0
L_92b7ce:
	st.ab r0,[r25,0x4]
L_92b7d2:
	bclr r25,r25,0xa
L_92b7d6:
	mov_s r0,0x1f003000
L_92b7dc:
	mov_s r32,r0
L_92b7de:
	st.ab r0,[r25,0x4]
L_92b7e2:
	bclr r25,r25,0xa
L_92b7e6:
	mov_s r0,0x83
L_92b7e8:
	asl_s r0,r0,0x19
L_92b7ea:
	mov_s r32,r0
L_92b7ec:
	st.ab r0,[r25,0x4]
L_92b7f0:
	bclr r25,r25,0xa
L_92b7f4:
	pop_s blink
L_92b7f6:
	j_s [blink]
