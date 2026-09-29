/* tx_initiator_flow @ 0x9337c8, 552 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_initiator_flow() Check for busy2 (CCA) or energy (RSSI) and abort if found
 *   tx_initiator_flow() Backoff expired without Q availability
 *   tx_initiator_flow() Abort Tx to shallow sleep STA , sta_id= %d, qid= %d
 *   tx_initiator_flow() Abort Tx to shallow sleep STA , assoc_sta_vec= %x
 *   tx_initiator_flow() tx_bcast_flow
 *   tx_initiator_flow() Starting internal TX
 * Зовут его: bi_tx_initiator_wrap
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bi_tx__check_idle_and_start, get_tx_eligibility__precheck, internal_tx__pending_sm, mac__select_all_sectors_and_wait, tx_ctx__next_slot, tx_initiator__build_tx_vector, tx_initiator_step, tx_rate_select_and_program
 * Глобалы (через gp): 0x800608
 */
	.section .text.tx_initiator_flow,"ax",@progbits
	.global tx_initiator_flow
tx_initiator_flow:
	.global L_9337c8
L_9337c8:
	push_s blink
L_9337ca:
	bl L_920210
L_9337ce:
	sub_s sp,sp,0x4
L_9337d0:
	mov_s r13,0x1
L_9337d2:
	bl.d L_933414
L_9337d6:
	mov_s r0,r13
L_9337d8:
	mov_s r14,r0
L_9337da:
	mov_s r0,sp
L_9337dc:
	bl.d L_933e90
L_9337e0:
	mov_s r1,r13
L_9337e2:
	ld_s r1,[sp,0x0]
L_9337e4:
	mov_s r15,r0
L_9337e6:
	cmp_s r1,0x1a
L_9337e8:
	mov.eq r0,r13
L_9337ec:
	beq_s L_933804
L_9337ee:
	mov_s r0,0x801ed0
L_9337f4:
	mov_s r3,0x801132
L_9337fa:
	add1 r2,r1,r1
L_9337fe:
	bl.d L_9264f0
L_933802:
	ldb_s r2,[r3,r2]
	.global L_933804
L_933804:
	cmp_s r15,0x0
L_933806:
	cmp.ne r0,0x0
L_93380a:
	beq_s L_93385a
L_93380c:
	bl L_931980
L_933810:
	mov_s r0,r42
L_933812:
	btst_s r0,0xe
L_933814:
	beq_s L_933938
L_933816:
	mov_s r1,0x801458
L_93381c:
	ld_s r0,[r1,0x4]
L_93381e:
	mov_s r2,0x80209c
L_933824:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933826:
	st_s r0,[r1,0x4]
L_933828:
	st.as 0x800,[gp,0x38]
L_933830:
	ldb_s r1,[r2,0x5]
L_933832:
	mov_s r0,0x1001d70
L_933838:
	btst_s r1,0x2
L_93383a:
	beq_s L_9339ea
L_93383c:
	bmsk_s r0,r0,0x13
L_93383e:
	ld_s r1,[r2]
L_933840:
	or r0,r0,0xa2100000
L_933848:
	extb_s r13,r1
L_93384a:
	mov_s r3,0x8020b0
L_933850:
	add2_s r3,r3,r13
L_933852:
	st_s r0,[r3]
L_933854:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_933856:
	st_s r1,[r2]
L_933858:
	b_s L_9339ea
	.global L_93385a
L_93385a:
	bl.d L_931a78
L_93385e:
	mov_s r0,0x2
L_933860:
	mov_s r1,0x801458
L_933866:
	ld_s r0,[r1,0x8]
L_933868:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93386a:
	st_s r0,[r1,0x8]
L_93386c:
	mov_s r1,0x80209c
L_933872:
	ldb_s r2,[r1,0x5]
L_933874:
	brne_s r15,0,L_9338c8
L_933876:
	mov_s r0,0x1001dc0
L_93387c:
	bbit0 r2,0x2,L_933926
L_933880:
	bmsk r2,r0,0x13
L_933884:
	ld_s r0,[r1]
L_933886:
	or r2,r2,0xa2100000
L_93388e:
	extb_s r13,r0
L_933890:
	mov_s r3,0x8020b0
L_933896:
	add2_s r3,r3,r13
L_933898:
	st_s r2,[r3]
L_93389a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93389c:
	st_s r0,[r1]
L_93389e:
	b_s L_933926
	.global L_9338a0
L_9338a0:
	ld_s r2,[r1]
L_9338a2:
	mov_s r13,0x8020b0
L_9338a8:
	add_s r3,r2,0x1
L_9338aa:
	extb_s r3,r3
L_9338ac:
	add2 r3,r13,r3
L_9338b0:
	st_s r14,[r3]
L_9338b2:
	bmsk_s r0,r0,0x13
L_9338b4:
	or r0,r0,0xa6100000
L_9338bc:
	extb_s r3,r2
L_9338be:
	add2_s r13,r13,r3
L_9338c0:
	st_s r0,[r13]
