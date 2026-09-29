/* qdesc__build_by_type @ 0x8fa224, 372 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__addba_at_08, mac_bringup__init_seq
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bits__set32_s0_w12, bits__set32_s16_w4, bits__set32_s24_w7, fw_sysassert_fatal, memset0_words, qdesc__bits_set32_s8_w3, qdesc_cfg__is_override
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qdesc__build_by_type
qdesc__build_by_type:
	.global L_8fa224
L_8fa224:
	push_s blink
L_8fa226:
	bl L_8c01d0
L_8fa22a:
	mov_s r14,r0
L_8fa22c:
	mov_s r16,r1
L_8fa22e:
	mov_s r13,r2
L_8fa230:
	mov_s r15,r3
L_8fa232:
	mov r18,r4
L_8fa236:
	mov r17,r5
L_8fa23a:
	mov r19,r6
L_8fa23e:
	bl.d L_8c1cd8
L_8fa242:
	mov_s r1,0x30
L_8fa244:
	cmp r16,0xa
L_8fa248:
	bhi L_8fa362
L_8fa24c:
	mov_s r0,r16
L_8fa24e:
	ldb.x r0,[0x802804,r0]
L_8fa256:
	add r1,pcl,0xc
L_8fa25a:
	add1_s r1,r1,r0
L_8fa25c:
	j_s.d [r1]
L_8fa25e:
	mov_s r2,0x0
L_8fa260:
	ld_s r0,[r14]
L_8fa262:
	bmsk r1,r13,0x2
L_8fa266:
	bclr_s r0,r0,0x0
L_8fa268:
	st_s r0,[r14]
L_8fa26a:
	mov_s r0,r14
L_8fa26c:
	bl L_8ed574
L_8fa270:
	ld_s r0,[r14]
L_8fa272:
	mov_s r1,r2
L_8fa274:
	bset_s r0,r0,0x1
L_8fa276:
	st_s r0,[r14]
L_8fa278:
	mov_s r0,r14
	.global L_8fa27a
L_8fa27a:
	bl L_8ed3f4
L_8fa27e:
	ld_s r0,[r14]
L_8fa280:
	mov_s r1,0x0
L_8fa282:
	bclr_s r0,r0,0x2
L_8fa284:
	st_s r0,[r14]
L_8fa286:
	mov_s r0,r14
L_8fa288:
	bl L_8ed484
L_8fa28c:
	b_s L_8fa36c
L_8fa28e:
	ld_s r0,[r14]
L_8fa290:
	bmsk r1,r13,0x2
L_8fa294:
	bclr_s r0,r0,0x0
L_8fa296:
	st_s r0,[r14]
L_8fa298:
	mov_s r0,r14
L_8fa29a:
	bl L_8ed574
L_8fa29e:
	ld_s r0,[r14]
L_8fa2a0:
	bmsk r1,r15,0x3
L_8fa2a4:
	bclr_s r0,r0,0x1
L_8fa2a6:
	st_s r0,[r14]
L_8fa2a8:
	mov_s r0,r14
L_8fa2aa:
	b_s L_8fa27a
L_8fa2ac:
	ld_s r0,[r14]
L_8fa2ae:
	bmsk r1,r13,0x2
L_8fa2b2:
	bset_s r0,r0,0x0
L_8fa2b4:
	st_s r0,[r14]
L_8fa2b6:
	mov_s r0,r14
L_8fa2b8:
	bl.d L_8ed574
L_8fa2bc:
	bmsk_s r15,r15,0x3
L_8fa2be:
	ld_s r0,[r14]
L_8fa2c0:
	bclr_s r0,r0,0x1
L_8fa2c2:
	st_s r0,[r14]
	.global L_8fa2c4
L_8fa2c4:
	mov_s r0,r14
L_8fa2c6:
	mov_s r1,r15
L_8fa2c8:
	bl L_8ed3f4
L_8fa2cc:
	ld_s r0,[r14]
L_8fa2ce:
	bmsk r1,r18,0x6
L_8fa2d2:
	bclr_s r0,r0,0x2
L_8fa2d4:
	st_s r0,[r14]
L_8fa2d6:
	mov_s r0,r14
L_8fa2d8:
	bl L_8ed484
L_8fa2dc:
	b_s L_8fa36c
L_8fa2de:
	bl.d L_8cc2e8
L_8fa2e2:
	bmsk_s r15,r15,0x3
L_8fa2e4:
	ld_s r2,[r14]
L_8fa2e6:
	bmsk r1,r13,0x2
L_8fa2ea:
	bclr_s r2,r2,0x0
L_8fa2ec:
	breq_s r0,0,L_8fa300
L_8fa2ee:
	bset_s r2,r2,0x0
L_8fa2f0:
	mov_s r0,r14
L_8fa2f2:
	bl.d L_8ed574
L_8fa2f6:
	st_s r2,[r14]
L_8fa2f8:
	ld_s r0,[r14]
L_8fa2fa:
	bclr_s r0,r0,0x1
L_8fa2fc:
	st_s r0,[r14]
L_8fa2fe:
	b_s L_8fa2c4
	.global L_8fa300
L_8fa300:
	mov_s r0,r14
L_8fa302:
	bl.d L_8ed574
L_8fa306:
	st_s r2,[r14]
L_8fa308:
	ld_s r0,[r14]
L_8fa30a:
	bclr_s r0,r0,0x1
L_8fa30c:
	st_s r0,[r14]
L_8fa30e:
	mov_s r0,r14
L_8fa310:
	mov_s r1,r15
L_8fa312:
	b_s L_8fa27a
L_8fa314:
	ld_s r0,[r14]
L_8fa316:
	mov_s r1,r2
L_8fa318:
	bset_s r0,r0,0x0
L_8fa31a:
	st_s r0,[r14]
L_8fa31c:
	mov_s r0,r14
L_8fa31e:
	bl L_8ed574
L_8fa322:
	ld_s r0,[r14]
L_8fa324:
	mov_s r1,0x6
L_8fa326:
	bclr_s r0,r0,0x1
L_8fa328:
	st_s r0,[r14]
L_8fa32a:
	mov_s r0,r14
L_8fa32c:
	bl L_8ed3f4
L_8fa330:
	ld_s r0,[r14]
L_8fa332:
	mov_s r1,r2
L_8fa334:
	bclr_s r0,r0,0x2
L_8fa336:
	st_s r0,[r14]
L_8fa338:
	mov_s r0,r14
L_8fa33a:
	bl L_8ed484
L_8fa33e:
	add r0,r14,0x8
L_8fa342:
	mov_s r1,0xc27
L_8fa348:
	bl L_8ed340
L_8fa34c:
	mov_s r0,0x7
L_8fa34e:
	stb_s r0,[r14,0xa]
L_8fa350:
	ld_s r0,[r14,0x8]
L_8fa352:
	stb_s r2,[r14,0xc]
L_8fa354:
	bclr_s r0,r0,0xc
L_8fa356:
	st_s r0,[r14,0x8]
L_8fa358:
	mov r0,-0x1
L_8fa35c:
	st_s r0,[r14,0x20]
L_8fa35e:
	st_s r0,[r14,0x24]
L_8fa360:
	b_s L_8fa36c
	.global L_8fa362
L_8fa362:
	mov_s r0,blink
L_8fa364:
	mov_s r1,0x22
L_8fa366:
	bl.d L_8c9b28
L_8fa36a:
	bset_s r1,r1,0xc
	.global L_8fa36c
L_8fa36c:
	breq r19,0x0,L_8fa394
L_8fa370:
	mov_s r0,0x0
L_8fa372:
	stb_s r0,[r14,0x6]
L_8fa374:
	bmsk r1,r17,0xb
L_8fa378:
	add_s r0,r14,0x4
L_8fa37a:
	bl L_8ed340
L_8fa37e:
	sub r0,r18,0x1
L_8fa382:
	stb_s r0,[r14,0xa]
L_8fa384:
	add r1,r17,r18
L_8fa388:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8fa38a:
	bmsk_s r1,r1,0xb
L_8fa38c:
	add r0,r14,0x8
L_8fa390:
	bl L_8ed340
	.global L_8fa394
L_8fa394:
	b L_8c022c
