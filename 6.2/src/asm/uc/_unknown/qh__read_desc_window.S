/* qh__read_desc_window @ 0x92449c, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dump_mac_buffer_bases, macq__is_idle, macq__kick_queue_tx, qh__build_descriptor, qh__build_descriptor_b, tx_bcast_flow
 * Зовёт сам: qh__reset_desc_window, qh__wait_desc_window_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__read_desc_window
qh__read_desc_window:
	.global L_92449c
L_92449c:
	st.a r13,[sp,-0x18]
L_9244a0:
	st blink,[sp, 0x4]
L_9244a4:
	st_s r14,[sp,0x8]
L_9244a6:
	st_s r15,[sp,0xc]
L_9244a8:
	st r16,[sp, 0x10]
L_9244ac:
	st r17,[sp, 0x14]
L_9244b0:
	sub_s sp,sp,0x8
L_9244b2:
	mov_s r17,r0
L_9244b4:
	mov_s r16,r3
L_9244b6:
	mov_s r13,0x0
L_9244b8:
	stw r13,[sp, 0x4]
L_9244bc:
	stw r13,[sp, 0x6]
L_9244c0:
	ld r5,[sp, 0x4]
L_9244c4:
	bmsk_s r2,r2,0x2
L_9244c6:
	ror r5,r5,0x4
L_9244ca:
	bic r5,r5,0x7
L_9244ce:
	or r5,r5,r2
L_9244d2:
	ror r8,r5,0x1c
L_9244d6:
	mov r7,-0x4
L_9244da:
	bic r8,r8,0x3
L_9244de:
	st r8,[sp, 0x4]
L_9244e2:
	bmsk r2,r3,0x1
L_9244e6:
	bmsk_s r1,r1,0x4
L_9244e8:
	ror r2,r2,0x2
L_9244ec:
	bic r2,r2,0x1f
L_9244f0:
	or r1,r1,r2
L_9244f4:
	bl.d L_924480
L_9244f8:
	ror r6,r1,0x1c
L_9244fc:
	ldw r9,[sp, 0x4]
L_924500:
	mov r15,0x886800
L_924508:
	asl r9,r9,0x10
L_92450c:
	st.as r9,[r15,-0x7d]
L_924510:
	brlo r4,0x1,L_924594
	.global L_924514
L_924514:
	bmsk r5,r13,0x1
L_924518:
	and r6,r6,r7
L_92451c:
	or r5,r5,r6
L_924520:
	st r5,[sp]
L_924524:
	st.as r5,[r15,-0x7c]
L_924528:
	ldb r5,[gp, -0xde]
L_92452c:
	brne.d r5,0x0,L_92453c
L_924530:
	mov_s r14,r4
L_924532:
	st.as 0xc0000000,[r15,-0x7e]
L_92453a:
	b_s L_924544
	.global L_92453c
L_92453c:
	st.as 0x40000000,[r15,-0x7e]
	.global L_924544
L_924544:
	sync
	.global L_924548
L_924548:
	ld.as r3,[r15,-0x7e]
L_92454c:
	bbit1 r3,0x1d,L_924548
L_924550:
	cmp r16,0x2
L_924554:
	mov r7,0x1
L_924558:
	sub.eq r7,r7,r7
L_92455c:
	mov_s r3,0x2
L_92455e:
	add1 r3,r3,r7
L_924562:
	cmp_s r3,0x0
L_924564:
	mov.hi lp_count,r3
L_924568:
	mov.hi r6,0x886614
L_924570:
	lphi L_92457c
L_924574:
	ld.ab r4,[r6,0x4]
L_924578:
	st.ab r4,[r17,0x4]
	.global L_92457c
L_92457c:
	sub r4,r14,0x1
L_924580:
	brlo.d r4,0x1,L_924594
L_924584:
	add r13,r13,0x1
L_924588:
	ld r6,[sp]
L_92458c:
	b.d L_924514
L_924590:
	mov r7,-0x4
	.global L_924594
L_924594:
	bl L_9246b0
L_924598:
	add_s sp,sp,0x8
L_92459a:
	ld blink,[sp, 0x4]
L_92459e:
	ld_s r14,[sp,0x8]
L_9245a0:
	ld_s r15,[sp,0xc]
L_9245a2:
	ld r16,[sp, 0x10]
L_9245a6:
	ld r17,[sp, 0x14]
L_9245aa:
	j_s.d [blink]
L_9245ac:
	ld.ab r13,[sp,0x18]
