/* sched__alloc_changed @ 0x8da3f4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations_from_beacon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__alloc_changed
sched__alloc_changed:
	.global L_8da3f4
L_8da3f4:
	push_s r13
L_8da3f6:
	mov_s r3,0x803c00
L_8da3fc:
	ld_s r13,[r3,0x10]
L_8da3fe:
	ld_s r3,[r0]
L_8da400:
	breq_s r13,0,L_8da41e
L_8da402:
	ld_s r1,[r3,0x4]
L_8da404:
	ldb_s r1,[r1,0x1]
L_8da406:
	brne r2,r1,L_8da410
L_8da40a:
	ldb_s r1,[r0,0x18]
L_8da40c:
	brne r1,0x10,L_8da416
	.global L_8da410
L_8da410:
	mov_s r1,0x0
L_8da412:
	stb_s r1,[r0,0x18]
L_8da414:
	b_s L_8da42e
	.global L_8da416
L_8da416:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8da418:
	stb_s r1,[r0,0x18]
L_8da41a:
	mov_s r0,0x0
L_8da41c:
	b_s L_8da45a
	.global L_8da41e
L_8da41e:
	ld_s r2,[r3,0x4]
L_8da420:
	ldb_s r0,[r2,0x1]
L_8da422:
	cmp_s r0,0x0
L_8da424:
	mov_s r0,0x1
L_8da426:
	sub_s.ne r0,r0,r0
L_8da428:
	extb.f 0x0,r0
L_8da42c:
	beq_s L_8da432
	.global L_8da42e
L_8da42e:
	mov_s r0,0x1
L_8da430:
	b_s L_8da45a
	.global L_8da432
L_8da432:
	ld.a r3,[r2,0x4]
L_8da436:
	ldb_s r0,[r1]
L_8da438:
	bmsk_s r3,r3,0x3
L_8da43a:
	bmsk_s r0,r0,0x3
L_8da43c:
	mov_s r13,0x0
L_8da43e:
	brne r3,r0,L_8da456
L_8da442:
	ldb_s r3,[r2,0x2]
L_8da444:
	ldb_s r0,[r1,0x4]
L_8da446:
	brne r3,r0,L_8da456
L_8da44a:
	ldb_s r2,[r2,0x3]
L_8da44c:
	ldb_s r0,[r1,0x5]
L_8da44e:
	cmp_s r2,r0
L_8da450:
	mov.eq r0,r13
L_8da454:
	beq_s L_8da458
	.global L_8da456
L_8da456:
	mov_s r0,0x1
	.global L_8da458
L_8da458:
	extb_s r0,r0
	.global L_8da45a
L_8da45a:
	j_s.d [blink]
L_8da45c:
	pop_s r13
L_8da45e:
	nop_s
