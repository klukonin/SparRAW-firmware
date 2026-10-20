/* hwf_phy_production_loopback_test @ 0x8d4330, 644 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwf_phy_production_loopback_test: started
 *   hwf_phy_production_loopback_test: test #%d, MCS: %d
 *   hwf_phy_production_loopback_test: ber_last_zero: %d, TH = %d, pass/fail = %d
 *   hwf_phy_production_loopback_test: tested %d MCS's, test result: %d(last_zero_ber = %d)
 *   PRODUCTION FLOWS:: IF_LOOPBACK_TEST took %d usec
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_read_timer, gpio__dump, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, rgf_reg_880b00, sdp__drive_pin
 */
	.section .text.hwf_phy_production_loopback_test,"ax",@progbits
	.global hwf_phy_production_loopback_test
hwf_phy_production_loopback_test:
	.global L_8d4330
L_8d4330:
	push_s blink
L_8d4332:
	bl L_8c02ac
L_8d4336:
	sub_s sp,sp,0x38
L_8d4338:
	mov_s r15,r0
L_8d433a:
	bl.d L_8e4694
L_8d433e:
	mov_s r19,r1
L_8d4340:
	mov_s r20,r0
L_8d4342:
	mov_s r2,0x10169a4
L_8d4348:
	mov_s r0,0x6
L_8d434a:
	bl.d L_8edfb0
L_8d434e:
	mov_s r1,0x2
L_8d4350:
	mov_s r14,0x0
L_8d4352:
	mov r16,0x1
L_8d4356:
	mov_s r0,r14
L_8d4358:
	bl.d L_8d13b0
L_8d435c:
	mov_s r1,0x19
L_8d435e:
	mov_s r0,r16
L_8d4360:
	bl.d L_8d154c
L_8d4364:
	mov_s r1,0x19
L_8d4366:
	mov_s r0,r14
L_8d4368:
	bl.d L_8d13b0
L_8d436c:
	mov_s r1,0x18
L_8d436e:
	mov_s r0,r16
L_8d4370:
	bl.d L_8d154c
L_8d4374:
	mov_s r1,0x18
L_8d4376:
	mov_s r0,r14
L_8d4378:
	bl.d L_8d13b0
L_8d437c:
	mov_s r1,0x17
L_8d437e:
	mov_s r0,r16
L_8d4380:
	bl.d L_8d154c
L_8d4384:
	mov_s r1,0x17
L_8d4386:
	mov_s r0,r16
L_8d4388:
	bl.d L_8d13b0
L_8d438c:
	mov_s r1,0x16
L_8d438e:
	mov_s r0,r16
L_8d4390:
	bl.d L_8d154c
L_8d4394:
	mov_s r1,0x16
L_8d4396:
	mov_s r0,r14
L_8d4398:
	bl.d L_8d13b0
L_8d439c:
	mov_s r1,0x14
L_8d439e:
	mov_s r0,r16
L_8d43a0:
	bl.d L_8d154c
L_8d43a4:
	mov_s r1,0x14
L_8d43a6:
	mov_s r0,r14
L_8d43a8:
	bl.d L_8d13b0
L_8d43ac:
	mov_s r1,0x12
L_8d43ae:
	mov_s r0,r16
L_8d43b0:
	bl.d L_8d154c
L_8d43b4:
	mov_s r1,0x12
L_8d43b6:
	mov_s r0,r14
L_8d43b8:
	bl.d L_8d13b0
L_8d43bc:
	mov_s r1,0x11
L_8d43be:
	mov_s r0,r16
L_8d43c0:
	bl.d L_8d154c
L_8d43c4:
	mov_s r1,0x11
L_8d43c6:
	mov_s r0,r14
L_8d43c8:
	bl.d L_8d13b0
L_8d43cc:
	mov_s r1,0xf
L_8d43ce:
	mov_s r0,r16
L_8d43d0:
	bl.d L_8d154c
L_8d43d4:
	mov_s r1,0xf
L_8d43d6:
	mov_s r0,r14
L_8d43d8:
	bl.d L_8d13b0
L_8d43dc:
	mov_s r1,0xb
L_8d43de:
	mov_s r0,r16
L_8d43e0:
	bl.d L_8d154c
L_8d43e4:
	mov_s r1,0xb
