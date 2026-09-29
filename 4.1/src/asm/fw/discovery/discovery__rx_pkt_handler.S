/* discovery__rx_pkt_handler @ 0x8df338, 344 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery.cpp
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID Beacon sent to host
 *   discovery::rx_pkt_handler() Probe Req pkt handler # %d
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID Probe Req pkt Pass to host %d
 *   discovery::rx_pkt_handler() Probe Resp pkt handler # %d
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID Probe Resp pkt
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, discovery__handle_rx_frame, discovery_handle_probe_req, discovery_handle_probe_resp, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, mgmt_buf__free, mgmt_pkt__release, operational_if__send_evt, tail_rx_mgmt_prs__alloc_ei
 */
	.section .text.discovery__rx_pkt_handler,"ax",@progbits
	.global discovery__rx_pkt_handler
discovery__rx_pkt_handler:
	.byte 0x4f
	.byte 0xf0
	.global fwlog_HOST_EVENT_WMI_RX_MGMT_PACKET_EVENTID_Pr
fwlog_HOST_EVENT_WMI_RX_MGMT_PACKET_EVENTID_Pr:
L_8df33a:
	nop_s
L_8df33c:
	push_s blink
L_8df33e:
	bl L_8c02bc
L_8df342:
	mov_s r16,r0
L_8df344:
	mov_s r14,r1
L_8df346:
	bl.d L_8df0e8
L_8df34a:
	mov_s r0,r1
L_8df34c:
	ld_s r0,[r14,0x8]
L_8df34e:
	ldw_s r0,[r0]
L_8df350:
	lsr_s r0,r0,0x4
L_8df352:
	bmsk.f r0,r0,0x3
L_8df356:
	beq_s L_8df376
L_8df358:
	breq r0,0x4,L_8df3ca
L_8df35c:
	breq r0,0x5,L_8df422
L_8df360:
	mov_s r0,blink
L_8df362:
	mov_s r2,0x1012024
L_8df368:
	mov_s r1,0x1231
L_8df36e:
	bl.d L_8c82c0
L_8df372:
	mov_s r3,0xaf
L_8df374:
	b_s L_8df48a
	.global L_8df376
L_8df376:
	mov_s r0,r16
L_8df378:
	bl.d L_8c7c80
L_8df37c:
	mov_s r1,r14
L_8df37e:
	mov_s r15,r0
L_8df380:
	mov_s r13,0x843104
L_8df386:
	ld_s r0,[r13,0x28]
L_8df388:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8df38a:
	st_s r0,[r13,0x28]
L_8df38c:
	bl.d L_8c955c
L_8df390:
	mov_s r0,r14
L_8df392:
	breq r15,0x0,L_8df450
L_8df396:
	mov_s r2,0x1012400
L_8df39c:
	mov_s r0,0xc
L_8df39e:
	bl.d L_8edfb0
L_8df3a2:
	mov_s r1,0x2
L_8df3a4:
	ld_s r2,[r14,0x30]
L_8df3a6:
	add r0,r14,0x28
L_8df3aa:
	add_s r2,r2,0x10
L_8df3ac:
	extw_s r2,r2
L_8df3ae:
	mov_s r1,0x61
L_8df3b0:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8df3b2:
	ldb r3,[r14, 0x35]
L_8df3b6:
	mov r4,0x1
L_8df3ba:
	bl.d L_8e0874
L_8df3be:
	mov r5,0x0
L_8df3c2:
	ld_s r0,[r13,0x1c]
L_8df3c4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8df3c6:
	st_s r0,[r13,0x1c]
L_8df3c8:
	b_s L_8df48a
	.global L_8df3ca
L_8df3ca:
	mov_s r13,0x843104
L_8df3d0:
	ld_s r3,[r13]
L_8df3d2:
	mov_s r2,0x1012444
L_8df3d8:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8df3da:
	st_s r3,[r13]
L_8df3dc:
	mov_s r0,0xc
L_8df3de:
	bl.d L_8edfcc
L_8df3e2:
	mov_s r1,0x2
L_8df3e4:
	mov_s r0,r16
L_8df3e6:
	bl.d L_8eb50c
L_8df3ea:
	mov_s r1,r14
L_8df3ec:
	bl.d L_8c955c
L_8df3f0:
	mov_s r0,r14
L_8df3f2:
	mov_s r2,0x101247c
L_8df3f8:
	mov_s r0,0xc
L_8df3fa:
	mov_s r1,0x2
L_8df3fc:
	bl.d L_8edfcc
L_8df400:
	ld_s r3,[r13]
L_8df402:
	ld_s r2,[r14,0x30]
L_8df404:
	add r0,r14,0x28
L_8df408:
	add_s r2,r2,0x10
L_8df40a:
	extw_s r2,r2
L_8df40c:
	mov_s r1,0x61
L_8df40e:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8df410:
	ldb r3,[r14, 0x35]
L_8df414:
	mov r4,0x1
L_8df418:
	bl.d L_8e0874
L_8df41c:
	mov r5,0x0
L_8df420:
	b_s L_8df48a
	.global L_8df422
L_8df422:
	mov_s r2,0x10124cc
L_8df428:
	mov_s r13,0x843104
L_8df42e:
	mov_s r0,0xc
L_8df430:
	mov_s r1,0x2
L_8df432:
	bl.d L_8edfcc
L_8df436:
	ld_s r3,[r13,0x10]
L_8df438:
	ld_s r0,[r13,0x10]
L_8df43a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8df43c:
	st_s r0,[r13,0x10]
L_8df43e:
	mov_s r0,r16
L_8df440:
	bl.d L_8eb678
L_8df444:
	mov_s r1,r14
L_8df446:
	mov_s r15,r0
L_8df448:
	bl.d L_8c955c
L_8df44c:
	mov_s r0,r14
L_8df44e:
	brne_s r15,0,L_8df458
	.global L_8df450
L_8df450:
	bl.d L_8c9538
L_8df454:
	mov_s r0,r14
L_8df456:
	b_s L_8df48a
	.global L_8df458
L_8df458:
	mov_s r2,0x1012508
L_8df45e:
	mov_s r0,0xc
L_8df460:
	bl.d L_8edfb0
L_8df464:
	mov_s r1,0x2
L_8df466:
	ld_s r2,[r14,0x30]
L_8df468:
	add r0,r14,0x28
L_8df46c:
	add_s r2,r2,0x10
L_8df46e:
	extw_s r2,r2
L_8df470:
	mov_s r1,0x61
L_8df472:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8df474:
	ldb r3,[r14, 0x35]
L_8df478:
	mov r4,0x1
L_8df47c:
	bl.d L_8e0874
L_8df480:
	mov r5,0x0
L_8df484:
	ld_s r0,[r13,0xc]
L_8df486:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8df488:
	st_s r0,[r13,0xc]
	.global L_8df48a
L_8df48a:
	b L_8c0324
L_8df48e:
	nop_s
