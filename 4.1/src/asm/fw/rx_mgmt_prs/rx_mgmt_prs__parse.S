/* rx_mgmt_prs__parse @ 0x8da284, 452 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [PRS]Unhandled  MGMT type: sub_type %d stype %x len %d
 *   rx_mgmt_prs.cpp
 *   [PRS]: ERROR in pckt type %d: stype %d len %d
 *           id %x: ei_len %x pos_to_end %d
 *   [PRS]: ERROR -  id %x: ei_len %x pos_to_end %d < 0
 * Зовут его: rx_mgmt_prs__alloc_ei
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log__emit3, fw_sysassert_fatal, log_hexdump, rx_mgmt_prs__parse_dmg_bcon_fixed, set_parse_ei
 */
	.section .text.rx_mgmt_prs__parse,"ax",@progbits
	.global rx_mgmt_prs__parse
rx_mgmt_prs__parse:
	.global L_8da284
L_8da284:
	push_s blink
L_8da286:
	bl L_8c02ac
L_8da28a:
	mov_s r20,r0
L_8da28c:
	mov_s r14,r1
L_8da28e:
	mov_s r13,r2
L_8da290:
	mov_s r17,r3
L_8da292:
	mov r16,r4
L_8da296:
	mov r19,r5
L_8da29a:
	st.a r3,[sp,-0x8]
L_8da29e:
	mov_s r1,0x0
L_8da2a0:
	stb_s r1,[r2,0x4]
L_8da2a2:
	stb_s r1,[sp,0x4]
L_8da2a4:
	brne r5,0x3,L_8da2c0
L_8da2a8:
	cmp r16,0x0
L_8da2ac:
	bne_s L_8da3a0
L_8da2ae:
	mov_s r3,sp
L_8da2b0:
	add r4,sp,0x4
L_8da2b4:
	bl.d L_8da1f0
L_8da2b8:
	mov_s r1,r14
L_8da2ba:
	ldb_s r0,[sp,0x4]
L_8da2bc:
	add_s r14,r14,r0
L_8da2be:
	b_s L_8da3a0
	.global L_8da2c0
L_8da2c0:
	brhs r16,0xb,L_8da36c
L_8da2c4:
	ldb.x r10,[0x802684,r16]
L_8da2cc:
	add r0,pcl,0xa
L_8da2d0:
	add1 r0,r0,r10
L_8da2d4:
	j_s [r0]
L_8da2d6:
	mov_s r0,0x5
L_8da2d8:
	add3 r1,r13,0x10
L_8da2dc:
	st_s r14,[r1,0x30]
L_8da2de:
	add r2,r14,0x8
L_8da2e2:
	mov_s r3,0x1
L_8da2e4:
	stb_s r3,[r13,0x4]
L_8da2e6:
	st_s r2,[r1,0x3c]
L_8da2e8:
	mov_s r3,0x2
L_8da2ea:
	add r2,r14,0xa
L_8da2ee:
	stb_s r3,[r13,0x4]
L_8da2f0:
	st_s r2,[r1,0x34]
L_8da2f2:
	sub r1,r17,0xc
L_8da2f6:
	st_s r1,[sp,0x0]
L_8da2f8:
	add_s r14,r14,0xc
L_8da2fa:
	mov_s r1,0x3
L_8da2fc:
	stb_s r1,[r13,0x4]
L_8da2fe:
	mov_s r1,0xc
L_8da300:
	stb_s r1,[sp,0x4]
L_8da302:
	mov_s r16,r0
L_8da304:
	b_s L_8da3a0
L_8da306:
	st r14,[r13, 0xb4]
L_8da30a:
	sub r0,r17,0x2
L_8da30e:
	st_s r0,[sp,0x0]
L_8da310:
	mov_s r1,0x1
L_8da312:
	stb_s r1,[r13,0x4]
L_8da314:
	ldw.a r1,[r14,0x2]
L_8da318:
	mov_s r2,0x2
L_8da31a:
	stw r1,[r13, 0xc8]
L_8da31e:
	mov_s r1,0x1
	.global L_8da320
L_8da320:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_8da322:
	st_s r0,[sp,0x0]
L_8da324:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8da326:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8da328:
	stb_s r1,[r13,0x4]
L_8da32a:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8da32c:
	stb_s r2,[sp,0x4]
L_8da32e:
	b_s L_8da3a0
L_8da330:
	st r14,[r13, 0xb4]
L_8da334:
	sub r0,r17,0x2
L_8da338:
	st_s r0,[sp,0x0]
L_8da33a:
	mov_s r0,0x1
L_8da33c:
	stb_s r0,[r13,0x4]
L_8da33e:
	ldw_s r0,[r14,0x2]
