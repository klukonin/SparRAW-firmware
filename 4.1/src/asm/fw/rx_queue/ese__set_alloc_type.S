/* ese__set_alloc_type @ 0x8df680, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: parse_ese
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_h_s0_w3, bf_w_s3_w29, memset0_words
 * Глобалы (через gp): 0x800294
 */
	.section .text.ese__set_alloc_type,"ax",@progbits
	.global ese__set_alloc_type
ese__set_alloc_type:
	.global L_8df680
L_8df680:
	push_s blink
L_8df682:
	bl L_8c02bc
L_8df686:
	mov_s r13,r0
L_8df688:
	mov_s r16,r1
L_8df68a:
	mov_s r14,r2
L_8df68c:
	mov_s r15,0x0
L_8df68e:
	bl.d L_8c1a78
L_8df692:
	mov_s r1,0x10
L_8df694:
	st_s r15,[r13]
L_8df696:
	brhs.d r14,0x5,L_8df6ce
L_8df69a:
	stw_s r15,[r13,0x4]
L_8df69c:
	ldb.x r14,[0x80229c,r14]
L_8df6a4:
	add r1,pcl,0xa
L_8df6a8:
	add1_s r1,r1,r14
L_8df6aa:
	j_s.d [r1]
L_8df6ac:
	ld_s r0,[r13,0xc]
L_8df6ae:
	bclr_s r0,r0,0x17
L_8df6b0:
	bclr_s r0,r0,0x18
L_8df6b2:
	bclr_s r0,r0,0x19
	.global L_8df6b4
L_8df6b4:
	st_s r0,[r13,0xc]
L_8df6b6:
	bclr_s r0,r0,0x1a
L_8df6b8:
	st_s r0,[r13,0xc]
L_8df6ba:
	b_s L_8df6ce
L_8df6bc:
	bset_s r0,r0,0x17
L_8df6be:
	bset_s r0,r0,0x18
L_8df6c0:
	bset_s r0,r0,0x19
L_8df6c2:
	b_s L_8df6b4
L_8df6c4:
	or r0,r0,0x7800000
L_8df6cc:
	st_s r0,[r13,0xc]
	.global L_8df6ce
L_8df6ce:
	add_s r0,r13,0x6
L_8df6d0:
	mov_s r1,0x0
L_8df6d2:
	bl.d L_8e82ac
L_8df6d6:
	cmp r16,0x2
L_8df6da:
	mov_s r0,0x1
L_8df6dc:
	sub_s.ne r0,r0,r0
L_8df6de:
	ld_s r2,[r13,0x8]
L_8df6e0:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8df6e2:
	bic r2,r2,0x5
L_8df6e6:
	bclr_s r0,r0,0x0
L_8df6e8:
	or_s r2,r2,r0
L_8df6ea:
	ld_s r0,[gp,0x124]
L_8df6ec:
	st_s r2,[r13,0x8]
L_8df6ee:
	bmsk_s r0,r0,0x0
L_8df6f0:
	asl_s r0,r0
L_8df6f2:
	bclr_s r2,r2,0x1
L_8df6f4:
	or_s r0,r0,r2
L_8df6f6:
	st_s r0,[r13,0x8]
L_8df6f8:
	add r0,r13,0x8
L_8df6fc:
	bl L_8e84bc
L_8df700:
	b L_8c0324
