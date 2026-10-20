/* l2mgr__send_host_event @ 0x8f0380, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   layer2_mgr.cpp
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID for devid %d.
 *   <<---- [HOST EVENT] WMI_CONNECT_EVENTID CID %d resp size %d, channel %d.
 * Зовут его: l2mgr__publish_assoc_done
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, conn_mgr__by_cid, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, get_g_8000ac_8c5c9c, memcpy_fw, memset0_words, mid_list__by_mid, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_host_event,"ax",@progbits
	.global l2mgr__send_host_event
l2mgr__send_host_event:
	.global L_8f0380
L_8f0380:
	push_s blink
L_8f0382:
	bl L_8c02a0
L_8f0386:
	mov_s r20,r0
L_8f0388:
	bl.d L_8ca1b0
L_8f038c:
	mov_s r17,r1
L_8f038e:
	mov_s r16,r0
L_8f0390:
	bl.d L_8c9e44
L_8f0394:
	mov_s r0,r17
L_8f0396:
	mov.f r18,r0
L_8f039a:
	beq_s L_8f0428
	.global L_8f039c
L_8f039c:
	add3 r21,r18,0x16
L_8f03a0:
	bl.d L_8c2b68
L_8f03a4:
	ld r13,[r21, 0x48]
L_8f03a8:
	mov_s r14,r0
L_8f03aa:
	bl.d L_8c1a78
L_8f03ae:
	mov_s r1,0x17
L_8f03b0:
	add r1,r18,0x10
L_8f03b4:
	add_s r0,r14,0x2
L_8f03b6:
	bl.d L_8c0460
L_8f03ba:
	mov_s r2,0x6
L_8f03bc:
	mov_s r15,0x0
L_8f03be:
	mov_s r0,r15
L_8f03c0:
	stb_s r0,[r14,0x8]
L_8f03c2:
	lsr_s r0,r0,0x8
L_8f03c4:
	stb_s r0,[r14,0x9]
L_8f03c6:
	ldw r1,[r16, 0x96]
L_8f03ca:
	stb_s r1,[r14,0xa]
L_8f03cc:
	lsr_s r1,r1,0x8
L_8f03ce:
	stb_s r1,[r14,0xb]
L_8f03d0:
	ld r0,[r16, 0x14]
L_8f03d4:
	stb_s r15,[r14,0x10]
L_8f03d6:
	stb_s r0,[r14,0xc]
L_8f03d8:
	stb r17,[r14, 0x13]
L_8f03dc:
	stb_s r15,[r14,0x11]
L_8f03de:
	stb_s r15,[r14,0x12]
L_8f03e0:
	mov r16,0x17
L_8f03e4:
	breq r13,0x0,L_8f0476
L_8f03e8:
	ldb r0,[r13, 0x37]
L_8f03ec:
	stb_s r0,[r14]
L_8f03ee:
	ld_s r0,[r13,0x30]
L_8f03f0:
	sub r22,r0,0x18
L_8f03f4:
	extw r23,r22
L_8f03f8:
	bl.d L_8ca19c
L_8f03fc:
	add r19,r23,0x17
L_8f0400:
	brlo r0,r19,L_8f0446
L_8f0404:
	ld_s r1,[r13,0x14]
L_8f0406:
	add r0,r14,0x17
L_8f040a:
	bl.d L_8c0460
L_8f040e:
	mov_s r2,r23
L_8f0410:
	ld r0,[r18, 0xc]
L_8f0414:
	ld_s r0,[r0,0x50]
L_8f0416:
	cmp_s r0,0x1
L_8f0418:
	mov_s r0,0x1
L_8f041a:
	sub_s.ne r0,r0,r0
L_8f041c:
	extb.f 0x0,r0
L_8f0420:
	mov_s r0,r22
L_8f0422:
	beq_s L_8f0440
L_8f0424:
	stb_s r0,[r14,0x12]
L_8f0426:
	b_s L_8f0442
	.global L_8f0428
L_8f0428:
	mov_s r0,blink
L_8f042a:
	mov_s r2,0x100c474
L_8f0430:
	mov_s r1,0x11e7
L_8f0436:
	mov_s r3,0x83
L_8f0438:
	bl.d L_8c82c0
L_8f043c:
	bset_s r3,r3,0xb
L_8f043e:
	b_s L_8f039c
	.global L_8f0440
L_8f0440:
	stb_s r0,[r14,0x11]
	.global L_8f0442
L_8f0442:
	extw r16,r19
	.global L_8f0446
L_8f0446:
	st r15,[r21, 0x48]
L_8f044a:
	mov_s r2,0x100c518
L_8f0450:
	mov_s r0,0xb
L_8f0452:
	mov_s r1,0x2
L_8f0454:
	bl.d L_8edfcc
L_8f0458:
	mov_s r3,r20
L_8f045a:
	ld_s r2,[r13,0x30]
L_8f045c:
	add r0,r13,0x28
L_8f0460:
	add_s r2,r2,0x10
L_8f0462:
	extw_s r2,r2
L_8f0464:
	mov_s r1,0x61
L_8f0466:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8f0468:
	mov_s r3,r20
L_8f046a:
	mov r4,0x1
L_8f046e:
	bl.d L_8e0874
L_8f0472:
	mov r5,0x0
	.global L_8f0476
L_8f0476:
	mov_s r2,0x100c558
L_8f047c:
	ldb r5,[r14]
L_8f0480:
	mov_s r0,0xb
L_8f0482:
	mov_s r1,0x2
L_8f0484:
	mov_s r3,r17
L_8f0486:
	bl.d L_8ee034
L_8f048a:
	mov r4,r16
L_8f048e:
	mov_s r0,r14
L_8f0490:
	mov_s r1,0x2
L_8f0492:
	bset_s r1,r1,0xc
L_8f0494:
	mov_s r2,r16
L_8f0496:
	mov_s r3,r20
L_8f0498:
	mov r4,0x0
L_8f049c:
	bl.d L_8e0874
L_8f04a0:
	mov r5,r4
L_8f04a4:
	bl.d L_8c5c9c
L_8f04a8:
	mov_s r0,0x1
L_8f04aa:
	b L_8c02ec
L_8f04ae:
	nop_s
