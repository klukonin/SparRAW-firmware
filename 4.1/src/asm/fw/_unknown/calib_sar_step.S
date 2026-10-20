/* calib_sar_step @ 0x8d327c, 636 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_calib_sar_alg
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, hwd_abif__adjust_5bit_pair, hwd_abif__rgf_88a200_8cbf84, hwd_phy__read_sar_sample, memcpy_fw, sar64_fw
 */
	.section .text.calib_sar_step,"ax",@progbits
	.global calib_sar_step
calib_sar_step:
	.global L_8d327c
L_8d327c:
	push_s blink
L_8d327e:
	bl L_8c0298
L_8d3282:
	st.a r0,[sp,-0xb8]
L_8d3286:
	st_s r2,[sp,0x4]
L_8d3288:
	st_s r3,[sp,0x8]
L_8d328a:
	sub r16,r0,r1
L_8d328e:
	extb r16,r16
L_8d3292:
	mov r18,0x0
L_8d3296:
	mov r24,r18
L_8d329a:
	mov r23,r18
L_8d329e:
	mov_s r0,0x802f00
L_8d32a4:
	ld_s r2,[r0]
L_8d32a6:
	ld_s r1,[r0,0x4]
L_8d32a8:
	st_s r2,[sp,0x28]
L_8d32aa:
	st_s r1,[sp,0x2c]
L_8d32ac:
	ld_s r1,[r0,0x8]
L_8d32ae:
	ld_s r0,[r0,0xc]
L_8d32b0:
	st_s r1,[sp,0x30]
L_8d32b2:
	st_s r0,[sp,0x34]
L_8d32b4:
	mov_s r15,r18
L_8d32b6:
	mov_s r25,r15
L_8d32b8:
	st r18,[sp, 0xc]
L_8d32bc:
	b_s L_8d32dc
	.global L_8d32be
L_8d32be:
	add.f r0,r20,0x4
L_8d32c2:
	adc r1,r14,0x0
L_8d32c6:
	bl.d L_8c06e0
L_8d32ca:
	mov_s r2,0x3
L_8d32cc:
	mov_s r2,r0
L_8d32ce:
	mov_s r0,r1
	.global L_8d32d0
L_8d32d0:
	add.f r24,r24,r2
L_8d32d4:
	adc r23,r23,r0
	.global L_8d32d8
L_8d32d8:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d32da:
	extb_s r15,r15
	.global L_8d32dc
L_8d32dc:
	cmp_s r15,0x8
L_8d32de:
	bge L_8d33e8
L_8d32e2:
	ld_s r0,[sp,0x0]
L_8d32e4:
	add_s r13,sp,0x18
L_8d32e6:
	add r17,r0,0x1
L_8d32ea:
	mov_s r0,0x854800
L_8d32f0:
	st_s r0,[sp,0x10]
L_8d32f2:
	mov_s r0,r15
L_8d32f4:
	bl.d L_8cf7b4
L_8d32f8:
	mov_s r1,r13
L_8d32fa:
	asl_s r0,r15,0x4
L_8d32fc:
	add_s r0,r0,sp
L_8d32fe:
	add_s r0,r0,0x38
L_8d3300:
	mov_s r1,r13
L_8d3302:
	bl.d L_8c0460
L_8d3306:
	mov_s r2,0x10
L_8d3308:
	ld_s r13,[sp,0x1c]
L_8d330a:
	mov_s r0,0x0
L_8d330c:
	ld_s r1,[sp,0x0]
L_8d330e:
	ld r22,[sp, 0x18]
L_8d3312:
	bset r0,r0,r1
L_8d3316:
	ld r20,[sp, 0x20]
L_8d331a:
	ld_s r14,[sp,0x24]
L_8d331c:
	mov_s r21,r0
L_8d331e:
	brlt.d r13,0x0,L_8d3338
L_8d3322:
	asr r19,r0,0x1f
L_8d3326:
	add.f r0,r21,r22
L_8d332a:
	adc r1,r19,r13
L_8d332e:
	bl.d L_8c06e0
L_8d3332:
	mov_s r2,r17
L_8d3334:
	sexb_s r0,r0
