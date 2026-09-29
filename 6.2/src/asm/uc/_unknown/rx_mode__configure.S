/* rx_mode__configure @ 0x92f4bc, 636 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, direct_tx__send_from_desc, fixed_sched__run_tx_slot, fsched_ap__start_slot, l1__enter_fixed_sched, l1_task__entry, rx__enter_listen_mode, rx_flow__handle_frame, rx_flow__run, rx_funcs__rx_flow
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bits__uc_set32_s4_w4, bits__uc_set32_s8_w15, brp__split_id, hwd_phy_rx_set_agc_start_val_and_gain_array_uc, mac__set_mode_a000, phy__set_88306c_field, rate_search__current_mcs_b, rx_mode__bits_uc_set32_s0_w4, uc_sysassert
 * Глобалы (через gp): 0x80054c, 0x8005a8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_mode__configure
rx_mode__configure:
	.global L_92f4bc
L_92f4bc:
	push_s blink
L_92f4be:
	bl L_920220
L_92f4c2:
	mov_s r16,r0
L_92f4c4:
	mov_s r17,r1
L_92f4c6:
	or r0,r0,0x80d00000
L_92f4ce:
	mov_s r32,r0
L_92f4d0:
	st.ab r0,[r25,0x4]
L_92f4d4:
	bclr r25,r25,0xa
L_92f4d8:
	mov_s r13,0x802588
L_92f4de:
	mov_s r2,0x802608
L_92f4e4:
	ldb_s r0,[r2,0x4]
L_92f4e6:
	mov_s r1,0x8025e8
L_92f4ec:
	sub r1,r1,0x60
L_92f4f0:
	add_s r12,r1,r0
L_92f4f2:
	stb r16,[r12, 0x74]
L_92f4f6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92f4f8:
	bmsk_s r0,r0,0x3
L_92f4fa:
	stb_s r0,[r2,0x4]
L_92f4fc:
	mov_s r2,0xff
L_92f4fe:
	add_s r1,r1,r0
L_92f500:
	stb r2,[r1, 0x74]
L_92f504:
	mov_s r0,0x0
L_92f506:
	cmp r16,0x2
L_92f50a:
	cmp.ne r16,0x3
L_92f50e:
	mov.eq r0,0x1
L_92f512:
	extb.f 0x0,r0
L_92f516:
	beq_s L_92f69e
L_92f518:
	ld_s r0,[gp,-0x34]
L_92f51a:
	mov_s r1,0x0
L_92f51c:
	mov_s r15,0x8
L_92f51e:
	brne r0,0x2,L_92f52e
L_92f522:
	mov_s r0,0x80212c
L_92f528:
	ldb r0,[r0, 0x68]
L_92f52c:
	brne_s r0,0,L_92f532
	.global L_92f52e
L_92f52e:
	mov_s r18,r1
L_92f530:
	b_s L_92f550
	.global L_92f532
L_92f532:
	norm r0,r0
L_92f536:
	rsub r15,r0,0x1e
L_92f53a:
	mov_s r1,0x857e49
L_92f540:
	asl_s r0,r15,0x2
L_92f542:
	add2_s r0,r0,r0
L_92f544:
	ldb_s r0,[r1,r0]
L_92f546:
	mov r18,0x1
L_92f54a:
	cmp_s r0,0x0
L_92f54c:
	sub.ne r18,r18,r18
	.global L_92f550
L_92f550:
	brne r18,0x0,L_92f5c2
L_92f554:
	brhs r17,0x8,L_92f5a0
L_92f558:
	asl r0,r17,0x4
L_92f55c:
	add2_s r0,r0,r0
L_92f55e:
	add_s r0,r0,0x801104
L_92f564:
	ldw_s r1,[r0,0x2]
L_92f566:
	bbit0 r1,0x0,L_92f5a0
L_92f56a:
	ld_s r3,[r0,0xc]
L_92f56c:
	mov_s r0,0x7fff00
L_92f572:
	and r1,r3,r0
L_92f576:
	mov_s r2,0x801024
L_92f57c:
	breq r1,r0,L_92f584
L_92f580:
	st_s r3,[r2]
L_92f582:
	b_s L_92f5a0
	.global L_92f584
L_92f584:
	ldb r1,[gp, -0xf7]
L_92f588:
	mov_s r0,r2
L_92f58a:
	bl L_93e414
L_92f58e:
	lsr r1,r3,0x4
L_92f592:
	bmsk_s r1,r1,0x3
L_92f594:
	bl L_93e3f0
L_92f598:
	bmsk r1,r3,0x3
L_92f59c:
	bl L_93e39c
	.global L_92f5a0
L_92f5a0:
	mov_s r0,0x801504
L_92f5a6:
	ldb.x r19,[r0, 0x1e]
L_92f5aa:
	mov_s r0,0x857700
L_92f5b0:
	ld r17,[r0, 0x30]
L_92f5b4:
	mov_s r14,0x80141c
L_92f5ba:
	ld_s r0,[r14,0x8]
L_92f5bc:
	bset_s r0,r0,0x0
L_92f5be:
	st_s r0,[r14,0x8]
L_92f5c0:
	b_s L_92f618
	.global L_92f5c2
L_92f5c2:
	brhs r15,0x8,L_92f5de
	.global L_92f5c6
L_92f5c6:
	mov_s r0,0x801523
L_92f5cc:
	ldb.x r19,[r0,r15]
L_92f5d0:
	bl.d L_92ff44
L_92f5d4:
	mov_s r0,r15
L_92f5d6:
	brlt r0,0x9,L_92f5ec
L_92f5da:
	mov_s r0,0x0
L_92f5dc:
	b_s L_92f5f4
	.global L_92f5de
L_92f5de:
	mov_s r0,blink
L_92f5e0:
	mov_s r1,0x12f0
L_92f5e6:
	bl L_926618
L_92f5ea:
	b_s L_92f5c6
	.global L_92f5ec
L_92f5ec:
	mov_s r0,0x857700
L_92f5f2:
	ld_s r0,[r0,0x30]
	.global L_92f5f4
L_92f5f4:
	mov_s r17,r0
L_92f5f6:
	mov_s r14,0x80141c
L_92f5fc:
	ld_s r0,[r14,0x8]
L_92f5fe:
	mov_s r1,0x801108
L_92f604:
	bclr_s r0,r0,0x0
L_92f606:
	st_s r0,[r14,0x8]
L_92f608:
	asl_s r0,r15,0x4
L_92f60a:
	add2_s r0,r0,r0
L_92f60c:
	ld_s r1,[r1,r0]
L_92f60e:
	mov_s r0,0x802978
L_92f614:
	ld_s r0,[r0,0x78]
L_92f616:
	st_s r1,[r0,0x2c]
	.global L_92f618
L_92f618:
	cmp r16,0x2
L_92f61c:
	bl.eq L_92a754
L_92f620:
	brne r18,0x0,L_92f650
L_92f624:
	ld_s r0,[r13,0x54]
L_92f626:
	bl.d L_929c10
L_92f62a:
	ld_s r1,[r13,0x5c]
L_92f62c:
	ldb_s r0,[gp,0x24]
L_92f62e:
	ld_s r1,[r13,0x54]
L_92f630:
	add_s r0,r0,r1
L_92f632:
	cmp_s r0,0x3f
L_92f634:
	bl.d L_929cac
L_92f638:
	mov.cc r0,0x3f
L_92f63c:
	ld.as r2,[gp,0x20]
L_92f640:
	mov_s r0,r19
L_92f642:
	jl_s.d [r2]
L_92f644:
	mov_s r1,r17
L_92f646:
	mov_s r0,0x801024
L_92f64c:
	ld_s r0,[r0]
L_92f64e:
	b_s L_92f67e
	.global L_92f650
L_92f650:
	ld_s r0,[r13,0x58]
L_92f652:
	bl.d L_929c10
L_92f656:
	ld_s r1,[r13,0x60]
L_92f658:
	ldb_s r0,[gp,0x24]
L_92f65a:
	ld_s r1,[r13,0x58]
L_92f65c:
	add_s r0,r0,r1
L_92f65e:
	cmp_s r0,0x3f
L_92f660:
	bl.d L_929cac
L_92f664:
	mov.cc r0,0x3f
L_92f668:
	ld.as r2,[gp,0x20]
L_92f66c:
	mov_s r0,r19
L_92f66e:
	jl_s.d [r2]
L_92f670:
	mov_s r1,r17
L_92f672:
	asl_s r0,r15,0x4
L_92f674:
	add2_s r0,r0,r0
L_92f676:
	mov_s r1,0x801108
L_92f67c:
	ld_s r0,[r1,r0]
	.global L_92f67e
L_92f67e:
	bl L_934dc8
L_92f682:
	brne r16,0x2,L_92f696
L_92f686:
	mov_s r0,0x3d000400
L_92f68c:
	mov_s r32,r0
L_92f68e:
	st.ab r0,[r25,0x4]
L_92f692:
	bclr r25,r25,0xa
	.global L_92f696
L_92f696:
	ld_s r0,[r14,0x8]
L_92f698:
	bset_s r0,r0,0x1
L_92f69a:
	st_s r0,[r14,0x8]
L_92f69c:
	b_s L_92f718
	.global L_92f69e
L_92f69e:
	brhs r17,0x8,L_92f6ba
	.global L_92f6a2
L_92f6a2:
	mov_s r1,0x801523
L_92f6a8:
	ldb.x r18,[r1,r17]
L_92f6ac:
	bl.d L_92ff44
L_92f6b0:
	mov_s r0,r17
L_92f6b2:
	brlt r0,0x9,L_92f6c8
L_92f6b6:
	mov_s r15,0x0
L_92f6b8:
	b_s L_92f6d0
	.global L_92f6ba
L_92f6ba:
	mov_s r0,blink
L_92f6bc:
	mov_s r1,0x12f0
L_92f6c2:
	bl L_926618
L_92f6c6:
	b_s L_92f6a2
	.global L_92f6c8
L_92f6c8:
	mov_s r0,0x857700
L_92f6ce:
	ld_s r15,[r0,0x30]
	.global L_92f6d0
L_92f6d0:
	mov_s r14,0x80141c
L_92f6d6:
	ld_s r0,[r14,0x8]
L_92f6d8:
	mov_s r1,0x801108
L_92f6de:
	bic r0,r0,0x3
L_92f6e2:
	st_s r0,[r14,0x8]
L_92f6e4:
	asl r0,r17,0x4
L_92f6e8:
	add2_s r0,r0,r0
L_92f6ea:
	ld_s r1,[r1,r0]
L_92f6ec:
	mov_s r0,0x802978
L_92f6f2:
	ld_s r0,[r0,0x78]
L_92f6f4:
	st_s r1,[r0,0x2c]
L_92f6f6:
	ld_s r0,[r13,0x58]
L_92f6f8:
	bl.d L_929c10
L_92f6fc:
	ld_s r1,[r13,0x60]
L_92f6fe:
	ldb_s r0,[gp,0x24]
L_92f700:
	ld_s r1,[r13,0x58]
L_92f702:
	add_s r0,r0,r1
L_92f704:
	cmp_s r0,0x3f
L_92f706:
	bl.d L_929cac
L_92f70a:
	mov.cc r0,0x3f
L_92f70e:
	ld.as r2,[gp,0x20]
L_92f712:
	mov_s r0,r18
L_92f714:
	jl_s.d [r2]
L_92f716:
	mov_s r1,r15
	.global L_92f718
L_92f718:
	ld_s r1,[r14,0x8]
L_92f71a:
	or r0,r16,0xd10000
L_92f722:
	bmsk_s r1,r1,0x0
L_92f724:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_92f726:
	or_s r0,r0,r1
L_92f728:
	bset_s r0,r0,0x1f
L_92f72a:
	mov_s r32,r0
L_92f72c:
	st.ab r0,[r25,0x4]
L_92f730:
	bclr r25,r25,0xa
L_92f734:
	b L_92027c
