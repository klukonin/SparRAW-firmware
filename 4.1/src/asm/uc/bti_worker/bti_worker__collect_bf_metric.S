/* bti_worker__collect_bf_metric @ 0x9375ec, 404 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bti_worker.cpp
 * Зовут его: bti_transmitter_bi2_flow
 * Зовёт сам: bf_gpc__program_mac_by_mode, bti__request_bf_metric, bti_worker_bi2_step, uc_sysassert, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x800540, 0x80059c
 */
	.section .text.bti_worker__collect_bf_metric,"ax",@progbits
	.global bti_worker__collect_bf_metric
bti_worker__collect_bf_metric:
	.global L_9375ec
L_9375ec:
	st.a r13,[sp,-0xc]
L_9375f0:
	st blink,[sp, 0x4]
L_9375f4:
	st_s r14,[sp,0x8]
L_9375f6:
	mov_s r14,r0
L_9375f8:
	mov r13,0x140
L_9375fc:
	mov r6,0x2001000
L_937604:
	mov r32,r6
L_937608:
	st.ab r6,[r25,0x4]
L_93760c:
	bclr r25,r25,0xa
L_937610:
	b L_937620
	.global L_937614
L_937614:
	st r4,[r1, 0x18]
L_937618:
	mov r6,0x1
L_93761c:
	stb r6,[r1, 0x14]
	.global L_937620
L_937620:
	mov_s r0,0x0
L_937622:
	bset_s r0,r0,0xc
L_937624:
	mov r1,r13
L_937628:
	bl.d L_9318f4
L_93762c:
	mov r2,0x0
L_937630:
	mov r11,r42
L_937634:
	bbit0 r11,0xc,L_9376fc
L_937638:
	ld r0,[r14]
L_93763c:
	bl.d L_923ba8
L_937640:
	mov r1,0x0
L_937644:
	breq_s r0,0,L_937620
L_937646:
	ld.as r3,[gp,-0x11]
L_93764a:
	and r3,r3,0xffff0fff
L_937652:
	or r10,r3,0xd000
L_93765a:
	or r3,r3,0x1d00d000
L_937662:
	st.as r10,[gp,-0x11]
L_937666:
	mov_s r32,r3
L_937668:
	st.ab r3,[r25,0x4]
L_93766c:
	bclr r25,r25,0xa
L_937670:
	nop_s
L_937672:
	nop_s
L_937674:
	nop_s
L_937676:
	lsr r4,r40,0x9
L_93767a:
	bmsk r4,r4,0xa
L_93767e:
	sub r7,r4,0x800
L_937686:
	cmp r4,0x3ff
L_93768a:
	mov_s r3,0x801e68
L_937690:
	ldb r9,[r3, 0x1b]
L_937694:
	mov.hi r4,r7
L_937698:
	brne r9,0x1,L_9376c0
L_93769c:
	ld r8,[r3, 0xc]
L_9376a0:
	brge r8,r4,L_9376c0
L_9376a4:
	mov r6,0x804010
L_9376ac:
	st r4,[r3, 0xc]
L_9376b0:
	ldw r2,[r6, 0x12]
L_9376b4:
	lsr_s r2,r2,0xa
L_9376b6:
	stb_s r2,[r3,0x8]
L_9376b8:
	ldw r0,[r6, 0x14]
L_9376bc:
	bmsk_s r0,r0,0x1
L_9376be:
	stb_s r0,[r3,0x9]
	.global L_9376c0
L_9376c0:
	ld.as r5,[gp,0x1d]
L_9376c4:
	breq r5,0x0,L_9376d0
L_9376c8:
	ld.as r7,[gp,0x6]
L_9376cc:
	bbit1 r7,0x0,L_9376dc
	.global L_9376d0
L_9376d0:
	brne r5,0x0,L_937620
L_9376d4:
	ld.as r2,[gp,0x6]
L_9376d8:
	bbit1 r2,0x0,L_937620
	.global L_9376dc
L_9376dc:
	mov r5,0x80088c
L_9376e4:
	ldb r1,[r5, 0x50]
L_9376e8:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_9376ea:
	add2_s r1,r1,r1
L_9376ec:
	add r1,r1,r5
L_9376f0:
	ld r5,[r1, 0x18]
L_9376f4:
	brge r5,r4,L_937620
L_9376f8:
	b L_937614
	.global L_9376fc
L_9376fc:
	mov_s r0,r54
L_9376fe:
	bbit1 r0,0x6,L_937714
L_937702:
	mov_s r3,r54
L_937704:
	bbit0 r3,0x8,L_937768
L_937708:
	bl.d L_923db8
L_93770c:
	mov r13,0x40
L_937710:
	b L_937620
	.global L_937714
L_937714:
	mov r13,0x801e68
L_93771c:
	ldb r4,[r13, 0x1]
L_937720:
	brne r4,0x0,L_93773c
	.global L_937724
L_937724:
	ldb_s r1,[r13,0x1b]
L_937726:
	cmp_s r1,0x0
L_937728:
	bl.ne L_92c9b0
L_93772c:
	mov_s r3,0x1
L_93772e:
	stb_s r3,[r14,0x4]
L_937730:
	ld blink,[sp, 0x4]
L_937734:
	ld_s r14,[sp,0x8]
L_937736:
	j_s.d [blink]
L_937738:
	ld.ab r13,[sp,0xc]
	.global L_93773c
L_93773c:
	mov r5,0x49000040
L_937744:
	mov r32,r5
L_937748:
	st.ab r5,[r25,0x4]
L_93774c:
	bclr r25,r25,0xa
L_937750:
	mov r4,0x49000100
L_937758:
	mov r32,r4
L_93775c:
	st.ab r4,[r25,0x4]
L_937760:
	bclr r25,r25,0xa
L_937764:
	b L_937724
	.global L_937768
L_937768:
	mov_s r0,blink
L_93776a:
	mov_s r2,0x1002fc0
L_937770:
	mov r1,0x5a
L_937774:
	bl.d L_925548
L_937778:
	mov r3,0x10b
L_93777c:
	b_s L_937620
L_93777e:
	nop_s
