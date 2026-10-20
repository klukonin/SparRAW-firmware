/* PS_CONNECTION__psc_complete @ 0x8dd554, 564 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION::psc_complete (is_local=%d) (success=%d) (dpm=%d)
 *   PS_CONNECTION::psc_complete WS: (start_time=0x%x) %d:%d
 *   ps_connection.cpp
 *   ps_connection::psc_complete: psc agreement was rejected, curr state %d. inject ABORT
 * Зовут его: pcp_psc_sm__psc_done, sta_psc_sm__psc_done_sm
 * Зовёт сам: __ld_r13_ret, __ld_r19_to_r13_ret, __st_r19_to_r13, basic_sm__inject_event, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, lmac_if_send_cmd_0x22, ps_conn__profile_params_by_index, psc__read_mac_counters, psc__set_two_flags, psc_if__start_psc
 */
	.section .text.PS_CONNECTION__psc_complete,"ax",@progbits
	.global PS_CONNECTION__psc_complete
PS_CONNECTION__psc_complete:
	.global L_8dd554
L_8dd554:
	mov_s r6,r1
L_8dd556:
	mov_s r5,r2
L_8dd558:
	ld r1,[r0, 0x94]
L_8dd55c:
	mov_s r4,r3
L_8dd55e:
	cmp_s r1,0x0
L_8dd560:
	mov_s r1,0x1
L_8dd562:
	sub_s.ne r1,r1,r1
L_8dd564:
	ld r0,[r0, 0x90]
L_8dd568:
	mov_s r2,r6
L_8dd56a:
	b.d L_8dd5f8
L_8dd56e:
	mov_s r3,r5
L_8dd570:
	mov_s r3,0x801a0c
L_8dd576:
	ld_s r0,[r0,0x2c]
L_8dd578:
	mov_s r1,0x0
L_8dd57a:
	ld r2,[r3, 0xf0]
L_8dd57e:
	b.d L_8d6b80
L_8dd582:
	ld r3,[r3, 0xf4]
L_8dd586:
	nop_s
L_8dd588:
	push_s blink
L_8dd58a:
	push_s r13
L_8dd58c:
	sub_s sp,sp,0xc
L_8dd58e:
	mov_s r13,r0
L_8dd590:
	mov_s r1,sp
L_8dd592:
	bl.d L_8ca90c
L_8dd596:
	ldw_s r0,[r0,0x30]
L_8dd598:
	mov_s r0,r13
L_8dd59a:
	bl.d L_8c98a8
L_8dd59e:
	mov_s r1,0x1
L_8dd5a0:
	mov_s r2,r0
L_8dd5a2:
	ldb r0,[sp, 0x1]
L_8dd5a6:
	mov_s r1,0x1
L_8dd5a8:
	stw r0,[sp, 0x8]
L_8dd5ac:
	ldb_s r0,[sp,0x0]
L_8dd5ae:
	stw r0,[sp, 0xa]
L_8dd5b2:
	ld_s r0,[r13,0x2c]
L_8dd5b4:
	bl.d L_8d6b80
L_8dd5b8:
	ld_s r3,[sp,0x8]
L_8dd5ba:
	b.d L_8c033c
L_8dd5be:
	add_s sp,sp,0xc
L_8dd5c0:
	push_s blink
L_8dd5c2:
	push_s r13
L_8dd5c4:
	sub_s sp,sp,0xc
L_8dd5c6:
	mov_s r13,r0
L_8dd5c8:
	mov_s r1,sp
L_8dd5ca:
	bl.d L_8cad48
L_8dd5ce:
	ldw_s r0,[r0,0x30]
L_8dd5d0:
	mov_s r0,r13
L_8dd5d2:
	bl.d L_8c98a8
L_8dd5d6:
	mov_s r1,0x0
L_8dd5d8:
	mov_s r2,r0
L_8dd5da:
	ldb r0,[sp, 0x1]
L_8dd5de:
	mov_s r1,0x1
L_8dd5e0:
	stw r0,[sp, 0x8]
L_8dd5e4:
	ldb_s r0,[sp,0x0]
L_8dd5e6:
	stw r0,[sp, 0xa]
