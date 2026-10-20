/* tx_queue__config_by_mode_b @ 0x8f22fc, 376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_queue.c
 * Зовут его: rf_chain_dist_config, tx_macq__config_queue_b
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bf_w_s0_w12, bf_w_s16_w4, bf_w_s24_w7, bf_w_s8_w3, fw_sysassert_fatal, get_g_800374, memset0_words
 */
	.section .text.tx_queue__config_by_mode_b,"ax",@progbits
	.global tx_queue__config_by_mode_b
tx_queue__config_by_mode_b:
	.global L_8f22fc
L_8f22fc:
	push_s blink
L_8f22fe:
	bl L_8c02b4
L_8f2302:
	mov_s r14,r0
L_8f2304:
	mov_s r16,r1
L_8f2306:
	mov_s r13,r2
L_8f2308:
	mov_s r15,r3
L_8f230a:
	mov r18,r4
L_8f230e:
	mov r17,r5
L_8f2312:
	bl.d L_8c1a78
L_8f2316:
	mov_s r1,0x30
L_8f2318:
	cmp r16,0xa
L_8f231c:
	bhi L_8f2436
L_8f2320:
	mov_s r0,r16
L_8f2322:
	ldb.x r0,[0x802290,r0]
L_8f232a:
	add r1,pcl,0xc
L_8f232e:
	add1_s r1,r1,r0
L_8f2330:
	j_s.d [r1]
L_8f2332:
	mov_s r2,0x0
L_8f2334:
	ld_s r0,[r14]
L_8f2336:
	bmsk r1,r13,0x2
L_8f233a:
	bclr_s r0,r0,0x0
L_8f233c:
	st_s r0,[r14]
L_8f233e:
	mov_s r0,r14
L_8f2340:
	bl L_8e8558
L_8f2344:
	ld_s r0,[r14]
L_8f2346:
	mov_s r1,r2
L_8f2348:
	bset_s r0,r0,0x1
L_8f234a:
	st_s r0,[r14]
L_8f234c:
	mov_s r0,r14
	.global L_8f234e
L_8f234e:
	bl L_8e83cc
L_8f2352:
	ld_s r0,[r14]
L_8f2354:
	mov_s r1,0x0
L_8f2356:
	bclr_s r0,r0,0x2
L_8f2358:
	st_s r0,[r14]
L_8f235a:
	mov_s r0,r14
L_8f235c:
	bl L_8e845c
L_8f2360:
	b_s L_8f244a
L_8f2362:
	ld_s r0,[r14]
L_8f2364:
	bmsk r1,r13,0x2
L_8f2368:
	bclr_s r0,r0,0x0
L_8f236a:
	st_s r0,[r14]
L_8f236c:
	mov_s r0,r14
L_8f236e:
	bl L_8e8558
L_8f2372:
	ld_s r0,[r14]
L_8f2374:
	bmsk r1,r15,0x3
L_8f2378:
	bclr_s r0,r0,0x1
L_8f237a:
	st_s r0,[r14]
L_8f237c:
	mov_s r0,r14
L_8f237e:
	b_s L_8f234e
L_8f2380:
	ld_s r0,[r14]
L_8f2382:
	bmsk r1,r13,0x2
L_8f2386:
	bset_s r0,r0,0x0
L_8f2388:
	st_s r0,[r14]
L_8f238a:
	mov_s r0,r14
L_8f238c:
	bl.d L_8e8558
L_8f2390:
	bmsk_s r15,r15,0x3
L_8f2392:
	ld_s r0,[r14]
L_8f2394:
	bclr_s r0,r0,0x1
L_8f2396:
	st_s r0,[r14]
	.global L_8f2398
L_8f2398:
	mov_s r0,r14
L_8f239a:
	mov_s r1,r15
L_8f239c:
	bl L_8e83cc
L_8f23a0:
	ld_s r0,[r14]
L_8f23a2:
	bmsk r1,r18,0x6
L_8f23a6:
	bclr_s r0,r0,0x2
L_8f23a8:
	st_s r0,[r14]
L_8f23aa:
	mov_s r0,r14
