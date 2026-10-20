/* hwd_phy__config_by_mode @ 0x8cf2a4, 480 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_phy__reconfig_with_delay
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_phy__config_by_mode,"ax",@progbits
	.global hwd_phy__config_by_mode
hwd_phy__config_by_mode:
	.global L_8cf2a4
L_8cf2a4:
	push_s blink
L_8cf2a6:
	bl L_8c02ac
L_8cf2aa:
	mov_s r17,r1
L_8cf2ac:
	mov_s r16,r2
L_8cf2ae:
	mov_s r15,r3
L_8cf2b0:
	mov r19,r4
L_8cf2b4:
	mov_s r1,0x1
L_8cf2b6:
	mov_s r14,0x0
L_8cf2b8:
	cmp_s r0,0x1
L_8cf2ba:
	mov.gt r14,r1
L_8cf2be:
	mov_s r2,0x1
L_8cf2c0:
	sub.le r2,r2,r2
L_8cf2c4:
	mov_s r1,0x1
L_8cf2c6:
	add1 r13,r1,r2
L_8cf2ca:
	cmp_s r0,0x2
L_8cf2cc:
	mov r18,0x0
L_8cf2d0:
	mov.gt r13,0x7
L_8cf2d4:
	mov.gt r18,r1
L_8cf2d8:
	bclr.f 0x0,r14,0x0
L_8cf2dc:
	bne_s L_8cf322
	.global L_8cf2de
L_8cf2de:
	bclr.f 0x0,r18,0x0
L_8cf2e2:
	bne_s L_8cf336
	.global L_8cf2e4
L_8cf2e4:
	mov_s r0,0x880180
L_8cf2ea:
	ld_s r2,[r0,0x60]
L_8cf2ec:
	/* asl_s r14,r14,0x7 */
	.byte 0x07,0xbe
L_8cf2ee:
	bic r2,r2,0xc0
L_8cf2f2:
	bset_s r2,r2,0x6
L_8cf2f4:
	or_s r2,r2,r14
L_8cf2f6:
	bclr_s r2,r2,0x8
L_8cf2f8:
	asl r1,r18,0x8
L_8cf2fc:
	or_s r1,r1,r2
L_8cf2fe:
	st_s r1,[r0,0x60]
L_8cf300:
	bic.f 0x0,r13,0x7
L_8cf304:
	bne_s L_8cf34a
	.global L_8cf306
L_8cf306:
	mov_s r1,0x883880
L_8cf30c:
	ld_s r0,[r1,0x28]
L_8cf30e:
	bic r0,r0,0x7
L_8cf312:
	or_s r13,r13,r0
L_8cf314:
	st_s r13,[r1,0x28]
L_8cf316:
	brne r17,0x0,L_8cf35e
L_8cf31a:
	mov_s r0,0x0
L_8cf31c:
	mov_s r20,r0
L_8cf31e:
	mov_s r18,r0
L_8cf320:
	b_s L_8cf384
	.global L_8cf322
L_8cf322:
	mov_s r0,blink
L_8cf324:
	mov_s r2,0x1018690
L_8cf32a:
	mov_s r1,0xb0
L_8cf32c:
	bl.d L_8c82c0
L_8cf330:
	mov r3,0x473
L_8cf334:
	b_s L_8cf2de
	.global L_8cf336
L_8cf336:
	mov_s r0,blink
L_8cf338:
	mov_s r2,0x1018690
L_8cf33e:
	mov_s r1,0xb1
L_8cf340:
	bl.d L_8c82c0
L_8cf344:
	mov r3,0x473
L_8cf348:
	b_s L_8cf2e4
	.global L_8cf34a
L_8cf34a:
	mov_s r0,blink
L_8cf34c:
	mov_s r2,0x1018690
L_8cf352:
	mov_s r1,0xac
L_8cf354:
	bl.d L_8c82c0
L_8cf358:
	mov r3,0x476
L_8cf35c:
	b_s L_8cf306
	.global L_8cf35e
L_8cf35e:
	mov_s r2,0x883000
L_8cf364:
	ld_s r0,[r2,0x10]
L_8cf366:
	bmsk r18,r0,0x0
L_8cf36a:
	ld_s r0,[r2,0x10]
L_8cf36c:
	lsr_s r0,r0,0x2
L_8cf36e:
	bmsk r20,r0,0x0
L_8cf372:
	ld_s r0,[r2,0x10]
L_8cf374:
	bclr_s r0,r0,0x0
L_8cf376:
	st_s r0,[r2,0x10]
L_8cf378:
	ld_s r0,[r2,0x10]
L_8cf37a:
	bset_s r0,r0,0x2
L_8cf37c:
	st_s r0,[r2,0x10]
L_8cf37e:
	ld_s r0,[r2,0x10]
L_8cf380:
	bset_s r0,r0,0x0
L_8cf382:
	st_s r0,[r2,0x10]
	.global L_8cf384
L_8cf384:
	ld_s r0,[r1,0x24]
L_8cf386:
	cmp_s r15,0x4
L_8cf388:
	bclr.eq r0,r0,0x0
L_8cf38c:
	bset.ne r0,r0,0x0
