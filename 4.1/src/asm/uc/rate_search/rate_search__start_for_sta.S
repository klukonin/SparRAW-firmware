/* rate_search__start_for_sta @ 0x92c34c, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rate_search.c
 * Зовут его: bf_sm__start_request, ucode_cmd_0x12_handler, ucode_cmd_0x30_handler, ucode_cmd__rs_enable
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, get_g_80051c, mac__program_qset_slots, memset0_words_uc, rate_search__build_mcs_mask, rate_search__step, uc_sysassert
 */
	.section .text.rate_search__start_for_sta,"ax",@progbits
	.global rate_search__start_for_sta
rate_search__start_for_sta:
	.global L_92c34c
L_92c34c:
	push_s blink
L_92c34e:
	bl L_920210
L_92c352:
	sub_s sp,sp,0x4
L_92c354:
	mov_s r13,r0
L_92c356:
	mov_s r14,r1
L_92c358:
	breq r0,0x8,L_92c362
L_92c35c:
	bl L_92c30c
L_92c360:
	brne_s r0,0,L_92c366
	.global L_92c362
L_92c362:
	mov_s r0,0x0
L_92c364:
	b_s L_92c41a
	.global L_92c366
L_92c366:
	brne_s r14,0,L_92c362
L_92c368:
	asl_s r14,r13,0x2
L_92c36a:
	add1_s r14,r14,r14
L_92c36c:
	add_s r14,r14,0x8016d8
L_92c372:
	ld_s r0,[r14]
L_92c374:
	brne r0,0x0,L_92c420
	.global L_92c378
L_92c378:
	mov_s r0,0x1f000601
L_92c37e:
	mov_s r32,r0
L_92c380:
	st.ab r0,[r25,0x4]
L_92c384:
	bclr r25,r25,0xa
L_92c388:
	bl L_928308
L_92c38c:
	mov_s r1,0x801958
L_92c392:
	add2_s r1,r1,r13
L_92c394:
	ld_s r0,[r1,0x70]
L_92c396:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c398:
	st_s r0,[r1,0x70]
L_92c39a:
	lr r0,[0xa]
L_92c39e:
	st_s r0,[sp,0x0]
L_92c3a0:
	bclr_s r0,r0,0x1
L_92c3a2:
	flag r0
L_92c3a6:
	mul64 r13,0x2c
L_92c3aa:
	add r15,mlo,0x801738
L_92c3b2:
	mov_s r0,r15
L_92c3b4:
	bl.d L_92166c
L_92c3b8:
	mov_s r1,0x2c
L_92c3ba:
	mov_s r0,r14
L_92c3bc:
	bl.d L_92166c
L_92c3c0:
	mov_s r1,0xc
L_92c3c2:
	mov_s r0,0x1
L_92c3c4:
	st_s r0,[r14]
L_92c3c6:
	stb_s r0,[r15,0x1e]
L_92c3c8:
	bl.d L_92c1fc
L_92c3cc:
	extb_s r0,r13
L_92c3ce:
	stb_s r0,[r15,0x1c]
L_92c3d0:
	add r0,r15,0x24
L_92c3d4:
	bl.d L_92166c
L_92c3d8:
	mov_s r1,0x8
L_92c3da:
	lr r1,[0xa]
L_92c3de:
	ld_s r0,[sp,0x0]
L_92c3e0:
	bic r0,r0,-0x3
L_92c3e4:
	or_s r0,r0,r1
L_92c3e6:
	flag r0
L_92c3ea:
	mov_s r0,0x800658
L_92c3f0:
	ldb_s r0,[r0,r13]
L_92c3f2:
	bbit0 r0,0x7,L_92c418
L_92c3f6:
	mov_s r1,0x1
L_92c3f8:
	mov_s r0,0x0
L_92c3fa:
	bset r0,r0,r13
L_92c3fe:
	st.as r0,[gp,-0x2]
L_92c402:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_92c404:
	add1_s r13,r13,r13
L_92c406:
	add_s r13,r13,0x8016d8
L_92c40c:
	st_s r1,[r13,0x4]
L_92c40e:
	st_s r1,[r13,0x8]
L_92c410:
	mov_s r0,0x0
L_92c412:
	bl.d L_92c05c
L_92c416:
	st_s r0,[r13]
	.global L_92c418
L_92c418:
	mov_s r0,0x1
	.global L_92c41a
L_92c41a:
	b.d L_92027c
L_92c41e:
	add_s sp,sp,0x4
	.global L_92c420
L_92c420:
	mov_s r0,blink
L_92c422:
	mov_s r2,0x10016ac
L_92c428:
	mov_s r1,0x66
L_92c42a:
	bl.d L_925548
L_92c42e:
	mov_s r3,0xdf
L_92c430:
	b_s L_92c378
L_92c432:
	nop_s
