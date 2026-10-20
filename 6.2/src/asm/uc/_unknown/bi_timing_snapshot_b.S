/* bi_timing_snapshot_b @ 0x922354, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__dispatch
 * Зовёт сам: bi__tsf_delta64, mac__read_tsf64_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_timing_snapshot_b
bi_timing_snapshot_b:
	.global L_922354
L_922354:
	st.a r13,[sp,-0x8]
L_922358:
	st_s r14,[sp,0x4]
L_92235a:
	mov_s r14,blink
L_92235c:
	mov_s r13,0x802ec0
L_922362:
	ld_s r0,[r13,0x18]
L_922364:
	bl.d L_924818
L_922368:
	ld r1,[r13, 0x1c]
L_92236c:
	st r0,[r13, 0x20]
L_922370:
	bl.d L_9356cc
L_922374:
	add r0,r13,0x18
L_922378:
	ld.as r2,[gp,-0x11]
L_92237c:
	and r2,r2,0xffff0fff
L_922384:
	bset r1,r2,0xe
L_922388:
	or r2,r2,0x1d004000
L_922390:
	st.as r1,[gp,-0x11]
L_922394:
	mov r32,r2
L_922398:
	st.ab r2,[r25,0x4]
L_92239c:
	bclr r25,r25,0xa
L_9223a0:
	nop_s
L_9223a2:
	nop_s
L_9223a4:
	mov 0x0,0x0
L_9223a8:
	bmsk r5,r40,0x19
L_9223ac:
	mov r7,0x802ec0
L_9223b4:
	ld r3,[r7, 0x38]
L_9223b8:
	breq.d r3,0x0,L_922418
L_9223bc:
	st r5,[r7, 0x34]
L_9223c0:
	ld r0,[r7, 0x20]
L_9223c4:
	brhs r0,0x168f0,L_9223dc
L_9223cc:
	ld r2,[r7, 0x24]
L_9223d0:
	add r2,r2,0x1
L_9223d4:
	b.d L_9223f0
L_9223d8:
	st r2,[r7, 0x24]
	.global L_9223dc
L_9223dc:
	brhs 0x1b710,r0,L_9223f0
L_9223e4:
	ld r1,[r7, 0x28]
L_9223e8:
	add r1,r1,0x1
L_9223ec:
	st r1,[r7, 0x28]
	.global L_9223f0
L_9223f0:
	ld r3,[r7, 0x2c]
L_9223f4:
	cmp r3,r0
L_9223f8:
	mov.cc r4,r0
L_9223fc:
	mov.cs r4,r3
L_922400:
	st r4,[r7, 0x2c]
L_922404:
	ld r4,[r7, 0x30]
L_922408:
	cmp r4,r0
L_92240c:
	mov.hi r0,r4
L_922410:
	b.d L_922420
L_922414:
	st r0,[r7, 0x30]
	.global L_922418
L_922418:
	mov r5,-0x1
L_92241c:
	st r5,[r7, 0x2c]
	.global L_922420
L_922420:
	mov r4,0x801030
L_922428:
	ldb r3,[r4, 0x50]
L_92242c:
	mov r6,0x1
L_922430:
	/* asl_s r3,r3,0x3 */
	.byte 0x03,0xbb
L_922432:
	st r6,[r7, 0x38]
L_922436:
	ld r6,[r7, 0x18]
L_92243a:
	add2_s r3,r3,r3
L_92243c:
	add r4,r4,r3
L_922440:
	ld r5,[r7, 0x1c]
L_922444:
	st r6,[r4, 0x8]
L_922448:
	st r5,[r4, 0xc]
L_92244c:
	mov_s blink,r14
L_92244e:
	ld_s r14,[sp,0x4]
L_922450:
	j.d [blink]
L_922454:
	ld.ab r13,[sp,0x8]
