/* state_sm_8030f4__action_8f76d8 @ 0x8f76d8, 488 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm:: probe_req handle: ADDR-%04X%08X
 *   FIND_SM:: DO NOT reply to this Probe REQ  <<<<<< Should be handled by HOST >>>>>
 *   FIND:: Received Probe Request contains WFA IE (P2P IE).
 *   FIND_SM:: Probe REQ with DEVICE ID attribute ADDR-%04X%08X
 *   DEVICE ID attribute is unequal to my device address
 *   FIND:: Received Probe Request contains WSC IE.
 *   FIND_SM:: DO NOT reply to this Probe REQ (Host may do that !).
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r22_to_r13_ret, __st_r22_to_r13, app_ie__walk_list, app_ies__set_buffer, app_ies__set_probe_req_ies, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, ie_iter__init, ie_list__first, ies__scan_for_match
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8030f4__action_8f76d8
state_sm_8030f4__action_8f76d8:
	.global L_8f76d8
L_8f76d8:
	push_s blink
L_8f76da:
	bl L_8c01c4
L_8f76de:
	mov_s r20,r0
L_8f76e0:
	mov_s r16,r1
L_8f76e2:
	ld_s r0,[r1,0xc]
L_8f76e4:
	mov r21,0x1
L_8f76e8:
	ld r0,[r0, 0xd0]
L_8f76ec:
	ld_s r1,[r1,0x8]
L_8f76ee:
	sub_s sp,sp,0x2c
L_8f76f0:
	ld r13,[r16, 0x30]
L_8f76f4:
	sub_s r0,r0,r1
L_8f76f6:
	sub_s r13,r13,r0
L_8f76f8:
	ld r0,[r20, 0x10]
L_8f76fc:
	ld_s r0,[r0,0x48]
L_8f76fe:
	bl.d L_8cbfc8
L_8f7702:
	ldb r1,[r16, 0x36]
L_8f7706:
	mov.f r17,r0
L_8f770a:
	extw_s r13,r13
L_8f770c:
	beq_s L_8f773e
	.global L_8f770e
L_8f770e:
	cmp r17,0x0
L_8f7712:
	beq_s L_8f78ba
L_8f7714:
	add r18,r17,0x1c
L_8f7718:
	ldw r2,[r18, 0x4]
L_8f771c:
	mov_s r1,0x1017ce0
L_8f7722:
	mov_s r0,0x2c
L_8f7724:
	bl.d L_8dcc80
L_8f7728:
	ld r3,[r18]
L_8f772c:
	ld r0,[r20, 0x10]
L_8f7730:
	ld_s r0,[r0,0x14]
L_8f7732:
	brne r0,0x2,L_8f774c
L_8f7736:
	mov_s r1,0x1017ea4
L_8f773c:
	b_s L_8f78b4
	.global L_8f773e
L_8f773e:
	mov_s r0,blink
L_8f7740:
	mov_s r1,0x1448
L_8f7746:
	bl L_8c9b28
L_8f774a:
	b_s L_8f770e
	.global L_8f774c
L_8f774c:
	mov_s r14,sp
L_8f774e:
	ld r1,[r16, 0xc]
L_8f7752:
	mov_s r0,r14
L_8f7754:
	ld r1,[r1, 0xd0]
L_8f7758:
	mov_s r2,r13
L_8f775a:
	mov_s r3,0x0
L_8f775c:
	bl.d L_8e693c
L_8f7760:
	mov_s r19,r3
L_8f7762:
	add_s r0,sp,0xc
L_8f7764:
	mov_s r22,r0
L_8f7766:
	bl.d L_8e5de8
L_8f776a:
	mov_s r1,r14
L_8f776c:
	b_s L_8f7822
	.global L_8f776e
L_8f776e:
	add_s r14,r13,0x2
L_8f7770:
	ldb_s r0,[r14]
L_8f7772:
	cmp_s r0,0x50
L_8f7774:
	bne_s L_8f781e
L_8f7776:
	ldb_s r0,[r14,0x1]
L_8f7778:
	cmp_s r0,0x6f
L_8f777a:
	bne_s L_8f781e
L_8f777c:
	ldb_s r0,[r14,0x2]
L_8f777e:
	cmp r0,0x9a
L_8f7782:
	bne_s L_8f781e
L_8f7784:
	ldb_s r0,[r14,0x3]
L_8f7786:
	brne r0,0x9,L_8f781e
L_8f778a:
	mov_s r1,0x1017ef8
L_8f7790:
	bl.d L_8dcba8
L_8f7794:
	mov_s r0,0x2c
L_8f7796:
	ld r0,[r20, 0x10]
L_8f779a:
	ld_s r0,[r0,0xc]
L_8f779c:
	breq r0,0x0,L_8f781e
L_8f77a0:
	ldb_s r2,[r13,0x1]
L_8f77a2:
	add_s r15,sp,0x18
L_8f77a4:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8f77a6:
	extw_s r2,r2
L_8f77a8:
	mov_s r0,r15
L_8f77aa:
	bl.d L_8e6908
L_8f77ae:
	mov_s r1,r13
L_8f77b0:
	mov_s r0,r15
L_8f77b2:
	bl.d L_8cb8ec
L_8f77b6:
	mov_s r1,0x3
L_8f77b8:
	breq_s r0,0,L_8f781e
L_8f77ba:
	add_s r13,r0,0x3
L_8f77bc:
	ld r0,[r20, 0x10]
L_8f77c0:
	mov_s r1,0x1017f30
L_8f77c6:
	ld_s r15,[r0,0x48]
L_8f77c8:
	mov_s r0,0x29
L_8f77ca:
	ldw_s r2,[r13,0x4]
L_8f77cc:
	bl.d L_8dcc80
L_8f77d0:
	ld_s r3,[r13]
L_8f77d2:
	ldb_s r2,[r13]
L_8f77d4:
	ldb.a r1,[r15,0xa]
L_8f77d8:
	mov_s r0,0x0
L_8f77da:
	brne r2,r1,L_8f7808
L_8f77de:
	ldb_s r2,[r13,0x1]
L_8f77e0:
	ldb_s r1,[r15,0x1]
L_8f77e2:
	brne r2,r1,L_8f7808
L_8f77e6:
	ldb_s r2,[r13,0x2]
L_8f77e8:
	ldb_s r1,[r15,0x2]
L_8f77ea:
	brne r2,r1,L_8f7808
L_8f77ee:
	ldb_s r2,[r13,0x3]
L_8f77f0:
	ldb_s r1,[r15,0x3]
L_8f77f2:
	brne r2,r1,L_8f7808
L_8f77f6:
	ldb_s r2,[r13,0x4]
L_8f77f8:
	ldb_s r1,[r15,0x4]
L_8f77fa:
	brne r2,r1,L_8f7808
L_8f77fe:
	ldb_s r2,[r13,0x5]
L_8f7800:
	ldb_s r1,[r15,0x5]
L_8f7802:
	cmp_s r2,r1
L_8f7804:
	mov.eq r0,0x1
	.global L_8f7808
L_8f7808:
	extb.f 0x0,r0
L_8f780c:
	bne_s L_8f781e
L_8f780e:
	mov_s r1,0x1017f6c
L_8f7814:
	bl.d L_8dcba8
L_8f7818:
	mov_s r0,0x2c
L_8f781a:
	mov r21,0x0
	.global L_8f781e
L_8f781e:
	ldb_s r0,[r14]
L_8f7820:
	breq_s r0,0,L_8f788c
	.global L_8f7822
L_8f7822:
	bl.d L_8df404
L_8f7826:
	mov_s r0,r22
L_8f7828:
	mov.f r13,r0
L_8f782c:
	bne_s L_8f776e
L_8f782e:
	breq r21,0x0,L_8f78ae
L_8f7832:
	bl L_8c3414
L_8f7836:
	mov_s r13,r0
L_8f7838:
	st r19,[sp, 0x18]
L_8f783c:
	ld r2,[r20, 0x10]
L_8f7840:
	add_s r1,sp,0x18
L_8f7842:
	ld_s r2,[r2,0x48]
L_8f7844:
	mov_s r3,r17
L_8f7846:
	bl.d L_8e9f74
L_8f784a:
	mov r4,0x0
L_8f784e:
	add_s r0,r13,0x4
L_8f7850:
	mov_s r1,r18
L_8f7852:
	bl.d L_8c0380
L_8f7856:
	mov_s r2,0x6
L_8f7858:
	ld r0,[r20, 0x10]
L_8f785c:
	ld_s r0,[r0,0x14]
L_8f785e:
	breq r0,0x2,L_8f7872
L_8f7862:
	ld r1,[r16, 0x8]
L_8f7866:
	add r0,r13,0x10
L_8f786a:
	add_s r1,r1,0x10
L_8f786c:
	bl.d L_8c0380
L_8f7870:
	mov_s r2,0x6
	.global L_8f7872
L_8f7872:
	ldw r4,[sp, 0x18]
L_8f7876:
	mov_s r0,r17
L_8f7878:
	mov_s r1,0x1
L_8f787a:
	mov_s r2,r1
L_8f787c:
	mov_s r3,r13
L_8f787e:
	mov r5,0x0
L_8f7882:
	bl.d L_8e5874
L_8f7886:
	mov r6,r5
L_8f788a:
	b_s L_8f78ba
	.global L_8f788c
L_8f788c:
	ldb_s r0,[r14,0x1]
L_8f788e:
	cmp_s r0,0x50
L_8f7890:
	bne_s L_8f7822
L_8f7892:
	ldb_s r0,[r14,0x2]
L_8f7894:
	cmp r0,0xf2
L_8f7898:
	bne_s L_8f7822
L_8f789a:
	ldb_s r0,[r14,0x3]
L_8f789c:
	brne r0,0x4,L_8f7822
L_8f78a0:
	mov_s r1,0x1017fa0
L_8f78a6:
	bl.d L_8dcba8
L_8f78aa:
	mov_s r0,0x2c
L_8f78ac:
	b_s L_8f7822
	.global L_8f78ae
L_8f78ae:
	mov_s r1,0x1017e64
	.global L_8f78b4
L_8f78b4:
	bl.d L_8dcba8
L_8f78b8:
	mov_s r0,0x2c
	.global L_8f78ba
L_8f78ba:
	b.d L_8c0214
L_8f78be:
	add_s sp,sp,0x2c
