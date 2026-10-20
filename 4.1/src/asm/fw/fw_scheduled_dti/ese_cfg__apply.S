/* ese_cfg__apply @ 0x8e7418, 528 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ESE CFG CMD. ESE: %d
 *   ESE CFG CMD. Source AID: %d, Destination AID: %d
 *   ESE CFG CMD. allocation_type: %d, allocation_block_duration: %d, allocation_id: %d
 *   Number of DTI allocations exceeded: %d. Ignoring allocation
 *   fw_scheduled_dti.cpp
 * Зовут его: wmi_handler_ese_cfg
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r22_to_r13_ret, __st_r22_to_r13, bf_h_s8_w2, bf_w_s0_w4, bf_w_s4_w3, ese__find_alloc_by_id, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, memcpy_fw
 * Глобалы (через gp): 0x8002a0, 0x80036c
 */
	.section .text.ese_cfg__apply,"ax",@progbits
	.global ese_cfg__apply
ese_cfg__apply:
	.global L_8e7418
L_8e7418:
	push_s blink
L_8e741a:
	bl L_8c02a4
L_8e741e:
	sub_s sp,sp,0x14
L_8e7420:
	mov_s r15,r0
L_8e7422:
	mov_s r16,r1
L_8e7424:
	bl.d L_8c2c80
L_8e7428:
	ld.as r19,[gp,0x4c]
L_8e742c:
	mov_s r1,0x90
L_8e742e:
	stb_s r1,[r0]
L_8e7430:
	mov_s r17,r0
L_8e7432:
	ldb r1,[r16]
L_8e7436:
	mov_s r0,0xf
L_8e7438:
	mul64_s r1,r0
L_8e743a:
	mov_s r22,r0
L_8e743c:
	stb mlo,[r17, 0x1]
L_8e7440:
	ldb r0,[r16]
L_8e7444:
	cmp_s r0,0x3
L_8e7446:
	bgt L_8e7542
	.global L_8e744a
L_8e744a:
	mov r20,0x0
L_8e744e:
	mov_s r0,0x857260
L_8e7454:
	stb r20,[r0, 0xd]
L_8e7458:
	ldb r2,[r16]
L_8e745c:
	cmp_s r2,0x0
L_8e745e:
	ble.d L_8e75ee
L_8e7462:
	mov_s r21,r0
L_8e7464:
	mov_s r13,r20
	.global L_8e7466
L_8e7466:
	mov_s r0,sp
L_8e7468:
	bl.d L_8c1a78
L_8e746c:
	mov_s r1,0xf
L_8e746e:
	ldb_s r2,[r15,0x14]
L_8e7470:
	mov_s r0,sp
L_8e7472:
	bmsk r1,r2,0x3
L_8e7476:
	/* bl.d 0x008e8348 */
	.byte 0xd6,0x0e,0x60,0x00
