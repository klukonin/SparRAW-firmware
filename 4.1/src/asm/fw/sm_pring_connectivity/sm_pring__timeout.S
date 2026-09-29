/* sm_pring__timeout @ 0x8e43c8, 488 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sm_pring_connectivity.cpp
 *   Timeout: [V-Ring %d] is_eop_TO %d, ptp_avial %d
 *   Timeout: FLUSH CMD for V-Ring %d at <%d> so far run %d usec
 *   PRING: TIMEOUT HANDLER: DMA is not Empty, Try#:%d
 *   Vring disconnect flow but DMA is not idle m_vring_index %d
 *   PRING is idle - close V-Ring %d.
 *   Spurious event of PRING timeout at <%d>.
 * Зовут его: frag_8dcc4c
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, dma_is_idle, fw_log__emit1, fw_log__emit3, fw_read_timer, fw_sysassert_fatal, hwd_pcie_exit_l1, lmac_if_send_cmd_0x08, tx_macq__is_empty, txq_ptp_sw_is_fifo_idle, u_schd__schedule
 * Глобалы (через gp): 0x800334
 */
	.section .text.sm_pring__timeout,"ax",@progbits
	.global sm_pring__timeout
sm_pring__timeout:
	.global L_8e43c8
L_8e43c8:
	push_s blink
L_8e43ca:
	bl L_8c02b0
L_8e43ce:
	mov_s r13,r0
L_8e43d0:
	mov_s r0,0x886a00
L_8e43d6:
	ld r19,[r0, 0x24]
L_8e43da:
	ld_s r1,[r13,0x1c]
L_8e43dc:
	mov_s r15,0x0
L_8e43de:
	ld_s r0,[r13,0x20]
L_8e43e0:
	breq_s r1,0,L_8e441e
L_8e43e2:
	mov_s r14,0x1
L_8e43e4:
	cmp_s r0,0x0
L_8e43e6:
	st_s r15,[r13,0x1c]
L_8e43e8:
	mov.eq r16,r14
L_8e43ec:
	beq_s L_8e4424
L_8e43ee:
	mov_s r0,blink
L_8e43f0:
	mov_s r2,0x100ec18
L_8e43f6:
	mov_s r1,0x12a7
L_8e43fc:
	mov r3,0x166
L_8e4400:
	mov_s r16,r14
L_8e4402:
	b_s L_8e4418
	.global L_8e4404
L_8e4404:
	mov_s r0,blink
L_8e4406:
	mov_s r2,0x100ec18
L_8e440c:
	mov_s r1,0x12ae
L_8e4412:
	mov r3,0x16d
L_8e4416:
	mov_s r16,r15
	.global L_8e4418
L_8e4418:
	bl L_8c82c0
L_8e441c:
	b_s L_8e4424
	.global L_8e441e
L_8e441e:
	breq_s r0,0,L_8e4404
L_8e4420:
	st_s r15,[r13,0x20]
L_8e4422:
	mov_s r16,r15
	.global L_8e4424
L_8e4424:
	ld_s r1,[r13,0x18]
L_8e4426:
	cmp_s r1,0x4
L_8e4428:
	bhi L_8e4594
L_8e442c:
	ldb r1,[0x801f44,r1]
L_8e4434:
	add r0,pcl,0x8
L_8e4438:
	add1_s r0,r0,r1
L_8e443a:
	j_s [r0]
L_8e443c:
	ldw_s r0,[r13]
L_8e443e:
	bl.d L_8cdaf8
L_8e4442:
	mov_s r1,0x0
L_8e4444:
	cmp_s r0,0x0
L_8e4446:
	bne_s L_8e455e
L_8e4448:
	bl.d L_8ce578
L_8e444c:
	mov_s r0,0x1
L_8e444e:
	bl.d L_8cacc0
L_8e4452:
	ldw_s r0,[r13,0x2]
L_8e4454:
	mov_s r18,r0
L_8e4456:
	bl.d L_8d7084
L_8e445a:
	mov_s r1,0x0
L_8e445c:
	brne r0,0x0,L_8e4500
L_8e4460:
	bl L_8e4694
L_8e4464:
	ld_s r1,[r13,0xc]
L_8e4466:
	asl r17,r0,0x4
L_8e446a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e446c:
	st_s r1,[r13,0xc]
L_8e446e:
	brlo.d r1,0x5,L_8e44b6
L_8e4472:
	ldw_s r0,[r13]
L_8e4474:
	bl.d L_8cdaf8
L_8e4478:
	mov_s r1,0x1
L_8e447a:
	bl.d L_8e50f0
L_8e447e:
	mov_s r0,0x0
L_8e4480:
	mov_s r0,r18
L_8e4482:
	bl.d L_8d7084
L_8e4486:
	mov_s r1,0x1
L_8e4488:
	mov_s r2,0x100ec9c
L_8e448e:
	mov_s r0,0x7
L_8e4490:
	mov_s r1,0x0
