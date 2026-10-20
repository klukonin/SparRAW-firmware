/* abft_resp__parse_fdbk @ 0x93061c, 344 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abft_resp__parse_fdbk
abft_resp__parse_fdbk:
	.global L_93061c
L_93061c:
	st.a r13,[sp,-0x8]
L_930620:
	st_s r14,[sp,0x4]
L_930622:
	mov_s r14,blink
L_930624:
	mov_s r13,r0
L_930626:
	mov_s r0,0x0
L_930628:
	bset r0,r0,0x10
L_93062c:
	bl.d L_9366e8
L_930630:
	mov r1,0x0
L_930634:
	ldb r3,[gp, -0xf2]
L_930638:
	cmp_s r3,0x0
L_93063a:
	beq_s L_93072c
	.global L_93063c
L_93063c:
	ld_s r0,[gp,0x50]
L_93063e:
	mov r4,0x8022c8
L_930646:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_930648:
	ld r3,[r4, 0x3c]
L_93064c:
	st.as r0,[gp,0x14]
L_930650:
	add r3,r3,0x1
L_930654:
	st r3,[r4, 0x3c]
L_930658:
	mov r5,0x2011000
L_930660:
	mov r32,r5
L_930664:
	st.ab r5,[r25,0x4]
L_930668:
	bclr r25,r25,0xa
L_93066c:
	mov_s r2,r37
L_93066e:
	btst_s r2,0x19
L_930670:
	beq_s L_930764
L_930672:
	mov_s r1,0x804010
L_930678:
	mov_s r2,0x802f14
L_93067e:
	ldb r5,[r2, 0x14]
L_930682:
	ldb r10,[r1, 0xa]
L_930686:
	cmp r5,r10
L_93068a:
	bne_s L_930764
L_93068c:
	ldb r6,[r2, 0x15]
L_930690:
	ldb r9,[r1, 0xb]
L_930694:
	brne r6,r9,L_930764
L_930698:
	ldb r7,[r2, 0x16]
L_93069c:
	ldb r6,[r1, 0xc]
L_9306a0:
	brne r7,r6,L_930764
L_9306a4:
	ldb r9,[r2, 0x17]
L_9306a8:
	ldb r8,[r1, 0xd]
L_9306ac:
	brne r9,r8,L_930764
L_9306b0:
	ldb r10,[r2, 0x18]
L_9306b4:
	ldb r11,[r1, 0xe]
L_9306b8:
	brne r10,r11,L_930764
L_9306bc:
	ldb r4,[r2, 0x19]
L_9306c0:
	ldb_s r0,[r1,0xf]
L_9306c2:
	brne r0,r4,L_930764
L_9306c6:
	mov_s r3,0x857800
L_9306cc:
	ldb r6,[r3, -0xc4]
L_9306d0:
	ld r2,[r1, 0x10]
L_9306d4:
	brlt.d r6,0x2,L_9306fc
L_9306d8:
	bmsk_s r2,r2,0x5
L_9306da:
	ld r4,[0x801024]
L_9306e2:
	ld r3,[r3, -0x50]
L_9306e6:
	lsr r4,r4,0x8
L_9306ea:
	bmsk r4,r4,0xe
L_9306ee:
	add1 r3,r3,r4
L_9306f2:
	ldb r7,[r3]
L_9306f6:
	add_s r2,r2,r7
L_9306f8:
	extb r2,r2
	.global L_9306fc
L_9306fc:
	stb_s r2,[r13,0xe]
L_9306fe:
	ld r5,[r1, 0x10]
L_930702:
	lsr r5,r5,0x6
L_930706:
	bmsk r5,r5,0x1
L_93070a:
	stb r5,[r13, 0xf]
L_93070e:
	ldb.x r1,[r1, 0x11]
L_930712:
	stb_s r1,[r13,0x10]
L_930714:
	mov r4,r38
L_930718:
	bbit0 r4,0xb,L_930754
L_93071c:
	lsr r0,r38,0x8
L_930720:
	bmsk r0,r0,0x2
L_930724:
	b.d L_93075c
L_930728:
	stb r0,[r13, 0xd]
	.global L_93072c
L_93072c:
	ldb r1,[gp, -0xf9]
L_930730:
	bmsk_s r1,r1,0x0
L_930732:
	or r1,r1,0x32000000
L_93073a:
	mov_s r32,r1
L_93073c:
	st.ab r1,[r25,0x4]
L_930740:
	bclr r25,r25,0xa
L_930744:
	ldb r11,[gp, -0xf9]
L_930748:
	add r11,r11,0x1
L_93074c:
	b.d L_93063c
L_930750:
	stb r11,[gp, -0xf9]
	.global L_930754
L_930754:
	mov r5,0x8
L_930758:
	stb r5,[r13, 0xd]
	.global L_93075c
L_93075c:
	b.d L_930768
L_930760:
	mov r0,0x1
	.global L_930764
L_930764:
	mov r0,0x0
	.global L_930768
L_930768:
	mov_s blink,r14
L_93076a:
	ld_s r14,[sp,0x4]
L_93076c:
	j.d [blink]
L_930770:
	ld.ab r13,[sp,0x8]
