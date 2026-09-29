/* internal_tx__await_rx_frame_a @ 0x9375b0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_step
 * Зовёт сам: mac_mode__wait_ppdu_and_kick_b, uc_wait_event1_or_event4
 */
	.section .text.internal_tx__await_rx_frame_a,"ax",@progbits
	.global internal_tx__await_rx_frame_a
internal_tx__await_rx_frame_a:
	.global L_9375b0
L_9375b0:
	push_s blink
L_9375b2:
	mov_s r0,0x2001000
L_9375b8:
	mov_s r32,r0
L_9375ba:
	st.ab r0,[r25,0x4]
L_9375be:
	bclr r25,r25,0xa
	.global L_9375c2
L_9375c2:
	mov_s r0,0x0
L_9375c4:
	bset_s r0,r0,0xc
L_9375c6:
	mov_s r1,0x40
L_9375c8:
	bl.d L_9318f4
L_9375cc:
	mov_s r2,0x0
L_9375ce:
	mov_s r0,r42
L_9375d0:
	bbit0 r0,0xc,L_9375de
L_9375d4:
	bl L_92abac
L_9375d8:
	breq_s r0,0,L_9375c2
L_9375da:
	mov_s r0,0x1
L_9375dc:
	b_s L_9375e6
	.global L_9375de
L_9375de:
	mov_s r0,r54
L_9375e0:
	bbit0 r0,0x6,L_9375c2
L_9375e4:
	mov_s r0,0x0
	.global L_9375e6
L_9375e6:
	pop_s blink
L_9375e8:
	j_s [blink]
L_9375ea:
	nop_s
