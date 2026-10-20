/* lmac_if__bf_done_evt @ 0x8db3c8, 336 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Manually failling the BF for debug
 *   BF DONE: OK. Flow type: BF_SUBFLOWS_DONE_DTI_TXSS
 *   BF DONE: OK. Flow type: BF_SUBFLOWS_DONE_DTI_TXSS_BRP
 *   BF DONE: OK. Flow type: BF_SUBFLOWS_DONE_ABFT_TXSS
 *   [NNL] CID=%2d STATE=%3d SUBSTATE=%3d
 *       DSH DBG: TX Sector: %d RX Sector: %d omni_address: %d
 *       DSH DBG: TX Sector snr: %d
 *       BF DONE: FAILED(ABORTED) CID=%2d STATE=%3d SUBSTATE=%3d
 * Зовут его: lmac_if__abft_notify_evt, lmac_if__bf_done_and_new_link
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3
 * Глобалы (через gp): 0x8002f8, 0x80030c, 0x800318
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__bf_done_evt
lmac_if__bf_done_evt:
	.global L_8db3c8
L_8db3c8:
	push_s blink
L_8db3ca:
	bl L_8c01e4
L_8db3ce:
	mov_s r13,r0
L_8db3d0:
	ld_s r0,[gp,0x188]
L_8db3d2:
	mov_s r14,0x0
L_8db3d4:
	breq_s r0,0,L_8db3fa
L_8db3d6:
	ld_s r0,[gp,0x174]
L_8db3d8:
	ld.as r1,[gp,0x65]
L_8db3dc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8db3de:
	st.as r0,[gp,0x5d]
L_8db3e2:
	brne r0,r1,L_8db3ec
L_8db3e6:
	st.as r14,[gp,0x5d]
L_8db3ea:
	b_s L_8db3fa
	.global L_8db3ec
L_8db3ec:
	mov_s r1,0x1003bc8
L_8db3f2:
	bl.d L_8dcba8
L_8db3f6:
	mov_s r0,0x10
L_8db3f8:
	st_s r14,[r13,0x2c]
	.global L_8db3fa
L_8db3fa:
	ld_s r0,[r13,0x2c]
L_8db3fc:
	brne r0,0x1,L_8db466
L_8db400:
	ld_s r0,[r13,0x30]
L_8db402:
	brne_s r0,0,L_8db40c
L_8db404:
	mov_s r1,0x1003bec
L_8db40a:
	b_s L_8db422
	.global L_8db40c
L_8db40c:
	brne r0,0x1,L_8db418
L_8db410:
	mov_s r1,0x1003c20
L_8db416:
	b_s L_8db422
	.global L_8db418
L_8db418:
	brne r0,0x2,L_8db428
L_8db41c:
	mov_s r1,0x1003c58
	.global L_8db422
L_8db422:
	bl.d L_8dcba8
L_8db426:
	mov_s r0,0x20
	.global L_8db428
L_8db428:
	ldb r4,[r13, 0x3b]
L_8db42c:
	mov_s r1,0x1003c8c
L_8db432:
	ldb_s r2,[r13,0x4]
L_8db434:
	mov_s r0,0x20
L_8db436:
	bl.d L_8dcd00
L_8db43a:
	ldb r3,[r13, 0x3a]
L_8db43e:
	mov_s r1,0x1003cb4
L_8db444:
	ldw r4,[r13, 0xa]
L_8db448:
	mov_s r0,0x20
L_8db44a:
	ldb_s r2,[r13,0x6]
L_8db44c:
	bl.d L_8dcd00
L_8db450:
	ldb_s r3,[r13,0x5]
L_8db452:
	mov_s r1,0x1003cf0
L_8db458:
	mov_s r0,0x20
L_8db45a:
	bl.d L_8dcc10
L_8db45e:
	ldb.x r2,[r13, 0xc]
L_8db462:
	mov_s r14,0x1
L_8db464:
	b_s L_8db4b0
	.global L_8db466
L_8db466:
	brne_s r0,0,L_8db492
L_8db468:
	ldb r4,[r13, 0x3b]
L_8db46c:
	mov_s r1,0x1003d10
L_8db472:
	ldb_s r2,[r13,0x4]
L_8db474:
	mov_s r0,0x10
L_8db476:
	bl.d L_8dcd00
L_8db47a:
	ldb r3,[r13, 0x3a]
L_8db47e:
	mov_s r1,0x1003d4c
L_8db484:
	ldb_s r2,[r13,0x6]
L_8db486:
	mov_s r0,0x10
L_8db488:
	bl.d L_8dcc80
L_8db48c:
	ldb_s r3,[r13,0x8]
L_8db48e:
	mov_s r14,0x1
L_8db490:
	b_s L_8db4b0
	.global L_8db492
L_8db492:
	mov_s r14,0x0
L_8db494:
	brne r0,0x2,L_8db4b0
L_8db498:
	ldb r4,[r13, 0x3b]
L_8db49c:
	mov_s r1,0x1003d78
L_8db4a2:
	ldb_s r2,[r13,0x4]
L_8db4a4:
	mov_s r0,0x10
L_8db4a6:
	mov_s r14,0x1
L_8db4a8:
	bl.d L_8dcd00
L_8db4ac:
	ldb r3,[r13, 0x3a]
	.global L_8db4b0
L_8db4b0:
	breq r14,0x0,L_8db512
L_8db4b4:
	ld_s r2,[r13,0x3c]
L_8db4b6:
	breq r2,0x20,L_8db4fe
L_8db4ba:
	sub_s r1,r2,0x1
L_8db4bc:
	brhs r1,0x10,L_8db506
L_8db4c0:
	ldb.x r1,[0x801f1c,r1]
L_8db4c8:
	add r0,pcl,0x8
L_8db4cc:
	add1_s r0,r0,r1
L_8db4ce:
	j_s [r0]
L_8db4d0:
	mov_s r1,0x1003db8
L_8db4d6:
	b_s L_8db4e6
L_8db4d8:
	mov_s r1,0x1003df8
L_8db4de:
	b_s L_8db4e6
L_8db4e0:
	mov_s r1,0x1003e3c
	.global L_8db4e6
L_8db4e6:
	bl.d L_8dcba8
L_8db4ea:
	mov_s r0,0x20
L_8db4ec:
	b_s L_8db512
L_8db4ee:
	mov_s r1,0x1003e80
L_8db4f4:
	b_s L_8db4e6
L_8db4f6:
	mov_s r1,0x1003ebc
L_8db4fc:
	b_s L_8db4e6
	.global L_8db4fe
L_8db4fe:
	mov_s r1,0x1003eec
L_8db504:
	b_s L_8db4e6
	.global L_8db506
L_8db506:
	mov_s r1,0x1003f38
L_8db50c:
	bl.d L_8dcc10
L_8db510:
	mov_s r0,0x0
	.global L_8db512
L_8db512:
	b L_8c0254
L_8db516:
	nop_s
