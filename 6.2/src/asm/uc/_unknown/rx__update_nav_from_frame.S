/* rx__update_nav_from_frame @ 0x9343a8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_flow_step
 * Зовёт сам: rx_nav__set_from_duration
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__update_nav_from_frame
rx__update_nav_from_frame:
	.global L_9343a8
L_9343a8:
	st.a r13,[sp,-0x4]
L_9343ac:
	ld r5,[0x804004]
L_9343b4:
	bbit0.d r5,0x17,L_93441c
L_9343b8:
	mov_s r13,blink
L_9343ba:
	mov r8,0x804010
L_9343c2:
	ldw r1,[r8]
L_9343c6:
	mov_s r3,0x80401a
L_9343cc:
	lsr r7,r1,0x2
L_9343d0:
	bmsk r7,r7,0x1
L_9343d4:
	brne.d r7,0x3,L_9343f4
L_9343d8:
	ldw r2,[r8, 0x2]
L_9343dc:
	ldb r6,[gp, -0xe3]
L_9343e0:
	mov_s r3,0x804014
L_9343e6:
	breq r6,0x0,L_93441c
L_9343ea:
	breq_s r0,0,L_9343f4
L_9343ec:
	add r2,r2,0x640
L_9343f0:
	extw r2,r2
	.global L_9343f4
L_9343f4:
	ld r4,[0x801424]
L_9343fc:
	bbit1 r4,0x0,L_934414
L_934400:
	mov r4,0x8014e8
L_934408:
	ldb r0,[r4]
L_93440c:
	stb r0,[r4, 0x5]
L_934410:
	ldw r1,[r8]
	.global L_934414
L_934414:
	bl.d L_92dd30
L_934418:
	mov r0,0x1
	.global L_93441c
L_93441c:
	mov_s blink,r13
L_93441e:
	j_s.d [blink]
L_934420:
	pop_s r13
L_934422:
	nop_s