L_8dd5ea:
	ld_s r0,[r13,0x2c]
L_8dd5ec:
	bl.d L_8d6b80
L_8dd5f0:
	ld_s r3,[sp,0x8]
L_8dd5f2:
	b.d L_8c033c
L_8dd5f6:
	add_s sp,sp,0xc
	.global L_8dd5f8
L_8dd5f8:
	push_s blink
L_8dd5fa:
	bl L_8c02b0
L_8dd5fe:
	mov_s r14,r0
L_8dd600:
	mov.f r15,r1
L_8dd604:
	mov_s r19,r2
L_8dd606:
	mov_s r17,r3
L_8dd608:
	mov_s r13,r4
L_8dd60a:
	mov_s r0,0xff
L_8dd60c:
	bne_s L_8dd612
L_8dd60e:
	ld_s r0,[r14,0x58]
L_8dd610:
	ldb_s r0,[r0,0x8]
	.global L_8dd612
L_8dd612:
	mov_s r18,r0
L_8dd614:
	mov_s r2,0x1002978
L_8dd61a:
	mov_s r0,0xe
L_8dd61c:
	mov_s r1,0x2
L_8dd61e:
	mov_s r3,r15
L_8dd620:
	mov r4,r19
L_8dd624:
	bl.d L_8ee034
L_8dd628:
	mov r5,r17
L_8dd62c:
	ldw r4,[r13, 0x6]
L_8dd630:
	mov_s r2,0x10029b8
L_8dd636:
	ldw r5,[r13, 0x4]
L_8dd63a:
	mov_s r0,0xe
L_8dd63c:
	mov_s r1,0x2
L_8dd63e:
	bl.d L_8ee034
L_8dd642:
	ld_s r3,[r13]
L_8dd644:
	breq r19,0x0,L_8dd6c6
L_8dd648:
	breq_s r15,0,L_8dd69c
L_8dd64a:
	st r17,[r14, 0x3c]
L_8dd64e:
	ld_s r0,[r13,0x4]
L_8dd650:
	ld_s r1,[r13]
L_8dd652:
	st_s r0,[r14,0x44]
L_8dd654:
	ld_s r0,[r14,0x58]
L_8dd656:
	st_s r1,[r14,0x40]
L_8dd658:
	ldb r16,[r0, 0x8]
L_8dd65c:
	brhs r16,0x8,L_8dd686
	.global L_8dd660
L_8dd660:
	ld_s r1,[r14,0x3c]
L_8dd662:
	mov_s r0,0x854da0
L_8dd668:
	add3 r0,r0,r16
L_8dd66c:
	stb_s r1,[r0,0x4]
L_8dd66e:
	ldw r1,[r14, 0x44]
L_8dd672:
	stb_s r1,[r0,0x5]
L_8dd674:
	ldw r1,[r14, 0x46]
L_8dd678:
	stb_s r1,[r0,0x6]
L_8dd67a:
	mov_s r1,0x854d80
L_8dd680:
	add3 r1,r1,r16
L_8dd684:
	b_s L_8dd6b6
	.global L_8dd686
L_8dd686:
	mov_s r0,blink
L_8dd688:
	mov_s r2,0x10029f0
L_8dd68e:
	mov_s r1,0x146d
L_8dd694:
	bl.d L_8c82c0
L_8dd698:
	mov_s r3,0x77
L_8dd69a:
	b_s L_8dd660
	.global L_8dd69c
L_8dd69c:
	st r17,[r14, 0x4c]
L_8dd6a0:
	ld_s r1,[r13]
L_8dd6a2:
	ld_s r0,[r13,0x4]
L_8dd6a4:
	st_s r1,[r14,0x50]
L_8dd6a6:
	brge.d r18,0x8,L_8dd6e0
L_8dd6aa:
	st_s r0,[r14,0x54]
	.global L_8dd6ac
L_8dd6ac:
	mov_s r1,0x854d80
L_8dd6b2:
	add3 r1,r1,r18
	.global L_8dd6b6
L_8dd6b6:
	ld_s r0,[r1,0x20]
L_8dd6b8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8dd6ba:
	st_s r0,[r1,0x20]
