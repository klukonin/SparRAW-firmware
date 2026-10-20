/* sched__calc_next_start_tsf @ 0x924768, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt
 * Зовёт сам: mac__get_beacon_interval_tu_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sched__calc_next_start_tsf
sched__calc_next_start_tsf:
	.global L_924768
L_924768:
	st.a r13,[sp,-0x10]
L_92476c:
	st blink,[sp, 0x4]
L_924770:
	st_s r14,[sp,0x8]
L_924772:
	st_s r15,[sp,0xc]
L_924774:
	mov_s r14,r0
L_924776:
	ldw_s r13,[r0,0x28]
L_924778:
	bl.d L_9374d8
L_92477c:
	ldw r15,[r0, 0x2a]
L_924780:
	asl r0,r0,0xa
L_924784:
	sub r5,r15,0x1
L_924788:
	ld.as r4,[r14,0x53]
L_92478c:
	add r14,r14,0x200
L_924790:
	ld r2,[r14, -0xd4]
L_924794:
	brhs.d r4,r5,L_9247b0
L_924798:
	ld r3,[r14, -0xd0]
L_92479c:
	add.f r0,r0,r2
L_9247a0:
	mov r5,0x0
L_9247a4:
	adc r3,r3,r5
L_9247a8:
	b.d L_9247f4
L_9247ac:
	sub.f r1,r0,0x19
	.global L_9247b0
L_9247b0:
	brne r5,r4,L_9247dc
L_9247b4:
	add.f r1,r0,r2
L_9247b8:
	mov r4,0x0
L_9247bc:
	adc r3,r3,r4
L_9247c0:
	sub.f r1,r1,0x19
L_9247c4:
	sub_s r13,r13,r15
L_9247c6:
	mulu64 r13,r0
L_9247ca:
	sbc r4,r3,0x0
L_9247ce:
	mov_s r3,0x0
L_9247d0:
	add.f r1,r1,mlo
L_9247d4:
	b.d L_9247f8
L_9247d8:
	adc r3,r3,r4
	.global L_9247dc
L_9247dc:
	sub r13,r13,r4
L_9247e0:
	mulu64 r13,r0
L_9247e4:
	mov r4,0x0
L_9247e8:
	add.f r1,mlo,r2
L_9247ec:
	adc r3,r3,r4
L_9247f0:
	sub.f r1,r1,0x19
	.global L_9247f4
L_9247f4:
	sbc r3,r3,0x0
	.global L_9247f8
L_9247f8:
	st r1,[r14, -0xb0]
L_9247fc:
	ld blink,[sp, 0x4]
L_924800:
	st r3,[r14, -0xac]
L_924804:
	sub_s r1,r1,r2
L_924806:
	ld_s r14,[sp,0x8]
L_924808:
	st r1,[0x803100]
L_924810:
	ld_s r15,[sp,0xc]
L_924812:
	j_s.d [blink]
L_924814:
	ld.ab r13,[sp,0x10]
