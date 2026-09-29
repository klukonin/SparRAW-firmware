/* parse_ese @ 0x8db3cc, 484 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Known ESE
 *   parse_ese function. tbtt:%x, start_allocation:%x, Duration:%x
 *   Number of DTI allocations exceeded: %d. Ignoring allocation
 *   obsolete_allocation. Allocation idx: %d
 *   fw_scheduled_dti.cpp
 * Зовут его: dti__parse_ese_at692, l2mgr__data_port_open, offload__parse_ese_with_flag, rx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r20_to_r13_ret, __st_r14_to_r13, __st_r20_to_r13, allocation_type, bf_h_s8_w2, ese__alloc_matches_id, ese__copy_alloc_header, ese__find_alloc_by_id, ese__set_alloc_type, fw_divmod_signed, fw_log__emit0
 */
	.section .text.parse_ese,"ax",@progbits
	.global parse_ese
parse_ese:
	.global L_8db3cc
L_8db3cc:
	push_s blink
L_8db3ce:
	bl L_8c02c4
L_8db3d2:
	mov_s r13,r0
L_8db3d4:
	ld_s r3,[r0,0xc]
L_8db3d6:
	mov_s r14,0x84861c
L_8db3dc:
	cmp_s r3,0x1
L_8db3de:
	mov_s r3,0x1
L_8db3e0:
	sub_s.ne r3,r3,r3
L_8db3e2:
	ldb_s r1,[r13,0x1]
L_8db3e4:
	add r0,r14,0x10
L_8db3e8:
	bl.d L_8df680
L_8db3ec:
	ldb_s r2,[r13,0x4]
L_8db3ee:
	add r0,r14,0x10
L_8db3f2:
	ldb_s r1,[r13]
L_8db3f4:
	mov_s r2,0x1
L_8db3f6:
	mov_s r3,0x0
L_8db3f8:
	mov_s r4,r3
L_8db3fa:
	mov_s r5,r3
L_8db3fc:
	mov_s r6,r2
L_8db3fe:
	bl.d L_8c46a4
L_8db402:
	mov_s r7,r2
L_8db404:
	b L_8c0334
	.global L_8db408
L_8db408:
	push_s blink
L_8db40a:
	bl L_8c02ac
L_8db40e:
	sub_s sp,sp,0x4
L_8db410:
	mov_s r13,r0
L_8db412:
	ld_s r0,[r1,0xc]
L_8db414:
	mov_s r16,r1
L_8db416:
	ld_s r14,[r0,0x6c]
L_8db418:
	mov_s r0,r13
L_8db41a:
	bl.d L_8d72e8
L_8db41e:
	mov_s r1,r14
L_8db420:
	breq_s r0,0,L_8db432
L_8db422:
	mov_s r2,0x1011938
L_8db428:
	mov_s r0,0xb
L_8db42a:
	bl.d L_8edfb0
L_8db42e:
	mov_s r1,0x2
L_8db430:
	b_s L_8db5ac
	.global L_8db432
L_8db432:
	mov_s r0,r13
L_8db434:
	bl.d L_8e56ec
L_8db438:
	mov_s r1,r14
L_8db43a:
	mov_s r0,0x886f80
L_8db440:
	ld r17,[r0, 0x44]
L_8db444:
	ldb_s r0,[r14,0x7]
L_8db446:
	ldb r4,[r14, 0x6]
L_8db44a:
	asl_s r0,r0,0x8
L_8db44c:
	or r4,r4,r0
L_8db450:
	ldb_s r0,[r14,0x8]
L_8db452:
	mov_s r2,0x1011944
L_8db458:
	asl_s r0,r0,0x10
L_8db45a:
	or r4,r4,r0
L_8db45e:
	ldb_s r0,[r14,0x9]
L_8db460:
	ldb r5,[r14, 0xa]
L_8db464:
	asl_s r0,r0,0x18
L_8db466:
	or r4,r4,r0
L_8db46a:
	ldb_s r0,[r14,0xb]
L_8db46c:
	mov_s r1,0x2
L_8db46e:
	asl_s r0,r0,0x8
L_8db470:
	or r5,r5,r0
L_8db474:
	mov_s r0,0xb
L_8db476:
	bl.d L_8ee034
L_8db47a:
	mov_s r3,r17
L_8db47c:
	mov r18,0x0
L_8db480:
	b_s L_8db498
	.global L_8db482
L_8db482:
	mov_s r2,0x1011984
L_8db488:
	mov_s r0,0xb
L_8db48a:
	mov_s r1,0x0
L_8db48c:
	bl.d L_8edfcc
L_8db490:
	mov_s r3,0x3
	.global L_8db492
L_8db492:
	add r18,r18,0x1
L_8db496:
	add_s r14,r14,0xf
	.global L_8db498
L_8db498:
	ld r0,[r16, 0xc]
L_8db49c:
	ldb r0,[r0, 0x69]
L_8db4a0:
	bl.d L_8c03bc
L_8db4a4:
	mov_s r1,0xf
L_8db4a6:
	cmp_s r0,r18
L_8db4a8:
	ble L_8db5ac
L_8db4ac:
	mov_s r0,r13
L_8db4ae:
	bl.d L_8dcd68
L_8db4b2:
	mov_s r1,r14