L_8d3336:
	b_s L_8d334c
	.global L_8d3338
L_8d3338:
	sub.f r0,r21,r22
L_8d333c:
	sbc r1,r19,r13
L_8d3340:
	bl.d L_8c06e0
L_8d3344:
	mov_s r2,r17
L_8d3346:
	rsub r2,r0,0x0
L_8d334a:
	sexb_s r0,r2
	.global L_8d334c
L_8d334c:
	ld_s r1,[sp,0x10]
L_8d334e:
	add_s r1,r1,r15
L_8d3350:
	st_s r1,[sp,0x14]
L_8d3352:
	brlt.d r14,0x0,L_8d336a
L_8d3356:
	stb_s r0,[r1,0x10]
L_8d3358:
	add.f r0,r21,r20
L_8d335c:
	adc r1,r19,r14
L_8d3360:
	bl.d L_8c06e0
L_8d3364:
	mov_s r2,r17
L_8d3366:
	sexb_s r0,r0
L_8d3368:
	b_s L_8d337e
	.global L_8d336a
L_8d336a:
	sub.f r0,r21,r20
L_8d336e:
	sbc r1,r19,r14
L_8d3372:
	bl.d L_8c06e0
L_8d3376:
	mov_s r2,r17
L_8d3378:
	rsub r2,r0,0x0
L_8d337c:
	sexb_s r0,r2
	.global L_8d337e
L_8d337e:
	ld_s r1,[sp,0x14]
L_8d3380:
	stb_s r0,[r1,0x18]
L_8d3382:
	ld_s r0,[sp,0x4]
L_8d3384:
	breq r0,0x0,L_8d32d8
L_8d3388:
	brlt r13,0x0,L_8d33a0
L_8d338c:
	add.f r0,r22,0x4
L_8d3390:
	adc r1,r13,0x0
L_8d3394:
	bl.d L_8c06e0
L_8d3398:
	mov_s r2,0x3
L_8d339a:
	mov_s r2,r0
L_8d339c:
	mov_s r13,r1
L_8d339e:
	b_s L_8d33ba
	.global L_8d33a0
L_8d33a0:
	rsub.f r0,r22,0x4
L_8d33a4:
	mov_s r1,0x0
L_8d33a6:
	sbc r1,r1,r13
L_8d33aa:
	bl.d L_8c06e0
L_8d33ae:
	mov_s r2,0x3
L_8d33b0:
	rsub.f r2,r0,0x0
L_8d33b4:
	mov_s r13,0x0
L_8d33b6:
	sbc r13,r13,r1
	.global L_8d33ba
L_8d33ba:
	ld_s r0,[sp,0xc]
L_8d33bc:
	add.f r25,r25,r2
L_8d33c0:
	adc r0,r0,r13
L_8d33c4:
	cmp_s r14,0x0
L_8d33c6:
	bge.d L_8d32be
L_8d33ca:
	st_s r0,[sp,0xc]
L_8d33cc:
	rsub.f r0,r20,0x4
L_8d33d0:
	mov_s r1,0x0
L_8d33d2:
	sbc r1,r1,r14
L_8d33d6:
	bl.d L_8c06e0
L_8d33da:
	mov_s r2,0x3
L_8d33dc:
	rsub.f r2,r0,0x0
L_8d33e0:
	mov_s r0,0x0
L_8d33e2:
	sbc r0,r0,r1
L_8d33e6:
	b_s L_8d32d0
	.global L_8d33e8
L_8d33e8:
	mov_s r13,0x0
L_8d33ea:
	b_s L_8d340e
	.global L_8d33ec
L_8d33ec:
	add.f r0,r15,r14
L_8d33f0:
	adc r1,r1,r17
L_8d33f4:
	bl.d L_8c06e0
L_8d33f8:
	mov_s r2,r16
L_8d33fa:
	sexb_s r0,r0
	.global L_8d33fc
L_8d33fc:
	stb r0,[r19, 0x30]
L_8d3400:
	abs_s r0,r0
L_8d3402:
	max r0,r0,r18
L_8d3406:
	extb r18,r0
L_8d340a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d340c:
	extb_s r13,r13
	.global L_8d340e
