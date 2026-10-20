/* find_main_sm__probe_req @ 0x8ef244, 520 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm:: probe_req handle: ADDR-%04X%08X
 *   FIND_SM:: DO NOT reply to this Probe REQ  <<<<<< Should be handled by HOST >>>>>
 *   find_main_sm.cpp
 *   FIND:: Received Probe Request contains WFA IE (P2P IE).
 *   FIND_SM:: Probe REQ with DEVICE ID attribute ADDR-%04X%08X
 *   DEVICE ID attribute is unequal to my device address
 *   FIND:: Received Probe Request contains WSC IE.
 *   FIND_SM:: DO NOT reply to this Probe REQ (Host may do that !).
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r22_to_r13_ret, __st_r22_to_r13, app_ies__set_buffer, app_ies__set_probe_req_ies, fw_log__emit0, fw_log__emit2, fw_sysassert_fatal, ie_iter__init, ie_iter__next, ie_list__first, ies__has_buffer
 */
	.section .text.find_main_sm__probe_req,"ax",@progbits
	.global find_main_sm__probe_req
find_main_sm__probe_req:
L_8ef244:
	/* b_s 0x008ef1e6 */
	.byte 0xd1,0xf1
	.global fwlog_FIND_SM_DO_NOT_reply_to_this_Probe_REQ_S
fwlog_FIND_SM_DO_NOT_reply_to_this_Probe_REQ_S:
L_8ef246:
	nop_s
L_8ef248:
	push_s blink
L_8ef24a:
	bl L_8c02a4
L_8ef24e:
	mov_s r16,r0
L_8ef250:
	mov_s r17,r1
L_8ef252:
	ld_s r0,[r1,0xc]
L_8ef254:
	mov r21,0x1
L_8ef258:
	ld r0,[r0, 0xd0]
L_8ef25c:
	ld_s r1,[r1,0x8]
L_8ef25e:
	sub_s sp,sp,0x2c
L_8ef260:
	ld r13,[r17, 0x30]
L_8ef264:
	sub_s r0,r0,r1
L_8ef266:
	sub_s r13,r13,r0
L_8ef268:
	ld r0,[r16, 0x34]
L_8ef26c:
	ld_s r0,[r0,0x6c]
L_8ef26e:
	bl.d L_8c9e10
L_8ef272:
	ldb r1,[r17, 0x36]
L_8ef276:
	mov.f r18,r0
L_8ef27a:
	extw_s r13,r13
L_8ef27c:
	beq_s L_8ef2b0
	.global L_8ef27e
L_8ef27e:
	cmp r18,0x0
L_8ef282:
	beq_s L_8ef448
L_8ef284:
	add r20,r18,0x10
L_8ef288:
	mov_s r2,0x1014800
L_8ef28e:
	ld r4,[r20]
L_8ef292:
	mov_s r0,0xc
L_8ef294:
	mov_s r1,0x2
L_8ef296:
	bl.d L_8edff8
L_8ef29a:
	ldw r3,[r20, 0x4]
L_8ef29e:
	ld r0,[r16, 0x34]
L_8ef2a2:
	ld_s r0,[r0,0x14]
L_8ef2a4:
	brne r0,0x2,L_8ef2c8
L_8ef2a8:
	mov_s r2,0x10149c4
L_8ef2ae:
	b_s L_8ef440
	.global L_8ef2b0
L_8ef2b0:
	mov_s r0,blink
L_8ef2b2:
	mov_s r2,0x101478c
L_8ef2b8:
	mov_s r1,0x1448
L_8ef2be:
	bl.d L_8c82c0
L_8ef2c2:
	mov r3,0x173
L_8ef2c6:
	b_s L_8ef27e
	.global L_8ef2c8
L_8ef2c8:
	mov_s r14,sp
L_8ef2ca:
	ld r1,[r17, 0xc]
L_8ef2ce:
	mov_s r0,r14
L_8ef2d0:
	ld r1,[r1, 0xd0]
