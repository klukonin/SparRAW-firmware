/* tx_ctx__post_status @ 0x92845c, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm6, rx_funcs__rx_flow, tx_ctx__clear_flag_179
 * Зовёт сам: uc_send_evt__ps_awake_peer
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_ctx__post_status
tx_ctx__post_status:
	.global L_92845c
L_92845c:
	ld.as r5,[r0,0x50]
L_928460:
	st.a r13,[sp,-0x8]
L_928464:
	add r13,r0,0x200
L_92846c:
	breq.d r5,0x0,L_9284e0
L_928470:
	st blink,[sp, 0x4]
L_928474:
	ldb r4,[r13, -0xcb]
L_928478:
	ld r7,[0x8014c0]
L_928480:
	ldb r6,[r13, -0xcc]
L_928484:
	or r4,r4,r6
L_928488:
	brne.d r7,0x1,L_9284cc
L_92848c:
	stb r4,[r13, -0xa6]
L_928490:
	ldb r6,[r13, -0x88]
L_928494:
	brne.d r2,0x1,L_9284d4
L_928498:
	stb r6,[r13, -0xa4]
L_92849c:
	ld r7,[0x8029f0]
L_9284a4:
	ldb r3,[r13, -0xa5]
L_9284a8:
	ld r8,[r7]
L_9284ac:
	asl r9,0x1,r8
L_9284b4:
	not r5,r9
L_9284b8:
	and r4,r4,r5
L_9284bc:
	stb r4,[r13, -0xa6]
L_9284c0:
	and r3,r3,r5
L_9284c4:
	b.d L_9284d4
L_9284c8:
	stb r3,[r13, -0xa5]
	.global L_9284cc
L_9284cc:
	ldb r10,[r13, -0x87]
L_9284d0:
	stb r10,[r13, -0xa4]
	.global L_9284d4
L_9284d4:
	ldb r5,[r13, -0xc8]
L_9284d8:
	b.d L_9284f0
L_9284dc:
	stb r5,[r13, -0xa5]
	.global L_9284e0
L_9284e0:
	mov r3,0xff
L_9284e4:
	stb r3,[r13, -0xa6]
L_9284e8:
	mov r4,0x0
L_9284ec:
	stb r4,[r13, -0xa5]
	.global L_9284f0
L_9284f0:
	ld r11,[r0, 0x20]
L_9284f4:
	stb r1,[r13, -0xa8]
L_9284f8:
	cmp r11,0x2
L_9284fc:
	mov r11,0x1
L_928500:
	sub.ne r11,r11,r11
L_928504:
	stb r11,[r13, -0xa7]
L_928508:
	st.as r2,[r0,0x58]
L_92850c:
	bl.d L_92757c
L_928510:
	add r0,r0,0x158
L_928514:
	ld blink,[sp, 0x4]
L_928518:
	j.d [blink]
L_92851c:
	ld.ab r13,[sp,0x8]