L_8db4b4:
	mov r20,0x857260
L_8db4bc:
	ldb r0,[r20, 0xd]
L_8db4c0:
	brge r0,0x3,L_8db482
L_8db4c4:
	ldb_s r0,[r14,0x7]
L_8db4c6:
	ldb_s r1,[r14,0x6]
L_8db4c8:
	asl_s r0,r0,0x8
L_8db4ca:
	or_s r1,r1,r0
L_8db4cc:
	ldb_s r0,[r14,0x8]
L_8db4ce:
	asl_s r0,r0,0x10
L_8db4d0:
	or_s r1,r1,r0
L_8db4d2:
	ldb_s r0,[r14,0x9]
L_8db4d4:
	asl_s r0,r0,0x18
L_8db4d6:
	or_s r1,r1,r0
L_8db4d8:
	mov_s r0,r13
L_8db4da:
	bl.d L_8db268
L_8db4de:
	mov_s r2,r17
L_8db4e0:
	breq_s r0,0,L_8db4f4
L_8db4e2:
	mov_s r2,0x10119c0
L_8db4e8:
	mov_s r0,0xb
L_8db4ea:
	mov_s r1,0x0
L_8db4ec:
	bl.d L_8edfcc
L_8db4f0:
	mov_s r3,r18
L_8db4f2:
	b_s L_8db492
	.global L_8db4f4
L_8db4f4:
	ldb_s r1,[r14,0x4]
L_8db4f6:
	mov_s r0,r13
L_8db4f8:
	bl.d L_8d733c
L_8db4fc:
	ldb_s r2,[r14,0x5]
L_8db4fe:
	breq_s r0,0,L_8db492
L_8db500:
	mov_s r0,0x0
L_8db502:
	mov_s r19,r0
L_8db504:
	stw r0,[sp]
L_8db508:
	ldb_s r1,[r14,0x4]
L_8db50a:
	mov_s r15,0xff
L_8db50c:
	ldb_s r2,[r14,0x5]
L_8db50e:
	ld_s r0,[r13]
L_8db510:
	breq r1,r15,L_8db51a
L_8db514:
	ldb_s r3,[r0,0x8]
L_8db516:
	brne r1,r3,L_8db52e
	.global L_8db51a
L_8db51a:
	bl.d L_8c9ebc
L_8db51e:
	mov_s r1,r2
L_8db520:
	stb_s r0,[sp,0x0]
L_8db522:
	mov_s r0,sp
L_8db524:
	mov_s r1,0x0
L_8db526:
	bl L_8e8300
L_8db52a:
	mov_s r15,r1
L_8db52c:
	b_s L_8db55e
	.global L_8db52e
L_8db52e:
	cmp_s r2,r15
L_8db530:
	cmp.ne r2,r3
L_8db534:
	bne_s L_8db548
L_8db536:
	bl.d L_8c9ebc
L_8db53a:
	mov_s r15,0x1
L_8db53c:
	stb_s r0,[sp,0x0]
L_8db53e:
	mov_s r0,sp
L_8db540:
	mov_s r1,r15
L_8db542:
	bl L_8e8300
L_8db546:
	b_s L_8db55e
	.global L_8db548
L_8db548:
	mov_s r0,blink
L_8db54a:
	mov_s r2,0x10119e8
L_8db550:
	mov_s r1,0x11c2
L_8db556:
	bl.d L_8c82c0
L_8db55a:
	mov_s r3,0x7f
L_8db55c:
	mov_s r15,r19
	.global L_8db55e
L_8db55e:
	ldb_s r0,[r14,0x7]
L_8db560:
	ldb_s r1,[r14,0x6]
L_8db562:
	asl_s r0,r0,0x8
L_8db564:
	or_s r1,r1,r0
L_8db566:
	ldb_s r0,[r14,0x8]
L_8db568:
	asl_s r15,r15,0x1c
L_8db56a:
	asl_s r0,r0,0x10
L_8db56c:
	or_s r1,r1,r0
L_8db56e:
	ldb_s r0,[r14,0x9]
L_8db570:
	asl_s r0,r0,0x18
L_8db572:
	or_s r1,r1,r0
L_8db574:
	mov_s r0,r13
L_8db576:
	bl.d L_8c97e0
L_8db57a:
	mov_s r2,r17
L_8db57c:
	ldb r1,[r20, 0xd]
L_8db580:
	mov_s r2,0x857000
L_8db586:
	add2_s r2,r2,r1
L_8db588:
	st.as r0,[r2,0x9f]
L_8db58c:
	ldb_s r0,[r14,0xb]
L_8db58e:
	ldb_s r3,[r14,0xa]
L_8db590:
	asl_s r0,r0,0x8
L_8db592:
	or_s r3,r3,r0
L_8db594:
	ldw r0,[sp]
L_8db598:
	st.as r3,[r2,0xa2]
L_8db59c:
	or_s r0,r0,r15
L_8db59e:
	st.as r0,[r2,0x9c]
L_8db5a2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8db5a4:
	extb_s r1,r1
L_8db5a6:
	stb r1,[r20, 0xd]
L_8db5aa:
	b_s L_8db492
	.global L_8db5ac
L_8db5ac:
	b.d L_8c0304
