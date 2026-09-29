/* find_main_sm__probe_req_in_search @ 0x8ef44c, 520 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm:: probe_req handle: ADDR-%04X%08X
 *   find_main_sm.cpp
 *   find_main_sm::probe_req_in_search() Received Probe Request contains WFA IE (P2P IE).
 *   find_main_sm::probe_req_in_search() Probe REQ with DEVICE ID attribute ADDR-%04X%08X
 *   find_main_sm::probe_req_in_search() DEVICE ID attribute is unequal to my device address
 *   find_main_sm::probe_req_in_search() Received Probe Request contains WSC IE.
 *   FIND_SM:: DO NOT reply to this Probe REQ (Host may do that !).
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r23_to_r13_ret, __st_r23_to_r13, app_ies__set_buffer, app_ies__set_probe_req_ies, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, ie_iter__init, ie_iter__next, ie_list__first, ies__has_buffer
 */
	.section .text.find_main_sm__probe_req_in_search,"ax",@progbits
	.global find_main_sm__probe_req_in_search
find_main_sm__probe_req_in_search:
L_8ef44c:
	add_s sp,sp,0x2c
	.global fwlog_find_main_sm_probe_req_in_search_DEVICE_
fwlog_find_main_sm_probe_req_in_search_DEVICE_:
L_8ef44e:
	nop_s
L_8ef450:
	push_s blink
L_8ef452:
	bl L_8c02a0
L_8ef456:
	mov_s r16,r0
L_8ef458:
	mov_s r17,r1
L_8ef45a:
	ld_s r0,[r1,0xc]
L_8ef45c:
	mov r21,0x1
L_8ef460:
	ld r0,[r0, 0xd0]
L_8ef464:
	ld_s r1,[r1,0x8]
L_8ef466:
	sub_s sp,sp,0x2c
L_8ef468:
	ld r13,[r17, 0x30]
L_8ef46c:
	sub_s r0,r0,r1
L_8ef46e:
	sub_s r13,r13,r0
L_8ef470:
	ld r0,[r16, 0x34]
L_8ef474:
	ld_s r0,[r0,0x6c]
L_8ef476:
	bl.d L_8c9e10
L_8ef47a:
	ldb r1,[r17, 0x36]
L_8ef47e:
	mov.f r18,r0
L_8ef482:
	extw_s r13,r13
L_8ef484:
	beq_s L_8ef4cc
	.global L_8ef486
L_8ef486:
	cmp r18,0x0
L_8ef48a:
	beq_s L_8ef64e
L_8ef48c:
	add r20,r18,0x10
L_8ef490:
	mov_s r2,0x1014800
L_8ef496:
	ld r4,[r20]
L_8ef49a:
	mov_s r0,0xc
L_8ef49c:
	mov_s r1,0x2
L_8ef49e:
	bl.d L_8edff8
L_8ef4a2:
	ldw r3,[r20, 0x4]
L_8ef4a6:
	mov_s r14,sp
L_8ef4a8:
	ld r1,[r17, 0xc]
L_8ef4ac:
	mov_s r0,r14
L_8ef4ae:
	ld r1,[r1, 0xd0]
L_8ef4b2:
	mov_s r2,r13
L_8ef4b4:
	mov_s r3,0x0
L_8ef4b6:
	bl.d L_8e1afc
L_8ef4ba:
	mov_s r23,r3
L_8ef4bc:
	add_s r0,sp,0xc
L_8ef4be:
	mov_s r19,r0
L_8ef4c0:
	bl.d L_8e112c
L_8ef4c4:
	mov_s r1,r14
L_8ef4c6:
	mov r22,0x1
L_8ef4ca:
	b_s L_8ef5b4
	.global L_8ef4cc
L_8ef4cc:
	mov_s r0,blink
L_8ef4ce:
	mov_s r2,0x101478c
L_8ef4d4:
	mov_s r1,0x1447
L_8ef4da:
	bl.d L_8c82c0
