/* qh__write_by_flags @ 0x92d488, 384 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwif_write_qh, qh_write_while_dma_open_check
 * Зовёт сам: qh__build_descriptor, qh__pack_descriptor, qh__write_desc_window, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__write_by_flags
qh__write_by_flags:
	.global L_92d488
L_92d488:
	st.a r13,[sp,-0x18]
L_92d48c:
	st blink,[sp, 0x4]
L_92d490:
	st_s r14,[sp,0x8]
L_92d492:
	st_s r15,[sp,0xc]
L_92d494:
	st r16,[sp, 0x10]
L_92d498:
	st r17,[sp, 0x14]
L_92d49c:
	sub_s sp,sp,0x10
L_92d49e:
	mov_s r14,r0
L_92d4a0:
	mov_s r13,r1
L_92d4a2:
	and r5,r1,0x21
L_92d4a6:
	cmp r5,0x21
L_92d4aa:
	mov_s r15,r2
L_92d4ac:
	beq.d L_92d5f8
L_92d4b0:
	mov r17,r3
	.global L_92d4b4
L_92d4b4:
	bbit0 r13,0x4,L_92d4e4
L_92d4b8:
	add3 r16,r15,0x8
L_92d4bc:
	mov_s r0,r14
L_92d4be:
	mov_s r1,r17
L_92d4c0:
	bl.d L_92d428
L_92d4c4:
	mov r2,r16
L_92d4c8:
	mov_s r0,r16
L_92d4ca:
	mov_s r1,r14
L_92d4cc:
	mov_s r2,0x2
L_92d4ce:
	mov_s r3,0x3
L_92d4d0:
	mov r4,0x0
L_92d4d4:
	mov r5,r4
L_92d4d8:
	mov r6,r4
L_92d4dc:
	bl.d L_924348
L_92d4e0:
	mov r7,r3
	.global L_92d4e4
L_92d4e4:
	bbit0 r13,0x0,L_92d500
L_92d4e8:
	mov_s r0,r15
L_92d4ea:
	mov_s r1,r14
L_92d4ec:
	mov_s r2,0x2
L_92d4ee:
	mov_s r3,0x0
L_92d4f0:
	mov_s r4,r3
L_92d4f2:
	mov_s r5,r3
L_92d4f4:
	mov r6,r3
L_92d4f8:
	bl.d L_924348
L_92d4fc:
	mov r7,0x1
	.global L_92d500
L_92d500:
	bbit0 r13,0x1,L_92d520
L_92d504:
	add r0,r15,0x10
L_92d508:
	mov_s r1,r14
L_92d50a:
	mov_s r2,0x2
L_92d50c:
	mov_s r3,0x0
L_92d50e:
	mov_s r4,r3
L_92d510:
	mov r5,r3
L_92d514:
	mov r6,0x1
L_92d518:
	bl.d L_924348
L_92d51c:
	mov r7,r6
	.global L_92d520
L_92d520:
	bbit0 r13,0x2,L_92d53c
L_92d524:
	add r0,r15,0x20
L_92d528:
	mov_s r1,r14
L_92d52a:
	mov_s r2,0x2
L_92d52c:
	mov_s r3,0x0
L_92d52e:
	mov_s r4,r3
L_92d530:
	mov_s r5,r3
L_92d532:
	mov_s r6,r2
L_92d534:
	bl.d L_924348
L_92d538:
	mov r7,0x1
	.global L_92d53c
L_92d53c:
	bbit0 r13,0x3,L_92d55c
L_92d540:
	add r0,r15,0x30
L_92d544:
	mov_s r1,r14
L_92d546:
	mov_s r2,0x2
L_92d548:
	mov_s r3,0x0
L_92d54a:
	mov_s r4,r3
L_92d54c:
	mov r5,r3
L_92d550:
	mov r6,0x3
L_92d554:
	bl.d L_924348
L_92d558:
	mov r7,0x1
	.global L_92d55c
L_92d55c:
	bbit0 r13,0x5,L_92d5e0
L_92d560:
	mov_s r13,sp
L_92d562:
	mov_s r0,r13
L_92d564:
	mov_s r1,r14
L_92d566:
	mov_s r2,0x2
L_92d568:
	mov_s r3,0x0
L_92d56a:
	mov_s r4,r3
L_92d56c:
	mov r5,0x1
L_92d570:
	bl.d L_92420c
L_92d574:
	mov r6,0x4
L_92d578:
	ldw r6,[r15, 0x6]
L_92d57c:
	ld_s r3,[sp,0x8]
L_92d57e:
	stw r6,[sp, 0x6]
L_92d582:
	ldw r7,[r15, 0x4]
L_92d586:
	mov_s r2,0xfffff000
L_92d58c:
	stw r7,[sp, 0x4]
L_92d590:
	ld r4,[r15, 0x8]
L_92d594:
	and_s r3,r3,r2
L_92d596:
	bmsk r4,r4,0xb
L_92d59a:
	or r3,r3,r4
L_92d59e:
	st_s r3,[sp,0x8]
L_92d5a0:
	ld_s r0,[r15,0xc]
L_92d5a2:
	ld_s r1,[sp,0xc]
L_92d5a4:
	lsr_s r0,r0,0x4
L_92d5a6:
	bmsk_s r0,r0,0xb
L_92d5a8:
	ror r1,r1,0x4
L_92d5ac:
	and_s r1,r1,r2
L_92d5ae:
	or_s r0,r0,r1
L_92d5b0:
	ror r3,r0,0x1c
L_92d5b4:
	st_s r3,[sp,0xc]
L_92d5b6:
	ld_s r1,[r15,0xc]
L_92d5b8:
	ror r3,r3,0x10
L_92d5bc:
	lsr_s r1,r1,0x10
L_92d5be:
	bmsk_s r1,r1,0xb
L_92d5c0:
	and_s r2,r2,r3
L_92d5c2:
	or_s r1,r1,r2
L_92d5c4:
	ror r1,r1,0x10
L_92d5c8:
	st_s r1,[sp,0xc]
L_92d5ca:
	mov_s r0,r13
L_92d5cc:
	mov_s r1,r14
L_92d5ce:
	mov_s r2,0x2
L_92d5d0:
	mov_s r3,0x0
L_92d5d2:
	mov_s r4,r3
L_92d5d4:
	mov_s r5,r3
L_92d5d6:
	mov_s r6,r3
L_92d5d8:
	bl.d L_924348
L_92d5dc:
	mov r7,0x1
	.global L_92d5e0
L_92d5e0:
	add_s sp,sp,0x10
L_92d5e2:
	ld blink,[sp, 0x4]
L_92d5e6:
	ld_s r14,[sp,0x8]
L_92d5e8:
	ld_s r15,[sp,0xc]
L_92d5ea:
	ld r16,[sp, 0x10]
L_92d5ee:
	ld r17,[sp, 0x14]
L_92d5f2:
	j_s.d [blink]
L_92d5f4:
	ld.ab r13,[sp,0x18]
	.global L_92d5f8
L_92d5f8:
	mov_s r0,blink
L_92d5fa:
	mov_s r1,0x1585
L_92d600:
	bl L_926618
L_92d604:
	b_s L_92d4b4
L_92d606:
	nop_s