L_8f23ac:
	bl L_8e845c
L_8f23b0:
	b_s L_8f244a
L_8f23b2:
	bl.d L_8ca0c4
L_8f23b6:
	bmsk_s r15,r15,0x3
L_8f23b8:
	ld_s r2,[r14]
L_8f23ba:
	bmsk r1,r13,0x2
L_8f23be:
	bclr_s r2,r2,0x0
L_8f23c0:
	breq_s r0,0,L_8f23d4
L_8f23c2:
	bset_s r2,r2,0x0
L_8f23c4:
	mov_s r0,r14
L_8f23c6:
	bl.d L_8e8558
L_8f23ca:
	st_s r2,[r14]
L_8f23cc:
	ld_s r0,[r14]
L_8f23ce:
	bclr_s r0,r0,0x1
L_8f23d0:
	st_s r0,[r14]
L_8f23d2:
	b_s L_8f2398
	.global L_8f23d4
L_8f23d4:
	mov_s r0,r14
L_8f23d6:
	bl.d L_8e8558
L_8f23da:
	st_s r2,[r14]
L_8f23dc:
	ld_s r0,[r14]
L_8f23de:
	bclr_s r0,r0,0x1
L_8f23e0:
	st_s r0,[r14]
L_8f23e2:
	mov_s r0,r14
L_8f23e4:
	mov_s r1,r15
L_8f23e6:
	b_s L_8f234e
L_8f23e8:
	ld_s r0,[r14]
L_8f23ea:
	mov_s r1,r2
L_8f23ec:
	bset_s r0,r0,0x0
L_8f23ee:
	st_s r0,[r14]
L_8f23f0:
	mov_s r0,r14
L_8f23f2:
	bl L_8e8558
L_8f23f6:
	ld_s r0,[r14]
L_8f23f8:
	mov_s r1,0x6
L_8f23fa:
	bclr_s r0,r0,0x1
L_8f23fc:
	st_s r0,[r14]
L_8f23fe:
	mov_s r0,r14
L_8f2400:
	bl L_8e83cc
L_8f2404:
	ld_s r0,[r14]
L_8f2406:
	mov_s r1,r2
L_8f2408:
	bclr_s r0,r0,0x2
L_8f240a:
	st_s r0,[r14]
L_8f240c:
	mov_s r0,r14
L_8f240e:
	bl L_8e845c
L_8f2412:
	add r0,r14,0x8
L_8f2416:
	mov_s r1,0xc27
L_8f241c:
	bl L_8e8318
L_8f2420:
	mov_s r0,0x7
L_8f2422:
	stb_s r0,[r14,0xa]
L_8f2424:
	ld_s r0,[r14,0x8]
L_8f2426:
	stb_s r2,[r14,0xc]
L_8f2428:
	bclr_s r0,r0,0xc
L_8f242a:
	st_s r0,[r14,0x8]
L_8f242c:
	mov r0,-0x1
L_8f2430:
	st_s r0,[r14,0x20]
L_8f2432:
	st_s r0,[r14,0x24]
L_8f2434:
	b_s L_8f244a
	.global L_8f2436
L_8f2436:
	mov_s r0,blink
L_8f2438:
	mov_s r2,0x10100b0
L_8f243e:
	mov_s r1,0x22
L_8f2440:
	bset_s r1,r1,0xc
L_8f2442:
	bl.d L_8c82c0
L_8f2446:
	mov r3,0x248
	.global L_8f244a
L_8f244a:
	mov_s r0,0x0
L_8f244c:
	stb_s r0,[r14,0x6]
L_8f244e:
	bmsk r1,r17,0xb
L_8f2452:
	add_s r0,r14,0x4
L_8f2454:
	bl L_8e8318
L_8f2458:
	sub r0,r18,0x1
L_8f245c:
	stb_s r0,[r14,0xa]
L_8f245e:
	add r1,r17,r18
L_8f2462:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8f2464:
	bmsk_s r1,r1,0xb
L_8f2466:
	add r0,r14,0x8
L_8f246a:
	bl L_8e8318
L_8f246e:
	b L_8c0314
L_8f2472:
	nop_s
