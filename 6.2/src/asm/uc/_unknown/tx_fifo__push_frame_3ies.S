/* tx_fifo__push_frame_3ies @ 0x938358, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: itx__tx_frame_3ies
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, direct_tx__issue_cmd_33, tx_fifo__write_bytes, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_fifo__push_frame_3ies
tx_fifo__push_frame_3ies:
	.global L_938358
L_938358:
	push_s blink
L_93835a:
	bl.d L_92021c
L_93835e:
	/* _asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_938360:
	push_s r2
L_938362:
	mov_s r14,r3
L_938364:
	mov_s r13,0x8577b8
L_93836a:
	asl r33,r1,0x4
L_93836e:
	ld.as r1,[gp,-0x5]
L_938372:
	add2 r19,r13,0x19
L_938376:
	/* sub_s r1,r1,0x4 */
	.byte 0x64,0xb9
L_938378:
	st.as r1,[gp,-0x5]
L_93837c:
	add2_s r0,r0,r0
L_93837e:
	add_s r0,r0,0x801104
L_938384:
	add r1,r0,0x30
L_938388:
	ldw_s r0,[r0,0x30]
L_93838a:
	add3 r18,r13,0x8
L_93838e:
	bset r34,r0,0x18
L_938392:
	ldw_s r0,[r1,0x2]
L_938394:
	add r17,r13,0x1c
L_938398:
	bset r34,r0,0x18
L_93839c:
	ldw_s r0,[r1,0x4]
L_93839e:
	mov_s r15,r5
L_9383a0:
	bset r34,r0,0x18
L_9383a4:
	ld_s r0,[gp,-0x14]
L_9383a6:
	mov r16,r4
L_9383aa:
	sub_s r0,r0,0xc
L_9383ac:
	st.as r0,[gp,-0x5]
L_9383b0:
	mov_s r0,0x33000443
L_9383b6:
	mov_s r32,r0
L_9383b8:
	st.ab r0,[r25,0x4]
L_9383bc:
	bclr r25,r25,0xa
L_9383c0:
	bl L_925874
L_9383c4:
	ld_s r0,[gp,-0x14]
L_9383c6:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_9383c8:
	st.as r0,[gp,-0x5]
L_9383cc:
	mov_s r0,0x33000123
L_9383d2:
	mov_s r32,r0
L_9383d4:
	st.ab r0,[r25,0x4]
L_9383d8:
	bclr r25,r25,0xa
L_9383dc:
	bl L_925874
L_9383e0:
	mov_s r0,0x886544
L_9383e6:
	ld_s r0,[r0]
L_9383e8:
	mov_s r2,0x886500
L_9383ee:
	bmsk_s r0,r0,0xb
L_9383f0:
	add_s r1,r0,0x1
L_9383f2:
	asl_s r1,r1,0x10
L_9383f4:
	and r1,r1,0xfff0000
L_9383fc:
	bset_s r1,r1,0x1c
L_9383fe:
	st_s r1,[r2,0x44]
L_938400:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_938402:
	bset r34,r0,0x18
L_938406:
	ld_s r0,[gp,-0x14]
L_938408:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_93840a:
	st.as r0,[gp,-0x5]
L_93840e:
	mov_s r0,r13
L_938410:
	bl.d L_9257f4
L_938414:
	ld_s r1,[sp,0x0]
L_938416:
	mov_s r0,0x18
L_938418:
	asl_s r0,r0,0x18
L_93841a:
	mov_s r32,r0
L_93841c:
	st.ab r0,[r25,0x4]
L_938420:
	bclr r25,r25,0xa
L_938424:
	add r0,r16,r14
L_938428:
	add.f 0x0,r0,r15
L_93842c:
	bne_s L_938438
	.global L_93842e
L_93842e:
	bl L_925774
L_938432:
	b.d L_920274
L_938436:
	add_s sp,sp,0x4
	.global L_938438
L_938438:
	ld_s r0,[gp,-0x44]
L_93843a:
	and r0,r0,0xfff0ffff
L_938442:
	st.as r0,[gp,-0x11]
L_938446:
	or r0,r0,0x1d000000
L_93844e:
	mov_s r32,r0
L_938450:
	st.ab r0,[r25,0x4]
L_938454:
	bclr r25,r25,0xa
L_938458:
	nop_s
L_93845a:
	nop_s
L_93845c:
	nop_s
L_93845e:
	lsr r13,r47,0x8
L_938462:
	mov r20,0xfc
L_938466:
	b_s L_93847a
	.global L_938468
L_938468:
	bl.d L_9257f4
L_93846c:
	mov_s r1,r13
L_93846e:
	add r0,r13,r17
L_938472:
	sub_s r14,r14,r13
L_938474:
	lsr r13,r47,0x8
L_938478:
	mov_s r17,r0
	.global L_93847a
L_93847a:
	and r13,r13,r20
L_93847e:
	brlo.d r13,r14,L_938468
L_938482:
	mov_s r0,r17
L_938484:
	bl.d L_9257f4
L_938488:
	mov_s r1,r14
L_93848a:
	b_s L_93849a
	.global L_93848c
L_93848c:
	bl.d L_9257f4
L_938490:
	mov_s r1,r13
L_938492:
	add r18,r18,r13
L_938496:
	sub r16,r16,r13
	.global L_93849a
L_93849a:
	lsr r13,r47,0x8
L_93849e:
	and r13,r13,r20
L_9384a2:
	brlo.d r13,r16,L_93848c
L_9384a6:
	mov_s r0,r18
L_9384a8:
	bl.d L_9257f4
L_9384ac:
	mov_s r1,r16
L_9384ae:
	b_s L_9384bc
	.global L_9384b0
L_9384b0:
	bl.d L_9257f4
L_9384b4:
	mov_s r1,r13
L_9384b6:
	add r19,r19,r13
L_9384ba:
	sub_s r15,r15,r13
	.global L_9384bc
L_9384bc:
	lsr r13,r47,0x8
L_9384c0:
	and r13,r13,r20
L_9384c4:
	brlo.d r13,r15,L_9384b0
L_9384c8:
	mov_s r0,r19
L_9384ca:
	bl.d L_9257f4
L_9384ce:
	mov_s r1,r15
L_9384d0:
	b_s L_93842e
L_9384d2:
	nop_s