L_8ef4de:
	mov r3,0x11c
L_8ef4e2:
	b_s L_8ef486
	.global L_8ef4e4
L_8ef4e4:
	bl.d L_8db160
L_8ef4e8:
	mov_s r0,r19
L_8ef4ea:
	mov_s r13,r0
L_8ef4ec:
	add_s r14,r0,0x2
L_8ef4ee:
	ldb_s r0,[r14]
L_8ef4f0:
	cmp_s r0,0x50
L_8ef4f2:
	bne_s L_8ef5b0
L_8ef4f4:
	ldb_s r0,[r14,0x1]
L_8ef4f6:
	cmp_s r0,0x6f
L_8ef4f8:
	bne_s L_8ef5b0
L_8ef4fa:
	ldb_s r0,[r14,0x2]
L_8ef4fc:
	cmp r0,0x9a
L_8ef500:
	bne_s L_8ef5b0
L_8ef502:
	ldb_s r0,[r14,0x3]
L_8ef504:
	brne r0,0x9,L_8ef5b0
L_8ef508:
	mov_s r2,0x1014830
L_8ef50e:
	mov_s r0,0xc
L_8ef510:
	bl.d L_8edfb0
L_8ef514:
	mov_s r1,0x2
L_8ef516:
	ld r0,[r16, 0x34]
L_8ef51a:
	ld_s r0,[r0,0xc]
L_8ef51c:
	mov r22,0x0
L_8ef520:
	breq r0,0x0,L_8ef5b0
L_8ef524:
	ldb_s r2,[r13,0x1]
L_8ef526:
	add_s r15,sp,0x18
L_8ef528:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ef52a:
	extw_s r2,r2
L_8ef52c:
	mov_s r0,r15
L_8ef52e:
	bl.d L_8e1abc
L_8ef532:
	mov_s r1,r13
L_8ef534:
	mov_s r0,r15
L_8ef536:
	bl.d L_8c9874
L_8ef53a:
	mov_s r1,0x3
L_8ef53c:
	breq_s r0,0,L_8ef5b0
L_8ef53e:
	add_s r13,r0,0x3
L_8ef540:
	ld r0,[r16, 0x34]
L_8ef544:
	mov_s r2,0x1014888
L_8ef54a:
	ld_s r15,[r0,0x6c]
L_8ef54c:
	mov_s r0,0x9
L_8ef54e:
	ld r4,[r13]
L_8ef552:
	mov_s r1,0x2
L_8ef554:
	bl.d L_8edff8
L_8ef558:
	ldw_s r3,[r13,0x4]
L_8ef55a:
	ldb_s r1,[r13]
L_8ef55c:
	ldb.a r0,[r15,0xa]
L_8ef560:
	brne r1,r0,L_8ef584
L_8ef564:
	ldb_s r1,[r13,0x1]
L_8ef566:
	ldb_s r0,[r15,0x1]
L_8ef568:
	brne r1,r0,L_8ef584
L_8ef56c:
	ldb_s r1,[r13,0x2]
L_8ef56e:
	ldb_s r0,[r15,0x2]
L_8ef570:
	brne r1,r0,L_8ef584
L_8ef574:
	ldb_s r1,[r13,0x3]
L_8ef576:
	ldb_s r0,[r15,0x3]
L_8ef578:
	brne r1,r0,L_8ef584
L_8ef57c:
	ldb_s r1,[r13,0x4]
L_8ef57e:
	ldb_s r0,[r15,0x4]
L_8ef580:
	breq r1,r0,L_8ef588
	.global L_8ef584
L_8ef584:
	mov_s r0,r22
L_8ef586:
	b_s L_8ef592
	.global L_8ef588
L_8ef588:
	ldb_s r1,[r13,0x5]
L_8ef58a:
	ldb_s r0,[r15,0x5]
L_8ef58c:
	brne r1,r0,L_8ef584
