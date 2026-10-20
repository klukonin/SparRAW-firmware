/* internal_tx__await_rx_frame_b @ 0x937780, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_step
 * Зовёт сам: mac_mode__wait_ppdu_and_kick_d, uc_wait_event1_or_event4
 */
	.section .text.internal_tx__await_rx_frame_b,"ax",@progbits
	.global internal_tx__await_rx_frame_b
internal_tx__await_rx_frame_b:
	.global L_937780
L_937780:
	push_s blink
L_937782:
	mov_s r0,0x2001000
L_937788:
	mov_s r32,r0
L_93778a:
	st.ab r0,[r25,0x4]
L_93778e:
	bclr r25,r25,0xa
	.global L_937792
L_937792:
	mov_s r0,0x0
L_937794:
	bset_s r0,r0,0xc
L_937796:
	mov_s r1,0x40
L_937798:
	bl.d L_9318f4
L_93779c:
	mov_s r2,0x0
L_93779e:
	mov_s r0,r42
L_9377a0:
	bbit0 r0,0xc,L_9377ae
L_9377a4:
	bl L_92ac08
L_9377a8:
	breq_s r0,0,L_937792
L_9377aa:
	mov_s r0,0x1
L_9377ac:
	b_s L_9377b6
	.global L_9377ae
L_9377ae:
	mov_s r0,r54
L_9377b0:
	bbit0 r0,0x6,L_937792
L_9377b4:
	mov_s r0,0x0
	.global L_9377b6
L_9377b6:
	pop_s blink
L_9377b8:
	j_s [blink]
L_9377ba:
	nop_s
