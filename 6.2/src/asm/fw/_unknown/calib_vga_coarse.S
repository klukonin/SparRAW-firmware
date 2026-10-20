/* calib_vga_coarse @ 0x8d53b8, 448 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, calib_vga_coarse_limit, hwd_abif__set_agc_column, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_vga_coarse
calib_vga_coarse:
	.global L_8d53b8
L_8d53b8:
	sub_s sp,sp,0x20
L_8d53ba:
	push_s blink
L_8d53bc:
	bl L_8c01c4
L_8d53c0:
	sub_s sp,sp,0x2c
L_8d53c2:
	mov_s r20,r0
L_8d53c4:
	mov_s r19,r1
L_8d53c6:
	mov_s r18,r2
L_8d53c8:
	mov_s r17,r3
L_8d53ca:
	mov r16,r4
L_8d53ce:
	st r5,[sp, 0x28]
L_8d53d2:
	ldb r14,[sp, 0xa4]
L_8d53d6:
	st r7,[sp, 0x24]
L_8d53da:
	st r6,[sp, 0x20]
L_8d53de:
	mov_s r2,0x0
L_8d53e0:
	breq r14,0x1,L_8d5412
L_8d53e4:
	ld r0,[sp, 0x90]
L_8d53e8:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d53ea:
	ldb_s r0,[r0,r14]
L_8d53ec:
	breq r0,0x1,L_8d5404
L_8d53f0:
	cmp_s r0,0x2
L_8d53f2:
	cmp.ne r0,0x3
L_8d53f6:
	beq_s L_8d5412
L_8d53f8:
	ld r0,[sp, 0xb0]
L_8d53fc:
	mov_s r1,0x2
L_8d53fe:
	st_s r1,[r0]
L_8d5400:
	mov_s r1,r2
L_8d5402:
	b_s L_8d541c
	.global L_8d5404
L_8d5404:
	mov_s r2,0xffff0000
L_8d540a:
	mov_s r1,0xfff80000
L_8d5410:
	b_s L_8d541c
	.global L_8d5412
L_8d5412:
	mov_s r2,0x5
L_8d5414:
	asl_s r2,r2,0x10
L_8d5416:
	mov_s r1,0xfffe0000
	.global L_8d541c
L_8d541c:
	ldb r0,[sp, 0x80]
L_8d5420:
	brne r0,0x1,L_8d5450
L_8d5424:
	ldb r0,[sp, 0xac]
L_8d5428:
	ld r15,[sp, 0x94]
L_8d542c:
	ld r22,[sp, 0x9c]
L_8d5430:
	mov_s r13,0x1
L_8d5432:
	brne r0,0x0,L_8d54c8
L_8d5436:
	b_s L_8d5496
	.global L_8d5438
L_8d5438:
	ld_s r0,[sp,0x78]
L_8d543a:
	st r13,[r22]
L_8d543e:
	st_s r0,[sp,0x0]
	.global L_8d5440
L_8d5440:
	mov_s r1,0x0
L_8d5442:
	st_s r15,[sp,0x4]
	.global L_8d5444
L_8d5444:
	ld r0,[sp, 0xa0]
L_8d5448:
	st_s r13,[sp,0x8]
L_8d544a:
	st_s r0,[sp,0xc]
L_8d544c:
	st_s r14,[sp,0x10]
L_8d544e:
	b_s L_8d5474
	.global L_8d5450
L_8d5450:
	ldb r0,[sp, 0x81]
L_8d5454:
	brne r0,0x1,L_8d5478
L_8d5458:
	ld_s r0,[sp,0x78]
L_8d545a:
	st_s r14,[sp,0x10]
L_8d545c:
	st_s r0,[sp,0x0]
L_8d545e:
	ld r0,[sp, 0x94]
L_8d5462:
	mov_s r1,0x0
L_8d5464:
	st_s r0,[sp,0x4]
L_8d5466:
	ld r0,[sp, 0x9c]
L_8d546a:
	ld_s r0,[r0]
L_8d546c:
	st_s r0,[sp,0x8]
L_8d546e:
	ld r0,[sp, 0xa0]
L_8d5472:
	st_s r0,[sp,0xc]
	.global L_8d5474
L_8d5474:
	st_s r1,[sp,0x14]
L_8d5476:
	b_s L_8d54de
	.global L_8d5478
L_8d5478:
	ld_s r3,[sp,0x7c]
L_8d547a:
	brge r2,r3,L_8d550a
L_8d547e:
	ldb r0,[sp, 0xac]
L_8d5482:
	ld r15,[sp, 0x94]
L_8d5486:
	mov_s r13,0x1
L_8d5488:
	ld r22,[sp, 0x9c]
L_8d548c:
	brne_s r0,0,L_8d54c8
L_8d548e:
	ld r0,[sp, 0x84]
L_8d5492:
	brge r0,r2,L_8d54c8
	.global L_8d5496
L_8d5496:
	ldb r0,[sp, 0x88]
L_8d549a:
	brne_s r0,0,L_8d54c8
L_8d549c:
	ld r1,[sp, 0x8c]
L_8d54a0:
	mov_s r0,r15
L_8d54a2:
	bl.d L_8c0380
L_8d54a6:
	mov_s r2,0x4
L_8d54a8:
	mov_s r0,0x1
L_8d54aa:
	mov r21,0x0
L_8d54ae:
	mov_s r1,r21
L_8d54b0:
	bl.d L_8cf080
L_8d54b4:
	ld r2,[sp, 0x98]
L_8d54b8:
	brhs r14,0x2,L_8d5438
L_8d54bc:
	ld r0,[r22]
L_8d54c0:
	breq r0,0x1,L_8d5438
L_8d54c4:
	mov_s r0,r21
L_8d54c6:
	b_s L_8d5550
	.global L_8d54c8
L_8d54c8:
	ld_s r0,[sp,0x78]
L_8d54ca:
	st_s r15,[sp,0x4]
L_8d54cc:
	st_s r0,[sp,0x0]
L_8d54ce:
	ld r0,[r22]
L_8d54d2:
	st_s r14,[sp,0x10]
L_8d54d4:
	st_s r0,[sp,0x8]
L_8d54d6:
	ld r0,[sp, 0xa0]
L_8d54da:
	st_s r13,[sp,0x14]
L_8d54dc:
	st_s r0,[sp,0xc]
	.global L_8d54de
L_8d54de:
	ld r0,[sp, 0xa8]
L_8d54e2:
	mov_s r1,r19
L_8d54e4:
	st_s r0,[sp,0x18]
L_8d54e6:
	ld r0,[sp, 0xb0]
L_8d54ea:
	mov_s r2,r18
L_8d54ec:
	st_s r0,[sp,0x1c]
L_8d54ee:
	ld r5,[sp, 0x28]
L_8d54f2:
	mov_s r0,r20
L_8d54f4:
	ld r6,[sp, 0x20]
L_8d54f8:
	mov_s r3,r17
L_8d54fa:
	mov r4,r16
L_8d54fe:
	bl.d L_8d8604
L_8d5502:
	ld r7,[sp, 0x24]
L_8d5506:
	mov_s r0,0x0
L_8d5508:
	b_s L_8d555a
	.global L_8d550a
L_8d550a:
	brge.d r3,r1,L_8d5550
L_8d550e:
	mov_s r0,0x0
L_8d5510:
	ldb r1,[sp, 0xac]
L_8d5514:
	brne_s r1,0,L_8d553c
L_8d5516:
	brlo r14,0x2,L_8d553c
L_8d551a:
	ldb r0,[sp, 0x88]
L_8d551e:
	breq r0,0x1,L_8d552a
L_8d5522:
	ld r0,[sp, 0x84]
L_8d5526:
	brge r2,r0,L_8d553c
	.global L_8d552a
L_8d552a:
	ld r0,[sp, 0x9c]
L_8d552e:
	mov_s r13,0x1
L_8d5530:
	st_s r13,[r0]
L_8d5532:
	ld_s r0,[sp,0x78]
L_8d5534:
	st_s r0,[sp,0x0]
L_8d5536:
	ld r15,[sp, 0x94]
L_8d553a:
	b_s L_8d5440
	.global L_8d553c
L_8d553c:
	breq r1,0x1,L_8d5562
L_8d5540:
	ldb r0,[sp, 0x88]
L_8d5544:
	brne_s r0,0,L_8d554e
L_8d5546:
	ld r0,[sp, 0x84]
L_8d554a:
	brlt r0,r2,L_8d5562
	.global L_8d554e
L_8d554e:
	mov_s r0,0x0
	.global L_8d5550
L_8d5550:
	ld r2,[sp, 0xa8]
L_8d5554:
	mov_s r1,0x1
L_8d5556:
	stb_s r0,[r2]
L_8d5558:
	mov_s r0,r1
	.global L_8d555a
L_8d555a:
	mov_s r12,0x24
L_8d555c:
	b.d L_8c0216
L_8d5560:
	add_s sp,sp,0x2c
	.global L_8d5562
L_8d5562:
	ld_s r0,[sp,0x78]
L_8d5564:
	st_s r0,[sp,0x0]
L_8d5566:
	ld r0,[sp, 0x94]
L_8d556a:
	st_s r0,[sp,0x4]
L_8d556c:
	ld r0,[sp, 0x9c]
L_8d5570:
	ld_s r13,[r0]
L_8d5572:
	mov_s r1,0x0
L_8d5574:
	b_s L_8d5444
L_8d5576:
	nop_s