L_8e747a:
	/* _add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e747c:
	add_s r14,r13,r13
L_8e747e:
	add1_s r14,r14,r14
L_8e7480:
	stb_s r2,[r15,0x14]
L_8e7482:
	add_s r14,r14,r16
L_8e7484:
	ldb_s r1,[r14,0x3]
L_8e7486:
	bmsk_s r1,r1,0x2
L_8e7488:
	bl.d L_8e84ec
L_8e748c:
	add2 r18,r15,r13
L_8e7490:
	ld_s r0,[sp,0x0]
L_8e7492:
	mov_s r1,0x1
L_8e7494:
	bset_s r0,r0,0x7
L_8e7496:
	st_s r0,[sp,0x0]
L_8e7498:
	ldb_s r0,[r14,0x1]
L_8e749a:
	ldb_s r2,[r14,0x6]
L_8e749c:
	stb_s r0,[sp,0x4]
L_8e749e:
	ldb_s r0,[r14,0x2]
L_8e74a0:
	asl_s r2,r2,0x8
L_8e74a2:
	stb r0,[sp, 0x5]
L_8e74a6:
	ldb_s r0,[r14,0x5]
L_8e74a8:
	stb_s r1,[sp,0xc]
L_8e74aa:
	or_s r0,r0,r2
L_8e74ac:
	stw r0,[sp, 0xa]
L_8e74b0:
	ld.as r2,[gp,0x7f]
L_8e74b4:
	st r19,[r18, 0x8]
L_8e74b8:
	add_s r0,r0,r2
L_8e74ba:
	add r19,r19,r0
L_8e74be:
	mov_s r2,0x1011a00
L_8e74c4:
	mov_s r0,0xb
L_8e74c6:
	mov_s r1,0x2
L_8e74c8:
	bl.d L_8edfcc
L_8e74cc:
	mov_s r3,r13
L_8e74ce:
	mov_s r2,0x1011a18
L_8e74d4:
	ldb r4,[r14, 0x2]
L_8e74d8:
	mov_s r0,0xb
L_8e74da:
	mov_s r1,0x2
L_8e74dc:
	bl.d L_8edff8
L_8e74e0:
	ldb_s r3,[r14,0x1]
L_8e74e2:
	mov_s r2,0x1011a4c
L_8e74e8:
	ldb_s r0,[r14,0x6]
L_8e74ea:
	ldb r4,[r14, 0x5]
L_8e74ee:
	asl_s r0,r0,0x8
L_8e74f0:
	or r4,r4,r0
L_8e74f4:
	ld r5,[sp]
L_8e74f8:
	mov_s r0,0xb
L_8e74fa:
	ldb_s r3,[r14,0x3]
L_8e74fc:
	mov_s r1,0x2
L_8e74fe:
	bl.d L_8ee034
L_8e7502:
	bmsk r5,r5,0x3
L_8e7506:
	add2 r0,r13,r13
L_8e750a:
	add1_s r0,r0,r0
L_8e750c:
	add_s r0,r0,r17
L_8e750e:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e7510:
	mov_s r1,sp
L_8e7512:
	bl.d L_8c0460
L_8e7516:
	mov_s r2,0xf
L_8e7518:
	ldb_s r1,[sp,0x4]
L_8e751a:
	mov_s r0,r15
L_8e751c:
	bl.d L_8d733c
L_8e7520:
	ldb r2,[sp, 0x5]
L_8e7524:
	breq r0,0x0,L_8e75e2
L_8e7528:
	ldb r0,[r21, 0xd]
L_8e752c:
	brlt r0,0x3,L_8e7558
L_8e7530:
	mov_s r2,0x1011984
L_8e7536:
	mov_s r0,0xb
L_8e7538:
	mov_s r1,0x0
L_8e753a:
	bl.d L_8edfcc
L_8e753e:
	mov_s r3,0x3
L_8e7540:
	b_s L_8e75e2
	.global L_8e7542
L_8e7542:
	mov_s r0,blink
L_8e7544:
	mov_s r2,0x10119e8
L_8e754a:
	mov_s r1,0x11bb
L_8e7550:
	bl.d L_8c82c0
L_8e7554:
	mov_s r3,0xd8
L_8e7556:
	b_s L_8e744a
	.global L_8e7558
L_8e7558:
	stw r20,[sp, 0x10]
L_8e755c:
	ldb_s r1,[sp,0x4]
L_8e755e:
	mov_s r14,0xff
L_8e7560:
	ldb r2,[sp, 0x5]
L_8e7564:
	ld_s r0,[r15]
L_8e7566:
	breq r1,r14,L_8e7570
L_8e756a:
	ldb_s r3,[r0,0x8]
L_8e756c:
	brne r1,r3,L_8e7582
	.global L_8e7570
L_8e7570:
	bl.d L_8c9ebc
L_8e7574:
	mov_s r1,r2
L_8e7576:
	stb_s r0,[sp,0x10]
L_8e7578:
	add_s r0,sp,0x10
L_8e757a:
	mov_s r1,0x0
L_8e757c:
	bl L_8e8300
L_8e7580:
	b_s L_8e75b2
	.global L_8e7582
L_8e7582:
	cmp_s r2,r14
L_8e7584:
	cmp.ne r2,r3
L_8e7588:
	bne_s L_8e759a
L_8e758a:
	bl L_8c9ebc
L_8e758e:
	mov_s r1,0x1
L_8e7590:
	stb_s r0,[sp,0x10]
L_8e7592:
	add_s r0,sp,0x10
L_8e7594:
	bl L_8e8300
L_8e7598:
	b_s L_8e75b2
	.global L_8e759a
L_8e759a:
	mov_s r0,blink
L_8e759c:
	mov_s r2,0x10119e8
L_8e75a2:
	mov_s r1,0x11d1
L_8e75a8:
	bl.d L_8c82c0
L_8e75ac:
	mov r3,0x112
L_8e75b0:
	mov_s r1,0x0
	.global L_8e75b2
L_8e75b2:
	ldb r2,[r21, 0xd]
L_8e75b6:
	mov_s r0,0x857000
L_8e75bc:
	ld r3,[r18, 0x8]
L_8e75c0:
	add2_s r0,r0,r2
L_8e75c2:
	st.as r3,[r0,0x9f]
L_8e75c6:
	ldw r3,[sp, 0xa]
L_8e75ca:
	asl_s r1,r1,0x1c
L_8e75cc:
	st.as r3,[r0,0xa2]
L_8e75d0:
	ldw r3,[sp, 0x10]
L_8e75d4:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e75d6:
	or_s r1,r1,r3
L_8e75d8:
	st.as r1,[r0,0x9c]
L_8e75dc:
	extb_s r2,r2
L_8e75de:
	stb r2,[r21, 0xd]
	.global L_8e75e2
L_8e75e2:
	ldb r2,[r16]
L_8e75e6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e75e8:
	cmp_s r2,r13
L_8e75ea:
	bgt L_8e7466
	.global L_8e75ee
L_8e75ee:
	ld_s r0,[r15]
L_8e75f0:
	brne_s r2,0,L_8e7606
L_8e75f2:
	mov_s r1,0x0
L_8e75f4:
	bl.d L_8de250
L_8e75f8:
	mov_s r2,0x90
L_8e75fa:
	ld_s r0,[r15]
L_8e75fc:
	bl.d L_8e555c
L_8e7600:
	add r0,r0,0x2b4
L_8e7604:
	b_s L_8e7622
	.global L_8e7606
L_8e7606:
	mul64 r2,r22
L_8e760a:
	mov_s r1,0x0
L_8e760c:
	add r2,mlo,0x2
L_8e7610:
	extw_s r2,r2
L_8e7612:
	bl.d L_8e1458
L_8e7616:
	mov_s r3,r17
L_8e7618:
	ld_s r0,[r15]
L_8e761a:
	bl.d L_8e196c
L_8e761e:
	add r0,r0,0x2b4
	.global L_8e7622
L_8e7622:
	b.d L_8c02f4
L_8e7626:
	add_s sp,sp,0x14
