/* handle_rf_sets_info @ 0x8ed5ec, 456 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   handle_rf_sets_info: [i]: Wrong RF sets info; error_ind=%d
 * Зовут его: marlon_r_if_class__load_brd_parameters_section
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, fw_log_emit2, fw_sysassert_fatal, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global handle_rf_sets_info
handle_rf_sets_info:
	.global L_8ed5ec
L_8ed5ec:
	push_s blink
L_8ed5ee:
	bl.d L_8c01b8
L_8ed5f2:
	mov_s r2,0x8
L_8ed5f4:
	sub_s sp,sp,0x14
L_8ed5f6:
	mov_s r15,r0
L_8ed5f8:
	ld_s r0,[r1]
L_8ed5fa:
	mov_s r16,r1
L_8ed5fc:
	add3 r13,r15,r0
L_8ed600:
	mov_s r14,0x857800
L_8ed606:
	sub2 r0,r14,0x1d
L_8ed60a:
	bl.d L_8c0380
L_8ed60e:
	add2 r1,r13,0x19
L_8ed612:
	sub2 r0,r14,0x33
L_8ed616:
	add2 r1,r13,0x1b
L_8ed61a:
	bl.d L_8c0380
L_8ed61e:
	mov_s r2,0x10
L_8ed620:
	ld r1,[r16]
L_8ed624:
	mov r25,0x857780
L_8ed62c:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8ed62e:
	st r1,[r16]
L_8ed632:
	add3 r0,r15,r1
L_8ed636:
	add_s r0,r0,0x5c
L_8ed638:
	mov_s r21,r0
L_8ed63a:
	mov_s r17,r0
L_8ed63c:
	mov_s r1,0x801fa4
L_8ed642:
	ld_s r0,[r1]
L_8ed644:
	mov_s r13,0x0
L_8ed646:
	st_s r0,[sp,0x0]
L_8ed648:
	stb_s r13,[sp,0x4]
L_8ed64a:
	add_s r0,sp,0x4
L_8ed64c:
	st_s r0,[sp,0x8]
L_8ed64e:
	add r0,sp,0x5
L_8ed652:
	st_s r0,[sp,0xc]
L_8ed654:
	ldw_s r0,[r1,0x4]
L_8ed656:
	stb r13,[sp, 0x5]
L_8ed65a:
	stw r0,[sp, 0x10]
L_8ed65e:
	mov_s r24,r15
L_8ed660:
	add r24,r24,0x400
L_8ed664:
	mov_s r19,r15
L_8ed666:
	add r19,r19,0x440
L_8ed66a:
	ldb r23,[r19, 0x1c]
L_8ed66e:
	mov_s r18,r13
L_8ed670:
	b_s L_8ed69a
	.global L_8ed672
L_8ed672:
	ldb r1,[r14, -0x54]
L_8ed676:
	asl_s r2,r2
L_8ed678:
	bset r1,r1,r13
L_8ed67c:
	stb r1,[r14, -0x54]
L_8ed680:
	extw_s r2,r2
L_8ed682:
	mov_s r20,r2
L_8ed684:
	bl.d L_8c0380
L_8ed688:
	mov_s r1,r17
L_8ed68a:
	add r17,r17,r20
	.global L_8ed68e
L_8ed68e:
	and r0,r22,r23
L_8ed692:
	stb r0,[r15, -0x5c]
L_8ed696:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8ed698:
	extw_s r13,r13
	.global L_8ed69a
L_8ed69a:
	brge r13,0x8,L_8ed71c
L_8ed69e:
	mov_s r2,0x0
L_8ed6a0:
	b_s L_8ed6bc
	.global L_8ed6a2
L_8ed6a2:
	add1 r0,sp,r2
L_8ed6a6:
	ldw_s r3,[r0]
L_8ed6a8:
	stb r3,[r1, -0x6c]
L_8ed6ac:
	add2 r1,sp,r2
L_8ed6b0:
	ld_s r1,[r1,0x8]
L_8ed6b2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ed6b4:
	ldb_s r1,[r1]
L_8ed6b6:
	extw_s r2,r2
L_8ed6b8:
	add_s r3,r3,r1
L_8ed6ba:
	stw_s r3,[r0]
	.global L_8ed6bc
L_8ed6bc:
	brge r2,0x2,L_8ed6de
L_8ed6c0:
	add3 r1,r13,r2
L_8ed6c4:
	add_s r1,r1,r14
L_8ed6c6:
	ldb r3,[r1, -0xcc]
L_8ed6ca:
	add r0,sp,r2
L_8ed6ce:
	ldb_s r0,[r0,0x10]
L_8ed6d0:
	stb_s r3,[sp,0x4]
L_8ed6d2:
	cmp_s r3,r0
L_8ed6d4:
	mov.le r0,r3
L_8ed6d8:
	ble_s L_8ed6dc
L_8ed6da:
	stb_s r0,[sp,0x4]
	.global L_8ed6dc
L_8ed6dc:
	brne_s r0,0,L_8ed6a2
	.global L_8ed6de
L_8ed6de:
	breq_s r2,0,L_8ed71c
L_8ed6e0:
	breq r2,0x1,L_8ed720
L_8ed6e4:
	add_s r15,r14,r13
L_8ed6e6:
	ldb r22,[r15, -0x74]
L_8ed6ea:
	breq r22,0x0,L_8ed724
L_8ed6ee:
	ldb r1,[r19, 0x1c]
L_8ed6f2:
	add r18,r18,0x1
L_8ed6f6:
	or r1,r1,r22
L_8ed6fa:
	stb r1,[r19, 0x1c]
L_8ed6fe:
	ldb r2,[r15, -0xc4]
L_8ed702:
	asl_s r0,r13,0x6
L_8ed704:
	add_s r0,r0,0x84783c
L_8ed70a:
	brge.d r2,0x2,L_8ed672
L_8ed70e:
	extw r18,r18
L_8ed712:
	ldb r1,[r15, -0xcc]
L_8ed716:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8ed718:
	stb_s r1,[r0,0x1]
L_8ed71a:
	b_s L_8ed68e
	.global L_8ed71c
L_8ed71c:
	mov_s r3,0x0
L_8ed71e:
	b_s L_8ed726
	.global L_8ed720
L_8ed720:
	mov_s r3,0x1
L_8ed722:
	b_s L_8ed726
	.global L_8ed724
L_8ed724:
	mov_s r3,0x2
	.global L_8ed726
L_8ed726:
	brlt r3,0x1,L_8ed744
L_8ed72a:
	mov_s r1,0x1005374
L_8ed730:
	mov_s r0,0x0
L_8ed732:
	bl.d L_8dcc80
L_8ed736:
	mov_s r2,r13
L_8ed738:
	mov_s r0,blink
L_8ed73a:
	mov_s r1,0x1570
L_8ed740:
	bl L_8c9b28
	.global L_8ed744
L_8ed744:
	brne r18,0x1,L_8ed786
L_8ed748:
	ldb r1,[r25, 0xc]
L_8ed74c:
	mov_s r2,0x0
L_8ed74e:
	b_s L_8ed758
	.global L_8ed750
L_8ed750:
	sub_s r0,r1,0x1
L_8ed752:
	and_s r1,r1,r0
L_8ed754:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ed756:
	extw_s r2,r2
	.global L_8ed758
L_8ed758:
	brne_s r1,0,L_8ed750
L_8ed75a:
	breq r2,0x1,L_8ed78c
L_8ed75e:
	ldb r1,[r14, -0x5c]
L_8ed762:
	mov_s r2,0x0
L_8ed764:
	b_s L_8ed76e
	.global L_8ed766
L_8ed766:
	sub_s r0,r1,0x1
L_8ed768:
	and_s r1,r1,r0
L_8ed76a:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ed76c:
	extw_s r2,r2
	.global L_8ed76e
L_8ed76e:
	brne_s r1,0,L_8ed766
L_8ed770:
	cmp_s r2,0x1
L_8ed772:
	mov.eq r0,blink
L_8ed776:
	mov.eq r1,0x16cc
L_8ed77e:
	bl.eq L_8c9b28
L_8ed782:
	mov_s r1,0x3
L_8ed784:
	b_s L_8ed788
	.global L_8ed786
L_8ed786:
	mov_s r1,0x2
	.global L_8ed788
L_8ed788:
	st r1,[r24, 0x68]
	.global L_8ed78c
L_8ed78c:
	st r18,[r14, -0x98]
L_8ed790:
	ld r1,[r16]
L_8ed794:
	mov_s r0,r17
L_8ed796:
	cmp_s r0,r21
L_8ed798:
	sub.eq r1,r1,0x1
L_8ed79c:
	beq_s L_8ed7aa
L_8ed79e:
	sub r0,r0,r21
L_8ed7a2:
	/* add_s r0,0x7 */
	.byte 0x07,0xe0
L_8ed7a4:
	lsr_s r0,r0,0x3
L_8ed7a6:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8ed7a8:
	add_s r1,r1,r0
	.global L_8ed7aa
L_8ed7aa:
	st r1,[r16]
L_8ed7ae:
	b.d L_8c01fc
L_8ed7b2:
	add_s sp,sp,0x14
