/* bf_sm__trigger @ 0x9222cc, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_sm.c
 * Зовут его: bf__trigger_for_mid, ucode_cmd_trigger_bf
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_sm__clear_pending, bf_sm__mark_sta_active, bf_state__set, memset0_words_uc, uc_sysassert
 */
	.section .text.bf_sm__trigger,"ax",@progbits
	.global bf_sm__trigger
bf_sm__trigger:
	.global L_9222cc
L_9222cc:
	push_s blink
L_9222ce:
	bl L_920210
L_9222d2:
	mov_s r13,r0
L_9222d4:
	ld_s r0,[r0]
L_9222d6:
	mov_s r14,0x800ef4
L_9222dc:
	brne_s r0,0,L_9222fe
L_9222de:
	mov_s r13,0x800ef4
L_9222e4:
	add2 r0,r13,0x2f
L_9222e8:
	bl.d L_92166c
L_9222ec:
	mov_s r1,0x1c
L_9222ee:
	mov_s r0,r14
L_9222f0:
	bl.d L_92166c
L_9222f4:
	mov_s r1,0x80
L_9222f6:
	ld_s r0,[gp,-0x34]
L_9222f8:
	st r0,[r13, 0xc8]
L_9222fc:
	b_s L_9223ae
	.global L_9222fe
L_9222fe:
	ld_s r0,[r13,0x8]
L_922300:
	ld_s r2,[r14,0x6c]
L_922302:
	bbit0 r2,r0,L_922320
L_922306:
	asl_s r1,r0,0x2
L_922308:
	add2_s r1,r1,r1
L_92230a:
	add_s r1,r1,0x857838
L_922310:
	ldb_s r0,[r1,0x11]
L_922312:
	and r2,r0,0x10
L_922316:
	breq r0,r2,L_9223ae
L_92231a:
	bclr_s r0,r0,0x4
L_92231c:
	stb_s r0,[r1,0x11]
L_92231e:
	b_s L_9223ae
	.global L_922320
L_922320:
	brne r1,0x1,L_922336
L_922324:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_922326:
	add2_s r0,r0,r0
L_922328:
	add r1,r0,0x857838
L_922330:
	ldb_s r0,[r1,0x11]
L_922332:
	bset_s r0,r0,0x4
L_922334:
	stb_s r0,[r1,0x11]
	.global L_922336
L_922336:
	ld_s r0,[r13,0x4]
L_922338:
	mov_s r15,0x0
L_92233a:
	breq_s r0,0,L_922356
L_92233c:
	breq r0,0x1,L_92235a
L_922340:
	mov_s r0,blink
L_922342:
	mov_s r2,0x1000754
L_922348:
	mov_s r1,0x16
L_92234a:
	bl.d L_925548
L_92234e:
	mov r3,0x22a
L_922352:
	mov_s r1,r15
L_922354:
	b_s L_92235c
	.global L_922356
L_922356:
	mov_s r1,0x2
L_922358:
	b_s L_92235c
	.global L_92235a
L_92235a:
	mov_s r1,0x9
	.global L_92235c
L_92235c:
	lr r15,[0xa]
L_922360:
	bclr r0,r15,0x1
L_922364:
	flag r0
L_922368:
	ld_s r0,[r13,0x8]
L_92236a:
	ld_s r2,[r14,0x6c]
L_92236c:
	bbit1 r2,r0,L_922378
L_922370:
	bl.d L_922448
L_922374:
	extb_s r0,r0
L_922376:
	b_s L_92237e
	.global L_922378
L_922378:
	bl L_9283c8
L_92237c:
	mov_s r0,0x1
	.global L_92237e
L_92237e:
	breq_s r0,0,L_9223a0
L_922380:
	ld_s r0,[r13,0x8]
L_922382:
	mov_s r1,0x801014
L_922388:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_92238a:
	add3_s r0,r0,r0
L_92238c:
	add_s r0,r0,0x8011b0
L_922392:
	ld_s r2,[r0,0xc]
L_922394:
	ldw_s r0,[r0,0x10]
L_922396:
	st_s r2,[r1,0x14]
L_922398:
	stw_s r0,[r1,0x18]
L_92239a:
	bl.d L_92208c
L_92239e:
	ld_s r0,[r13,0x8]
	.global L_9223a0
L_9223a0:
	lr r0,[0xa]
L_9223a4:
	bic r15,r15,-0x3
L_9223a8:
	or_s r15,r15,r0
L_9223aa:
	flag r15
	.global L_9223ae
L_9223ae:
	b L_92027c
L_9223b2:
	nop_s
