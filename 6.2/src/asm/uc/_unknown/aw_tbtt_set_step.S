/* aw_tbtt_set_step @ 0x935560, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt
 * Зовёт сам: aw_tbtt__count_intervals, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw_tbtt_set_step
aw_tbtt_set_step:
	.global L_935560
L_935560:
	st.a r13,[sp,-0x14]
L_935564:
	st blink,[sp, 0x4]
L_935568:
	st_s r14,[sp,0x8]
L_93556a:
	st_s r15,[sp,0xc]
L_93556c:
	st r16,[sp, 0x10]
L_935570:
	mov_s r15,r0
L_935572:
	ld r10,[r2]
L_935576:
	mov_s r14,r2
L_935578:
	mov r13,r1
L_93557c:
	breq.d r10,0x0,L_935620
L_935580:
	ld r3,[r1]
L_935584:
	brne.d r3,0x0,L_9355c4
L_935588:
	ldb r4,[r14, 0x4]
L_93558c:
	brne r4,0x1,L_935620
L_935590:
	ld.as r1,[r15,0x4b]
L_935594:
	ld r11,[r14, 0x8]
L_935598:
	sub r1,r1,r11
L_93559c:
	brhs r1,0x80000000,L_935620
L_9355a4:
	mov_s r0,0x1
L_9355a6:
	st_s r0,[r13]
L_9355a8:
	ld r5,[r14, 0x8]
L_9355ac:
	mov r1,0x0
L_9355b0:
	ld r8,[r14, 0xc]
L_9355b4:
	st r5,[r13, 0x4]
L_9355b8:
	st r8,[r13, 0x8]
L_9355bc:
	b.d L_93561c
L_9355c0:
	st r1,[r14]
	.global L_9355c4
L_9355c4:
	brne r4,0x0,L_9355e4
L_9355c8:
	mov r16,0x0
L_9355cc:
	mov r0,r13
L_9355d0:
	bl.d L_920a84
L_9355d4:
	mov r1,0xc
L_9355d8:
	st r16,[r13]
L_9355dc:
	b.d L_93561c
L_9355e0:
	st r16,[r14]
	.global L_9355e4
L_9355e4:
	brne r4,0x1,L_935620
L_9355e8:
	ld.as r2,[r15,0x4b]
L_9355ec:
	ld r4,[r14, 0x8]
L_9355f0:
	sub r2,r2,r4
L_9355f4:
	brhs r2,0x80000000,L_935620
L_9355fc:
	mov r6,0x1
L_935600:
	st r6,[r13]
L_935604:
	ld r7,[r14, 0x8]
L_935608:
	mov r5,0x0
L_93560c:
	ld r9,[r14, 0xc]
L_935610:
	st r7,[r13, 0x4]
L_935614:
	st r9,[r13, 0x8]
L_935618:
	st r5,[r14]
	.global L_93561c
L_93561c:
	ld r3,[r13]
	.global L_935620
L_935620:
	cmp r3,0x0
L_935624:
	mov.ne r0,r15
L_935628:
	bl.ne.d L_9353ac
L_93562c:
	mov.ne r1,r13
L_935630:
	ld blink,[sp, 0x4]
L_935634:
	ld_s r14,[sp,0x8]
L_935636:
	ld_s r15,[sp,0xc]
L_935638:
	ld r16,[sp, 0x10]
L_93563c:
	j.d [blink]
L_935640:
	ld.ab r13,[sp,0x14]
