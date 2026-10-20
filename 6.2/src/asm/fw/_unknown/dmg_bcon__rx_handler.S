/* dmg_bcon__rx_handler @ 0x8c9404, 512 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   non_valid_becon , curr_systime = %d , bcon_systime = %d , time_since_last_loop_start = %d
 * Зовут его: discovery__rx_pkt_handler
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, conn_main_sm__inject_bcon_rx, dmg_bcon__build_allocations, find_mngr__detect_discovery_bcon, fw_divmod_unsigned, fw_log_emit3, fw_sysassert_fatal, mid_list__find_by, power_mngr__post_evt5, scan_mngr__dband_beacon_ind, sched_builder__build_if_present
 * Глобалы (через gp): 0x800338
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dmg_bcon__rx_handler
dmg_bcon__rx_handler:
	.global L_8c9404
L_8c9404:
	push_s blink
L_8c9406:
	bl L_8c01d0
L_8c940a:
	mov_s r13,r0
L_8c940c:
	ld_s r0,[r1,0xc]
L_8c940e:
	mov_s r14,r1
L_8c9410:
	breq_s r0,0,L_8c9478
	.global L_8c9412
L_8c9412:
	ld_s r3,[r14,0xc]
L_8c9414:
	ld r0,[r3, 0xc0]
L_8c9418:
	breq_s r0,0,L_8c9486
	.global L_8c941a
L_8c941a:
	ld r17,[r13, 0x4]
L_8c941e:
	ld r0,[r3, 0xc0]
L_8c9422:
	mov_s r15,0x803c00
L_8c9428:
	ldb_s r2,[r0,0x5]
L_8c942a:
	add3 r18,r17,0x9
L_8c942e:
	lsr r1,r2,0x3
L_8c9432:
	ld_s r0,[r15,0x20]
L_8c9434:
	lsr_s r2,r2,0x4
L_8c9436:
	bmsk_s r1,r1,0x0
L_8c9438:
	bmsk_s r2,r2,0x1
L_8c943a:
	bbit1 r0,0x9,L_8c9442
L_8c943e:
	ld_s r0,[r15,0xc]
L_8c9440:
	breq_s r0,0,L_8c9446
	.global L_8c9442
L_8c9442:
	mov_s r1,0x1
L_8c9444:
	mov_s r2,r1
	.global L_8c9446
L_8c9446:
	ld r0,[r3, 0x84]
L_8c944a:
	mov_s r15,0x0
L_8c944c:
	breq_s r0,0,L_8c9468
L_8c944e:
	ldb_s r0,[r0]
L_8c9450:
	mov_s r3,0x847adc
L_8c9456:
	lsr_s r0,r0,0x2
L_8c9458:
	bxor r0,r0,0x0
L_8c945c:
	ldb_s r15,[r3,0x5]
L_8c945e:
	bmsk_s r0,r0,0x0
L_8c9460:
	rsub.f r15,r15,r0
L_8c9464:
	mov.ne r15,0x1
	.global L_8c9468
L_8c9468:
	add r0,r13,0xc
L_8c946c:
	ld_s r3,[r0,0x40]
L_8c946e:
	breq_s r3,0,L_8c9496
L_8c9470:
	bl.d L_8c7f40
L_8c9474:
	mov_s r1,r14
L_8c9476:
	b_s L_8c94f8
	.global L_8c9478
L_8c9478:
	mov_s r0,blink
L_8c947a:
	mov_s r1,0x1232
L_8c9480:
	bl L_8c9b28
L_8c9484:
	b_s L_8c9412
	.global L_8c9486
L_8c9486:
	mov_s r0,blink
L_8c9488:
	mov_s r1,0x1233
L_8c948e:
	bl L_8c9b28
L_8c9492:
	ld_s r3,[r14,0xc]
L_8c9494:
	b_s L_8c941a
	.global L_8c9496
L_8c9496:
	ld_s r0,[r13,0x8]
L_8c9498:
	ld_s r3,[r0,0x6c]
L_8c949a:
	mov r4,0x0
L_8c949e:
	cmp_s r3,0x0
L_8c94a0:
	cmp.ne r3,0x3
L_8c94a4:
	mov.ne r3,r4
L_8c94a8:
	bne_s L_8c94c2
L_8c94aa:
	ldb r3,[r0,0x216]
L_8c94b2:
	brne r3,0x1,L_8c94bc
L_8c94b6:
	ld_s r3,[r0,0x78]
L_8c94b8:
	breq r3,0x1,L_8c94c0
	.global L_8c94bc
L_8c94bc:
	mov_s r3,0x0
L_8c94be:
	b_s L_8c94c2
	.global L_8c94c0
L_8c94c0:
	mov_s r3,0x1
	.global L_8c94c2
L_8c94c2:
	extb.f 0x0,r3
L_8c94c6:
	bne_s L_8c94ec
L_8c94c8:
	ld r3,[r18, 0x8]
L_8c94cc:
	mov r4,0x0
L_8c94d0:
	cmp_s r3,0x2
L_8c94d2:
	cmp.ne r3,0x3
L_8c94d6:
	mov.ne r3,r4
L_8c94da:
	bne_s L_8c94de
L_8c94dc:
	mov_s r3,0x1
	.global L_8c94de
L_8c94de:
	extb.f 0x0,r3
L_8c94e2:
	bne_s L_8c94f6
L_8c94e4:
	cmp_s r1,0x0
L_8c94e6:
	cmp.eq r2,0x0
L_8c94ea:
	beq_s L_8c94f6
	.global L_8c94ec
L_8c94ec:
	mov_s r1,r14
L_8c94ee:
	bl.d L_8c7f9c
L_8c94f2:
	mov_s r2,r15
L_8c94f4:
	b_s L_8c94f8
	.global L_8c94f6
L_8c94f6:
	mov_s r0,0x0
	.global L_8c94f8
L_8c94f8:
	cmp_s r15,0x0
L_8c94fa:
	mov_s r16,r0
L_8c94fc:
	bne_s L_8c95fe
L_8c94fe:
	ld r0,[r18, 0x4]
L_8c9502:
	cmp_s r0,0x2
L_8c9504:
	bne_s L_8c95fe
L_8c9506:
	add2 r0,r17,0x15
L_8c950a:
	ld_s r1,[r14,0x8]
L_8c950c:
	ldb_s r3,[r0]
L_8c950e:
	ldb_s r2,[r1,0x4]
L_8c9510:
	cmp_s r3,r2
L_8c9512:
	bne_s L_8c95fe
L_8c9514:
	ldb_s r3,[r0,0x1]
L_8c9516:
	ldb_s r2,[r1,0x5]
L_8c9518:
	brne r3,r2,L_8c95fe
L_8c951c:
	ldb_s r3,[r0,0x2]
L_8c951e:
	ldb_s r2,[r1,0x6]
L_8c9520:
	brne r3,r2,L_8c95fe
L_8c9524:
	ldb_s r3,[r0,0x3]
L_8c9526:
	ldb_s r2,[r1,0x7]
L_8c9528:
	brne r3,r2,L_8c95fe
L_8c952c:
	ldb_s r3,[r0,0x4]
L_8c952e:
	ldb_s r2,[r1,0x8]
L_8c9530:
	brne r3,r2,L_8c95fe
L_8c9534:
	ldb_s r2,[r0,0x5]
L_8c9536:
	ldb_s r0,[r1,0x9]
L_8c9538:
	brne r2,r0,L_8c95fe
L_8c953c:
	ld_s r0,[gp,0x1b4]
L_8c953e:
	breq_s r0,0,L_8c95ae
L_8c9540:
	bl L_8e9524
L_8c9544:
	ld.as r2,[gp,0x6d]
L_8c9548:
	mov_s r15,r0
L_8c954a:
	ldw_s r0,[r2,0xa]
L_8c954c:
	ldb r1,[gp, 0xad]
L_8c9550:
	mul64 r0,0x3e8
L_8c9554:
	add r18,mlo,0x960
L_8c955c:
	ld r19,[r2, 0x10]
L_8c9560:
	mulu64 r1,r18
L_8c9564:
	brlo.d r15,r19,L_8c9574
L_8c9568:
	mov r17,mlo
L_8c956c:
	sub r0,r15,r19
L_8c9570:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c9572:
	b_s L_8c9582
	.global L_8c9574
L_8c9574:
	rsub r0,r19,0xffffffff
L_8c957c:
	add_s r0,r0,r15
L_8c957e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c9580:
	add_s r0,r0,0x10
	.global L_8c9582
L_8c9582:
	bl.d L_8c02d4
L_8c9586:
	mov_s r1,r17
L_8c9588:
	mov_s r4,r1
L_8c958a:
	sub r0,r17,r18
L_8c958e:
	mov_s r1,0x7530
L_8c9594:
	brhs r4,r0,L_8c95ae
L_8c9598:
	brhs r1,r4,L_8c95ae
L_8c959c:
	mov_s r1,0x1016744
L_8c95a2:
	mov_s r0,0x2b
L_8c95a4:
	mov_s r2,r15
L_8c95a6:
	bl.d L_8dcd00
L_8c95aa:
	mov_s r3,r19
L_8c95ac:
	b_s L_8c95fe
	.global L_8c95ae
L_8c95ae:
	ld_s r1,[r14,0x8]
L_8c95b0:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8c95b2:
	bl.d L_8cc024
L_8c95b6:
	ld_s r0,[r13,0x4]
L_8c95b8:
	mov.f r15,r0
L_8c95bc:
	beq_s L_8c95f6
L_8c95be:
	ld_s r0,[r14,0xc]
L_8c95c0:
	ld_s r0,[r0,0x6c]
L_8c95c2:
	breq_s r0,0,L_8c95ce
L_8c95c4:
	ld_s r0,[r13,0x4]
L_8c95c6:
	bl.d L_8df698
L_8c95ca:
	mov_s r1,r14
L_8c95cc:
	b_s L_8c95e4
	.global L_8c95ce
L_8c95ce:
	mov_s r0,0x857260
L_8c95d4:
	ldb_s r0,[r0,0x4]
L_8c95d6:
	brne r0,0x2,L_8c95e4
L_8c95da:
	ld_s r0,[r13,0x4]
L_8c95dc:
	bl.d L_8ea86c
L_8c95e0:
	ld.as r0,[r0,0xa4]
	.global L_8c95e4
L_8c95e4:
	mov_s r0,r15
L_8c95e6:
	bl.d L_8c47e0
L_8c95ea:
	mov_s r1,r14
L_8c95ec:
	ld_s r0,[r14,0xc]
L_8c95ee:
	bl.d L_8c3e90
L_8c95f2:
	ld r0,[r0, 0xac]
	.global L_8c95f6
L_8c95f6:
	ld_s r0,[r13,0x4]
L_8c95f8:
	bl.d L_8e91fc
L_8c95fc:
	ldb_s r0,[r0,0x10]
	.global L_8c95fe
L_8c95fe:
	b.d L_8c022c
L_8c9602:
	mov_s r0,r16
