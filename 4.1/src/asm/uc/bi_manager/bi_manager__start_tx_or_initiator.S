/* bi_manager__start_tx_or_initiator @ 0x928588, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__l1_rx_entry
 * Зовёт сам: bi_tx__check_idle_and_start, bi_tx_initiator_wrap
 */
	.section .text.bi_manager__start_tx_or_initiator,"ax",@progbits
	.global bi_manager__start_tx_or_initiator
bi_manager__start_tx_or_initiator:
	.global L_928588
L_928588:
	push_s r13
L_92858a:
	mov_s r3,0x801ed0
L_928590:
	ld r1,[r3, 0x20]
L_928594:
	sub.f r1,r1,0x0
L_928598:
	mov.ne r1,0x1
L_92859c:
	extb.f 0x0,r1
L_9285a0:
	beq.d L_9285c8
L_9285a4:
	mov_s r13,blink
L_9285a6:
	ld_s r0,[r3,0x18]
L_9285a8:
	breq r0,0x0,L_9285c8
L_9285ac:
	bl.d L_931a78
L_9285b0:
	mov r0,0x2
L_9285b4:
	mov_s r2,0x81
L_9285b6:
	asl_s r2,r2,0x12
L_9285b8:
	mov r32,r2
L_9285bc:
	st.ab r2,[r25,0x4]
L_9285c0:
	bclr r25,r25,0xa
L_9285c4:
	b L_9285cc
	.global L_9285c8
L_9285c8:
	bl L_932844
	.global L_9285cc
L_9285cc:
	mov_s blink,r13
L_9285ce:
	j_s.d [blink]
L_9285d0:
	pop_s r13
L_9285d2:
	nop_s
