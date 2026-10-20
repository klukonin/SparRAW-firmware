/* uc_hwd_rfc_write_core @ 0x927564, 960 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   hw_drivers_rfc.c
 *   hwd_rfc_write_core busy set before write! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hwd_rfc_write_core busy set - go again!! (rfc_opcode=%d, rfc_addr=0x%x, rfc_data=0x%x)
 *   [NNL] mac_go_when_busy_err_cnt=%d
 * Зовут его: rgf_reg_889000, tail_uc_hwd_rfc_write_core
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_hwd_rfc_write_core,"ax",@progbits
	.global uc_hwd_rfc_write_core
uc_hwd_rfc_write_core:
	.global L_927564
L_927564:
	st.a r13,[sp,-0x18]
L_927568:
	st blink,[sp, 0x4]
L_92756c:
	st_s r14,[sp,0x8]
L_92756e:
	st_s r15,[sp,0xc]
L_927570:
	st r16,[sp, 0x10]
L_927574:
	st r17,[sp, 0x14]
L_927578:
	mov_s r13,r1
L_92757a:
	cmp_s r0,0x10
L_92757c:
	mov r14,r2
L_927580:
	bge.d L_927698
L_927584:
	mov r15,r3
	.global L_927588
L_927588:
	cmp r13,0x10
L_92758c:
	bge L_9276b4
	.global L_927590
L_927590:
	cmp r14,0x7fff
L_927598:
	bhi L_9276cc
	.global L_92759c
L_92759c:
	mov r17,0x889000
L_9275a4:
	ld r8,[r17, 0xcc]
L_9275a8:
	bmsk r16,r13,0x3
L_9275ac:
	btst r8,0x1d
L_9275b0:
	bne.d L_9276e8
L_9275b4:
	asl r16,r16,0x4
	.global L_9275b8
L_9275b8:
	and.f 0x0,r16,0xffff8000
L_9275c0:
	bne L_9277c8
	.global L_9275c4
L_9275c4:
	ld r10,[r17, 0xd0]
L_9275c8:
	asl r16,r16,0x10
L_9275cc:
	and r10,r10,0x8000ffff
L_9275d4:
	or r10,r10,r16
L_9275d8:
	st r10,[r17, 0xd0]
L_9275dc:
	ld r11,[r17, 0xd4]
L_9275e0:
	st r14,[r17, 0xd4]
L_9275e4:
	ld r10,[r17, 0xd8]
L_9275e8:
	st r15,[r17, 0xd8]
L_9275ec:
	ld r3,[r17, 0xcc]
L_9275f0:
	mov lp_count,0x30d40
L_9275f8:
	bset r3,r3,0x1e
L_9275fc:
	st r3,[r17, 0xcc]
L_927600:
	lp L_927614
L_927604:
	ld r8,[r17, 0xcc]
L_927608:
	btst r8,0x1d
L_92760c:
	beq_s L_927614
L_92760e:
	nop_s
L_927610:
	mov 0x0,0x0
	.global L_927614
L_927614:
	ld r6,[r17, 0xcc]
L_927618:
	btst r6,0x1d
L_92761c:
	beq_s L_9277e0
L_92761e:
	mov_s r0,0x80209c
L_927624:
	ldb_s r2,[r0,0x4]
L_927626:
	mov r11,0x1003b40
L_92762e:
	btst_s r2,0x0
L_927630:
	beq.d L_9277e0
L_927634:
	mov r7,blink
L_927638:
	ld r6,[r0]
L_92763c:
	mov r4,0x8020b0
L_927644:
	add r3,r6,0x1
L_927648:
	extb r3,r3
L_92764c:
	add2 r3,r4,r3
L_927650:
	st r7,[r3]
L_927654:
	bmsk r11,r11,0x13
L_927658:
	or r11,r11,0xa4000000
L_927660:
	extb r5,r6
L_927664:
	add2 r5,r4,r5
L_927668:
	st r11,[r5]
L_92766c:
	ld r7,[r17, 0xcc]
L_927670:
	add r6,r6,0x2
L_927674:
	btst r7,0x1d
L_927678:
	bne.d L_9277f4
L_92767c:
	st r6,[r0]
	.global L_927680
L_927680:
	ld blink,[sp, 0x4]
L_927684:
	ld_s r14,[sp,0x8]
L_927686:
	ld_s r15,[sp,0xc]
L_927688:
	ld r16,[sp, 0x10]
L_92768c:
	ld r17,[sp, 0x14]
L_927690:
	j.d [blink]
L_927694:
	ld.ab r13,[sp,0x18]
	.global L_927698
L_927698:
	mov_s r0,blink
L_92769a:
	mov_s r2,0x1003b70
L_9276a0:
	mov r1,0x1135
L_9276a8:
	bl.d L_925548
L_9276ac:
	mov r3,0x188
L_9276b0:
	b L_927588
	.global L_9276b4
L_9276b4:
	mov_s r0,blink
L_9276b6:
	mov_s r2,0x1003b70
L_9276bc:
	mov_s r1,0x45
L_9276be:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_9276c0:
	bl.d L_925548
L_9276c4:
	mov r3,0x189
L_9276c8:
	b L_927590
	.global L_9276cc
L_9276cc:
	mov_s r0,blink
L_9276ce:
	mov_s r2,0x1003b70
L_9276d4:
	mov r1,0x1141
L_9276dc:
	bl.d L_925548
L_9276e0:
	mov r3,0x18a
L_9276e4:
	b L_92759c
	.global L_9276e8
L_9276e8:
	mov r10,0x80209c
L_9276f0:
	ldb r8,[r10, 0x4]
L_9276f4:
	mov r5,0x1003b84
L_9276fc:
	bbit0 r8,0x1,L_927754
L_927700:
	ld r2,[r10]
L_927704:
	mov_s r0,0x8020b0
L_92770a:
	add r9,r2,0x3
L_92770e:
	extb r9,r9
L_927712:
	add2 r9,r0,r9
L_927716:
	st r15,[r9]
L_92771a:
	add r7,r2,0x2
L_92771e:
	extb r7,r7
L_927722:
	add2 r7,r0,r7
L_927726:
	st r14,[r7]
L_92772a:
	add r6,r2,0x1
L_92772e:
	extb r6,r6
L_927732:
	add2 r6,r0,r6
L_927736:
	st r13,[r6]
L_92773a:
	bmsk r5,r5,0x13
L_92773e:
	or r5,r5,0xad000000
L_927746:
	extb_s r1,r2
L_927748:
	add2_s r0,r0,r1
L_92774a:
	st r5,[r0]
L_92774e:
	/* add_s r2,0x4 */
	.byte 0x04,0xe2