L_8dd6bc:
	mov_s r0,r18
L_8dd6be:
	mov_s r1,r17
L_8dd6c0:
	bl.d L_8d8e68
L_8dd6c4:
	mov_s r2,r13
	.global L_8dd6c6
L_8dd6c6:
	breq r15,0x0,L_8dd784
L_8dd6ca:
	add_s r15,r14,0x4
L_8dd6cc:
	ldb r16,[r15]
L_8dd6d0:
	breq r19,0x0,L_8dd6f6
L_8dd6d4:
	mov_s r2,0x0
L_8dd6d6:
	stb r2,[r14, 0x48]
L_8dd6da:
	mov_s r0,r15
L_8dd6dc:
	mov_s r1,0x2
L_8dd6de:
	b_s L_8dd716
	.global L_8dd6e0
L_8dd6e0:
	mov_s r0,blink
L_8dd6e2:
	mov_s r2,0x10029f0
L_8dd6e8:
	mov_s r1,0x146d
L_8dd6ee:
	bl.d L_8c82c0
L_8dd6f2:
	mov_s r3,0x80
L_8dd6f4:
	b_s L_8dd6ac
	.global L_8dd6f6
L_8dd6f6:
	cmp r16,0x6
L_8dd6fa:
	cmp.ne r16,0x7
L_8dd6fe:
	cmp.ne r16,0x1
L_8dd702:
	bne_s L_8dd710
L_8dd704:
	ldb r0,[r14, 0x48]
L_8dd708:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8dd70a:
	extb_s r0,r0
L_8dd70c:
	stb r0,[r14, 0x48]
	.global L_8dd710
L_8dd710:
	mov_s r0,r15
L_8dd712:
	mov_s r1,0x3
L_8dd714:
	mov_s r2,0x0
	.global L_8dd716
L_8dd716:
	mov_s r17,r2
L_8dd718:
	mov_s r2,0x0
L_8dd71a:
	mov_s r3,r2
L_8dd71c:
	bl.d L_8d6a1c
L_8dd720:
	mov_s r4,r2
L_8dd722:
	ldb r0,[r14, 0x48]
L_8dd726:
	brlt r0,0xa,L_8dd760
L_8dd72a:
	mov_s r2,0x1002a04
L_8dd730:
	mov_s r0,0xe
L_8dd732:
	mov_s r1,0x0
L_8dd734:
	bl.d L_8edfcc
L_8dd738:
	mov_s r3,r16
L_8dd73a:
	mov_s r0,r15
L_8dd73c:
	mov_s r1,0x4
L_8dd73e:
	mov_s r2,0x0
L_8dd740:
	mov_s r3,r2
L_8dd742:
	bl.d L_8d6a1c
L_8dd746:
	mov_s r4,r2
L_8dd748:
	st r17,[r13]
L_8dd74c:
	stw r17,[r13, 0x6]
L_8dd750:
	stw r17,[r13, 0x4]
L_8dd754:
	mov_s r0,r18
L_8dd756:
	mov_s r1,0x0
L_8dd758:
	bl.d L_8d8e68
L_8dd75c:
	mov_s r2,r13
L_8dd75e:
	b_s L_8dd784
	.global L_8dd760
L_8dd760:
	ld_s r0,[r14]
L_8dd762:
	ldb_s r1,[r15]
L_8dd764:
	breq_s r0,0,L_8dd772
L_8dd766:
	cmp_s r1,0x0
L_8dd768:
	mov.eq r0,r15
L_8dd76c:
	mov.eq r1,0x0
L_8dd770:
	beq_s L_8dd77a
	.global L_8dd772
L_8dd772:
	brne_s r0,0,L_8dd784
L_8dd774:
	breq_s r1,0,L_8dd784
L_8dd776:
	mov_s r0,r15
L_8dd778:
	mov_s r1,0x5
	.global L_8dd77a
L_8dd77a:
	mov_s r2,0x0
L_8dd77c:
	mov_s r3,r2
L_8dd77e:
	bl.d L_8d6a1c
L_8dd782:
	mov_s r4,r2
	.global L_8dd784
L_8dd784:
	b L_8c030c
