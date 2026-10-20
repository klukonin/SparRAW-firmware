/* calc_awake_tsf @ 0x924434, 272 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calc_awake_tsf: %x
 * Зовут его: aw__set_new_tbtt
 * Зовёт сам: get_reg_886d64_93256c
 */
	.section .text.calc_awake_tsf,"ax",@progbits
	.global calc_awake_tsf
calc_awake_tsf:
	.global L_924434
L_924434:
	st.a r13,[sp,-0x10]
L_924438:
	st blink,[sp, 0x4]
L_92443c:
	st_s r14,[sp,0x8]
L_92443e:
	st_s r15,[sp,0xc]
L_924440:
	mov_s r14,r0
L_924442:
	ldw_s r13,[r0,0x28]
L_924444:
	bl.d L_93256c
L_924448:
	ldw r15,[r0, 0x2a]
L_92444c:
	asl r0,r0,0xa
L_924450:
	sub r9,r15,0x1
L_924454:
	ld.as r7,[r14,0x53]
L_924458:
	add r5,r14,0x200
L_924460:
	ld r6,[r5, -0xd4]
L_924464:
	brhs.d r7,r9,L_924480
L_924468:
	ld r1,[r5, -0xd0]
L_92446c:
	add.f r0,r0,r6
L_924470:
	mov_s r3,0x0
L_924472:
	adc r1,r1,r3
L_924476:
	add.f r3,r0,0xfffffff1
L_92447e:
	b_s L_9244c4
	.global L_924480
L_924480:
	brne r9,r7,L_9244ac
L_924484:
	add.f r3,r0,r6
L_924488:
	mov_s r2,0x0
L_92448a:
	adc r1,r1,r2
L_92448e:
	add.f r3,r3,-0xf
L_924492:
	sub_s r13,r13,r15
L_924494:
	mulu64 r13,r0
L_924498:
	adc r10,r1,0xffffffff
L_9244a0:
	add.f r3,r3,mlo
L_9244a4:
	b.d L_9244c8
L_9244a8:
	adc r1,r2,r10
	.global L_9244ac
L_9244ac:
	sub r13,r13,r7
L_9244b0:
	mulu64 r13,r0
L_9244b4:
	mov r2,0x0
L_9244b8:
	add.f r3,mlo,r6
L_9244bc:
	adc r1,r1,r2
L_9244c0:
	add.f r3,r3,-0xf
	.global L_9244c4
L_9244c4:
	adc r1,r1,-0x1
	.global L_9244c8
L_9244c8:
	st r3,[r5, -0xb0]
L_9244cc:
	st r1,[r5, -0xac]
L_9244d0:
	mov r7,0x80209c
L_9244d8:
	ldb r0,[r7, 0x4]
L_9244dc:
	mov r2,0x1002e64
L_9244e4:
	bbit0.d r0,0x2,L_92452c
L_9244e8:
	ld.as r9,[r14,0x54]
L_9244ec:
	ld r4,[r7]
L_9244f0:
	mov r8,0x8020b0
L_9244f8:
	add r10,r4,0x1
L_9244fc:
	extb r10,r10
L_924500:
	add2 r10,r8,r10
L_924504:
	st r9,[r10]
L_924508:
	extb r1,r4
L_92450c:
	bmsk_s r2,r2,0x13
L_92450e:
	or r2,r2,0xa6000000
L_924516:
	add2 r1,r8,r1
L_92451a:
	add r4,r4,0x2
L_92451e:
	st_s r2,[r1]
L_924520:
	st r4,[r7]
L_924524:
	ld r6,[r5, -0xd4]
L_924528:
	ld r3,[r5, -0xb0]
	.global L_92452c
L_92452c:
	sub r3,r3,r6
L_924530:
	st.as r3,[gp,-0x2b]
L_924534:
	ld blink,[sp, 0x4]
L_924538:
	ld_s r14,[sp,0x8]
L_92453a:
	ld_s r15,[sp,0xc]
L_92453c:
	j.d [blink]
L_924540:
	ld.ab r13,[sp,0x10]
