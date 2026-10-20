/* pbss_sta_list_update @ 0x8d5560, 572 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, add_pbss_dmg_capinfo_list, conn_mgr__by_cid, log_hexdump, memcpy_fw, pbss__add_sta, pbss__del_sta, pbss__sta_entry_flag, pbss__sta_flags_ptr
 */
	.section .text.pbss_sta_list_update,"ax",@progbits
	.global pbss_sta_list_update
pbss_sta_list_update:
	.global L_8d5560
L_8d5560:
	push_s blink
L_8d5562:
	bl L_8c02b4
L_8d5566:
	sub_s sp,sp,0x38
L_8d5568:
	mov_s r15,r0
L_8d556a:
	mov_s r13,r1
L_8d556c:
	bl.d L_8c9e44
L_8d5570:
	mov_s r0,r2
L_8d5572:
	mov_s r16,r0
L_8d5574:
	sub r17,r13,0x2
L_8d5578:
	extw r17,r17
L_8d557c:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8d557e:
	mov_s r0,r15
L_8d5580:
	bl.d L_8c7f90
L_8d5584:
	mov_s r1,r17
L_8d5586:
	cmp r16,0x0
L_8d558a:
	beq L_8d5796
L_8d558e:
	ld r13,[r16, 0xc]
L_8d5592:
	add r14,r16,0x10
L_8d5596:
	add_s r0,sp,0x30
L_8d5598:
	mov_s r1,r15
L_8d559a:
	bl.d L_8c0460
L_8d559e:
	mov_s r2,0x6
L_8d55a0:
	add r18,r15,0x6
L_8d55a4:
	sub r17,r17,0x6
L_8d55a8:
	extw r17,r17
L_8d55ac:
	mov_s r15,0x0
L_8d55ae:
	b_s L_8d55b8
	.global L_8d55b0
L_8d55b0:
	mov_s r0,0x0
	.global L_8d55b2
L_8d55b2:
	stb r0,[r1, 0x28]
L_8d55b6:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8d55b8
L_8d55b8:
	brge r15,0x8,L_8d55d0
L_8d55bc:
	add3 r0,r13,0x9
L_8d55c0:
	bl.d L_8ca7c4
L_8d55c4:
	extw_s r1,r15
L_8d55c6:
	add r1,sp,r15
L_8d55ca:
	breq_s r0,0,L_8d55b0
L_8d55cc:
	mov_s r0,0x3
L_8d55ce:
	b_s L_8d55b2
	.global L_8d55d0
L_8d55d0:
	mov_s r15,sp
L_8d55d2:
	mov_s r0,r15
L_8d55d4:
	add r1,r18,0x2
L_8d55d8:
	bl.d L_8c0460
L_8d55dc:
	mov_s r2,0x11
L_8d55de:
	mov_s r0,r15
L_8d55e0:
	bl.d L_8c7f90
L_8d55e4:
	mov_s r1,0x11
L_8d55e6:
	ldb r0,[sp, 0x6]
L_8d55ea:
	cmp_s r0,0x8
L_8d55ec:
	bge L_8d5796
L_8d55f0:
	add_s r13,r13,0x48
L_8d55f2:
	mov_s r0,r13
L_8d55f4:
	bl.d L_8c2498
L_8d55f8:
	mov_s r1,r15
L_8d55fa:
	cmp_s r0,0x0
L_8d55fc:
	ldb r1,[sp, 0x6]
L_8d5600:
	add_s r1,r1,sp
L_8d5602:
	beq_s L_8d571e
L_8d5604:
	mov_s r0,0x80047c
L_8d560a:
	ldb_s r3,[r0]
L_8d560c:
	ldb_s r2,[sp,0x0]
L_8d560e:
	brne r3,r2,L_8d5642
L_8d5612:
	ldb_s r15,[r0,0x1]
L_8d5614:
	ldb r3,[sp, 0x1]
L_8d5618:
	brne r15,r3,L_8d5642
L_8d561c:
	ldb_s r15,[r0,0x2]
L_8d561e:
	ldb r3,[sp, 0x2]
L_8d5622:
	brne r15,r3,L_8d5642
L_8d5626:
	ldb_s r15,[r0,0x3]
L_8d5628:
	ldb r3,[sp, 0x3]
L_8d562c:
	brne r15,r3,L_8d5642
L_8d5630:
	ldb_s r15,[r0,0x4]
L_8d5632:
	ldb_s r3,[sp,0x4]
L_8d5634:
	brne r15,r3,L_8d5642
L_8d5638:
	ldb_s r3,[r0,0x5]
L_8d563a:
	ldb r0,[sp, 0x5]
L_8d563e:
	breq r3,r0,L_8d571e
	.global L_8d5642
L_8d5642:
	ldb_s r0,[r14]
L_8d5644:
	brne r2,r0,L_8d5722
L_8d5648:
	ldb_s r2,[r14,0x1]
L_8d564a:
	ldb r0,[sp, 0x1]
L_8d564e:
	brne r0,r2,L_8d5722
L_8d5652:
	ldb_s r2,[r14,0x2]
L_8d5654:
	ldb r0,[sp, 0x2]
L_8d5658:
	brne r0,r2,L_8d5722
L_8d565c:
	ldb_s r2,[r14,0x3]
L_8d565e:
	ldb r0,[sp, 0x3]
L_8d5662:
	brne r0,r2,L_8d5722
L_8d5666:
	ldb_s r2,[r14,0x4]
L_8d5668:
	ldb_s r0,[sp,0x4]
L_8d566a:
	brne r0,r2,L_8d5722
L_8d566e:
	ldb_s r2,[r14,0x5]
L_8d5670:
	ldb r0,[sp, 0x5]
L_8d5674:
	brne r0,r2,L_8d5722
