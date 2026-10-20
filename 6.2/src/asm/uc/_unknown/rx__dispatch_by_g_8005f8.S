/* rx__dispatch_by_g_8005f8 @ 0x9333fc, 732 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow_step
 * Зовёт сам: bap_q_avail__check, uc_sysassert
 * Глобалы (через gp): 0x800568, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__dispatch_by_g_8005f8
rx__dispatch_by_g_8005f8:
	.global L_9333fc
L_9333fc:
	st.a r13,[sp,-0xc]
L_933400:
	ld.as r2,[gp,0x34]
L_933404:
	st_s r14,[sp,0x8]
L_933406:
	btst_s r2,0x8
L_933408:
	st blink,[sp, 0x4]
L_93340c:
	beq.d L_9336c8
L_933410:
	mov_s r13,0x0
L_933412:
	lsr r2,r38,0x14
L_933416:
	ld.as r1,[gp,0x34]
L_93341a:
	bmsk_s r1,r1,0x4
L_93341c:
	sub r11,r1,0x1
L_933420:
	cmp r11,0xf
L_933424:
	bhi.d L_9336c8
L_933428:
	bmsk r14,r2,0x4
L_93342c:
	ld.as r1,[0x801984,r11]
L_933434:
	j_s [r1]
L_933436:
	mov_s r3,r36
L_933438:
	btst r3,0x8
L_93343c:
	beq L_9336c8
L_933440:
	mov r5,r38
L_933444:
	btst r5,0xf
L_933448:
	bne L_9336c8
L_93344c:
	mov r7,r38
L_933450:
	bbit0 r7,0xc,L_9334c4
L_933454:
	ldb r4,[gp, -0xe4]
L_933458:
	breq r4,0x0,L_9334c4
L_93345c:
	mov r5,r53
L_933460:
	bbit1 r5,0x0,L_9334a8
L_933464:
	mov r6,0x23010003
L_93346c:
	mov r32,r6
L_933470:
	st.ab r6,[r25,0x4]
L_933474:
	bclr r25,r25,0xa
L_933478:
	mov_s r1,0x2000200
L_93347e:
	mov_s r32,r1
L_933480:
	st.ab r1,[r25,0x4]
L_933484:
	bclr r25,r25,0xa
L_933488:
	nop_s
L_93348a:
	nop_s
L_93348c:
	mov 0x0,0x0
	.global L_933490
L_933490:
	mov r6,r42
L_933494:
	bbit1 r6,0x9,L_9334a0
L_933498:
	mov r9,r53
L_93349c:
	bbit0 r9,0x0,L_933490
	.global L_9334a0
L_9334a0:
	mov r10,r42
L_9334a4:
	bbit1 r10,0x9,L_9334e8
	.global L_9334a8
L_9334a8:
	and r3,r53,0x10
L_9334ac:
	st.as r3,[gp,-0x32]
L_9334b0:
	mov r7,0x1c000001
L_9334b8:
	mov r32,r7
L_9334bc:
	st.ab r7,[r25,0x4]
L_9334c0:
	bclr r25,r25,0xa
	.global L_9334c4
L_9334c4:
	brlt.d r14,0x1,L_9334d4
L_9334c8:
	mov r13,0x1
L_9334cc:
	st r13,[0x802224]
	.global L_9334d4
L_9334d4:
	st.as r13,[gp,0x10]
L_9334d8:
	mov_s r0,r13
L_9334da:
	ld blink,[sp, 0x4]
L_9334de:
	ld_s r14,[sp,0x8]
L_9334e0:
	j.d [blink]
L_9334e4:
	ld.ab r13,[sp,0xc]
	.global L_9334e8
L_9334e8:
	mov r0,blink
L_9334ec:
	bl.d L_926618
L_9334f0:
	mov r1,0x3b
L_9334f4:
	b L_9334a8
L_9334f8:
	mov r4,r36
L_9334fc:
	btst r4,0x9
L_933500:
	beq L_9336c8
L_933504:
	mov r6,r38
L_933508:
	btst r6,0xf
L_93350c:
	bne L_9336c8
L_933510:
	mov r8,r38
L_933514:
	btst r8,0xc
L_933518:
	beq L_9336c8
L_93351c:
	ldb r11,[gp, -0xe4]
L_933520:
	breq r11,0x0,L_933588
L_933524:
	mov r0,r53
L_933528:
	bbit1 r0,0x0,L_93356c
L_93352c:
	mov r9,0x23010003
L_933534:
	mov r32,r9
L_933538:
	st.ab r9,[r25,0x4]
L_93353c:
	bclr r25,r25,0xa
L_933540:
	mov_s r3,0x2000200
L_933546:
	mov_s r32,r3
L_933548:
	st.ab r3,[r25,0x4]
L_93354c:
	bclr r25,r25,0xa
L_933550:
	nop_s
L_933552:
	nop_s
L_933554:
	mov 0x0,0x0
	.global L_933558
L_933558:
	mov_s r3,r42
L_93355a:
	bbit1 r3,0x9,L_933564
L_93355e:
	mov_s r2,r53
L_933560:
	bbit0 r2,0x0,L_933558
	.global L_933564
L_933564:
	mov_s r0,r42
L_933566:
	btst_s r0,0x9
L_933568:
	bne L_933648
	.global L_93356c
L_93356c:
	and r11,r53,0x10
L_933570:
	st.as r11,[gp,-0x32]
L_933574:
	mov r8,0x1c000001
L_93357c:
	mov r32,r8
L_933580:
	st.ab r8,[r25,0x4]
L_933584:
	bclr r25,r25,0xa
	.global L_933588
L_933588:
	ld.as r7,[gp,-0x32]
L_93358c:
	cmp r7,0x0
L_933590:
	bne_s L_9336c8
L_933592:
	mov_s r13,0x1
L_933594:
	lsr r0,r53,0x8
L_933598:
	bmsk r1,r0,0x6
L_93359c:
	lsr r3,r53,0x10
L_9335a0:
	mov r9,0x802210
L_9335a8:
	ld r4,[r9]
L_9335ac:
	bmsk r3,r3,0x6
L_9335b0:
	add r4,r4,r1
L_9335b4:
	ld r5,[r9, 0x4]
L_9335b8:
	st r4,[r9]
L_9335bc:
	add r5,r5,r3
L_9335c0:
	ld r6,[r9, 0x8]
L_9335c4:
	st r5,[r9, 0x4]
L_9335c8:
	add r6,r6,0x1
L_9335cc:
	brlt.d r14,0x1,L_9335dc
L_9335d0:
	st r6,[r9, 0x8]
L_9335d4:
	mov r8,0x1
L_9335d8:
	st r8,[r9, 0x14]
	.global L_9335dc
L_9335dc:
	ld r0,[0x802288]
L_9335e4:
	asl r10,r0,0x2
L_9335e8:
	add1 r10,r10,r10
L_9335ec:
	ld r7,[r10,0x802610]
L_9335f4:
	sub.f r7,r7,0x0
L_9335f8:
	mov.ne r7,0x1
L_9335fc:
	extb.f 0x0,r7
L_933600:
	bl.ne.d L_930268
L_933604:
	mov.ne r2,r3
L_933608:
	ld.as r10,[gp,0x34]
L_93360c:
	btst r10,0x1e
L_933610:
	beq_s L_9336c8
L_933612:
	ld r9,[0x8029f0]
L_93361a:
	mov r4,0x802948
L_933622:
	ld r2,[r9, 0x4]
L_933626:
	ld r8,[r4]
L_93362a:
	bclr r10,r10,0x1e
L_93362e:
	bclr r8,r8,r2
L_933632:
	st r8,[r4]
L_933636:
	st.as r10,[gp,0x34]
L_93363a:
	mov_s r0,r13
L_93363c:
	ld blink,[sp, 0x4]
L_933640:
	ld_s r14,[sp,0x8]
L_933642:
	j_s.d [blink]
L_933644:
	ld.ab r13,[sp,0xc]
	.global L_933648
L_933648:
	mov r0,blink
L_93364c:
	bl.d L_926618
L_933650:
	mov r1,0x3b
L_933654:
	b L_93356c
L_933658:
	mov_s r1,r37
L_93365a:
	bbit0 r1,0x1,L_9336c8
L_93365e:
	ld r4,[0x8029f0]
L_933666:
	mov_s r0,0x802450
L_93366c:
	ld r1,[r4]
L_933670:
	mov r5,0x20000400
L_933678:
	add2 r0,r0,r1
L_93367c:
	ld r11,[r0]
L_933680:
	add r11,r11,0x1
L_933684:
	st r11,[r0]
L_933688:
	mov r32,r5
L_93368c:
	st.ab r5,[r25,0x4]
L_933690:
	bclr r25,r25,0xa
L_933694:
	b L_9336b8
L_933698:
	mov r3,r36
L_93369c:
	mov_s r2,r38
L_93369e:
	bbit1 r2,0xf,L_9336c8
L_9336a2:
	ld r3,[0x8029f0]
L_9336aa:
	ld r1,[0x802288]
L_9336b2:
	ld_s r2,[r3]
L_9336b4:
	brne r1,r2,L_9336c8
	.global L_9336b8
L_9336b8:
	mov_s r0,0x1
L_9336ba:
	ld blink,[sp, 0x4]
L_9336be:
	ld_s r14,[sp,0x8]
L_9336c0:
	j.d [blink]
L_9336c4:
	ld.ab r13,[sp,0xc]
	.global L_9336c8
L_9336c8:
	ld blink,[sp, 0x4]
L_9336cc:
	mov_s r0,r13
L_9336ce:
	ld_s r14,[sp,0x8]
L_9336d0:
	j.d [blink]
L_9336d4:
	ld.ab r13,[sp,0xc]
