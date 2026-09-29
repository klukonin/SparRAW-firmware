/* rx_flow__measure_snr_select_best @ 0x92d688, 428 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Глобалы (через gp): 0x800560, 0x8005b2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow__measure_snr_select_best
rx_flow__measure_snr_select_best:
	.global L_92d688
L_92d688:
	st.a r13,[sp,-0x10]
L_92d68c:
	st_s r14,[sp,0x4]
L_92d68e:
	st_s r15,[sp,0x8]
L_92d690:
	st r16,[sp, 0xc]
L_92d694:
	sub_s sp,sp,0x40
L_92d696:
	mov r8,0x883000
L_92d69e:
	ld r16,[r8, 0x6c]
L_92d6a2:
	ld r7,[0x8025dc]
L_92d6aa:
	mov_s r15,0x0
L_92d6ac:
	st r7,[r8, 0x6c]
L_92d6b0:
	ldb r11,[0x8021b8]
L_92d6b8:
	mov r14,0x883800
L_92d6c0:
	cmp r11,0x0
L_92d6c4:
	mov.ls r9,r15
L_92d6c8:
	bls.d L_92d77c
L_92d6cc:
	mov.ls r11,r15
L_92d6d0:
	mov_s r13,0x80183c
L_92d6d6:
	mov_s r9,r15
L_92d6d8:
	mov r11,r15
	.global L_92d6dc
L_92d6dc:
	ld r8,[r14, 0x30]
L_92d6e0:
	ld r10,[r14, 0x30]
L_92d6e4:
	bmsk r8,r8,0x6
L_92d6e8:
	ld_s r2,[r14,0x30]
L_92d6ea:
	bmsk r10,r10,0x6
L_92d6ee:
	ld_s r3,[r14,0x30]
L_92d6f0:
	bmsk_s r2,r2,0x6
L_92d6f2:
	ld r4,[r14, 0x30]
L_92d6f6:
	bmsk_s r3,r3,0x6
L_92d6f8:
	ld r5,[r14, 0x30]
L_92d6fc:
	bmsk r4,r4,0x6
L_92d700:
	ld r7,[r14, 0x30]
L_92d704:
	bmsk r5,r5,0x6
L_92d708:
	ld r6,[r14, 0x30]
L_92d70c:
	bmsk r7,r7,0x6
L_92d710:
	ld.as r8,[r13,r8]
L_92d714:
	ld.as r1,[r13,r10]
L_92d718:
	bmsk r6,r6,0x6
L_92d71c:
	ld.as r0,[r13,r2]
L_92d720:
	add_s r1,r1,r8
L_92d722:
	ld.as r2,[r13,r3]
L_92d726:
	add_s r0,r0,r1
L_92d728:
	ld.as r1,[r13,r4]
L_92d72c:
	ld.as r3,[r13,r5]
L_92d730:
	add_s r0,r0,r2
L_92d732:
	ld.as r4,[r13,r7]
L_92d736:
	add_s r3,r3,r1
L_92d738:
	ld.as r5,[r13,r6]
L_92d73c:
	add r4,r4,r3
L_92d740:
	add r5,r5,r4
L_92d744:
	add_s r0,r0,r5
L_92d746:
	mov r5,r42
L_92d74a:
	bbit1 r5,0xe,L_92d774
L_92d74e:
	mov r6,r49
L_92d752:
	bbit1 r6,0xd,L_92d774
L_92d756:
	add_s r15,r15,r0
L_92d758:
	add2 r1,sp,r11
L_92d75c:
	ldb r0,[0x8021b8]
L_92d764:
	add r9,r9,0x8
L_92d768:
	st r15,[r1]
L_92d76c:
	brlo.d r9,r0,L_92d6dc
L_92d770:
	add r11,r11,0x1
	.global L_92d774
L_92d774:
	mov r8,0x883000
	.global L_92d77c
L_92d77c:
	ld.as r6,[r14,0xbb]
L_92d780:
	mov_s r1,0x802204
L_92d786:
	lsr r6,r6,0x9
L_92d78a:
	bmsk r6,r6,0x8
L_92d78e:
	sub r0,r6,0x200
L_92d796:
	cmp r6,0xff
L_92d79a:
	mov.le r0,r6
L_92d79e:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_92d7a0:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_92d7a2:
	st_s r0,[r1,0x8]
L_92d7a4:
	st r16,[r8, 0x6c]
L_92d7a8:
	stb r9,[0x801021]
L_92d7b0:
	breq r9,0x0,L_92d824
L_92d7b4:
	norm r11,r11
L_92d7b8:
	rsub r0,r11,0x1e
L_92d7bc:
	asl r8,0x1,r0
L_92d7c4:
	sub r8,r8,0x1
L_92d7c8:
	norm r9,r9
L_92d7cc:
	rsub r2,r9,0x1e
L_92d7d0:
	add2 r4,sp,r8
L_92d7d4:
	ld r10,[r4]
L_92d7d8:
	rsub r3,r2,0x7
L_92d7dc:
	asl r10,r10,r3
L_92d7e0:
	mov r9,0x80212c
L_92d7e8:
	ld r3,[r9, 0x4]
L_92d7ec:
	st r10,[r1, 0x4]
L_92d7f0:
	mov r11,0x1
L_92d7f4:
	brlo.d r10,r3,L_92d810
L_92d7f8:
	stw.as r11,[gp,0x45]
L_92d7fc:
	st.as r1,[gp,0xe]
L_92d800:
	add_s sp,sp,0x40
L_92d802:
	ld_s r14,[sp,0x4]
L_92d804:
	ld_s r15,[sp,0x8]
L_92d806:
	ld r16,[sp, 0xc]
L_92d80a:
	j_s.d [blink]
L_92d80c:
	ld.ab r13,[sp,0x10]
	.global L_92d810
L_92d810:
	st.as r9,[gp,0xe]
L_92d814:
	add_s sp,sp,0x40
L_92d816:
	ld_s r14,[sp,0x4]
L_92d818:
	ld_s r15,[sp,0x8]
L_92d81a:
	ld r16,[sp, 0xc]
L_92d81e:
	j_s.d [blink]
L_92d820:
	ld.ab r13,[sp,0x10]
	.global L_92d824
L_92d824:
	add_s sp,sp,0x40
L_92d826:
	ld_s r14,[sp,0x4]
L_92d828:
	ld_s r15,[sp,0x8]
L_92d82a:
	ld r16,[sp, 0xc]
L_92d82e:
	j_s.d [blink]
L_92d830:
	ld.ab r13,[sp,0x10]