L_8d5678:
	b_s L_8d571e
	.global L_8d567a
L_8d567a:
	add_s r15,sp,0x14
L_8d567c:
	mov_s r0,r15
L_8d567e:
	add r1,r18,0x2
L_8d5682:
	bl.d L_8c0460
L_8d5686:
	mov_s r2,0x11
L_8d5688:
	ldb r0,[sp, 0x1a]
L_8d568c:
	cmp_s r0,0x8
L_8d568e:
	bge L_8d5796
L_8d5692:
	mov_s r0,r15
L_8d5694:
	bl.d L_8c7f90
L_8d5698:
	mov_s r1,0x11
L_8d569a:
	mov_s r0,r13
L_8d569c:
	bl.d L_8c2498
L_8d56a0:
	mov_s r1,r15
L_8d56a2:
	ldb r1,[sp, 0x1a]
L_8d56a6:
	add_s r1,r1,sp
L_8d56a8:
	breq_s r0,0,L_8d571e
L_8d56aa:
	mov_s r0,0x80047c
L_8d56b0:
	ldb_s r3,[r0]
L_8d56b2:
	ldb_s r2,[sp,0x14]
L_8d56b4:
	brne r3,r2,L_8d56e8
L_8d56b8:
	ldb_s r15,[r0,0x1]
L_8d56ba:
	ldb r3,[sp, 0x15]
L_8d56be:
	brne r15,r3,L_8d56e8
L_8d56c2:
	ldb_s r15,[r0,0x2]
L_8d56c4:
	ldb r3,[sp, 0x16]
L_8d56c8:
	brne r15,r3,L_8d56e8
L_8d56cc:
	ldb_s r15,[r0,0x3]
L_8d56ce:
	ldb r3,[sp, 0x17]
L_8d56d2:
	brne r15,r3,L_8d56e8
L_8d56d6:
	ldb_s r15,[r0,0x4]
L_8d56d8:
	ldb_s r3,[sp,0x18]
L_8d56da:
	brne r15,r3,L_8d56e8
L_8d56de:
	ldb_s r3,[r0,0x5]
L_8d56e0:
	ldb r0,[sp, 0x19]
L_8d56e4:
	breq r3,r0,L_8d571e
	.global L_8d56e8
L_8d56e8:
	ldb_s r0,[r14]
L_8d56ea:
	brne r0,r2,L_8d5722
L_8d56ee:
	ldb_s r2,[r14,0x1]
L_8d56f0:
	ldb r0,[sp, 0x15]
L_8d56f4:
	brne r2,r0,L_8d5722
L_8d56f8:
	ldb_s r2,[r14,0x2]
L_8d56fa:
	ldb r0,[sp, 0x16]
L_8d56fe:
	brne r2,r0,L_8d5722
L_8d5702:
	ldb_s r2,[r14,0x3]
L_8d5704:
	ldb r0,[sp, 0x17]
L_8d5708:
	brne r2,r0,L_8d5722
L_8d570c:
	ldb_s r2,[r14,0x4]
L_8d570e:
	ldb_s r0,[sp,0x18]
L_8d5710:
	brne r2,r0,L_8d5722
L_8d5714:
	ldb_s r2,[r14,0x5]
L_8d5716:
	ldb r0,[sp, 0x19]
L_8d571a:
	brne r2,r0,L_8d5722
	.global L_8d571e
L_8d571e:
	mov_s r0,0x1
L_8d5720:
	b_s L_8d5724
	.global L_8d5722
L_8d5722:
	mov_s r0,0x2
	.global L_8d5724
L_8d5724:
	sub r17,r17,0x13
L_8d5728:
	extw r17,r17
L_8d572c:
	stb r0,[r1, 0x28]
L_8d5730:
	brlo.d r17,0x11,L_8d5742
L_8d5734:
	add r18,r18,0x13
L_8d5738:
	ldb r0,[r18]
L_8d573c:
	cmp r0,0x94
L_8d5740:
	beq_s L_8d567a
	.global L_8d5742
L_8d5742:
	mov_s r14,0x0
L_8d5744:
	b_s L_8d575a
	.global L_8d5746
L_8d5746:
	breq_s r0,0,L_8d5758
L_8d5748:
	extw_s r1,r14
L_8d574a:
	bl.d L_8ca7c4
L_8d574e:
	mov_s r0,r13
L_8d5750:
	mov_s r1,r0
L_8d5752:
	bl.d L_8dc0a0
L_8d5756:
	mov_s r0,r16
	.global L_8d5758
L_8d5758:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8d575a
L_8d575a:
	brge r14,0x8,L_8d5796
L_8d575e:
	add r1,sp,r14
L_8d5762:
	ldb r1,[r1, 0x28]
L_8d5766:
	cmp_s r1,0x0
L_8d5768:
	cmp.ne r1,0x1
L_8d576c:
	beq_s L_8d5758
L_8d576e:
	mov_s r0,0x80345c
L_8d5774:
	ld_s r0,[r0,0xc]
L_8d5776:
	breq r1,0x2,L_8d5746
L_8d577a:
	breq_s r0,0,L_8d578c
L_8d577c:
	extw_s r1,r14
L_8d577e:
	bl.d L_8ca7c4
L_8d5782:
	mov_s r0,r13
L_8d5784:
	mov_s r1,r0
L_8d5786:
	bl.d L_8dc0f4
L_8d578a:
	mov_s r0,r16
	.global L_8d578c
L_8d578c:
	extb_s r1,r14
L_8d578e:
	bl.d L_8de3c8
L_8d5792:
	mov_s r0,r13
L_8d5794:
	b_s L_8d5758
	.global L_8d5796
L_8d5796:
	b.d L_8c0314
L_8d579a:
	add_s sp,sp,0x38
