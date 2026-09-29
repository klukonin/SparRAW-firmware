/* mac__rx_off_seq @ 0x93759c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__latch_tsf_and_reset
 * Зовёт сам: mac__cmd_29000001, mac_evt__enable_bit_sync_b
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__rx_off_seq
mac__rx_off_seq:
	.global L_93759c
L_93759c:
	push_s blink
L_93759e:
	bl L_936520
L_9375a2:
	bl.d L_936544
L_9375a6:
	mov_s r0,0x0
L_9375a8:
	mov_s r0,0x3d000004
L_9375ae:
	mov_s r32,r0
L_9375b0:
	st.ab r0,[r25,0x4]
L_9375b4:
	bclr r25,r25,0xa
L_9375b8:
	mov_s r0,0x29000002
L_9375be:
	mov_s r32,r0
L_9375c0:
	st.ab r0,[r25,0x4]
L_9375c4:
	bclr r25,r25,0xa
L_9375c8:
	pop_s blink
L_9375ca:
	j_s [blink]