L_8d43e6:
	mov_s r0,r14
L_8d43e8:
	bl.d L_8d13dc
L_8d43ec:
	mov_s r1,0xa
L_8d43ee:
	mov_s r0,r14
L_8d43f0:
	bl.d L_8d13b0
L_8d43f4:
	mov_s r1,0xa
L_8d43f6:
	mov_s r0,r16
L_8d43f8:
	bl.d L_8d154c
L_8d43fc:
	mov_s r1,0xa
L_8d43fe:
	mov_s r0,r14
L_8d4400:
	bl.d L_8d13dc
L_8d4404:
	mov_s r1,0x9
L_8d4406:
	mov_s r0,r14
L_8d4408:
	bl.d L_8d13b0
L_8d440c:
	mov_s r1,0x9
L_8d440e:
	mov_s r0,r16
L_8d4410:
	bl.d L_8d154c
L_8d4414:
	mov_s r1,0x9
L_8d4416:
	mov_s r0,r14
L_8d4418:
	bl.d L_8d13b0
L_8d441c:
	mov_s r1,0x3
L_8d441e:
	mov_s r0,r16
L_8d4420:
	bl.d L_8d154c
L_8d4424:
	mov_s r1,0x3
L_8d4426:
	mov_s r0,r14
L_8d4428:
	bl.d L_8d13b0
L_8d442c:
	mov_s r1,0x2
L_8d442e:
	mov_s r0,r16
L_8d4430:
	bl.d L_8d154c
L_8d4434:
	mov_s r1,0x2
L_8d4436:
	mov_s r0,r14
L_8d4438:
	bl.d L_8d13b0
L_8d443c:
	mov_s r1,r16
L_8d443e:
	mov_s r0,r16
L_8d4440:
	bl.d L_8d154c
L_8d4444:
	mov_s r1,r16
L_8d4446:
	mov_s r0,r14
L_8d4448:
	bl.d L_8d13b0
L_8d444c:
	mov_s r1,r14
L_8d444e:
	mov_s r0,r16
L_8d4450:
	bl.d L_8d154c
L_8d4454:
	mov_s r1,r14
L_8d4456:
	mov_s r13,r16
L_8d4458:
	mov_s r18,r14
L_8d445a:
	b_s L_8d4554
	.global L_8d445c
L_8d445c:
	mov_s r0,0x801610
L_8d4462:
	ldb r17,[r0,r14]
L_8d4466:
	mov_s r2,0x10169d0
L_8d446c:
	mov_s r0,0x6
L_8d446e:
	mov_s r1,0x2
L_8d4470:
	mov_s r3,r14
L_8d4472:
	bl.d L_8edff8
L_8d4476:
	mov r4,r17
L_8d447a:
	cmp r17,0xff
L_8d447e:
	beq_s L_8d4552
L_8d4480:
	mov_s r0,0x1
L_8d4482:
	bl.d L_8d13b0
L_8d4486:
	mov_s r1,0x17
L_8d4488:
	mov_s r0,0x0
L_8d448a:
	bl.d L_8d13b0
L_8d448e:
	mov_s r1,0x16
L_8d4490:
	mov r4,sp
L_8d4494:
	mov r0,0x3e8
L_8d4498:
	mov_s r1,0x1b58
L_8d449e:
	mov_s r2,r17
L_8d44a0:
	mov_s r3,r0
L_8d44a2:
	brne r15,0x1,L_8d44ac
L_8d44a6:
	bl L_8d4204
L_8d44aa:
	b_s L_8d44b0
	.global L_8d44ac
L_8d44ac:
	bl L_8d4124
	.global L_8d44b0
L_8d44b0:
	brne r17,0x0,L_8d44ba
L_8d44b4:
	ld r18,[sp, 0x30]
L_8d44b8:
	b_s L_8d44be
	.global L_8d44ba
L_8d44ba:
	ld r18,[sp, 0x14]
	.global L_8d44be
L_8d44be:
	cmp r19,r18
L_8d44c2:
	mov.hi r16,0x0
L_8d44c6:
	cmp.ls r17,0xc
L_8d44ca:
	bhi L_8d4524
L_8d44ce:
	ldb.x r17,[0x802d10,r17]
L_8d44d6:
	add r0,pcl,0xc
L_8d44da:
	add1 r0,r0,r17
