/* mlme_sm__association_timeout_ev_handle @ 0x8f131c, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOCIATION TIMEOUT event.
 *   mlme_sm::association_timeout_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 *   global timeout completed while ADDBA RSP timer wasn't completed yet
 * Зовёт сам: RADIO_MGR__remove_request, __ld_r13_to_r13_ret, __ld_r15_to_r13_ret, __st_r15_to_r13, ba_setup_sm__close_addba_resp_timeout, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, mem_pool__free_thunk, mlme_notify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__association_timeout_ev_handle
mlme_sm__association_timeout_ev_handle:
	.global L_8f131c
L_8f131c:
	push_s blink
L_8f131e:
	bl L_8c01e0
L_8f1322:
	mov_s r14,r0
L_8f1324:
	mov_s r15,r3
L_8f1326:
	mov_s r1,0x1011534
L_8f132c:
	bl.d L_8dcba8
L_8f1330:
	mov_s r0,0x2a
L_8f1332:
	mov_s r13,0x0
L_8f1334:
	ld_s r0,[r14,0x20]
L_8f1336:
	st_s r13,[r14,0x14]
L_8f1338:
	ld_s r0,[r0,0x18]
L_8f133a:
	ld_s r0,[r0,0x50]
L_8f133c:
	cmp_s r0,0x1
L_8f133e:
	mov_s r0,0x1
L_8f1340:
	sub_s.ne r0,r0,r0
L_8f1342:
	extb.f 0x0,r0
L_8f1346:
	beq_s L_8f1362
L_8f1348:
	mov_s r0,r14
L_8f134a:
	mov_s r1,0x1
L_8f134c:
	bl.d L_8f6bc0
L_8f1350:
	mov_s r2,r15
L_8f1352:
	ld_s r1,[r14,0x20]
L_8f1354:
	mov_s r0,r14
L_8f1356:
	ldb_s r1,[r1,0x8]
L_8f1358:
	mov_s r2,0x1
L_8f135a:
	mov_s r3,0x5
L_8f135c:
	bl.d L_8de394
L_8f1360:
	mov_s r4,r13
	.global L_8f1362
L_8f1362:
	ld_s r0,[r14,0x2c]
L_8f1364:
	st_s r13,[r14,0xc]
L_8f1366:
	breq_s r0,0,L_8f136e
L_8f1368:
	bl L_8cb15c
L_8f136c:
	st_s r13,[r14,0x2c]
	.global L_8f136e
L_8f136e:
	ld_s r2,[r14,0x10]
L_8f1370:
	mov_s r1,0x1011550
L_8f1376:
	mov_s r0,0x20
L_8f1378:
	bl.d L_8dcc80
L_8f137c:
	ld_s r3,[r14,0x8]
L_8f137e:
	ld_s r2,[r14,0x10]
L_8f1380:
	breq_s r2,0,L_8f13ac
L_8f1382:
	ld_s r0,[r14,0x8]
L_8f1384:
	breq_s r0,0,L_8f139a
L_8f1386:
	mov_s r1,0x101159c
L_8f138c:
	bl.d L_8dcc10
L_8f1390:
	mov_s r0,0x2c
L_8f1392:
	bl.d L_8ea800
L_8f1396:
	ld_s r0,[r14,0x10]
L_8f1398:
	b_s L_8f13ac
	.global L_8f139a
L_8f139a:
	mov_s r1,0x10115c8
L_8f13a0:
	bl.d L_8dcc10
L_8f13a4:
	mov_s r0,0x2c
L_8f13a6:
	bl.d L_8e2798
L_8f13aa:
	ld_s r0,[r14,0x10]
	.global L_8f13ac
L_8f13ac:
	st_s r13,[r14,0x10]
L_8f13ae:
	b.d L_8c024c
L_8f13b2:
	st_s r13,[r14,0x8]
L_8f13b4:
	push_s blink
L_8f13b6:
	push_s r13
L_8f13b8:
	mov.f r13,r0
L_8f13bc:
	beq_s L_8f13ea
	.global L_8f13be
L_8f13be:
	mov_s r0,0x0
L_8f13c0:
	st_s r0,[r13,0x14]
L_8f13c2:
	ld_s r0,[r13,0xc]
L_8f13c4:
	breq_s r0,0,L_8f13d8
L_8f13c6:
	mov_s r1,0x10137f0
L_8f13cc:
	bl.d L_8dcba8
L_8f13d0:
	mov_s r0,0x15
L_8f13d2:
	bl.d L_8f1bd8
L_8f13d6:
	mov_s r0,r13
	.global L_8f13d8
L_8f13d8:
	mov_s r0,r13
L_8f13da:
	mov_s r1,0xb
L_8f13dc:
	mov_s r2,0x0
L_8f13de:
	mov_s r3,r2
L_8f13e0:
	bl.d L_8d9b6c
L_8f13e4:
	mov_s r4,r2
L_8f13e6:
	b L_8c025c
	.global L_8f13ea
L_8f13ea:
	mov_s r0,blink
L_8f13ec:
	mov_s r1,0x1293
L_8f13f2:
	bl L_8c9b28
L_8f13f6:
	b_s L_8f13be
