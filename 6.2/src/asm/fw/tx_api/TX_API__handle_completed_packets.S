/* TX_API__handle_completed_packets @ 0x8cd5dc, 328 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::handle_completed_packets() - m_pending_peer_pm_list.add2tail(0x%x)
 * Зовут его: TX_CTRL_API__flush_connection, tx_desc__init_32
 * Зовёт сам: FWQ_TX_AVAILABILITY__remove_packet, TX_API__free_memory, __ld_r18_to_r13_ret, __st_r18_to_r13, conn_mgr__by_cid, fw_log_emit1, fw_sysassert_fatal, list__find_entry_d, llist__init, llist__pop_front, tx_api__call_vmethod_04, tx_api__count_completion_status
 * Глобалы (через gp): 0x80041c, 0x800480
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__handle_completed_packets
TX_API__handle_completed_packets:
	.global L_8cd5dc
L_8cd5dc:
	push_s blink
L_8cd5de:
	bl L_8c01d4
L_8cd5e2:
	sub_s sp,sp,0x14
L_8cd5e4:
	mov_s r15,r0
L_8cd5e6:
	mov_s r0,sp
L_8cd5e8:
	bl.d L_8e293c
L_8cd5ec:
	mov_s r17,r0
L_8cd5ee:
	mov_s r0,r15
L_8cd5f0:
	bl.d L_8cc748
L_8cd5f4:
	mov_s r1,r17
L_8cd5f6:
	b_s L_8cd708
	.global L_8cd5f8
L_8cd5f8:
	bl.d L_8e2674
L_8cd5fc:
	mov_s r0,r17
L_8cd5fe:
	mov.f r14,r0
L_8cd602:
	add_s r13,sp,0xc
L_8cd604:
	beq_s L_8cd636
	.global L_8cd606
L_8cd606:
	st_s r14,[r13]
L_8cd608:
	add r0,r14,0x24
L_8cd60c:
	st_s r0,[r13,0x4]
L_8cd60e:
	ldb_s r13,[r14,0x11]
L_8cd610:
	mov_s r0,r15
L_8cd612:
	bl.d L_8ead70
L_8cd616:
	mov_s r1,r13
L_8cd618:
	mov_s r0,0x842274
L_8cd61e:
	brne r15,r0,L_8cd67e
L_8cd622:
	brhs r13,0x5,L_8cd67e
L_8cd626:
	ldb.x r13,[0x8031b8,r13]
L_8cd62e:
	add r0,pcl,0xa
L_8cd632:
	add1_s r0,r0,r13
L_8cd634:
	j_s [r0]
	.global L_8cd636
L_8cd636:
	mov_s r0,blink
L_8cd638:
	mov_s r1,0x11d6
L_8cd63e:
	bl L_8c9b28
L_8cd642:
	b_s L_8cd606
L_8cd644:
	ld_s r0,[gp,-0x138]
L_8cd646:
	mov_s r13,0x0
L_8cd648:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd64a:
	st.as r0,[gp,-0x4e]
L_8cd64e:
	b_s L_8cd67e
L_8cd650:
	ld_s r0,[gp,-0x148]
L_8cd652:
	mov_s r13,0x1
L_8cd654:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd656:
	st.as r0,[gp,-0x52]
L_8cd65a:
	b_s L_8cd67e
L_8cd65c:
	ld_s r0,[gp,-0x13c]
L_8cd65e:
	mov_s r13,0x2
L_8cd660:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd662:
	st.as r0,[gp,-0x4f]
L_8cd666:
	b_s L_8cd67e
L_8cd668:
	ld_s r0,[gp,-0x140]
L_8cd66a:
	mov_s r13,0x3
L_8cd66c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd66e:
	st.as r0,[gp,-0x50]
L_8cd672:
	b_s L_8cd67e
L_8cd674:
	ld_s r0,[gp,-0x144]
L_8cd676:
	mov_s r13,0x4
L_8cd678:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd67a:
	st.as r0,[gp,-0x51]
	.global L_8cd67e
L_8cd67e:
	mov_s r1,0x842148
L_8cd684:
	add r0,r1,0xc
L_8cd688:
	mov r16,0x1
L_8cd68c:
	brne r15,r0,L_8cd6be
L_8cd690:
	brne r13,0x5,L_8cd6b8
L_8cd694:
	ld_s r0,[gp,-0x14c]
L_8cd696:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd698:
	st.as r0,[gp,-0x53]
L_8cd69c:
	mov_s r0,r1
L_8cd69e:
	bl.d L_8c25f4
L_8cd6a2:
	mov_s r1,r14
L_8cd6a4:
	mov_s r1,0x1018310
L_8cd6aa:
	mov_s r0,0x27
L_8cd6ac:
	bl.d L_8dcc10
L_8cd6b0:
	mov_s r2,r14
L_8cd6b2:
	mov r16,0x0
L_8cd6b6:
	b_s L_8cd6be
	.global L_8cd6b8
L_8cd6b8:
	cmp r13,0xff
L_8cd6bc:
	bne_s L_8cd6f0
	.global L_8cd6be
L_8cd6be:
	brne r16,0x1,L_8cd706
L_8cd6c2:
	ld_s r2,[r14,0x18]
L_8cd6c4:
	breq_s r2,0,L_8cd6d2
L_8cd6c6:
	ld_s r0,[r14,0x1c]
L_8cd6c8:
	mov_s r1,0x0
L_8cd6ca:
	jl_s.d [r2]
L_8cd6cc:
	mov_s r16,r1
L_8cd6ce:
	st r16,[r14, 0x18]
	.global L_8cd6d2
L_8cd6d2:
	ld r18,[r14, 0x20]
L_8cd6d6:
	ld_s r0,[sp,0x10]
L_8cd6d8:
	breq r18,0x0,L_8cd702
L_8cd6dc:
	mov_s r16,r0
L_8cd6de:
	bl.d L_8cbffc
L_8cd6e2:
	ldb_s r0,[r14,0xa]
L_8cd6e4:
	mov_s r3,r18
L_8cd6e6:
	mov_s r2,r0
L_8cd6e8:
	mov_s r0,r16
L_8cd6ea:
	jl_s.d [r3]
L_8cd6ec:
	mov_s r1,r13
L_8cd6ee:
	b_s L_8cd706
	.global L_8cd6f0
L_8cd6f0:
	cmp r13,0xfe
L_8cd6f4:
	beq_s L_8cd6be
L_8cd6f6:
	ldb_s r1,[r14,0xb]
L_8cd6f8:
	ldb_s r0,[r14,0xa]
L_8cd6fa:
	bl.d L_8e26a4
L_8cd6fe:
	bmsk_s r1,r1,0x5
L_8cd700:
	b_s L_8cd6be
	.global L_8cd702
L_8cd702:
	bl L_8cb10c
	.global L_8cd706
L_8cd706:
	brne_s r13,0,L_8cd714
	.global L_8cd708
L_8cd708:
	ld_s r0,[sp,0x0]
L_8cd70a:
	cmp_s r0,0x0
L_8cd70c:
	bne_s L_8cd5f8
L_8cd70e:
	b.d L_8c0234
L_8cd712:
	add_s sp,sp,0x14
	.global L_8cd714
L_8cd714:
	ld_s r0,[gp,0x298]
L_8cd716:
	breq_s r0,0,L_8cd708
L_8cd718:
	ld_s r0,[gp,0x2fc]
L_8cd71a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd71c:
	st.as r0,[gp,0xbf]
L_8cd720:
	b_s L_8cd708
L_8cd722:
	nop_s