L_927750:
	st r2,[r10]
	.global L_927754
L_927754:
	mov lp_count,0x30d40
L_92775c:
	mov 0x0,0x0
L_927760:
	lp L_927770
L_927764:
	ld r0,[r17, 0xcc]
L_927768:
	btst_s r0,0x1d
L_92776a:
	beq_s L_927770
L_92776c:
	mov 0x0,0x0
	.global L_927770
L_927770:
	ld r11,[r17, 0xcc]
L_927774:
	btst r11,0x1d
L_927778:
	beq_s L_9275b8
L_92777a:
	mov_s r2,0x1003b70
L_927780:
	mov_s r1,0x1003bdc
L_927786:
	bbit0 r8,0x0,L_9277b4
L_92778a:
	bmsk_s r1,r1,0x13
L_92778c:
	ld r9,[r10]
L_927790:
	or r1,r1,0xa0000000
L_927798:
	extb r5,r9
L_92779c:
	mov r4,0x8020b0
L_9277a4:
	add2 r5,r4,r5
L_9277a8:
	st r1,[r5]
L_9277ac:
	add r9,r9,0x1
L_9277b0:
	st r9,[r10]
	.global L_9277b4
L_9277b4:
	mov_s r0,blink
L_9277b6:
	mov_s r1,0x134a
L_9277bc:
	bl.d L_925548
L_9277c0:
	mov r3,0x195
L_9277c4:
	b L_9275b8
	.global L_9277c8
L_9277c8:
	mov_s r0,blink
L_9277ca:
	mov_s r2,0x1003b70
