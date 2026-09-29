/* bf_sm__process_request_fifo @ 0x922748, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BF state failure, but the BRP mode was already set; cid: %d
 *   BF state failure; move to non-deferred BRP; cid: %d
 *   beamforming_sm.c
 * Зовут его: bf_sm__background_step, bf_sm__state_failure_path
 * Зовёт сам: __ld_r17_to_r13_ret_uc, bf__clear_pending_and_notify, bf_sm__pop_request_fifo, bf_sm_step, bf_state__set, rate_search__apply_mcs, uc_sysassert
 * Глобалы (через gp): 0x8005b0, 0x8005d2
 */
	.section .text.bf_sm__process_request_fifo,"ax",@progbits
	.global bf_sm__process_request_fifo
bf_sm__process_request_fifo:
L_922748:
	tst_s r0,r2
	.global fwlog_BF_state_failure_but_the_BRP_mode_was_al
fwlog_BF_state_failure_but_the_BRP_mode_was_al:
L_92274a:
	mov_s r1,0x80209c
L_922750:
	ldb_s r15,[r1,0x4]
L_922752:
	beq_s L_922786
L_922754:
	mov_s r3,0x10007ec
L_92275a:
	bbit0 r15,0x2,L_9227c4
L_92275e:
	ld_s r0,[r1]
L_922760:
	mov_s r2,0x8020b0
L_922766:
	add_s r15,r0,0x1
L_922768:
	extb_s r15,r15
L_92276a:
	add2 r15,r2,r15
L_92276e:
	st_s r14,[r15]
L_922770:
	bmsk_s r3,r3,0x13
L_922772:
	or r3,r3,0xa6000000
L_92277a:
	extb_s r15,r0
L_92277c:
	add2_s r2,r2,r15
L_92277e:
	st_s r3,[r2]
L_922780:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_922782:
	st_s r0,[r1]
L_922784:
	b_s L_9227c4
	.global L_922786
L_922786:
	mov r4,0x1000828
L_92278e:
	bbit0 r15,0x1,L_9227bc
L_922792:
	ld_s r0,[r1]
L_922794:
	mov_s r15,0x8020b0
L_92279a:
	add_s r3,r0,0x1
L_92279c:
	extb_s r3,r3
L_92279e:
	add2 r3,r15,r3
L_9227a2:
	st_s r14,[r3]
L_9227a4:
	bmsk r3,r4,0x13
L_9227a8:
	or r4,r3,0xa5000000
L_9227b0:
	extb_s r3,r0
L_9227b2:
	add2_s r15,r15,r3
L_9227b4:
	st r4,[r15]
L_9227b8:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_9227ba:
	st_s r0,[r1]
	.global L_9227bc
L_9227bc:
	ldw_s r0,[gp,0xaa]
L_9227be:
	bic_s r0,r0,r2
L_9227c0:
	stw.as r0,[gp,0x55]
	.global L_9227c4
L_9227c4:
	ld_s r1,[r13]
L_9227c6:
	ld_s r0,[gp,0x88]
L_9227c8:
	st_s r1,[r0,0x14]
L_9227ca:
	ld_s r1,[r13,0x4]
L_9227cc:
	ld_s r0,[gp,0x88]
L_9227ce:
	st_s r1,[r0,0x18]
L_9227d0:
	mov_s r0,0x857280
L_9227d6:
	ldb r0,[r0, 0x20]
L_9227da:
	bl.d L_92c330
L_9227de:
	mov_s r1,r14
L_9227e0:
	mov_s r0,r14
L_9227e2:
	bl.d L_9283c8
L_9227e6:
	mov_s r1,0x0
L_9227e8:
	bl.d L_924fb8
L_9227ec:
	mov_s r0,r14
L_9227ee:
	mov_s r0,r16
L_9227f0:
	mov_s r1,r14
L_9227f2:
	bl.d L_92a924
L_9227f6:
	mov_s r2,r17
L_9227f8:
	mov_s r0,r16
L_9227fa:
	bl.d L_9223b4
L_9227fe:
	mov_s r1,0x0
L_922800:
	ld_s r1,[r13,0x4]
L_922802:
	ld_s r0,[r13]
L_922804:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_922806:
	or_s r0,r0,r1
L_922808:
	mov_s r1,0x800f74
L_92280e:
	st_s r0,[r1,0x4c]
L_922810:
	b_s L_922824
	.global L_922812
L_922812:
	mov_s r0,blink
L_922814:
	mov_s r2,0x1000754
L_92281a:
	mov_s r1,0x15
L_92281c:
	bl.d L_925548
L_922820:
	mov r3,0x1f7
	.global L_922824
L_922824:
	ld_s r0,[r13,0x4]
L_922826:
	ld_s r1,[r13]
L_922828:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92282a:
	or_s r0,r0,r1
L_92282c:
	bmsk_s r0,r0,0xb
L_92282e:
	or r0,r0,0xfaa000
L_922836:
	mov_s r32,r0
L_922838:
	st.ab r0,[r25,0x4]
L_92283c:
	bclr r25,r25,0xa
L_922840:
	mov_s r1,0x800f74
L_922846:
	ld_s r0,[r1,0x4c]
L_922848:
	st_s r0,[r1,0x50]
	.global L_92284a
L_92284a:
	b L_92026c
L_92284e:
	nop_s
