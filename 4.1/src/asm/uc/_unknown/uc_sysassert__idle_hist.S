/* uc_sysassert__idle_hist @ 0x92522c, 796 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   IDLE SM histogram on SYSASSERT (%d iterations with 16 CLK delay):
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_IDLE_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA1_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA2_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA_RX_STATE] = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_CCA_NAV_STATE]= %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_SIFS_STATE]   = %d
 *   g_sysassert_idle_sm_hist[SXD_IDLE_DETECT_TX_STATE]     = %d
 * Зовут его: uc_sysassert
 */
	.section .text.uc_sysassert__idle_hist,"ax",@progbits
	.global uc_sysassert__idle_hist
uc_sysassert__idle_hist:
	.global L_92522c
L_92522c:
	st.a r13,[sp,-0x8]
L_925230:
	st_s r14,[sp,0x4]
L_925232:
	ld.as r1,[gp,-0x11]
L_925236:
	mov_s r14,blink
L_925238:
	and r1,r1,0xffff0fff
L_925240:
	st.as r1,[gp,-0x11]
L_925244:
	or r1,r1,0x1d000000
L_92524c:
	mov r32,r1
L_925250:
	st.ab r1,[r25,0x4]
L_925254:
	bclr r25,r25,0xa
L_925258:
	nop_s
L_92525a:
	nop_s
L_92525c:
	mov 0x0,0x0
L_925260:
	mov r8,0x4e20
L_925268:
	mov lp_count,r8
L_92526c:
	mov r5,0x8006c4
L_925274:
	lp L_9252ac
L_925278:
	nop_s
L_92527a:
	nop_s
L_92527c:
	nop_s
L_92527e:
	nop_s
L_925280:
	nop_s
L_925282:
	nop_s
L_925284:
	nop_s
L_925286:
	nop_s
L_925288:
	nop_s
L_92528a:
	nop_s
L_92528c:
	nop_s
L_92528e:
	nop_s
L_925290:
	nop_s
L_925292:
	nop_s
L_925294:
	nop_s
L_925296:
	nop_s
L_925298:
	bmsk r2,r40,0x2
L_92529c:
	add1 r3,r5,r2
L_9252a0:
	ldw r6,[r3]
L_9252a4:
	add r6,r6,0x1
L_9252a8:
	stw r6,[r3]
	.global L_9252ac
L_9252ac:
	mov r6,0x80209c
L_9252b4:
	ldb r13,[r6, 0x4]
L_9252b8:
	mov r7,0x1000278
L_9252c0:
	bbit0 r13,0x2,L_9252f8
L_9252c4:
	ld r0,[r6]
L_9252c8:
	mov_s r2,0x8020b0
L_9252ce:
	add_s r1,r0,0x1
L_9252d0:
	extb_s r1,r1
L_9252d2:
	add2 r1,r2,r1
L_9252d6:
	st r8,[r1]
L_9252da:
	bmsk r7,r7,0x13
L_9252de:
	or r7,r7,0xa6000000
L_9252e6:
	extb r11,r0
L_9252ea:
	add2 r2,r2,r11
L_9252ee:
	st r7,[r2]
L_9252f2:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_9252f4:
	st r0,[r6]
	.global L_9252f8
L_9252f8:
	mov r2,0x10002bc
L_925300:
	bbit0.d r13,0x2,L_925340
L_925304:
	ldw r0,[r5]
L_925308:
	ld r4,[r6]
L_92530c:
	mov_s r3,0x8020b0
L_925312:
	add r11,r4,0x1
L_925316:
	extb r11,r11
L_92531a:
	add2 r11,r3,r11
L_92531e:
	st r0,[r11]
L_925322:
	bmsk_s r2,r2,0x13
L_925324:
	or r2,r2,0xa6000000
L_92532c:
	extb r10,r4
L_925330:
	add2 r3,r3,r10
L_925334:
	st r2,[r3]
L_925338:
	add r4,r4,0x2
L_92533c:
	st r4,[r6]
	.global L_925340
L_925340:
	mov r1,0x10002f8
L_925348:
	bbit0.d r13,0x2,L_92538c
L_92534c:
	ldw r11,[r5, 0x2]
L_925350:
	ld r8,[r6]
L_925354:
	mov r4,0x8020b0
L_92535c:
	add r10,r8,0x1
L_925360:
	extb r10,r10
L_925364:
	add2 r10,r4,r10
L_925368:
	st r11,[r10]
L_92536c:
	bmsk r1,r1,0x13
L_925370:
	or r1,r1,0xa6000000
L_925378:
	extb r9,r8
L_92537c:
	add2 r9,r4,r9
L_925380:
	st r1,[r9]
L_925384:
	add r8,r8,0x2
L_925388:
	st r8,[r6]
	.global L_92538c
L_92538c:
	mov r7,0x1000334
L_925394:
	bbit0.d r13,0x2,L_9253d8
