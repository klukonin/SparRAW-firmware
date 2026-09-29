/* rx_queue__config_by_kind @ 0x8df50c, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_queue.c
 * Зовут его: rx_chain__configure
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bf_w_s0_w12, bf_w_s0_w4, bf_w_s16_w12, bf_w_s16_w7, bf_w_s4_w4, bf_w_s8_w12, fw_sysassert_fatal, get_g_800374, memset0_words
 * Глобалы (через gp): 0x800294
 */
	.section .text.rx_queue__config_by_kind,"ax",@progbits
	.global rx_queue__config_by_kind
rx_queue__config_by_kind:
	.global L_8df50c
L_8df50c:
	push_s blink
L_8df50e:
	bl L_8c02b4
L_8df512:
	mov_s r14,r0
L_8df514:
	mov_s r16,r2
L_8df516:
	mov_s r17,r3
L_8df518:
	mov_s r15,r4
L_8df51a:
	mov r18,r5
L_8df51e:
	brne r6,0x0,L_8df54a
L_8df522:
	brhs r1,0x6,L_8df5b8
L_8df526:
	ldb.x r1,[0x8022a4,r1]
L_8df52e:
	add r0,pcl,0xa
L_8df532:
	add1_s r0,r0,r1
L_8df534:
	j_s [r0]
L_8df536:
	bl L_8ca0c4
L_8df53a:
	mov_s r13,0x2
L_8df53c:
	brne_s r0,0,L_8df54c
	.global L_8df53e
L_8df53e:
	mov_s r13,0x1
L_8df540:
	b_s L_8df54c
L_8df542:
	ld_s r0,[gp,0x124]
L_8df544:
	breq_s r0,0,L_8df53e
L_8df546:
	mov_s r13,0x4
L_8df548:
	b_s L_8df54c
	.global L_8df54a
L_8df54a:
	mov_s r13,0x0
	.global L_8df54c
L_8df54c:
	mov_s r0,r14
L_8df54e:
	bl.d L_8c1a78
L_8df552:
	mov_s r1,0x30
L_8df554:
	bmsk r1,r13,0x3
L_8df558:
	mov_s r0,r14
L_8df55a:
	bl.d L_8e8348
L_8df55e:
	mov_s r3,0x0
L_8df560:
	bmsk r1,r16,0x3
L_8df564:
	bl.d L_8e84f8
L_8df568:
	bmsk r2,r17,0xb
L_8df56c:
	mov_s r1,r2
L_8df56e:
	bl.d L_8e8540
L_8df572:
	stb_s r3,[r14,0x3]
L_8df574:
	add r0,r15,r17
L_8df578:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8df57a:
	bmsk r4,r0,0xb
L_8df57e:
	add_s r0,r14,0x4
L_8df580:
	mov_s r1,r4
L_8df582:
	bl.d L_8e8318
L_8df586:
	cmp_s r13,0x4
L_8df588:
	mov_s r1,r2
L_8df58a:
	bl L_8e83c0
L_8df58e:
	add r0,r14,0x8
L_8df592:
	mov_s r1,r4
L_8df594:
	bl L_8e8318
L_8df598:
	bmsk r1,r15,0x6
L_8df59c:
	bl L_8e83e4
L_8df5a0:
	stb_s r3,[r14,0xb]
L_8df5a2:
	stb_s r3,[r14,0xc]
L_8df5a4:
	stb_s r3,[r14,0xd]
L_8df5a6:
	stb_s r3,[r14,0xe]
L_8df5a8:
	bne_s L_8df5e0
L_8df5aa:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8df5ac:
	brlt r18,r15,L_8df5ce
	.global L_8df5b0
L_8df5b0:
	b.d L_8c0314
L_8df5b4:
	stb r18,[r14, 0xf]
	.global L_8df5b8
L_8df5b8:
	mov_s r0,blink
L_8df5ba:
	mov_s r2,0x1010150
L_8df5c0:
	mov_s r1,0x18
L_8df5c2:
	bset_s r1,r1,0xc
L_8df5c4:
	bl.d L_8c82c0
L_8df5c8:
	mov r3,0x17e
L_8df5cc:
	b_s L_8df54a
	.global L_8df5ce
L_8df5ce:
	mov_s r0,blink
L_8df5d0:
	mov_s r2,0x1010150
L_8df5d6:
	mov_s r1,0x19
L_8df5d8:
	bset_s r1,r1,0xc
L_8df5da:
	mov r3,0x1ad
L_8df5de:
	b_s L_8df5f6
	.global L_8df5e0
L_8df5e0:
	asl_s r15,r15
L_8df5e2:
	brge r18,r15,L_8df5b0
L_8df5e6:
	mov_s r0,blink
L_8df5e8:
	mov_s r2,0x1010150
L_8df5ee:
	mov_s r1,0x1a
L_8df5f0:
	bset_s r1,r1,0xc
L_8df5f2:
	mov r3,0x1b2
	.global L_8df5f6
L_8df5f6:
	bl L_8c82c0
L_8df5fa:
	b_s L_8df5b0
