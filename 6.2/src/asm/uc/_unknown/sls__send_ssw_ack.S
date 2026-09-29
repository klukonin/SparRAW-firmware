/* sls__send_ssw_ack @ 0x934424, 364 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sls__rx_ssw_frame, txss_resp__flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, direct_tx__program_cmd34, mac__program_tx_common, mac__set_rf_chain_state__with_sta_sector, mac_evt__enable_bit_sync_b, rx_funcs__send_direct_frame, sls__build_ssw_ack, uc_spin_until_event
 * Глобалы (через gp): 0x8005f4, 0x800608, 0x80060c, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sls__send_ssw_ack
sls__send_ssw_ack:
	.global L_934424
L_934424:
	push_s blink
L_934426:
	bl L_920234
L_93442a:
	sub_s sp,sp,0x18
L_93442c:
	mov_s r14,r0
L_93442e:
	mov_s r13,r1
L_934430:
	mov_s r0,0x37000005
L_934436:
	mov_s r32,r0
L_934438:
	st.ab r0,[r25,0x4]
L_93443c:
	bclr r25,r25,0xa
L_934440:
	mov_s r0,0x37000002
L_934446:
	mov_s r32,r0
L_934448:
	st.ab r0,[r25,0x4]
L_93444c:
	bclr r25,r25,0xa
L_934450:
	mov_s r0,0x802288
L_934456:
	ld_s r0,[r0]
L_934458:
	mov_s r1,0x80110c
L_93445e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_934460:
	add2_s r0,r0,r0
L_934462:
	ld_s r0,[r1,r0]
L_934464:
	or r0,r0,0x3f000000
L_93446c:
	mov_s r32,r0
L_93446e:
	st.ab r0,[r25,0x4]
L_934472:
	bclr r25,r25,0xa
L_934476:
	mov_s r0,0x3e
L_934478:
	asl_s r0,r0,0x18
L_93447a:
	mov_s r32,r0
L_93447c:
	st.ab r0,[r25,0x4]
L_934480:
	bclr r25,r25,0xa
L_934484:
	mov_s r0,0x37000020
L_93448a:
	mov_s r32,r0
L_93448c:
	st.ab r0,[r25,0x4]
L_934490:
	bclr r25,r25,0xa
L_934494:
	mov_s r1,0x8022c8
L_93449a:
	ld_s r0,[r1,0xc]
L_93449c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93449e:
	st_s r0,[r1,0xc]
L_9344a0:
	ld_s r0,[gp,0x178]
L_9344a2:
	mov_s r1,0x802940
L_9344a8:
	bclr_s r0,r0,0x18
L_9344aa:
	ld_s r1,[r1]
L_9344ac:
	bclr_s r0,r0,0x19
L_9344ae:
	asl_s r1,r1,0x18
L_9344b0:
	or_s r0,r0,r1
L_9344b2:
	st.as r0,[gp,0x5e]
L_9344b6:
	mov_s r1,0x889480
L_9344bc:
	st_s r0,[r1,0x8]
L_9344be:
	mov_s r0,sp
L_9344c0:
	mov_s r1,r14
L_9344c2:
	bl.d L_93b220
L_9344c6:
	mov_s r2,r13
L_9344c8:
	mov_s r0,0x10
L_9344ca:
	bl.d L_9257a8
L_9344ce:
	mov_s r1,0x18
L_9344d0:
	bl L_92d990
L_9344d4:
	mov_s r0,0x2008000
L_9344da:
	mov_s r32,r0
L_9344dc:
	st.ab r0,[r25,0x4]
L_9344e0:
	bclr r25,r25,0xa
L_9344e4:
	ld_s r0,[gp,0xcc]
L_9344e6:
	and r1,r0,0x10
L_9344ea:
	mov_s r0,0x0
L_9344ec:
	or.f 0x0,r1,r0
L_9344f0:
	beq_s L_934512
L_9344f2:
	ld_s r0,[gp,0xe0]
L_9344f4:
	ld.as r1,[gp,0x39]
L_9344f8:
	bic r0,r0,-0x3
L_9344fc:
	cmp_s r0,0x2
L_9344fe:
	mov_s r0,0x1
L_934500:
	sub_s.ne r0,r0,r0
L_934502:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_934504:
	or r0,r0,0x19800830
L_93450c:
	asl_s r1,r1,0xe
L_93450e:
	or_s r0,r0,r1
L_934510:
	b_s L_934518
	.global L_934512
L_934512:
	mov_s r0,0x19000001
	.global L_934518
L_934518:
	mov_s r32,r0
L_93451a:
	st.ab r0,[r25,0x4]
L_93451e:
	bclr r25,r25,0xa
	.global L_934522
L_934522:
	mov_s r0,r45
L_934524:
	bbit0 r0,0x1f,L_934522
L_934528:
	ld_s r0,[gp,0xcc]
L_93452a:
	and r1,r0,0x10
L_93452e:
	mov_s r0,0x0
L_934530:
	or.f 0x0,r1,r0
L_934534:
	mov_s r0,0x18
L_934536:
	asl.ne r0,r0,0x18
L_93453a:
	mov.eq r0,0x18001000
L_934542:
	mov_s r32,r0
L_934544:
	st.ab r0,[r25,0x4]
L_934548:
	bclr r25,r25,0xa
L_93454c:
	bl.d L_93b2b8
L_934550:
	mov_s r0,sp
L_934552:
	bl.d L_936544
L_934556:
	mov_s r0,0x6
L_934558:
	bl L_935928
L_93455c:
	mov_s r0,0x0
L_93455e:
	bl.d L_9366dc
L_934562:
	bset_s r0,r0,0xf
L_934564:
	bl.d L_936544
L_934568:
	mov_s r0,0x5
L_93456a:
	ld_s r0,[gp,0x178]
L_93456c:
	mov_s r1,0x802944
L_934572:
	bclr_s r0,r0,0x18
L_934574:
	ld_s r1,[r1]
L_934576:
	bclr_s r0,r0,0x19
L_934578:
	asl_s r1,r1,0x18
L_93457a:
	or_s r0,r0,r1
L_93457c:
	st.as r0,[gp,0x5e]
L_934580:
	mov_s r1,0x889480
L_934586:
	st_s r0,[r1,0x8]
L_934588:
	b.d L_9202a4
L_93458c:
	add_s sp,sp,0x18
L_93458e:
	nop_s
