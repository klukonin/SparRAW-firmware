/* rx_capture__match_filter @ 0x93e56c, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step, bti_bi2__track_best_metric, rx__check_mode_2, rx_flow__handle_frame, rx_flow_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_capture__match_filter
rx_capture__match_filter:
	.global L_93e56c
L_93e56c:
	push_s r13
L_93e56e:
	mov_s r2,0x8017c8
L_93e574:
	ld_s r1,[r2]
L_93e576:
	st.a r1,[sp,-0x8]
L_93e57a:
	ldb_s r1,[r2,0x4]
L_93e57c:
	stb_s r1,[sp,0x4]
L_93e57e:
	mov_s r1,r38
L_93e580:
	mov_s r2,sp
L_93e582:
	bbit0 r1,0xb,L_93e58e
L_93e586:
	lsr r1,r38,0x8
L_93e58a:
	bmsk_s r1,r1,0x2
L_93e58c:
	b_s L_93e590
	.global L_93e58e
L_93e58e:
	mov_s r1,0x8
	.global L_93e590
L_93e590:
	stb_s r1,[r2]
L_93e592:
	lsr r1,r38,0x14
L_93e596:
	bmsk_s r1,r1,0x4
L_93e598:
	stb_s r1,[r2,0x3]
L_93e59a:
	cmp_s r1,0x0
L_93e59c:
	mov_s r1,0x1
L_93e59e:
	sub_s.ne r1,r1,r1
L_93e5a0:
	stb_s r1,[r2,0x2]
L_93e5a2:
	mov_s r1,0x80141c
L_93e5a8:
	ld_s r1,[r1,0x8]
L_93e5aa:
	add_s r0,r0,0x20
L_93e5ac:
	bmsk_s r1,r1,0x0
L_93e5ae:
	stb_s r1,[r2,0x4]
L_93e5b0:
	ldb_s r13,[r0,0x4]
L_93e5b2:
	mov_s r3,0xff
L_93e5b4:
	mov_s r1,0x0
L_93e5b6:
	breq r13,r3,L_93e5c0
L_93e5ba:
	ldb_s r2,[sp,0x0]
L_93e5bc:
	brne r13,r2,L_93e5fc
	.global L_93e5c0
L_93e5c0:
	ldb_s r2,[r0,0x5]
L_93e5c2:
	breq r2,r3,L_93e5ce
L_93e5c6:
	ldb r1,[sp, 0x1]
L_93e5ca:
	brne r2,r1,L_93e5f6
	.global L_93e5ce
L_93e5ce:
	ldb_s r2,[r0,0x7]
L_93e5d0:
	breq r2,r3,L_93e5dc
L_93e5d4:
	ldb r1,[sp, 0x3]
L_93e5d8:
	brne r2,r1,L_93e5f6
	.global L_93e5dc
L_93e5dc:
	ldb_s r2,[r0,0x6]
L_93e5de:
	breq r2,r3,L_93e5ea
L_93e5e2:
	ldb r1,[sp, 0x2]
L_93e5e6:
	brne r2,r1,L_93e5f6
	.global L_93e5ea
L_93e5ea:
	ldb_s r2,[r0,0x8]
L_93e5ec:
	breq r2,r3,L_93e5fa
L_93e5f0:
	ldb_s r1,[sp,0x4]
L_93e5f2:
	breq r1,r2,L_93e5fa
	.global L_93e5f6
L_93e5f6:
	mov_s r1,0x0
L_93e5f8:
	b_s L_93e5fc
	.global L_93e5fa
L_93e5fa:
	mov_s r1,0x1
	.global L_93e5fc
L_93e5fc:
	extb_s r1,r1
L_93e5fe:
	brne r1,0x1,L_93e61c
L_93e602:
	ldb r2,[sp, 0x2]
L_93e606:
	stb_s r2,[r0,0xb]
L_93e608:
	ldb r2,[sp, 0x3]
L_93e60c:
	stb_s r2,[r0,0xc]
L_93e60e:
	ldb r2,[sp, 0x1]
L_93e612:
	stb_s r2,[r0,0xa]
L_93e614:
	ldb_s r2,[sp,0x0]
L_93e616:
	stb_s r2,[r0,0x9]
L_93e618:
	ldb_s r2,[sp,0x4]
L_93e61a:
	stb_s r2,[r0,0xd]
	.global L_93e61c
L_93e61c:
	mov_s r0,r1
L_93e61e:
	add_s sp,sp,0x8
L_93e620:
	j_s.d [blink]
L_93e622:
	pop_s r13