L_8ef2d4:
	mov_s r2,r13
L_8ef2d6:
	mov_s r3,0x0
L_8ef2d8:
	bl.d L_8e1afc
L_8ef2dc:
	mov_s r22,r3
L_8ef2de:
	add_s r0,sp,0xc
L_8ef2e0:
	mov_s r19,r0
L_8ef2e2:
	bl.d L_8e112c
L_8ef2e6:
	mov_s r1,r14
L_8ef2e8:
	b_s L_8ef3ae
	.global L_8ef2ea
L_8ef2ea:
	bl.d L_8db160
L_8ef2ee:
	mov_s r0,r19
L_8ef2f0:
	mov_s r13,r0
L_8ef2f2:
	add_s r14,r0,0x2
L_8ef2f4:
	ldb_s r0,[r14]
L_8ef2f6:
	cmp_s r0,0x50
L_8ef2f8:
	bne_s L_8ef3aa
L_8ef2fa:
	ldb_s r0,[r14,0x1]
L_8ef2fc:
	cmp_s r0,0x6f
L_8ef2fe:
	bne_s L_8ef3aa
L_8ef300:
	ldb_s r0,[r14,0x2]
L_8ef302:
	cmp r0,0x9a
L_8ef306:
	bne_s L_8ef3aa
L_8ef308:
	ldb_s r0,[r14,0x3]
L_8ef30a:
	brne r0,0x9,L_8ef3aa
L_8ef30e:
	mov_s r2,0x1014a18
L_8ef314:
	mov_s r0,0xc
L_8ef316:
	bl.d L_8edfb0
L_8ef31a:
	mov_s r1,0x2
L_8ef31c:
	ld r0,[r16, 0x34]
L_8ef320:
	ld_s r0,[r0,0xc]
L_8ef322:
	breq r0,0x0,L_8ef3aa
L_8ef326:
	ldb_s r2,[r13,0x1]
L_8ef328:
	add_s r15,sp,0x18
L_8ef32a:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8ef32c:
	extw_s r2,r2
L_8ef32e:
	mov_s r0,r15
L_8ef330:
	bl.d L_8e1abc
L_8ef334:
	mov_s r1,r13
L_8ef336:
	mov_s r0,r15
L_8ef338:
	bl.d L_8c9874
L_8ef33c:
	mov_s r1,0x3
L_8ef33e:
	breq_s r0,0,L_8ef3aa
L_8ef340:
	add_s r13,r0,0x3
L_8ef342:
	ld r0,[r16, 0x34]
L_8ef346:
	mov_s r2,0x1014a50
L_8ef34c:
	ld_s r15,[r0,0x6c]
L_8ef34e:
	mov_s r0,0x9
L_8ef350:
	ld r4,[r13]
L_8ef354:
	mov_s r1,0x2
L_8ef356:
	bl.d L_8edff8
L_8ef35a:
	ldw_s r3,[r13,0x4]
L_8ef35c:
	ldb_s r2,[r13]
L_8ef35e:
	ldb.a r1,[r15,0xa]
L_8ef362:
	mov_s r0,0x0
L_8ef364:
	brne r2,r1,L_8ef392
L_8ef368:
	ldb_s r2,[r13,0x1]
L_8ef36a:
	ldb_s r1,[r15,0x1]
L_8ef36c:
	brne r2,r1,L_8ef392
L_8ef370:
	ldb_s r2,[r13,0x2]
L_8ef372:
	ldb_s r1,[r15,0x2]
L_8ef374:
	brne r2,r1,L_8ef392
L_8ef378:
	ldb_s r2,[r13,0x3]
L_8ef37a:
	ldb_s r1,[r15,0x3]
L_8ef37c:
	brne r2,r1,L_8ef392
L_8ef380:
	ldb_s r2,[r13,0x4]
L_8ef382:
	ldb_s r1,[r15,0x4]
L_8ef384:
	brne r2,r1,L_8ef392
