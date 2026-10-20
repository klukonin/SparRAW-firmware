/* mgmt_tx__probe_resp_ies_8d8378 @ 0x8d8378, 604 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIXED MGMT TX Probe resp use host SSID IE length %d total %d
 *   FIXED MGMT TX Probe resp use local SSID IE length %d total %d
 *   FIXED MGMT TX Probe resp use host COUNTRY IE length %d total %d
 *   FIXED MGMT TX Probe resp use host RSN IE length %d total %d
 *   FIXED MGMT TX Probe resp use local EDCA IE length %d total %d
 *   FIXED MGMT TX Probe resp use host MULTI BAND length %d total %d
 *   FIXED MGMT TX Probe resp use local DMG CAP length %d total %d
 *   FIXED MGMT TX Probe resp use local DMG OPER length %d total %d
 * Зовут его: mgmt_tx__build_fixed_probe_resp
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit2, ie__classify_vendor_oui, ie__push_dmg_capabilities, ie__push_edca, ie__push_eid151_len10, ie__push_ssid, ie__push_wfa_vendor, memcpy_fw, mid__copy_ssid, tx_mgmt_get_ie
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__probe_resp_ies_8d8378
mgmt_tx__probe_resp_ies_8d8378:
	.global L_8d8378
L_8d8378:
	push_s blink
L_8d837a:
	bl L_8c01cc
L_8d837e:
	mov_s r13,r0
L_8d8380:
	mov_s r18,r1
L_8d8382:
	mov_s r19,r2
L_8d8384:
	mov_s r16,r3
L_8d8386:
	mov_s r2,0x0
L_8d8388:
	stb.a r2,[sp,-0x24]
L_8d838c:
	add3 r17,r1,0x9
L_8d8390:
	extb_s r15,r3
L_8d8392:
	mov r20,sp
L_8d8396:
	mov_s r0,r19
L_8d8398:
	mov_s r1,r15
L_8d839a:
	bl.d L_8e9db0
L_8d839e:
	mov_s r3,r20
L_8d83a0:
	mov.f r1,r0
L_8d83a4:
	beq_s L_8d83c4
L_8d83a6:
	ldb_s r2,[r1,0x1]
L_8d83a8:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8d83aa:
	extb_s r2,r2
L_8d83ac:
	stb_s r2,[sp,0x0]
L_8d83ae:
	bl.d L_8c0380
L_8d83b2:
	mov_s r0,r13
L_8d83b4:
	ldb_s r14,[sp,0x0]
L_8d83b6:
	mov_s r1,0x100fcd4
L_8d83bc:
	add_s r13,r13,r14
L_8d83be:
	mov_s r0,0x2d
L_8d83c0:
	mov_s r2,r14
L_8d83c2:
	b_s L_8d83e8
	.global L_8d83c4
L_8d83c4:
	add_s r14,sp,0x4
L_8d83c6:
	mov_s r0,r17
L_8d83c8:
	bl.d L_8ccc98
L_8d83cc:
	mov_s r1,r14
L_8d83ce:
	extb_s r2,r0
L_8d83d0:
	mov_s r0,r13
L_8d83d2:
	bl.d L_8e2028
L_8d83d6:
	mov_s r1,r14
L_8d83d8:
	extb_s r2,r0
L_8d83da:
	stb_s r0,[sp,0x0]
L_8d83dc:
	add_s r13,r13,r2
L_8d83de:
	extb_s r14,r0
L_8d83e0:
	mov_s r1,0x100fd14
L_8d83e6:
	mov_s r0,0x2d
	.global L_8d83e8
L_8d83e8:
	bl.d L_8dcc80
L_8d83ec:
	mov_s r3,r14
L_8d83ee:
	mov_s r0,r19
L_8d83f0:
	mov_s r1,r15
L_8d83f2:
	mov_s r2,0x7
L_8d83f4:
	bl.d L_8e9db0
L_8d83f8:
	mov_s r3,r20
L_8d83fa:
	mov.f r1,r0
L_8d83fe:
	beq_s L_8d8424
L_8d8400:
	ldb_s r2,[r1,0x1]
L_8d8402:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8d8404:
	extb_s r2,r2
L_8d8406:
	stb_s r2,[sp,0x0]
L_8d8408:
	bl.d L_8c0380
L_8d840c:
	mov_s r0,r13
L_8d840e:
	ldb_s r2,[sp,0x0]
L_8d8410:
	mov_s r1,0x100fd54
L_8d8416:
	add_s r13,r13,r2
L_8d8418:
	add_s r14,r14,r2
L_8d841a:
	extw_s r14,r14
L_8d841c:
	mov_s r0,0x2d
L_8d841e:
	bl.d L_8dcc80
L_8d8422:
	mov_s r3,r14
	.global L_8d8424
L_8d8424:
	mov_s r0,r19
L_8d8426:
	mov_s r1,r15
L_8d8428:
	mov_s r2,0x30
L_8d842a:
	bl.d L_8e9db0
L_8d842e:
	mov_s r3,r20
L_8d8430:
	mov.f r1,r0
L_8d8434:
	beq_s L_8d845a
L_8d8436:
	ldb_s r2,[r1,0x1]
L_8d8438:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8d843a:
	extb_s r2,r2
L_8d843c:
	stb_s r2,[sp,0x0]
L_8d843e:
	bl.d L_8c0380
L_8d8442:
	mov_s r0,r13
L_8d8444:
	ldb_s r2,[sp,0x0]
L_8d8446:
	mov_s r1,0x100fd94
L_8d844c:
	add_s r13,r13,r2
L_8d844e:
	add_s r14,r14,r2
L_8d8450:
	extw_s r14,r14
L_8d8452:
	mov_s r0,0x2d
L_8d8454:
	bl.d L_8dcc80
L_8d8458:
	mov_s r3,r14
	.global L_8d845a
L_8d845a:
	mov_s r0,r13
L_8d845c:
	bl.d L_8e1da8
L_8d8460:
	mov_s r1,r17
L_8d8462:
	extb_s r2,r0
L_8d8464:
	stb_s r0,[sp,0x0]
L_8d8466:
	add_s r13,r13,r2
L_8d8468:
	add_s r14,r14,r2
L_8d846a:
	extw_s r14,r14
L_8d846c:
	mov_s r1,0x100fdd0
L_8d8472:
	mov_s r0,0x2d
L_8d8474:
	bl.d L_8dcc80
L_8d8478:
	mov_s r3,r14
L_8d847a:
	mov_s r0,r19
L_8d847c:
	mov_s r1,r15
L_8d847e:
	mov_s r2,0x9e
L_8d8480:
	bl.d L_8e9db0
L_8d8484:
	mov_s r3,r20
L_8d8486:
	mov.f r1,r0
L_8d848a:
	beq_s L_8d84b0
L_8d848c:
	ldb_s r2,[r1,0x1]
L_8d848e:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8d8490:
	extb_s r2,r2
L_8d8492:
	stb_s r2,[sp,0x0]
L_8d8494:
	bl.d L_8c0380
L_8d8498:
	mov_s r0,r13
L_8d849a:
	ldb_s r2,[sp,0x0]
L_8d849c:
	mov_s r1,0x100fe10
L_8d84a2:
	add_s r13,r13,r2
L_8d84a4:
	add_s r14,r14,r2
L_8d84a6:
	extw_s r14,r14
L_8d84a8:
	mov_s r0,0x2d
L_8d84aa:
	bl.d L_8dcc80
L_8d84ae:
	mov_s r3,r14
	.global L_8d84b0
L_8d84b0:
	add1 r1,r17,0x2f
L_8d84b4:
	mov_s r0,r13
L_8d84b6:
	bl.d L_8e1fd4
L_8d84ba:
	mov_s r2,0x0
L_8d84bc:
	extb_s r2,r0
L_8d84be:
	stb_s r0,[sp,0x0]
L_8d84c0:
	add_s r13,r13,r2
L_8d84c2:
	add_s r14,r14,r2
L_8d84c4:
	extw_s r14,r14
L_8d84c6:
	mov_s r1,0x100fe50
L_8d84cc:
	mov_s r0,0x2d
L_8d84ce:
	bl.d L_8dcc80
L_8d84d2:
	mov_s r3,r14
L_8d84d4:
	add3 r1,r17,0x1f
L_8d84d8:
	bl.d L_8e1fbc
L_8d84dc:
	mov_s r0,r13
L_8d84de:
	extb_s r2,r0
L_8d84e0:
	stb_s r0,[sp,0x0]
L_8d84e2:
	add_s r13,r13,r2
L_8d84e4:
	add_s r14,r14,r2
L_8d84e6:
	extw_s r14,r14
L_8d84e8:
	mov_s r1,0x100fe90
L_8d84ee:
	mov_s r0,0x2d
L_8d84f0:
	bl.d L_8dcc80
L_8d84f4:
	mov_s r3,r14
L_8d84f6:
	mov_s r0,r19
L_8d84f8:
	mov_s r1,r15
L_8d84fa:
	mov_s r2,0xdd
L_8d84fc:
	mov_s r3,0x0
L_8d84fe:
	bl.d L_8e9e04
L_8d8502:
	mov r4,r20
L_8d8506:
	mov.f r17,r0
L_8d850a:
	beq_s L_8d8532
L_8d850c:
	ldb_s r2,[sp,0x0]
L_8d850e:
	mov_s r1,0x100fed0
L_8d8514:
	mov_s r0,0x2d
L_8d8516:
	bl.d L_8dcc80
L_8d851a:
	mov_s r3,r14
L_8d851c:
	ldb_s r2,[sp,0x0]
L_8d851e:
	brge r2,r16,L_8d8532
L_8d8522:
	mov_s r0,r13
L_8d8524:
	bl.d L_8c0380
L_8d8528:
	mov_s r1,r17
L_8d852a:
	ldb_s r0,[sp,0x0]
L_8d852c:
	add_s r14,r14,r0
L_8d852e:
	add_s r13,r13,r0
L_8d8530:
	extw_s r14,r14
	.global L_8d8532
L_8d8532:
	mov_s r0,r19
L_8d8534:
	mov_s r1,r15
L_8d8536:
	mov_s r2,0xdd
L_8d8538:
	mov_s r3,0x1
L_8d853a:
	bl.d L_8e9e04
L_8d853e:
	mov r4,r20
L_8d8542:
	mov.f r17,r0
L_8d8546:
	beq_s L_8d856e
L_8d8548:
	ldb_s r2,[sp,0x0]
L_8d854a:
	mov_s r1,0x100ff1c
L_8d8550:
	mov_s r0,0x2d
L_8d8552:
	bl.d L_8dcc80
L_8d8556:
	mov_s r3,r14
L_8d8558:
	ldb_s r2,[sp,0x0]
L_8d855a:
	brge r2,r16,L_8d856e
L_8d855e:
	mov_s r0,r13
L_8d8560:
	bl.d L_8c0380
L_8d8564:
	mov_s r1,r17
L_8d8566:
	ldb_s r0,[sp,0x0]
L_8d8568:
	add_s r14,r14,r0
L_8d856a:
	add_s r13,r13,r0
L_8d856c:
	extw_s r14,r14
	.global L_8d856e
L_8d856e:
	mov_s r0,r19
L_8d8570:
	mov_s r1,r15
L_8d8572:
	mov_s r2,0xdd
L_8d8574:
	mov_s r3,0x4
L_8d8576:
	bl.d L_8e9e04
L_8d857a:
	mov r4,r20
L_8d857e:
	mov.f r15,r0
L_8d8582:
	beq_s L_8d85aa
L_8d8584:
	ldb_s r2,[sp,0x0]
L_8d8586:
	mov_s r1,0x100ff68
L_8d858c:
	mov_s r0,0x2d
L_8d858e:
	bl.d L_8dcc80
L_8d8592:
	mov_s r3,r14
L_8d8594:
	ldb_s r2,[sp,0x0]
L_8d8596:
	brge r2,r16,L_8d85aa
L_8d859a:
	mov_s r0,r13
L_8d859c:
	bl.d L_8c0380
L_8d85a0:
	mov_s r1,r15
L_8d85a2:
	ldb_s r0,[sp,0x0]
L_8d85a4:
	add_s r14,r14,r0
L_8d85a6:
	add_s r13,r13,r0
L_8d85a8:
	extw_s r14,r14
	.global L_8d85aa
L_8d85aa:
	add r1,r18,0xa
L_8d85ae:
	mov_s r0,r13
L_8d85b0:
	bl.d L_8e1c94
L_8d85b4:
	mov_s r2,0x0
L_8d85b6:
	extb_s r2,r0
L_8d85b8:
	stb_s r0,[sp,0x0]
L_8d85ba:
	add_s r14,r14,r2
L_8d85bc:
	extw_s r14,r14
L_8d85be:
	mov_s r1,0x100ffbc
L_8d85c4:
	mov_s r0,0x2d
L_8d85c6:
	bl.d L_8dcc80
L_8d85ca:
	mov_s r3,r14
L_8d85cc:
	mov_s r0,r14
L_8d85ce:
	b.d L_8c0224
L_8d85d2:
	add_s sp,sp,0x24