L_9277d0:
	mov r1,0xac
L_9277d4:
	bl.d L_925548
L_9277d8:
	mov r3,0x198
L_9277dc:
	b L_9275c4
	.global L_9277e0
L_9277e0:
	ld r6,[r17, 0xcc]
L_9277e4:
	btst r6,0x1d
L_9277e8:
	beq_s L_927680
L_9277ea:
	mov_s r0,0x80209c
L_9277f0:
	ldb r2,[r0, 0x4]
	.global L_9277f4
L_9277f4:
	mov_s r1,0x1003bfc
L_9277fa:
	bbit0 r2,0x1,L_927854
L_9277fe:
	ld r8,[r0]
L_927802:
	mov r11,0x8020b0
L_92780a:
	add r2,r8,0x3
L_92780e:
	extb_s r2,r2
L_927810:
	add2 r2,r11,r2
L_927814:
	st_s r15,[r2]
L_927816:
	add r7,r8,0x2
L_92781a:
	extb r7,r7
L_92781e:
	add2 r7,r11,r7
L_927822:
	st r14,[r7]
L_927826:
	add r9,r8,0x1
L_92782a:
	extb r9,r9
L_92782e:
	add2 r9,r11,r9
L_927832:
	st r13,[r9]
L_927836:
	bmsk_s r1,r1,0x13
L_927838:
	or r1,r1,0xad000000
L_927840:
	extb r10,r8
L_927844:
	add2 r10,r11,r10
L_927848:
	st r1,[r10]
L_92784c:
	add r8,r8,0x4
L_927850:
	st r8,[r0]
	.global L_927854
L_927854:
	ld.as r4,[r17,0x42]
L_927858:
	ldb r11,[r0, 0x4]
L_92785c:
	mov r5,0x1003c54
L_927864:
	bbit0.d r11,0x1,L_9278a4
L_927868:
	bmsk r4,r4,0xe
L_92786c:
	ld r7,[r0]
L_927870:
	mov_s r3,0x8020b0
L_927876:
	add r10,r7,0x1
L_92787a:
	extb r10,r10
L_92787e:
	add2 r10,r3,r10
L_927882:
	st r4,[r10]
L_927886:
	bmsk r5,r5,0x13
L_92788a:
	or r5,r5,0xa5000000
L_927892:
	extb r1,r7
L_927896:
	add2_s r3,r3,r1
L_927898:
	st r5,[r3]
L_92789c:
	add r7,r7,0x2
L_9278a0:
	st r7,[r0]
	.global L_9278a4
L_9278a4:
	ld r2,[r17, 0xcc]
L_9278a8:
	mov lp_count,0x30d40
L_9278b0:
	bset r2,r2,0x1e
L_9278b4:
	st r2,[r17, 0xcc]
L_9278b8:
	lp L_9278c8
L_9278bc:
	ld r2,[r17, 0xcc]
L_9278c0:
	btst_s r2,0x1d
L_9278c2:
	beq_s L_9278c8
L_9278c4:
	mov 0x0,0x0
	.global L_9278c8
L_9278c8:
	ld r3,[r17, 0xcc]
L_9278cc:
	btst_s r3,0x1d
L_9278ce:
	beq L_927680
L_9278d2:
	ldb r4,[r0, 0x4]
L_9278d6:
	mov_s r3,0x1003bdc
L_9278dc:
	mov_s r2,0x1003b70
L_9278e2:
	bbit0 r4,0x0,L_927910
L_9278e6:
	bmsk_s r3,r3,0x13
L_9278e8:
	ld r4,[r0]
L_9278ec:
	or r3,r3,0xa0000000
L_9278f4:
	extb r9,r4
L_9278f8:
	mov r5,0x8020b0
L_927900:
	add2 r9,r5,r9
L_927904:
	st r3,[r9]
L_927908:
	add r4,r4,0x1
L_92790c:
	st r4,[r0]
	.global L_927910
L_927910:
	mov_s r0,blink
L_927912:
	mov_s r1,0x133d
L_927918:
	bl.d L_925548
L_92791c:
	mov r3,0x1b1
L_927920:
	b L_927680
