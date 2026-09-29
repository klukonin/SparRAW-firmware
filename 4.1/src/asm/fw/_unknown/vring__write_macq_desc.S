/* vring__write_macq_desc @ 0x8c4768, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open, sw_vring__ba_agreed, tail_vring__write_macq_desc, tail_vring__write_macq_desc_8df898, tail_vring__write_macq_desc_8df8a4, tx_macq__is_empty, vring__on_macq_delete_ntf, vring__program_macq_and_ba, vring__read_macq_stats, vring__wait_macq_delete
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s0_w2, bf_w_s2_w2, bf_w_s4_w3, bf_w_s4_w5
 */
	.section .text.vring__write_macq_desc,"ax",@progbits
	.global vring__write_macq_desc
vring__write_macq_desc:
	.global L_8c4768
L_8c4768:
	push_s blink
L_8c476a:
	bl.d L_8c02bc
L_8c476e:
	mov_s r5,r1
L_8c4770:
	sub_s sp,sp,0x8
L_8c4772:
	mov_s r14,r0
L_8c4774:
	mov_s r16,r3
L_8c4776:
	mov_s r13,0x0
L_8c4778:
	stw r13,[sp, 0x4]
L_8c477c:
	stw r13,[sp, 0x6]
L_8c4780:
	bmsk r1,r2,0x2
L_8c4784:
	add_s r0,sp,0x4
L_8c4786:
	bl.d L_8e84ec
L_8c478a:
	st_s r13,[sp,0x0]
L_8c478c:
	mov_s r1,r13
L_8c478e:
	bl.d L_8e8330
L_8c4792:
	mov.f r15,r4
L_8c4796:
	bmsk r1,r16,0x1
L_8c479a:
	mov_s r0,sp
L_8c479c:
	bl L_8e84a4
L_8c47a0:
	bmsk r1,r5,0x4
L_8c47a4:
	bl L_8e8504
L_8c47a8:
	ldw r0,[sp, 0x4]
L_8c47ac:
	mov_s r2,0x886600
L_8c47b2:
	asl_s r0,r0,0x10
L_8c47b4:
	st_s r0,[r2,0xc]
L_8c47b6:
	beq_s L_8c4810
	.global L_8c47b8
L_8c47b8:
	bmsk r1,r13,0x1
L_8c47bc:
	mov_s r0,sp
L_8c47be:
	bl L_8e8330
L_8c47c2:
	ld_s r0,[sp,0x0]
L_8c47c4:
	st_s r0,[r2,0x10]
L_8c47c6:
	st 0x40000000,[r2, 0x8]
L_8c47ce:
	sync
	.global L_8c47d2
L_8c47d2:
	mov_s r2,0x886600
L_8c47d8:
	ld_s r0,[r2,0x8]
L_8c47da:
	bbit1 r0,0x1d,L_8c47d2
L_8c47de:
	cmp r16,0x2
L_8c47e2:
	mov_s r0,0x1
L_8c47e4:
	sub.eq r0,r0,r0
L_8c47e8:
	mov_s r1,0x2
L_8c47ea:
	add1_s r1,r1,r0
L_8c47ec:
	mov_s r0,0x0
L_8c47ee:
	cmp_s r1,0x0
L_8c47f0:
	mov.hi lp_count,r1
L_8c47f4:
	lphi L_8c4808
L_8c47f8:
	mov_s r1,0x886614
L_8c47fe:
	ld.as r1,[r1,r0]
L_8c4802:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c4804:
	st.ab r1,[r14,0x4]
	.global L_8c4808
L_8c4808:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8c480a:
	/* brhs.d r15,0x1,0x008c47b8 */
	.byte 0xb1,0x0f,0x75,0x90
L_8c480e:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c4810
L_8c4810:
	b.d L_8c0324
L_8c4814:
	add_s sp,sp,0x8
L_8c4816:
	nop_s