L_8e4492:
	ldw_s r3,[r13,0x2]
L_8e4494:
	mov r4,r16
L_8e4498:
	bl.d L_8ee034
L_8e449c:
	mov r5,r19
L_8e44a0:
	mov_s r0,blink
L_8e44a2:
	mov_s r2,0x100ec18
L_8e44a8:
	mov_s r1,0x12a9
L_8e44ae:
	bl.d L_8c82c0
L_8e44b2:
	mov r3,0x188
	.global L_8e44b6
L_8e44b6:
	mov_s r2,0x0
L_8e44b8:
	ld.as r4,[gp,0x71]
L_8e44bc:
	mov_s r0,0x1cc50
L_8e44c2:
	ldw_s r1,[r13]
L_8e44c4:
	mov_s r3,0x1
L_8e44c6:
	mov_s r5,r2
L_8e44c8:
	bl.d L_8dc92c
L_8e44cc:
	mov_s r6,r2
L_8e44ce:
	st_s r0,[r13,0x1c]
L_8e44d0:
	ld_s r0,[r13,0x2c]
L_8e44d2:
	mov_s r2,0x100eccc
L_8e44d8:
	sub r5,r17,r0
L_8e44dc:
	ldw_s r3,[r13,0x2]
L_8e44de:
	mov_s r0,0x7
L_8e44e0:
	mov_s r1,0x2
L_8e44e2:
	bl.d L_8ee034
L_8e44e6:
	mov r4,r17
L_8e44ea:
	mov_s r0,0x3
L_8e44ec:
	mov_s r1,r0
L_8e44ee:
	mov_s r2,0x0
L_8e44f0:
	ldb_s r3,[r13,0x2]
L_8e44f2:
	mov_s r4,r2
L_8e44f4:
	mov r5,0x1
L_8e44f8:
	bl.d L_8d8864
L_8e44fc:
	mov_s r6,r2
L_8e44fe:
	b_s L_8e45aa
	.global L_8e4500
L_8e4500:
	ld_s r0,[r13,0xc]
L_8e4502:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e4504:
	brhs.d r0,0x6,L_8e453a
L_8e4508:
	st_s r0,[r13,0xc]
L_8e450a:
	ld.as r4,[gp,0x71]
L_8e450e:
	mov_s r0,0x1cc50
L_8e4514:
	ldw_s r1,[r13]
L_8e4516:
	mov_s r2,0x0
L_8e4518:
	mov_s r3,0x1
L_8e451a:
	mov r5,0x0
L_8e451e:
	bl.d L_8dc92c
L_8e4522:
	mov r6,0x0
L_8e4526:
	st_s r0,[r13,0x1c]
L_8e4528:
	mov_s r2,0x100ed08
L_8e452e:
	mov_s r0,0x7
L_8e4530:
	mov_s r1,0x2
L_8e4532:
	bl.d L_8edfcc
L_8e4536:
	ld_s r3,[r13,0xc]
L_8e4538:
	b_s L_8e45aa
	.global L_8e453a
L_8e453a:
	mov_s r2,0x100ed3c
L_8e4540:
	mov_s r0,0x7
L_8e4542:
	mov_s r1,0x0
L_8e4544:
	bl.d L_8edfcc
L_8e4548:
	ldw_s r3,[r13,0x2]
L_8e454a:
	mov_s r0,blink
L_8e454c:
	mov_s r2,0x100ec18
L_8e4552:
	mov_s r1,0x12aa
L_8e4558:
	mov r3,0x19d
L_8e455c:
	b_s L_8e45a6
	.global L_8e455e
L_8e455e:
	bl.d L_8ce578
L_8e4562:
	mov_s r0,0x0
L_8e4564:
	mov_s r2,0x100ed78
L_8e456a:
	mov_s r0,0x7
L_8e456c:
	mov_s r1,0x2
L_8e456e:
	bl.d L_8edfcc
L_8e4572:
	ldw_s r3,[r13,0x2]
L_8e4574:
	bl.d L_8c5b94
L_8e4578:
	mov_s r0,r13
L_8e457a:
	b_s L_8e45aa
L_8e457c:
	bl L_8e4694
L_8e4580:
	mov_s r2,0x100ed9c
L_8e4586:
	mov_s r3,r0
L_8e4588:
	mov_s r0,0x7
L_8e458a:
	mov_s r1,0x2
L_8e458c:
	/* bl.d 0x008edfcc */
	.byte 0x42,0x0a,0xe0,0x04
L_8e4590:
	/* _asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_8e4592:
	b_s L_8e45aa
	.global L_8e4594
L_8e4594:
	mov_s r0,blink
L_8e4596:
	mov_s r2,0x100ec18
L_8e459c:
	mov_s r1,0x12ab
L_8e45a2:
	mov r3,0x1b3
	.global L_8e45a6
L_8e45a6:
	bl L_8c82c0
	.global L_8e45aa
L_8e45aa:
	b L_8c030c
L_8e45ae:
	nop_s