L_8cf390:
	st_s r0,[r1,0x24]
L_8cf392:
	brne r15,0xb,L_8cf39e
L_8cf396:
	ld_s r0,[r1,0x24]
L_8cf398:
	bset_s r15,r15,0xf
L_8cf39a:
	bclr_s r0,r0,0x0
L_8cf39c:
	st_s r0,[r1,0x24]
	.global L_8cf39e
L_8cf39e:
	mov_s r13,0xffff0000
L_8cf3a4:
	tst_s r15,r13
L_8cf3a6:
	bne_s L_8cf420
	.global L_8cf3a8
L_8cf3a8:
	mov_s r14,0x883580
L_8cf3ae:
	ld_s r0,[r14,0x14]
L_8cf3b0:
	tst r16,r13
L_8cf3b4:
	and_s r0,r0,r13
L_8cf3b6:
	or_s r0,r0,r15
L_8cf3b8:
	st_s r0,[r14,0x14]
L_8cf3ba:
	bne_s L_8cf434
	.global L_8cf3bc
L_8cf3bc:
	ld_s r0,[r14,0x1c]
L_8cf3be:
	and_s r0,r0,r13
L_8cf3c0:
	or r0,r0,r16
L_8cf3c4:
	st_s r0,[r14,0x1c]
L_8cf3c6:
	ld_s r0,[r14,0x18]
L_8cf3c8:
	and_s r0,r0,r13
L_8cf3ca:
	st_s r0,[r14,0x18]
L_8cf3cc:
	brne r19,0x1f,L_8cf3da
L_8cf3d0:
	ld_s r0,[r14,0x18]
L_8cf3d2:
	and_s r0,r0,r13
L_8cf3d4:
	or r0,r0,0x1e
L_8cf3d8:
	st_s r0,[r14,0x18]
	.global L_8cf3da
L_8cf3da:
	tst r19,r13
L_8cf3de:
	bne_s L_8cf448
	.global L_8cf3e0
L_8cf3e0:
	ld_s r0,[r14,0x18]
L_8cf3e2:
	and_s r0,r0,r13
L_8cf3e4:
	or r0,r0,r19
L_8cf3e8:
	st_s r0,[r14,0x18]
L_8cf3ea:
	breq r17,0x0,L_8cf41c
L_8cf3ee:
	mov_s r13,0x883000
L_8cf3f4:
	ld_s r0,[r13,0x10]
L_8cf3f6:
	bclr.f 0x0,r20,0x0
L_8cf3fa:
	bclr_s r0,r0,0x0
L_8cf3fc:
	st_s r0,[r13,0x10]
L_8cf3fe:
	bne_s L_8cf45c
	.global L_8cf400
L_8cf400:
	ld_s r0,[r13,0x10]
L_8cf402:
	asl r1,r20,0x2
L_8cf406:
	bclr_s r0,r0,0x2
L_8cf408:
	or_s r0,r0,r1
L_8cf40a:
	st_s r0,[r13,0x10]
L_8cf40c:
	bclr.f 0x0,r18,0x0
L_8cf410:
	bne_s L_8cf470
	.global L_8cf412
L_8cf412:
	ld_s r1,[r13,0x10]
L_8cf414:
	bclr_s r1,r1,0x0
L_8cf416:
	or r0,r18,r1
L_8cf41a:
	st_s r0,[r13,0x10]
	.global L_8cf41c
L_8cf41c:
	b L_8c0304
	.global L_8cf420
L_8cf420:
	mov_s r0,blink
L_8cf422:
	mov_s r2,0x1018690
L_8cf428:
	mov_s r1,0xac
L_8cf42a:
	bl.d L_8c82c0
L_8cf42e:
	mov r3,0x491
L_8cf432:
	b_s L_8cf3a8
	.global L_8cf434
L_8cf434:
	mov_s r0,blink
L_8cf436:
	mov_s r2,0x1018690
L_8cf43c:
	mov_s r1,0xac
L_8cf43e:
	bl.d L_8c82c0
L_8cf442:
	mov r3,0x492
L_8cf446:
	b_s L_8cf3bc
	.global L_8cf448
L_8cf448:
	mov_s r0,blink
L_8cf44a:
	mov_s r2,0x1018690
L_8cf450:
	mov_s r1,0xac
L_8cf452:
	bl.d L_8c82c0
L_8cf456:
	mov r3,0x49c
L_8cf45a:
	b_s L_8cf3e0
	.global L_8cf45c
L_8cf45c:
	mov_s r0,blink
L_8cf45e:
	mov_s r2,0x1018690
L_8cf464:
	mov_s r1,0xac
L_8cf466:
	bl.d L_8c82c0
L_8cf46a:
	mov r3,0x4a1
L_8cf46e:
	b_s L_8cf400
	.global L_8cf470
L_8cf470:
	mov_s r0,blink
L_8cf472:
	mov_s r2,0x1018690
L_8cf478:
	mov_s r1,0xac
L_8cf47a:
	bl.d L_8c82c0
L_8cf47e:
	mov r3,0x4a2
L_8cf482:
	b_s L_8cf412
