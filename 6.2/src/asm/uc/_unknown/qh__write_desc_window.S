/* qh__write_desc_window @ 0x924348, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__kick_queue_tx, qh__write_by_flags
 * Зовёт сам: qh__reset_desc_window, qh__wait_desc_window_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__write_desc_window
qh__write_desc_window:
	.global L_924348
L_924348:
	st.a r13,[sp,-0x1c]
L_92434c:
	st blink,[sp, 0x4]
L_924350:
	st_s r14,[sp,0x8]
L_924352:
	st_s r15,[sp,0xc]
L_924354:
	st r16,[sp, 0x10]
L_924358:
	st r17,[sp, 0x14]
L_92435c:
	st r18,[sp, 0x18]
L_924360:
	sub_s sp,sp,0x8
L_924362:
	mov_s r14,r0
L_924364:
	mov_s r16,r3
L_924366:
	mov r17,r6
L_92436a:
	mov_s r13,0x0
L_92436c:
	stw r13,[sp, 0x4]
L_924370:
	stw r13,[sp, 0x6]
L_924374:
	ld r8,[sp, 0x4]
L_924378:
	bmsk_s r2,r2,0x2
L_92437a:
	ror r8,r8,0x4
L_92437e:
	bic r8,r8,0x7
L_924382:
	or r8,r8,r2
L_924386:
	ror r6,r8,0x1c
L_92438a:
	bmsk r4,r4,0x1
L_92438e:
	mov r9,-0x4
L_924392:
	bic r6,r6,0x3
L_924396:
	or r4,r4,r6
L_92439a:
	st r4,[sp, 0x4]
L_92439e:
	bmsk r2,r3,0x1
L_9243a2:
	bmsk_s r1,r1,0x4
L_9243a4:
	ror r2,r2,0x2
L_9243a8:
	bic r2,r2,0x1f
L_9243ac:
	or r1,r1,r2
L_9243b0:
	bl.d L_924480
L_9243b4:
	ror r10,r1,0x1c
L_9243b8:
	ldw r6,[sp, 0x4]
L_9243bc:
	mov r15,0x886800
L_9243c4:
	asl r6,r6,0x10
L_9243c8:
	bset r6,r6,0x1f
L_9243cc:
	or r5,r5,r6
L_9243d0:
	st.as r5,[r15,-0x7d]
L_9243d4:
	brlo r7,0x1,L_924460
	.global L_9243d8
L_9243d8:
	mov r18,r7
L_9243dc:
	add r8,r13,r17
L_9243e0:
	bmsk r8,r8,0x1
L_9243e4:
	and r9,r9,r10
L_9243e8:
	or r8,r8,r9
L_9243ec:
	st r8,[sp]
L_9243f0:
	st.as r8,[r15,-0x7c]
L_9243f4:
	cmp r16,0x2
L_9243f8:
	mov r8,0x1
L_9243fc:
	sub.eq r8,r8,r8
L_924400:
	mov r7,0x2
L_924404:
	add1 r7,r7,r8
L_924408:
	cmp r7,0x0
L_92440c:
	mov.hi lp_count,r7
L_924410:
	mov.hi r6,0x886614
L_924418:
	lphi L_924424
L_92441c:
	ld.ab r5,[r14,0x4]
L_924420:
	st.ab r5,[r6,0x4]
	.global L_924424
L_924424:
	ldb r3,[gp, -0xde]
L_924428:
	brne_s r3,0,L_924434
L_92442a:
	st.as 0xc0000000,[r15,-0x7e]
L_924432:
	b_s L_92443c
	.global L_924434
L_924434:
	st.as 0x40000000,[r15,-0x7e]
	.global L_92443c
L_92443c:
	sync
	.global L_924440
L_924440:
	ld.as r4,[r15,-0x7e]
L_924444:
	bbit1 r4,0x1d,L_924440
L_924448:
	sub r7,r18,0x1
L_92444c:
	brlo.d r7,0x1,L_924460
L_924450:
	add r13,r13,0x1
L_924454:
	ld r10,[sp]
L_924458:
	b.d L_9243d8
L_92445c:
	mov r9,-0x4
	.global L_924460
L_924460:
	bl L_9246b0
L_924464:
	add_s sp,sp,0x8
L_924466:
	ld blink,[sp, 0x4]
L_92446a:
	ld_s r14,[sp,0x8]
L_92446c:
	ld_s r15,[sp,0xc]
L_92446e:
	ld r16,[sp, 0x10]
L_924472:
	ld r17,[sp, 0x14]
L_924476:
	ld r18,[sp, 0x18]
L_92447a:
	j_s.d [blink]
L_92447c:
	ld.ab r13,[sp,0x1c]