L_925398:
	ldw r10,[r5, 0x4]
L_92539c:
	ld r4,[r6]
L_9253a0:
	mov r8,0x8020b0
L_9253a8:
	add r9,r4,0x1
L_9253ac:
	extb r9,r9
L_9253b0:
	add2 r9,r8,r9
L_9253b4:
	st r10,[r9]
L_9253b8:
	bmsk r7,r7,0x13
L_9253bc:
	or r7,r7,0xa6000000
L_9253c4:
	extb r1,r4
L_9253c8:
	add2 r1,r8,r1
L_9253cc:
	st r7,[r1]
L_9253d0:
	add r4,r4,0x2
L_9253d4:
	st r4,[r6]
	.global L_9253d8
L_9253d8:
	mov r9,0x1000370
L_9253e0:
	bbit0.d r13,0x2,L_925424
L_9253e4:
	ldw r4,[r5, 0x6]
L_9253e8:
	ld r10,[r6]
L_9253ec:
	mov r11,0x8020b0
L_9253f4:
	add r7,r10,0x1
L_9253f8:
	extb r7,r7
L_9253fc:
	add2 r7,r11,r7
L_925400:
	st r4,[r7]
L_925404:
	bmsk r9,r9,0x13
L_925408:
	or r9,r9,0xa6000000
L_925410:
	extb r0,r10
L_925414:
	add2 r0,r11,r0
L_925418:
	st r9,[r0]
L_92541c:
	add r10,r10,0x2
L_925420:
	st r10,[r6]
	.global L_925424
L_925424:
	mov r11,0x10003ac
L_92542c:
	bbit0.d r13,0x2,L_925468
L_925430:
	ldw r3,[r5, 0x8]
L_925434:
	ld r0,[r6]
L_925438:
	mov_s r2,0x8020b0
L_92543e:
	add_s r1,r0,0x1
L_925440:
	extb_s r1,r1
L_925442:
	add2 r1,r2,r1
L_925446:
	st_s r3,[r1]
L_925448:
	bmsk r11,r11,0x13
L_92544c:
	or r11,r11,0xa6000000
L_925454:
	extb r8,r0
L_925458:
	add2 r2,r2,r8
L_92545c:
	st r11,[r2]
L_925460:
	add r0,r0,0x2
L_925464:
	st r0,[r6]
	.global L_925468
L_925468:
	mov r1,0x10003e8
L_925470:
	bbit0.d r13,0x2,L_9254ac
L_925474:
	ldw r2,[r5, 0xa]
L_925478:
	ld r3,[r6]
L_92547c:
	mov r4,0x8020b0
L_925484:
	add r10,r3,0x1
L_925488:
	extb r10,r10
L_92548c:
	add2 r10,r4,r10
L_925490:
	st r2,[r10]
L_925494:
	bmsk_s r1,r1,0x13
L_925496:
	or r1,r1,0xa6000000
L_92549e:
	extb_s r2,r3
L_9254a0:
	add2 r2,r4,r2
L_9254a4:
	st_s r1,[r2]
L_9254a6:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_9254a8:
	st r3,[r6]
	.global L_9254ac
L_9254ac:
	mov r3,0x1000424
L_9254b4:
	bbit0.d r13,0x2,L_9254f4
L_9254b8:
	ldw r0,[r5, 0xc]
L_9254bc:
	ld r2,[r6]
L_9254c0:
	mov r4,0x8020b0
L_9254c8:
	add r9,r2,0x1
L_9254cc:
	extb r9,r9
L_9254d0:
	add2 r9,r4,r9
L_9254d4:
	st r0,[r9]
L_9254d8:
	bmsk_s r3,r3,0x13
L_9254da:
	or r3,r3,0xa6000000
L_9254e2:
	extb r7,r2
L_9254e6:
	add2 r7,r4,r7
L_9254ea:
	st r3,[r7]
L_9254ee:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_9254f0:
	st r2,[r6]
	.global L_9254f4
L_9254f4:
	mov r4,0x1000460
L_9254fc:
	bbit0.d r13,0x2,L_92553c
L_925500:
	ldw r2,[r5, 0xe]
L_925504:
	ld r5,[r6]
L_925508:
	mov_s r0,0x8020b0
L_92550e:
	add r1,r5,0x1
L_925512:
	extb_s r1,r1
L_925514:
	add2 r1,r0,r1
L_925518:
	st r2,[r1]
L_92551c:
	bmsk r4,r4,0x13
L_925520:
	or r4,r4,0xa6000000
L_925528:
	extb r8,r5
L_92552c:
	add2 r0,r0,r8
L_925530:
	st r4,[r0]
L_925534:
	add r5,r5,0x2
L_925538:
	st r5,[r6]
	.global L_92553c
L_92553c:
	mov_s blink,r14
L_92553e:
	ld_s r14,[sp,0x4]
L_925540:
	j.d [blink]
L_925544:
	ld.ab r13,[sp,0x8]
