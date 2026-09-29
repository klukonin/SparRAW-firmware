/* bf__abort_unexpected @ 0x9283dc, 344 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ABORT unexpected BF of new sta  sta_id=%d request_fifo_head=%d
 *   ABORT unexpected BF of defualt sta  sta_id=%d request_fifo_head=%d
 * Зовут его: bi_manager__rx_flow_kind1, rx_funcs__rx_flow
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_sm__clear_pending, bf_sm__mark_sta_active
 */
	.section .text.bf__abort_unexpected,"ax",@progbits
	.global bf__abort_unexpected
bf__abort_unexpected:
	.global L_9283dc
L_9283dc:
	push_s blink
L_9283de:
	bl L_920210
L_9283e2:
	mov_s r3,0x800ef4
L_9283e8:
	ld_s r2,[r3,0x6c]
L_9283ea:
	cmp_s r2,0x0
L_9283ec:
	beq_s L_928526
L_9283ee:
	ld_s r2,[r3,0x78]
L_9283f0:
	mov_s r13,0x800f64
L_9283f6:
	bmsk_s r2,r2,0x2
L_9283f8:
	ldb_s r2,[r13,r2]
L_9283fa:
	cmp_s r0,r2
L_9283fc:
	beq_s L_928518
L_9283fe:
	ld_s r15,[r3,0x6c]
L_928400:
	mov_s r2,0x0
L_928402:
	mov_s r14,0x1
L_928404:
	bbit0 r15,0x8,L_92841a
L_928408:
	ld_s r15,[r3,0x6c]
L_92840a:
	bbit1 r15,r0,L_92841a
L_92840e:
	ld_s r15,[r3,0x78]
L_928410:
	bmsk_s r15,r15,0x2
L_928412:
	ldb_s r15,[r13,r15]
L_928414:
	cmp_s r15,0x8
L_928416:
	mov.eq r2,r14
	.global L_92841a
L_92841a:
	extb.f 0x0,r2
L_92841e:
	bne_s L_928502
L_928420:
	ld_s r1,[r3,0x78]
L_928422:
	mov_s r14,0x80209c
L_928428:
	bmsk_s r1,r1,0x2
L_92842a:
	ldb_s r1,[r13,r1]
L_92842c:
	ldb_s r2,[r14,0x5]
L_92842e:
	breq r0,0x8,L_9284a8
L_928432:
	mov r5,0x1000768
L_92843a:
	bbit0 r2,0x2,L_92847c
L_92843e:
	ld_s r15,[r14]
L_928440:
	mov r4,0x8020b0
L_928448:
	add r6,r15,0x2
L_92844c:
	extb r6,r6
L_928450:
	add2 r6,r4,r6
L_928454:
	st r1,[r6]
L_928458:
	add_s r2,r15,0x1
L_92845a:
	extb_s r2,r2
L_92845c:
	add2 r2,r4,r2
L_928460:
	st_s r0,[r2]
L_928462:
	bmsk r2,r5,0x13
L_928466:
	or r5,r2,0xaa100000
L_92846e:
	extb_s r2,r15
L_928470:
	add2 r2,r4,r2
L_928474:
	st r5,[r2]
L_928478:
	/* add_s r15,0x3 */
	.byte 0x03,0xe7
L_92847a:
	st_s r15,[r14]
	.global L_92847c
L_92847c:
	ld_s r2,[r3,0x6c]
L_92847e:
	bclr r2,r2,r1
L_928482:
	st_s r2,[r3,0x6c]
L_928484:
	ld_s r1,[r3,0x6c]
L_928486:
	mov_s r2,0x0
L_928488:
	bset r1,r1,r0
L_92848c:
	st_s r1,[r3,0x6c]
L_92848e:
	ld_s r1,[r3,0x78]
L_928490:
	bmsk_s r1,r1,0x2
L_928492:
	add_s r13,r13,r1
L_928494:
	asl_s r1,r0,0x2
L_928496:
	stb_s r0,[r13]
L_928498:
	add1_s r1,r1,r1
L_92849a:
	add_s r3,r3,r1
L_92849c:
	mov_s r13,0xb
L_92849e:
	st_s r13,[r3]
L_9284a0:
	st_s r2,[r3,0x4]
L_9284a2:
	mov_s r1,0x35
L_9284a4:
	st_s r1,[r3,0x4]
L_9284a6:
	b_s L_9284fa
	.global L_9284a8
L_9284a8:
	mov r4,0x10007a8
L_9284b0:
	bbit0 r2,0x2,L_9284e6
L_9284b4:
	ld_s r2,[r14]
L_9284b6:
	mov_s r13,0x8020b0
L_9284bc:
	add_s r15,r2,0x2
L_9284be:
	extb_s r15,r15
L_9284c0:
	add2 r15,r13,r15
L_9284c4:
	st_s r1,[r15]
L_9284c6:
	add_s r15,r2,0x1
L_9284c8:
	extb_s r15,r15
L_9284ca:
	add2 r15,r13,r15
L_9284ce:
	st_s r0,[r15]
L_9284d0:
	bmsk r0,r4,0x13
L_9284d4:
	or r0,r0,0xaa100000
L_9284dc:
	extb_s r15,r2
L_9284de:
	add2_s r13,r13,r15
L_9284e0:
	st_s r0,[r13]
L_9284e2:
	/* add_s r2,0x3 */
	.byte 0x03,0xe2
L_9284e4:
	st_s r2,[r14]
	.global L_9284e6
L_9284e6:
	mov_s r13,0xb
L_9284e8:
	mov_s r2,0x0
L_9284ea:
	asl_s r0,r1,0x2
L_9284ec:
	add1_s r0,r0,r0
L_9284ee:
	add_s r3,r3,r0
L_9284f0:
	st_s r13,[r3]
L_9284f2:
	st_s r2,[r3,0x4]
L_9284f4:
	mov_s r0,0x35
L_9284f6:
	st_s r0,[r3,0x4]
L_9284f8:
	mov_s r0,r1
	.global L_9284fa
L_9284fa:
	bl L_92208c
L_9284fe:
	mov_s r0,0x0
L_928500:
	b_s L_92852e
	.global L_928502
L_928502:
	ld_s r2,[r3,0x6c]
L_928504:
	bclr_s r2,r2,0x8
L_928506:
	st_s r2,[r3,0x6c]
L_928508:
	ld_s r2,[r3,0x6c]
L_92850a:
	bset r2,r2,r0
L_92850e:
	st_s r2,[r3,0x6c]
L_928510:
	ld_s r2,[r3,0x78]
L_928512:
	bmsk_s r2,r2,0x2
L_928514:
	add_s r13,r13,r2
L_928516:
	stb_s r0,[r13]
	.global L_928518
L_928518:
	mov_s r2,0x0
L_92851a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92851c:
	add1_s r0,r0,r0
L_92851e:
	add_s r3,r3,r0
L_928520:
	st_s r1,[r3]
L_928522:
	st_s r2,[r3,0x4]
L_928524:
	b_s L_92852c
	.global L_928526
L_928526:
	bl.d L_922448
L_92852a:
	extb_s r0,r0
	.global L_92852c
L_92852c:
	mov_s r0,0x1
	.global L_92852e
L_92852e:
	b L_92027c
L_928532:
	nop_s
