/* direct_tx_step @ 0x92c3a4, 452 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_program_c
 * Зовёт сам: direct_tx__build_desc, direct_tx__issue_cmd_33, direct_tx__program_cmd34, mac__program_rx_window, mac__program_tx_common, mac__set_rf_chain_state__with_sta_sector, mac_evt__enable_bit_sync_b, tx_fifo__write_bytes, uc_spin_until_event, uc_wait_direct_tx_ready
 * Глобалы (через gp): 0x8005f4, 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx_step
direct_tx_step:
	.global L_92c3a4
L_92c3a4:
	st.a r13,[sp,-0x8]
L_92c3a8:
	st blink,[sp, 0x4]
L_92c3ac:
	sub_s sp,sp,0x18
L_92c3ae:
	mov_s r13,r0
L_92c3b0:
	ld.as r9,[gp,-0x3]
L_92c3b4:
	ldb r10,[r0, 0xb]
L_92c3b8:
	or r1,r9,0x30
L_92c3bc:
	asl r10,r10,0x8
L_92c3c0:
	mov_s r0,0x1
L_92c3c2:
	or r1,r1,r10
L_92c3c6:
	mov_s r2,0x0
L_92c3c8:
	bl.d L_92f798
L_92c3cc:
	mov r3,r2
L_92c3d0:
	mov r9,0x15000000
L_92c3d8:
	mov r32,r9
L_92c3dc:
	st.ab r9,[r25,0x4]
L_92c3e0:
	bclr r25,r25,0xa
L_92c3e4:
	mov_s r0,0x14000007
L_92c3ea:
	mov_s r32,r0
L_92c3ec:
	st.ab r0,[r25,0x4]
L_92c3f0:
	bclr r25,r25,0xa
L_92c3f4:
	mov r1,sp
L_92c3f8:
	bl.d L_92bf38
L_92c3fc:
	mov r0,r13
L_92c400:
	mov r0,0x10
L_92c404:
	bl.d L_9257a8
L_92c408:
	mov r1,0x18
L_92c40c:
	bl L_92d990
L_92c410:
	mov_s r1,0x2008000
L_92c416:
	mov_s r32,r1
L_92c418:
	st.ab r1,[r25,0x4]
L_92c41c:
	bclr r25,r25,0xa
L_92c420:
	ld.as r11,[gp,0x33]
L_92c424:
	mov r8,0x0
L_92c428:
	and r0,r11,0x10
L_92c42c:
	or.f 0x0,r0,r8
L_92c430:
	beq L_92c470
L_92c434:
	ld.as r7,[gp,0x38]
L_92c438:
	ld.as r6,[gp,0x39]
L_92c43c:
	bic r7,r7,-0x3
L_92c440:
	cmp r7,0x2
L_92c444:
	mov r7,0x1
L_92c448:
	sub.ne r7,r7,r7
L_92c44c:
	asl r7,r7,0x6
L_92c450:
	or r7,r7,0x19800830
L_92c458:
	asl r6,r6,0xe
L_92c45c:
	or r6,r6,r7
L_92c460:
	mov r32,r6
L_92c464:
	st.ab r6,[r25,0x4]
L_92c468:
	bclr r25,r25,0xa
L_92c46c:
	b L_92c480
	.global L_92c470
L_92c470:
	mov_s r2,0x19000001
L_92c476:
	mov_s r32,r2
L_92c478:
	st.ab r2,[r25,0x4]
L_92c47c:
	bclr r25,r25,0xa
	.global L_92c480
L_92c480:
	mov r10,r45
L_92c484:
	bbit0 r10,0x1f,L_92c480
L_92c488:
	ld.as r9,[gp,0x33]
L_92c48c:
	mov r7,0x0
L_92c490:
	and r8,r9,0x10
L_92c494:
	or.f 0x0,r8,r7
L_92c498:
	beq_s L_92c4ac
L_92c49a:
	mov_s r3,0x18
L_92c49c:
	asl_s r3,r3,0x18
L_92c49e:
	mov_s r32,r3
L_92c4a0:
	st.ab r3,[r25,0x4]
L_92c4a4:
	bclr r25,r25,0xa
L_92c4a8:
	b L_92c4c0
	.global L_92c4ac
L_92c4ac:
	mov r4,0x18001000
L_92c4b4:
	mov r32,r4
L_92c4b8:
	st.ab r4,[r25,0x4]
L_92c4bc:
	bclr r25,r25,0xa
	.global L_92c4c0
L_92c4c0:
	mov_s r13,sp
L_92c4c2:
	mov_s r0,r13
L_92c4c4:
	bl.d L_9257f4
L_92c4c8:
	mov r1,0xa
L_92c4cc:
	ld.as r2,[gp,-0x5]
L_92c4d0:
	mov r5,0x33000443
L_92c4d8:
	sub r2,r2,0x6
L_92c4dc:
	st.as r2,[gp,-0x5]
L_92c4e0:
	mov r32,r5
L_92c4e4:
	st.ab r5,[r25,0x4]
L_92c4e8:
	bclr r25,r25,0xa
L_92c4ec:
	bl L_925874
L_92c4f0:
	ldb r34,[r13, 0x10]
L_92c4f4:
	ldb r34,[r13, 0x11]
L_92c4f8:
	ldb r34,[r13, 0x12]
L_92c4fc:
	ld.as r5,[gp,-0x5]
L_92c500:
	sub r5,r5,0x3
L_92c504:
	st.as r5,[gp,-0x5]
L_92c508:
	ldb r33,[r13, 0x13]
L_92c50c:
	ldb_s r0,[r13,0x14]
L_92c50e:
	asl_s r0,r0,0x8
L_92c510:
	or r33,r33,r0
L_92c514:
	ldb_s r0,[r13,0x15]
L_92c516:
	asl_s r0,r0,0x10
L_92c518:
	or r33,r33,r0
L_92c51c:
	ldb_s r0,[r13,0x16]
L_92c51e:
	asl_s r0,r0,0x18
L_92c520:
	or r33,r33,r0
L_92c524:
	ld.as r3,[gp,-0x5]
L_92c528:
	sub r3,r3,0x4
L_92c52c:
	st.as r3,[gp,-0x5]
L_92c530:
	ldb r34,[r13, 0x17]
L_92c534:
	ld.as r4,[gp,-0x5]
L_92c538:
	sub r4,r4,0x1
L_92c53c:
	bl.d L_925774
L_92c540:
	st.as r4,[gp,-0x5]
L_92c544:
	bl.d L_936544
L_92c548:
	mov r0,0x6
L_92c54c:
	bl L_935928
L_92c550:
	mov r0,0x0
L_92c554:
	bl.d L_9366dc
L_92c558:
	bset r0,r0,0xf
L_92c55c:
	add_s sp,sp,0x18
L_92c55e:
	ld blink,[sp, 0x4]
L_92c562:
	j_s.d [blink]
L_92c564:
	ld.ab r13,[sp,0x8]