L_9338c2:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_9338c4:
	st_s r2,[r1]
L_9338c6:
	b_s L_933926
	.global L_9338c8
L_9338c8:
	mov r4,0x1001dfc
L_9338d0:
	ld_s r0,[sp,0x0]
L_9338d2:
	mov_s r13,0x801132
L_9338d8:
	add1 r3,r0,r0
L_9338dc:
	ldb_s r14,[r13,r3]
L_9338de:
	bbit0 r2,0x2,L_933914
L_9338e2:
	ld_s r3,[r1]
L_9338e4:
	mov_s r13,0x8020b0
L_9338ea:
	add_s r15,r3,0x2
L_9338ec:
	extb_s r15,r15
L_9338ee:
	add2 r15,r13,r15
L_9338f2:
	st_s r0,[r15]
L_9338f4:
	add_s r0,r3,0x1
L_9338f6:
	extb_s r0,r0
L_9338f8:
	add2 r0,r13,r0
L_9338fc:
	st_s r14,[r0]
L_9338fe:
	bmsk r0,r4,0x13
L_933902:
	or r0,r0,0xaa100000
L_93390a:
	extb_s r14,r3
L_93390c:
	add2_s r13,r13,r14
L_93390e:
	st_s r0,[r13]
L_933910:
	/* add_s r3,0x3 */
	.byte 0x03,0xe3
L_933912:
	st_s r3,[r1]
	.global L_933914
L_933914:
	mov_s r0,0x1001e44
L_93391a:
	mov_s r3,0x80102c
L_933920:
	ldb_s r14,[r3,0x8]
L_933922:
	bbit1 r2,0x2,L_9338a0
	.global L_933926
L_933926:
	mov_s r0,0xeeee01
	.global L_93392c
L_93392c:
	mov_s r32,r0
L_93392e:
	st.ab r0,[r25,0x4]
L_933932:
	bclr r25,r25,0xa
L_933936:
	b_s L_9339ea
	.global L_933938
L_933938:
	ld_s r1,[sp,0x0]
L_93393a:
	ld_s r0,[r14,0xc]
L_93393c:
	st_s r1,[r14,0x4]
L_93393e:
	bset_s r0,r0,0x0
L_933940:
	st_s r0,[r14,0xc]
L_933942:
	breq r1,0x1f,L_933986
L_933946:
	ld_s r0,[gp,-0xc4]
L_933948:
	brne r1,r0,L_9339e4
L_93394c:
	cmp r0,0xff
L_933950:
	beq_s L_9339e4
L_933952:
	mov_s r2,0x80209c
L_933958:
	ldb_s r0,[r2,0x5]
L_93395a:
	mov_s r1,0x1001e8c
L_933960:
	bbit0 r0,0x2,L_933980
L_933964:
	bmsk_s r1,r1,0x13
L_933966:
	ld_s r0,[r2]
L_933968:
	or r1,r1,0xa2100000
L_933970:
	extb_s r13,r0
L_933972:
	mov_s r3,0x8020b0
L_933978:
	add2_s r3,r3,r13
L_93397a:
	st_s r1,[r3]
L_93397c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93397e:
	st_s r0,[r2]
	.global L_933980
L_933980:
	bl L_9329fc
L_933984:
	b_s L_9339ea
	.global L_933986
L_933986:
	mov_s r0,0x80
L_933988:
	bset_s r0,r0,0x19
L_93398a:
	mov_s r32,r0
L_93398c:
	st.ab r0,[r25,0x4]
L_933990:
	bclr r25,r25,0xa
L_933994:
	mov_s r2,0x80209c
L_93399a:
	ldb_s r1,[r2,0x5]
L_93399c:
	mov_s r0,0x1001eb0
L_9339a2:
	bbit0 r1,0x2,L_9339c2
L_9339a6:
	bmsk_s r0,r0,0x13
L_9339a8:
	ld_s r1,[r2]
L_9339aa:
	or r0,r0,0xa2100000
L_9339b2:
	extb_s r13,r1
L_9339b4:
	mov_s r3,0x8020b0
L_9339ba:
	add2_s r3,r3,r13
L_9339bc:
	st_s r0,[r3]
L_9339be:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9339c0:
	st_s r1,[r2]
	.global L_9339c2
L_9339c2:
	mov_s r0,0xeeee03
L_9339c8:
	mov_s r32,r0
L_9339ca:
	st.ab r0,[r25,0x4]
L_9339ce:
	bclr r25,r25,0xa
L_9339d2:
	bl.d L_928e68
L_9339d6:
	mov_s r0,r14
L_9339d8:
	ld_s r0,[gp,-0x48]
L_9339da:
	or r0,r0,0x27003f00
L_9339e2:
	b_s L_93392c
	.global L_9339e4
L_9339e4:
	bl.d L_93466c
L_9339e8:
	mov_s r0,r14
	.global L_9339ea
L_9339ea:
	b.d L_92027c
L_9339ee:
	add_s sp,sp,0x4
