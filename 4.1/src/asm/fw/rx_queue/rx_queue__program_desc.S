/* rx_queue__program_desc @ 0x8df7a4, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_queue.c
 * Зовут его: rx_queue__setup_ring
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, bf_w_s0_w13, bf_w_s21_w5, bf_w_s26_w2, bf_w_s28_w4, fw_sysassert_fatal
 */
	.section .text.rx_queue__program_desc,"ax",@progbits
	.global rx_queue__program_desc
rx_queue__program_desc:
	.global L_8df7a4
L_8df7a4:
	push_s blink
L_8df7a6:
	bl L_8c02ac
L_8df7aa:
	mov_s r13,r0
L_8df7ac:
	mov_s r14,r1
L_8df7ae:
	mov_s r17,r2
L_8df7b0:
	mov_s r16,r3
L_8df7b2:
	mov r19,r4
L_8df7b6:
	mov_s r0,0x886400
L_8df7bc:
	ld_s r0,[r0]
L_8df7be:
	mov r18,r6
L_8df7c2:
	mov_s r15,r5
L_8df7c4:
	mov r20,r7
L_8df7c8:
	bbit1 r0,0xa,L_8df802
	.global L_8df7cc
L_8df7cc:
	bmsk r0,r16,0x0
L_8df7d0:
	asl r4,r0,0x13
L_8df7d4:
	ld_s r2,[r13]
L_8df7d6:
	cmp_s r15,0x0
L_8df7d8:
	mov_s r1,0x1
L_8df7da:
	sub_s.ne r1,r1,r1
L_8df7dc:
	asl_s r1,r1,0x14
L_8df7de:
	bclr_s r2,r2,0x13
L_8df7e0:
	bclr_s r2,r2,0x14
L_8df7e2:
	bclr r0,r4,0x14
L_8df7e6:
	or_s r0,r0,r2
L_8df7e8:
	or_s r0,r0,r1
L_8df7ea:
	st_s r0,[r13]
L_8df7ec:
	brne r14,0x2,L_8df81a
L_8df7f0:
	mov_s r0,0x89
L_8df7f2:
	stb_s r0,[r13,0x1]
L_8df7f4:
	mov_s r0,r13
L_8df7f6:
	mov_s r1,0x8
L_8df7f8:
	bl L_8e8414
L_8df7fc:
	ld_s r0,[r13]
L_8df7fe:
	bset_s r0,r0,0x10
L_8df800:
	b_s L_8df83c
	.global L_8df802
L_8df802:
	breq r16,0x0,L_8df7cc
L_8df806:
	mov_s r0,blink
L_8df808:
	mov_s r2,0x1010150
L_8df80e:
	mov_s r1,0x17
L_8df810:
	bset_s r1,r1,0xc
L_8df812:
	bl.d L_8c82c0
L_8df816:
	mov_s r3,0xb8
L_8df818:
	b_s L_8df7cc
	.global L_8df81a
L_8df81a:
	brne r14,0x3,L_8df828
L_8df81e:
	mov_s r0,0xcb
L_8df820:
	stb_s r0,[r13,0x1]
L_8df822:
	mov_s r0,r13
L_8df824:
	mov_s r1,0x0
L_8df826:
	b_s L_8df834
	.global L_8df828
L_8df828:
	mov_s r0,0xdf
L_8df82a:
	stb_s r0,[r13,0x1]
L_8df82c:
	asl_s r1,r15,0x3
L_8df82e:
	add1_s r1,r1,r1
L_8df830:
	bmsk_s r1,r1,0x4
L_8df832:
	mov_s r0,r13
	.global L_8df834
L_8df834:
	bl L_8e8414
L_8df838:
	ld_s r0,[r13]
L_8df83a:
	bclr_s r0,r0,0x10
	.global L_8df83c
L_8df83c:
	st_s r0,[r13]
L_8df83e:
	bmsk_s r15,r15,0x0
L_8df840:
	asl_s r15,r15,0x11
L_8df842:
	bclr_s r0,r0,0x11
L_8df844:
	bclr_s r0,r0,0x12
L_8df846:
	bset_s r0,r0,0x12
L_8df848:
	or_s r15,r15,r0
L_8df84a:
	bmsk r0,r19,0x0
L_8df84e:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_8df850:
	bmsk r1,r20,0x0
L_8df854:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8df856:
	bic r15,r15,0xc0
L_8df85a:
	or_s r0,r0,r15
L_8df85c:
	or_s r0,r0,r1
L_8df85e:
	bset_s r0,r0,0x5
L_8df860:
	st_s r0,[r13]
L_8df862:
	mov_s r0,r13
L_8df864:
	mov_s r1,0x1
L_8df866:
	bl.d L_8e8480
L_8df86a:
	cmp_s r14,0x3
L_8df86c:
	bmsk r1,r18,0x1
L_8df870:
	bl L_8e8468
L_8df874:
	bmsk r1,r17,0xc
L_8df878:
	add_s r0,r13,0x4
L_8df87a:
	bl L_8e8324
L_8df87e:
	bne_s L_8df886
L_8df880:
	ld_s r0,[r13,0x4]
L_8df882:
	bset_s r0,r0,0xe
L_8df884:
	st_s r0,[r13,0x4]
	.global L_8df886
L_8df886:
	b L_8c0304
L_8df88a:
	nop_s