L_8d340e:
	brge r13,0x8,L_8d34a8
L_8d3412:
	asl_s r15,r13,0x4
L_8d3414:
	add_s r15,r15,sp
L_8d3416:
	ld_s r0,[r15,0x38]
L_8d3418:
	ld r4,[r15, 0x3c]
L_8d341c:
	ld_s r1,[sp,0xc]
L_8d341e:
	sub.f r5,r25,r0
L_8d3422:
	sub r2,r16,0x1
L_8d3426:
	sbc.f r1,r1,r4
L_8d342a:
	mov_s r14,0x0
L_8d342c:
	bset r14,r14,r2
L_8d3430:
	bmi.d L_8d344a
L_8d3434:
	asr r17,r14,0x1f
L_8d3438:
	add.f r0,r14,r5
L_8d343c:
	adc r1,r1,r17
L_8d3440:
	bl.d L_8c06e0
L_8d3444:
	mov_s r2,r16
L_8d3446:
	sexb_s r0,r0
L_8d3448:
	b_s L_8d3468
	.global L_8d344a
L_8d344a:
	ld_s r2,[sp,0xc]
L_8d344c:
	sub.f r0,r0,r25
L_8d3450:
	sbc r1,r4,r2
L_8d3454:
	add.f r0,r0,r14
L_8d3458:
	adc r1,r1,r17
L_8d345c:
	bl.d L_8c06e0
L_8d3460:
	mov_s r2,r16
L_8d3462:
	rsub r2,r0,0x0
L_8d3466:
	sexb_s r0,r2
	.global L_8d3468
L_8d3468:
	add r19,sp,r13
L_8d346c:
	stb r0,[r19, 0x28]
L_8d3470:
	abs_s r0,r0
L_8d3472:
	max r0,r0,r18
L_8d3476:
	extb r18,r0
L_8d347a:
	ld_s r0,[r15,0x44]
L_8d347c:
	ld_s r2,[r15,0x40]
L_8d347e:
	sub.f r15,r24,r2
L_8d3482:
	sbc.f r1,r23,r0
L_8d3486:
	bpl L_8d33ec
L_8d348a:
	sub.f r2,r2,r24
L_8d348e:
	sbc r1,r0,r23
L_8d3492:
	add.f r0,r2,r14
L_8d3496:
	adc r1,r1,r17
L_8d349a:
	bl.d L_8c06e0
L_8d349e:
	mov_s r2,r16
L_8d34a0:
	rsub r2,r0,0x0
L_8d34a4:
	sexb_s r0,r2
L_8d34a6:
	b_s L_8d33fc
	.global L_8d34a8
L_8d34a8:
	ld_s r1,[sp,0x8]
L_8d34aa:
	asl r0,r18
L_8d34ae:
	cmp_s r1,r0
L_8d34b0:
	mov.lt r15,0x0
L_8d34b4:
	blt_s L_8d34ba
L_8d34b6:
	nop_s
L_8d34b8:
	mov_s r15,0x1
	.global L_8d34ba
L_8d34ba:
	brne_s r15,0,L_8d34ea
L_8d34bc:
	mov_s r14,0x0
L_8d34be:
	mov_s r13,0x8
	.global L_8d34c0
L_8d34c0:
	add r2,sp,r14
L_8d34c4:
	mov_s r0,r14
L_8d34c6:
	mov_s r1,0x0
L_8d34c8:
	bl.d L_8cbf98
L_8d34cc:
	ldb.x r2,[r2, 0x28]
L_8d34d0:
	add r2,sp,r14
L_8d34d4:
	ldb.x r2,[r2, 0x30]
L_8d34d8:
	mov_s r0,r14
L_8d34da:
	bl.d L_8cbf98
L_8d34de:
	mov_s r1,0x1
L_8d34e0:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d34e2:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d34e4:
	brhs.d r13,0x1,L_8d34c0
L_8d34e8:
	extb_s r14,r14
	.global L_8d34ea
L_8d34ea:
	bl L_8cbf84
L_8d34ee:
	mov_s r0,r15
L_8d34f0:
	b.d L_8c02dc
L_8d34f4:
	add sp,sp,0xb8
