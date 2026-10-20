/* brp_init__flow @ 0x922728, 252 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__on_brp_init
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf__store_flow_status, brp__rank_insert, brp_init__exchange_request, brp_init__reset_ctx, brp_initiator_brp_transaction_flow, brp_update_omni_sector_idx, config_brp_rf, gp_timer__stop, rfca__access_sector_other_rf, rfca__get_rf_mask_uc
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_init__flow
brp_init__flow:
	.global L_922728
L_922728:
	push_s blink
L_92272a:
	bl L_920220
L_92272e:
	sub_s sp,sp,0x4
L_922730:
	bl.d L_928c68
L_922734:
	mov_s r17,r0
L_922736:
	st_s r0,[sp,0x0]
L_922738:
	mov_s r1,0x802008
L_92273e:
	asl r0,r17,0x2
L_922742:
	add2_s r0,r0,r0
L_922744:
	ld_s r0,[r1,r0]
L_922746:
	extb r0,r17
L_92274a:
	bl.d L_92afb8
L_92274e:
	mov_s r19,r0
L_922750:
	mov_s r0,r17
L_922752:
	bl.d L_9357cc
L_922756:
	mov_s r1,0x31
L_922758:
	mov r18,0x800824
L_922760:
	ld r0,[r18, 0x50]
L_922764:
	bbit0 r0,0x9,L_922786
L_922768:
	bl L_922928
L_92276c:
	brne_s r0,0,L_92277c
L_92276e:
	mov_s r0,0x889480
L_922774:
	ld_s r0,[r0,0x8]
L_922776:
	st.as r0,[gp,0x5e]
L_92277a:
	b_s L_92281c
	.global L_92277c
L_92277c:
	ld r1,[r18, 0x50]
L_922780:
	bclr_s r1,r1,0x9
L_922782:
	st r1,[r18, 0x50]
	.global L_922786
L_922786:
	bl L_922514
L_92278a:
	breq_s r0,0,L_9227f8
L_92278c:
	mov_s r0,0x889480
L_922792:
	ld_s r0,[r0,0x8]
L_922794:
	st.as r0,[gp,0x5e]
L_922798:
	mov_s r0,r17
L_92279a:
	bl.d L_9357cc
L_92279e:
	mov_s r1,0x30
L_9227a0:
	mov_s r0,0x8006b4
L_9227a6:
	ldb_s r0,[r0,0x3]
L_9227a8:
	b_s L_9227ba
	.global L_9227aa
L_9227aa:
	mov_s r0,r14
L_9227ac:
	bl.d L_925050
L_9227b0:
	ldb r1,[r18, 0x58]
L_9227b4:
	bclr r0,r16,r14
L_9227b8:
	extb_s r0,r0
	.global L_9227ba
L_9227ba:
	mov.f r16,r0
L_9227be:
	beq_s L_9227ec
L_9227c0:
	norm r0,r0
L_9227c4:
	rsub r14,r0,0x1e
L_9227c8:
	extb_s r14,r14
L_9227ca:
	mov_s r13,0x0
L_9227cc:
	mov_s r15,0x20
	.global L_9227ce
L_9227ce:
	asl_s r0,r14,0x5
L_9227d0:
	add_s r0,r0,r13
L_9227d2:
	mov_s r1,0x801ef4
L_9227d8:
	ldb_s r1,[r1,r0]
L_9227da:
	extb_s r2,r13
L_9227dc:
	bl.d L_92e904
L_9227e0:
	mov_s r0,r14
L_9227e2:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_9227e4:
	/* brhs.d r15,0x1,0x009227ce */
	.byte 0xeb,0x0f,0x75,0x90
L_9227e8:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_9227ea:
	b_s L_9227aa
	.global L_9227ec
L_9227ec:
	bl.d L_92e0a8
L_9227f0:
	mov_s r0,r19
L_9227f2:
	mov_s r0,r17
L_9227f4:
	mov_s r1,0x1
L_9227f6:
	b_s L_9227fc
	.global L_9227f8
L_9227f8:
	mov_s r0,r17
L_9227fa:
	mov_s r1,0x0
	.global L_9227fc
L_9227fc:
	bl L_923970
L_922800:
	bl.d L_925998
L_922804:
	mov_s r0,0x0
L_922806:
	mov_s r0,0x52
L_922808:
	asl_s r0,r0,0x18
L_92280a:
	mov_s r32,r0
L_92280c:
	st.ab r0,[r25,0x4]
L_922810:
	bclr r25,r25,0xa
L_922814:
	ld_s r0,[sp,0x0]
L_922816:
	bl.d L_928b8c
L_92281a:
	mov_s r1,0x0
	.global L_92281c
L_92281c:
	b.d L_92027c
L_922820:
	add_s sp,sp,0x4
L_922822:
	nop_s
