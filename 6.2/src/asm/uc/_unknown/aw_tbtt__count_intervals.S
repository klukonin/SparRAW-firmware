/* aw_tbtt__count_intervals @ 0x9353ac, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_tbtt_set_step
 * Зовёт сам: mac__get_beacon_interval_tu_uc, uc_divmod_unsigned
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw_tbtt__count_intervals
aw_tbtt__count_intervals:
	.global L_9353ac
L_9353ac:
	st.a r13,[sp,-0xc]
L_9353b0:
	st blink,[sp, 0x4]
L_9353b4:
	st_s r14,[sp,0x8]
L_9353b6:
	mov_s r14,r0
L_9353b8:
	bl.d L_9374d8
L_9353bc:
	mov r13,r1
L_9353c0:
	ld.as r3,[r14,0x4b]
L_9353c4:
	ld_s r1,[r13,0x4]
L_9353c6:
	extb_s r0,r0
L_9353c8:
	sub r3,r3,r1
L_9353cc:
	brlt.d r0,0x1,L_9353ec
L_9353d0:
	lsr r3,r3,0xa
L_9353d4:
	brhs r3,0x3f,L_9353ec
L_9353d8:
	mov r5,0x0
	.global L_9353dc
L_9353dc:
	sub.f r3,r3,r0
L_9353e0:
	bhi.d L_9353dc
L_9353e4:
	add.cc r5,r5,0x1
L_9353e8:
	b L_935448
	.global L_9353ec
L_9353ec:
	breq r0,0x0,L_935438
L_9353f0:
	mov r5,0x0
L_9353f4:
	norm.f r11,r3
L_9353f8:
	sub r5,r5,0x1
L_9353fc:
	mov.mi r11,r5
L_935400:
	norm.f r10,r0
L_935404:
	mov.mi r10,r5
L_935408:
	sub.f r5,r10,r11
L_93540c:
	mov.mi r5,0x0
L_935410:
	add lp_count,r5,0x1
L_935414:
	asl.pl r0,r0,r5
L_935418:
	mov r5,0x0
L_93541c:
	lp L_935430
L_935420:
	sub.f r3,r3,r0
L_935424:
	bset.cc r5,r5,lp_count
L_935428:
	add.cs r3,r3,r0
L_93542c:
	lsr r0,r0
	.global L_935430
L_935430:
	b.d L_935448
L_935434:
	ror r5,r5
	.global L_935438
L_935438:
	mov r1,r0
L_93543c:
	bl.d L_9203e0
L_935440:
	mov r0,r3
L_935444:
	mov r5,r0
	.global L_935448
L_935448:
	ldw_s r2,[r13,0x8]
L_93544a:
	mov_s r3,0x801030
L_935450:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_935452:
	and r2,r2,r5
L_935456:
	st.as r2,[r14,0x53]
L_93545a:
	ldw r4,[r13, 0xa]
L_93545e:
	brhs r2,r4,L_93547c
L_935462:
	mov r4,0x1
L_935466:
	st r4,[r13]
L_93546a:
	st r4,[r3, 0xd0]
L_93546e:
	ld blink,[sp, 0x4]
L_935472:
	ld_s r14,[sp,0x8]
L_935474:
	j.d [blink]
L_935478:
	ld.ab r13,[sp,0xc]
	.global L_93547c
L_93547c:
	mov r5,0x2
L_935480:
	st r5,[r13]
L_935484:
	st r5,[r3, 0xd0]
L_935488:
	ld r6,[r14, 0x1c]
L_93548c:
	brne r6,0x0,L_9354b4
L_935490:
	ldw r8,[r13, 0x8]
L_935494:
	brlt r8,0x2,L_9354b4
L_935498:
	ld r7,[r14, 0x18]
L_93549c:
	brne r7,0x1,L_9354b4
L_9354a0:
	mov r9,0x1
L_9354a4:
	st r9,[r14, 0x1c]
L_9354a8:
	ld blink,[sp, 0x4]
L_9354ac:
	ld_s r14,[sp,0x8]
L_9354ae:
	j_s.d [blink]
L_9354b0:
	ld.ab r13,[sp,0xc]
	.global L_9354b4
L_9354b4:
	ld blink,[sp, 0x4]
L_9354b8:
	ld_s r14,[sp,0x8]
L_9354ba:
	j_s.d [blink]
L_9354bc:
	ld.ab r13,[sp,0xc]
