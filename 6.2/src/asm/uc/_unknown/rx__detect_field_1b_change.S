/* rx__detect_field_1b_change @ 0x93e42c, 320 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__detect_field_1b_change
rx__detect_field_1b_change:
	.global L_93e42c
L_93e42c:
	st.a r13,[sp,-0x4]
L_93e430:
	ld.as r5,[gp,0x34]
L_93e434:
	bset r5,r5,0x1f
L_93e438:
	st.as r5,[gp,0x34]
L_93e43c:
	ldb r9,[r0, 0x1b]
L_93e440:
	mov r5,0x8013d4
L_93e448:
	brne.d r9,0x0,L_93e45c
L_93e44c:
	mov_s r13,0x0
L_93e44e:
	st r13,[r5]
L_93e452:
	mov_s r0,r13
L_93e454:
	j.d [blink]
L_93e458:
	ld.ab r13,[sp,0x4]
	.global L_93e45c
L_93e45c:
	ld r3,[r5]
L_93e460:
	mov_s r13,0x1
L_93e462:
	cmp r9,r3
L_93e466:
	sub.eq r13,r13,r13
L_93e46a:
	st r9,[r5]
L_93e46e:
	bmsk.f r9,r9,0x2
L_93e472:
	beq_s L_93e47c
L_93e474:
	b.d L_93e480
L_93e478:
	sub r6,r9,0x1
	.global L_93e47c
L_93e47c:
	mov r6,0x7
	.global L_93e480
L_93e480:
	asl r8,r1,0x2
L_93e484:
	add2 r8,r8,r8
L_93e488:
	add r8,r8,0x802354
L_93e490:
	ld r2,[r8]
L_93e494:
	brne.d r2,0x0,L_93e4a4
L_93e498:
	st r6,[r5, 0x4]
L_93e49c:
	mov r11,0x1
L_93e4a0:
	st r11,[r8]
	.global L_93e4a4
L_93e4a4:
	ldw r11,[r0, 0x1c]
L_93e4a8:
	asl r6,r6,0x5
L_93e4ac:
	ldw r10,[r0, 0x1e]
L_93e4b0:
	add1 r6,r6,r6
L_93e4b4:
	ldw r9,[r0, 0x20]
L_93e4b8:
	add r3,r6,0x857400
L_93e4c0:
	stw r11,[r3, -0xb8]
L_93e4c4:
	stw r10,[r3, -0xb6]
L_93e4c8:
	stw r9,[r3, -0xb4]
L_93e4cc:
	ldw r11,[r0, 0x22]
L_93e4d0:
	add r6,r6,0x857000
L_93e4d8:
	ldw r10,[r0, 0x24]
L_93e4dc:
	ldw r9,[r0, 0x26]
L_93e4e0:
	stw r11,[r3, -0xb2]
L_93e4e4:
	stw r10,[r3, -0xb0]
L_93e4e8:
	stw r9,[r3, -0xae]
L_93e4ec:
	ldw r11,[r0, 0x28]
L_93e4f0:
	stw r11,[r3, -0xac]
L_93e4f4:
	ldw r11,[r0, 0x2a]
L_93e4f8:
	stw r11,[r3, -0xaa]
L_93e4fc:
	ldb r10,[r0, 0x2c]
L_93e500:
	cmp r10,0xff
L_93e504:
	bne_s L_93e530
L_93e506:
	ldb r2,[r0, 0x30]
L_93e50a:
	ldb r4,[r0, 0x2f]
L_93e50e:
	asl_s r2,r2,0x8
L_93e510:
	or r4,r4,r2
L_93e514:
	ldb r2,[r0, 0x31]
L_93e518:
	asl_s r2,r2,0x10
L_93e51a:
	or r4,r4,r2
L_93e51e:
	ldb r2,[r0, 0x32]
L_93e522:
	asl_s r2,r2,0x18
L_93e524:
	or r4,r4,r2
L_93e528:
	b.d L_93e538
L_93e52c:
	st.as r4,[r6,0xd9]
	.global L_93e530
L_93e530:
	mov r9,-0x1
L_93e534:
	st.as r9,[r6,0xd9]
	.global L_93e538
L_93e538:
	st r1,[r5, 0xc]
L_93e53c:
	ldb r10,[r0, 0x1a]
L_93e540:
	brne r10,0x0,L_93e54c
L_93e544:
	mov r4,0x1
L_93e548:
	st r4,[r5, 0x10]
	.global L_93e54c
L_93e54c:
	breq_s r13,0,L_93e564
L_93e54e:
	ld r7,[r5, 0x8]
L_93e552:
	mov_s r0,r13
L_93e554:
	add r7,r7,0x1
L_93e558:
	st r7,[r5, 0x8]
L_93e55c:
	j.d [blink]
L_93e560:
	ld.ab r13,[sp,0x4]
	.global L_93e564
L_93e564:
	mov_s r0,r13
L_93e566:
	j_s.d [blink]
L_93e568:
	pop_s r13
L_93e56a:
	nop_s
