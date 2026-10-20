/* rx_macq__pack_desc @ 0x8e4340, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__program_desc_848018
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, bits__set32_s0_w13, bits__set32_s28_w4, fw_sysassert_fatal, rx_macq__bits_set32_s21_w5, rx_macq__bits_set32_s26_w2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__pack_desc
rx_macq__pack_desc:
	.global L_8e4340
L_8e4340:
	push_s blink
L_8e4342:
	bl L_8c01cc
L_8e4346:
	mov_s r13,r0
L_8e4348:
	mov_s r14,r1
L_8e434a:
	mov_s r16,r2
L_8e434c:
	mov_s r17,r3
L_8e434e:
	mov r19,r4
L_8e4352:
	mov_s r0,0x886400
L_8e4358:
	ld_s r0,[r0]
L_8e435a:
	mov r18,r6
L_8e435e:
	mov_s r15,r5
L_8e4360:
	mov r20,r7
L_8e4364:
	bbit1 r0,0xa,L_8e439e
	.global L_8e4368
L_8e4368:
	bmsk r0,r17,0x0
L_8e436c:
	asl r4,r0,0x13
L_8e4370:
	ld_s r2,[r13]
L_8e4372:
	cmp_s r15,0x0
L_8e4374:
	mov_s r1,0x1
L_8e4376:
	sub_s.ne r1,r1,r1
L_8e4378:
	asl_s r1,r1,0x14
L_8e437a:
	bclr_s r2,r2,0x13
L_8e437c:
	bclr_s r2,r2,0x14
L_8e437e:
	bclr r0,r4,0x14
L_8e4382:
	or_s r0,r0,r2
L_8e4384:
	or_s r0,r0,r1
L_8e4386:
	st_s r0,[r13]
L_8e4388:
	brne r14,0x2,L_8e43b4
L_8e438c:
	mov_s r0,0x89
L_8e438e:
	stb_s r0,[r13,0x1]
L_8e4390:
	mov_s r0,r13
L_8e4392:
	mov_s r1,0x8
L_8e4394:
	bl L_8ed43c
L_8e4398:
	ld_s r0,[r13]
L_8e439a:
	bset_s r0,r0,0x10
L_8e439c:
	b_s L_8e43d6
	.global L_8e439e
L_8e439e:
	cmp r17,0x0
L_8e43a2:
	mov.ne r0,blink
L_8e43a6:
	mov.ne r1,0x17
L_8e43aa:
	bl.ne.d L_8c9b28
L_8e43ae:
	bset.ne r1,r1,0xc
L_8e43b2:
	b_s L_8e4368
	.global L_8e43b4
L_8e43b4:
	brne r14,0x3,L_8e43c2
L_8e43b8:
	mov_s r0,0xcb
L_8e43ba:
	stb_s r0,[r13,0x1]
L_8e43bc:
	mov_s r0,r13
L_8e43be:
	mov_s r1,0x0
L_8e43c0:
	b_s L_8e43ce
	.global L_8e43c2
L_8e43c2:
	mov_s r0,0xdf
L_8e43c4:
	stb_s r0,[r13,0x1]
L_8e43c6:
	asl_s r1,r15,0x3
L_8e43c8:
	add1_s r1,r1,r1
L_8e43ca:
	bmsk_s r1,r1,0x4
L_8e43cc:
	mov_s r0,r13
	.global L_8e43ce
L_8e43ce:
	bl L_8ed43c
L_8e43d2:
	ld_s r0,[r13]
L_8e43d4:
	bclr_s r0,r0,0x10
	.global L_8e43d6
L_8e43d6:
	st_s r0,[r13]
L_8e43d8:
	bmsk_s r15,r15,0x0
L_8e43da:
	asl_s r15,r15,0x11
L_8e43dc:
	bclr_s r0,r0,0x11
L_8e43de:
	bclr_s r0,r0,0x12
L_8e43e0:
	bset_s r0,r0,0x12
L_8e43e2:
	or_s r15,r15,r0
L_8e43e4:
	bmsk r0,r19,0x0
L_8e43e8:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_8e43ea:
	bmsk r1,r20,0x0
L_8e43ee:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e43f0:
	bic r15,r15,0xc0
L_8e43f4:
	or_s r0,r0,r15
L_8e43f6:
	or_s r0,r0,r1
L_8e43f8:
	bset_s r0,r0,0x5
L_8e43fa:
	st_s r0,[r13]
L_8e43fc:
	mov_s r0,r13
L_8e43fe:
	mov_s r1,0x1
L_8e4400:
	bl.d L_8ed4a8
L_8e4404:
	cmp_s r14,0x3
L_8e4406:
	bmsk r1,r18,0x1
L_8e440a:
	bl L_8ed490
L_8e440e:
	bmsk r1,r16,0xc
L_8e4412:
	add_s r0,r13,0x4
L_8e4414:
	bl L_8ed34c
L_8e4418:
	bne_s L_8e4420
L_8e441a:
	ld_s r0,[r13,0x4]
L_8e441c:
	bset_s r0,r0,0xe
L_8e441e:
	st_s r0,[r13,0x4]
	.global L_8e4420
L_8e4420:
	b L_8c0224