L_8ef590:
	mov_s r0,0x1
	.global L_8ef592
L_8ef592:
	extb.f 0x0,r0
L_8ef596:
	sub.ne r22,r22,r22
L_8ef59a:
	bne_s L_8ef5b0
L_8ef59c:
	mov_s r2,0x10148e0
L_8ef5a2:
	mov_s r0,0xc
L_8ef5a4:
	bl.d L_8edfb0
L_8ef5a8:
	mov_s r1,0x2
L_8ef5aa:
	mov_s r0,0x0
L_8ef5ac:
	mov_s r22,r0
L_8ef5ae:
	mov_s r21,r0
	.global L_8ef5b0
L_8ef5b0:
	ldb_s r0,[r14]
L_8ef5b2:
	breq_s r0,0,L_8ef61c
	.global L_8ef5b4
L_8ef5b4:
	bl.d L_8cb668
L_8ef5b8:
	mov_s r0,r19
L_8ef5ba:
	brne r0,0x0,L_8ef4e4
L_8ef5be:
	breq r21,0x0,L_8ef640
L_8ef5c2:
	bl L_8c2c80
L_8ef5c6:
	mov_s r13,r0
L_8ef5c8:
	st r23,[sp, 0x18]
L_8ef5cc:
	ld r2,[r16, 0x34]
L_8ef5d0:
	add_s r1,sp,0x18
L_8ef5d2:
	ld_s r2,[r2,0x6c]
L_8ef5d4:
	mov_s r3,r18
L_8ef5d6:
	bl.d L_8f1f50
L_8ef5da:
	mov r4,r22
L_8ef5de:
	add_s r0,r13,0x4
L_8ef5e0:
	mov_s r1,r20
L_8ef5e2:
	bl.d L_8c0460
L_8ef5e6:
	mov_s r2,0x6
L_8ef5e8:
	ld r0,[r16, 0x34]
L_8ef5ec:
	ld_s r0,[r0,0x14]
L_8ef5ee:
	breq r0,0x2,L_8ef602
L_8ef5f2:
	ld r1,[r17, 0x8]
L_8ef5f6:
	add r0,r13,0x10
L_8ef5fa:
	add_s r1,r1,0x10
L_8ef5fc:
	bl.d L_8c0460
L_8ef600:
	mov_s r2,0x6
	.global L_8ef602
L_8ef602:
	ldw r4,[sp, 0x18]
L_8ef606:
	mov_s r0,r18
L_8ef608:
	mov_s r1,0x1
L_8ef60a:
	mov_s r2,r1
L_8ef60c:
	mov_s r3,r13
L_8ef60e:
	mov r5,0x0
L_8ef612:
	bl.d L_8e0c44
L_8ef616:
	mov r6,r5
L_8ef61a:
	b_s L_8ef64e
	.global L_8ef61c
L_8ef61c:
	ldb_s r0,[r14,0x1]
L_8ef61e:
	cmp_s r0,0x50
L_8ef620:
	bne_s L_8ef5b4
L_8ef622:
	ldb_s r0,[r14,0x2]
L_8ef624:
	cmp r0,0xf2
L_8ef628:
	bne_s L_8ef5b4
L_8ef62a:
	ldb_s r0,[r14,0x3]
L_8ef62c:
	brne r0,0x4,L_8ef5b4
L_8ef630:
	mov_s r2,0x1014938
L_8ef636:
	mov_s r0,0xc
L_8ef638:
	bl.d L_8edfb0
L_8ef63c:
	mov_s r1,0x2
L_8ef63e:
	b_s L_8ef5b4
	.global L_8ef640
L_8ef640:
	mov_s r2,0x1014984
L_8ef646:
	mov_s r0,0xc
L_8ef648:
	bl.d L_8edfb0
L_8ef64c:
	mov_s r1,0x2
	.global L_8ef64e
L_8ef64e:
	b.d L_8c02ec
L_8ef652:
	add_s sp,sp,0x2c