L_8da340:
	mov_s r1,0x2
L_8da342:
	stw r0,[r13, 0xcc]
L_8da346:
	sub r0,r17,0x4
L_8da34a:
	st_s r0,[sp,0x0]
L_8da34c:
	stb_s r1,[r13,0x4]
L_8da34e:
	ldw.a r1,[r14,0x4]
L_8da352:
	mov_s r2,0x4
L_8da354:
	stw r1,[r13, 0xca]
L_8da358:
	mov_s r1,0x2
L_8da35a:
	b_s L_8da320
L_8da35c:
	ldw_s r0,[r14]
L_8da35e:
	mov r16,0xa
L_8da362:
	stw r0,[r13, 0xcc]
L_8da366:
	mov_s r2,r1
L_8da368:
	mov_s r0,r17
L_8da36a:
	b_s L_8da320
	.global L_8da36c
L_8da36c:
	mov_s r2,0x1010c2c
L_8da372:
	mov_s r0,0xd
L_8da374:
	mov_s r1,0x0
L_8da376:
	mov_s r3,r16
L_8da378:
	mov r4,r19
L_8da37c:
	bl.d L_8ee034
L_8da380:
	mov r5,r17
L_8da384:
	mov_s r0,r14
L_8da386:
	bl.d L_8c7f90
L_8da38a:
	mov_s r1,r17
L_8da38c:
	mov_s r0,blink
L_8da38e:
	mov_s r2,0x1010c64
L_8da394:
	mov_s r1,0xa6
L_8da396:
	bset_s r1,r1,0xc
L_8da398:
	bl.d L_8c82c0
L_8da39c:
	mov r3,0x150
	.global L_8da3a0
L_8da3a0:
	st r14,[r13, 0xd0]
L_8da3a4:
	b_s L_8da3e4
	.global L_8da3a6
L_8da3a6:
	ldb_s r15,[r14]
L_8da3a8:
	sub r5,r0,0x2
L_8da3ac:
	ldb r18,[r14, 0x1]
L_8da3b0:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8da3b2:
	st r5,[sp]
L_8da3b6:
	mov_s r0,r20
L_8da3b8:
	mov_s r1,r14
L_8da3ba:
	mov_s r2,r13
L_8da3bc:
	mov_s r3,r15
L_8da3be:
	mov r4,r18
L_8da3c2:
	bl.d L_8e1c30
L_8da3c6:
	mov r6,r19
L_8da3ca:
	brlt r0,0x0,L_8da3ee
L_8da3ce:
	ld_s r0,[sp,0x0]
L_8da3d0:
	add_s r14,r14,r18
L_8da3d2:
	sub.f r5,r0,r18
L_8da3d6:
	ldb_s r1,[r13,0x4]
L_8da3d8:
	st r5,[sp]
L_8da3dc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8da3de:
	bmi.d L_8da42a
L_8da3e2:
	stb_s r1,[r13,0x4]
	.global L_8da3e4
L_8da3e4:
	ld_s r0,[sp,0x0]
L_8da3e6:
	brge r0,0x3,L_8da3a6
L_8da3ea:
	mov_s r0,0x1
L_8da3ec:
	b_s L_8da440
	.global L_8da3ee
L_8da3ee:
	mov_s r2,0x1010c74
L_8da3f4:
	mov_s r0,0xd
L_8da3f6:
	mov_s r1,0x2
L_8da3f8:
	mov_s r3,r19
L_8da3fa:
	mov r4,r16
L_8da3fe:
	bl.d L_8ee034
L_8da402:
	mov r5,r17
L_8da406:
	mov_s r2,0x1010ca4
L_8da40c:
	ld r5,[sp]
L_8da410:
	mov_s r0,0xd
L_8da412:
	mov_s r1,0x2
L_8da414:
	mov_s r3,r15
L_8da416:
	bl.d L_8ee034
L_8da41a:
	mov r4,r18
L_8da41e:
	mov_s r0,r14
L_8da420:
	bl.d L_8c7f90
L_8da424:
	mov_s r1,r17
L_8da426:
	mov_s r0,0x0
L_8da428:
	b_s L_8da440
	.global L_8da42a
L_8da42a:
	mov_s r2,0x1010ccc
L_8da430:
	mov_s r0,0xd
L_8da432:
	mov_s r1,0x0
L_8da434:
	mov_s r3,r15
L_8da436:
	bl.d L_8ee034
L_8da43a:
	mov r4,r18
L_8da43e:
	mov_s r0,0x0
	.global L_8da440
L_8da440:
	b.d L_8c0304
L_8da444:
	add_s sp,sp,0x8
L_8da446:
	nop_s
