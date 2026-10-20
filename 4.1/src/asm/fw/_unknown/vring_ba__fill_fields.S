/* vring_ba__fill_fields @ 0x8c45c8, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_ba__build_cfg
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bf_w_s0_w2, bf_w_s2_w2, bf_w_s4_w3, bf_w_s4_w5
 */
	.section .text.vring_ba__fill_fields,"ax",@progbits
	.global vring_ba__fill_fields
vring_ba__fill_fields:
	.global L_8c45c8
L_8c45c8:
	push_s blink
L_8c45ca:
	bl.d L_8c02b4
L_8c45ce:
	mov_s r7,r0
L_8c45d0:
	sub_s sp,sp,0x8
L_8c45d2:
	mov_s r14,r1
L_8c45d4:
	mov_s r13,r2
L_8c45d6:
	mov_s r15,0x0
L_8c45d8:
	stw r15,[sp, 0x4]
L_8c45dc:
	stw r15,[sp, 0x6]
L_8c45e0:
	bmsk r1,r13,0x2
L_8c45e4:
	add_s r0,sp,0x4
L_8c45e6:
	bl.d L_8e84ec
L_8c45ea:
	st_s r15,[sp,0x0]
L_8c45ec:
	mov_s r1,r15
L_8c45ee:
	bl.d L_8e8330
L_8c45f2:
	mov r17,r6
L_8c45f6:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8c45f8:
	mov r16,r4
L_8c45fc:
	brhs.d r13,0x6,L_8c462c
L_8c4600:
	mov_s r2,r5
L_8c4602:
	ldb.x r13,[0x801f5c,r13]
L_8c460a:
	add r0,pcl,0xa
L_8c460e:
	add1_s r0,r0,r13
L_8c4610:
	j_s [r0]
L_8c4612:
	bmsk r1,r3,0x1
L_8c4616:
	mov_s r0,sp
L_8c4618:
	bl.d L_8e84a4
L_8c461c:
	mov_s r15,0x1
L_8c461e:
	bmsk r1,r14,0x4
L_8c4622:
	bl L_8e8504
L_8c4626:
	b_s L_8c462c
L_8c4628:
	st r16,[sp]
	.global L_8c462c
L_8c462c:
	ldw r0,[sp, 0x4]
L_8c4630:
	mov_s r3,0x886600
L_8c4636:
	asl_s r0,r0,0x10
L_8c4638:
	st_s r0,[r3,0xc]
L_8c463a:
	brlo.d r2,0x1,L_8c469e
L_8c463e:
	mov_s r13,0x0
L_8c4640:
	mov_s r14,r7
	.global L_8c4642
L_8c4642:
	mov_s r18,r2
L_8c4644:
	add r1,r13,r16
L_8c4648:
	cmp_s r15,0x0
L_8c464a:
	bmsk.ne r1,r1,0x1
L_8c464e:
	mov.ne r0,sp
L_8c4652:
	bl.ne L_8e8330
L_8c4656:
	bne_s L_8c465a
L_8c4658:
	st_s r1,[sp,0x0]
	.global L_8c465a
L_8c465a:
	ld_s r0,[sp,0x0]
L_8c465c:
	st_s r0,[r3,0x10]
L_8c465e:
	st 0x40000000,[r3, 0x8]
L_8c4666:
	sync
	.global L_8c466a
L_8c466a:
	mov_s r3,0x886600
L_8c4670:
	ld_s r0,[r3,0x8]
L_8c4672:
	bbit1 r0,0x1d,L_8c466a
L_8c4676:
	mov_s r0,0x0
L_8c4678:
	cmp r17,0x0
L_8c467c:
	mov.hi lp_count,r17
L_8c4680:
	lphi L_8c4694
L_8c4684:
	mov_s r1,0x886614
L_8c468a:
	ld.as r1,[r1,r0]
L_8c468e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c4690:
	st.ab r1,[r14,0x4]
	.global L_8c4694
L_8c4694:
	sub r2,r18,0x1
L_8c4698:
	/* brhs.d r2,0x1,0x008c4642 */
	.byte 0xab,0x0a,0x75,0x80
L_8c469c:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c469e
L_8c469e:
	b.d L_8c0314
L_8c46a2:
	add_s sp,sp,0x8