L_8d44de:
	j_s [r0]
L_8d44e0:
	mov_s r0,0x1
L_8d44e2:
	mov_s r1,0x14
L_8d44e4:
	b_s L_8d4520
L_8d44e6:
	mov_s r0,0x1
L_8d44e8:
	mov_s r1,0x12
L_8d44ea:
	b_s L_8d4520
L_8d44ec:
	mov_s r0,0x1
L_8d44ee:
	mov_s r1,0x11
L_8d44f0:
	b_s L_8d4520
L_8d44f2:
	mov_s r0,0x1
L_8d44f4:
	mov_s r1,0xf
L_8d44f6:
	b_s L_8d4520
L_8d44f8:
	mov_s r0,0x1
L_8d44fa:
	mov_s r1,0xb
L_8d44fc:
	b_s L_8d4520
L_8d44fe:
	mov_s r0,0x1
L_8d4500:
	mov_s r1,0xa
L_8d4502:
	b_s L_8d4520
L_8d4504:
	mov_s r0,0x1
L_8d4506:
	mov_s r1,0x9
L_8d4508:
	b_s L_8d4520
L_8d450a:
	mov_s r0,0x1
L_8d450c:
	mov_s r1,0x3
L_8d450e:
	b_s L_8d4520
L_8d4510:
	mov_s r0,0x1
L_8d4512:
	mov_s r1,0x2
L_8d4514:
	b_s L_8d4520
L_8d4516:
	mov_s r0,0x1
L_8d4518:
	mov_s r1,r0
L_8d451a:
	b_s L_8d4520
L_8d451c:
	mov_s r0,0x1
L_8d451e:
	mov_s r1,0x0
	.global L_8d4520
L_8d4520:
	bl L_8d13b0
	.global L_8d4524
L_8d4524:
	mov_s r0,0x0
L_8d4526:
	bl.d L_8d13b0
L_8d452a:
	mov_s r1,0x17
L_8d452c:
	mov_s r0,0x1
L_8d452e:
	bl.d L_8d13b0
L_8d4532:
	mov_s r1,0x16
L_8d4534:
	mov_s r2,0x1016a08
L_8d453a:
	mov_s r0,0x6
L_8d453c:
	mov_s r1,0x2
L_8d453e:
	mov_s r3,r18
L_8d4540:
	mov r4,r19
L_8d4544:
	bl.d L_8ee034
L_8d4548:
	mov r5,r16
L_8d454c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d454e:
	extb_s r14,r14
L_8d4550:
	b_s L_8d4554
	.global L_8d4552
L_8d4552:
	mov_s r13,0x0
	.global L_8d4554
L_8d4554:
	cmp_s r13,0x1
L_8d4556:
	cmp.eq r16,0x1
L_8d455a:
	bne_s L_8d4562
L_8d455c:
	cmp_s r14,0xb
L_8d455e:
	blt L_8d445c
	.global L_8d4562
L_8d4562:
	mov_s r2,0x1016a58
L_8d4568:
	mov_s r0,0x6
L_8d456a:
	mov_s r1,0x2
L_8d456c:
	mov_s r3,r14
L_8d456e:
	mov r4,r16
L_8d4572:
	bl.d L_8ee034
L_8d4576:
	mov r5,r18
L_8d457a:
	mov_s r0,r16
L_8d457c:
	bl.d L_8d13b0
L_8d4580:
	mov_s r1,0x18
L_8d4582:
	mov_s r0,0x1
L_8d4584:
	bl.d L_8d154c
L_8d4588:
	mov_s r1,0x18
L_8d458a:
	mov_s r0,0x1
L_8d458c:
	bl.d L_8d13b0
L_8d4590:
	mov_s r1,0x19
L_8d4592:
	bl L_8e4694
L_8d4596:
	mov_s r2,0x1016ab0
L_8d459c:
	sub r0,r0,r20
L_8d45a0:
	asl_s r3,r0,0x4
L_8d45a2:
	mov_s r0,0x6
L_8d45a4:
	bl.d L_8edfcc
L_8d45a8:
	mov_s r1,0x2
L_8d45aa:
	mov_s r0,r16
L_8d45ac:
	b.d L_8c0304
L_8d45b0:
	add_s sp,sp,0x38
L_8d45b2:
	nop_s