L_8ef388:
	ldb_s r2,[r13,0x5]
L_8ef38a:
	ldb_s r1,[r15,0x5]
L_8ef38c:
	cmp_s r2,r1
L_8ef38e:
	mov.eq r0,0x1
	.global L_8ef392
L_8ef392:
	extb.f 0x0,r0
L_8ef396:
	bne_s L_8ef3aa
L_8ef398:
	mov_s r2,0x1014a8c
L_8ef39e:
	mov_s r0,0xc
L_8ef3a0:
	bl.d L_8edfb0
L_8ef3a4:
	mov_s r1,0x2
L_8ef3a6:
	mov r21,0x0
	.global L_8ef3aa
L_8ef3aa:
	ldb_s r0,[r14]
L_8ef3ac:
	breq_s r0,0,L_8ef416
	.global L_8ef3ae
L_8ef3ae:
	bl.d L_8cb668
L_8ef3b2:
	mov_s r0,r19
L_8ef3b4:
	brne r0,0x0,L_8ef2ea
L_8ef3b8:
	breq r21,0x0,L_8ef43a
L_8ef3bc:
	bl L_8c2c80
L_8ef3c0:
	mov_s r13,r0
L_8ef3c2:
	st r22,[sp, 0x18]
L_8ef3c6:
	ld r2,[r16, 0x34]
L_8ef3ca:
	add_s r1,sp,0x18
L_8ef3cc:
	ld_s r2,[r2,0x6c]
L_8ef3ce:
	mov_s r3,r18
L_8ef3d0:
	bl.d L_8f1f50
L_8ef3d4:
	mov r4,0x0
L_8ef3d8:
	add_s r0,r13,0x4
L_8ef3da:
	mov_s r1,r20
L_8ef3dc:
	bl.d L_8c0460
L_8ef3e0:
	mov_s r2,0x6
L_8ef3e2:
	ld r0,[r16, 0x34]
L_8ef3e6:
	ld_s r0,[r0,0x14]
L_8ef3e8:
	breq r0,0x2,L_8ef3fc
L_8ef3ec:
	ld r1,[r17, 0x8]
L_8ef3f0:
	add r0,r13,0x10
L_8ef3f4:
	add_s r1,r1,0x10
L_8ef3f6:
	bl.d L_8c0460
L_8ef3fa:
	mov_s r2,0x6
	.global L_8ef3fc
L_8ef3fc:
	ldw r4,[sp, 0x18]
L_8ef400:
	mov_s r0,r18
L_8ef402:
	mov_s r1,0x1
L_8ef404:
	mov_s r2,r1
L_8ef406:
	mov_s r3,r13
L_8ef408:
	mov r5,0x0
L_8ef40c:
	bl.d L_8e0c44
L_8ef410:
	mov r6,r5
L_8ef414:
	b_s L_8ef448
	.global L_8ef416
L_8ef416:
	ldb_s r0,[r14,0x1]
L_8ef418:
	cmp_s r0,0x50
L_8ef41a:
	bne_s L_8ef3ae
L_8ef41c:
	ldb_s r0,[r14,0x2]
L_8ef41e:
	cmp r0,0xf2
L_8ef422:
	bne_s L_8ef3ae
L_8ef424:
	ldb_s r0,[r14,0x3]
L_8ef426:
	brne r0,0x4,L_8ef3ae
L_8ef42a:
	mov_s r2,0x1014ac0
L_8ef430:
	mov_s r0,0xc
L_8ef432:
	bl.d L_8edfb0
L_8ef436:
	mov_s r1,0x2
L_8ef438:
	b_s L_8ef3ae
	.global L_8ef43a
L_8ef43a:
	mov_s r2,0x1014984
	.global L_8ef440
L_8ef440:
	mov_s r0,0xc
L_8ef442:
	bl.d L_8edfb0
L_8ef446:
	mov_s r1,0x2
	.global L_8ef448
L_8ef448:
	b.d L_8c02f4
