/* mtp__get_tx_permission @ 0x93e8c4, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__program_mac_and_wait, rx_flow__run
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fixed_sched_manager__decrement_curr_sta_rd_counter, fsched_slot__f3_positive, mtp_service__dispatch, tx__send_and_await_rx_frame, tx_flow__arm_88606c_0x102
 * Глобалы (через gp): 0x800564, 0x8005f4, 0x8005f8, 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mtp__get_tx_permission
mtp__get_tx_permission:
	.global L_93e8c4
L_93e8c4:
	push_s blink
L_93e8c6:
	bl L_920230
L_93e8ca:
	mov_s r14,r0
L_93e8cc:
	mov_s r15,r1
L_93e8ce:
	mov_s r0,0x2008000
L_93e8d4:
	mov_s r32,r0
L_93e8d6:
	st.ab r0,[r25,0x4]
L_93e8da:
	bclr r25,r25,0xa
L_93e8de:
	mov_s r0,0x19000001
L_93e8e4:
	mov_s r32,r0
L_93e8e6:
	st.ab r0,[r25,0x4]
L_93e8ea:
	bclr r25,r25,0xa
L_93e8ee:
	lsr r13,r43,0x1a
L_93e8f2:
	bmsk_s r13,r13,0x0
	.global L_93e8f4
L_93e8f4:
	mov_s r0,r45
L_93e8f6:
	bbit0 r0,0x1f,L_93e8f4
L_93e8fa:
	ld_s r1,[r14,0x18]
L_93e8fc:
	extb r0,r45
L_93e900:
	and_s r0,r0,r1
L_93e902:
	cmp_s r0,0x0
L_93e904:
	mov_s r0,0x1
L_93e906:
	sub_s.ne r0,r0,r0
L_93e908:
	extb.f 0x0,r0
L_93e90c:
	beq_s L_93e942
L_93e90e:
	ld_s r1,[r14]
L_93e910:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93e912:
	add1_s r1,r1,r1
L_93e914:
	add_s r1,r1,0x802610
L_93e91a:
	ld_s r2,[r1]
L_93e91c:
	mov_s r0,0x0
L_93e91e:
	breq r2,0x2,L_93e93a
L_93e922:
	ld_s r1,[r1,0x4]
L_93e924:
	cmp_s r1,0x3
L_93e926:
	cmp.ne r1,0x4
L_93e92a:
	cmp.ne r1,0x5
L_93e92e:
	bne_s L_93e932
L_93e930:
	mov_s r0,0x1
	.global L_93e932
L_93e932:
	extb.f 0x0,r0
L_93e936:
	mov_s r0,0x0
L_93e938:
	beq_s L_93e93c
	.global L_93e93a
L_93e93a:
	mov_s r0,0x1
	.global L_93e93c
L_93e93c:
	extb.f 0x0,r0
L_93e940:
	beq_s L_93e9e6
	.global L_93e942
L_93e942:
	ld_s r0,[r14,0x24]
L_93e944:
	brne r0,0x2,L_93e9cc
L_93e948:
	ld_s r0,[r14,0xc]
L_93e94a:
	bbit0 r0,0x0,L_93e9cc
L_93e94e:
	ld_s r1,[r14]
L_93e950:
	asl_s r2,r1,0x2
L_93e952:
	add1_s r2,r2,r2
L_93e954:
	add_s r2,r2,0x802610
L_93e95a:
	ld_s r3,[r2]
L_93e95c:
	mov_s r0,0x0
L_93e95e:
	breq r3,0x2,L_93e97a
L_93e962:
	ld_s r2,[r2,0x4]
L_93e964:
	cmp_s r2,0x3
L_93e966:
	cmp.ne r2,0x4
L_93e96a:
	cmp.ne r2,0x5
L_93e96e:
	bne_s L_93e972
L_93e970:
	mov_s r0,0x1
	.global L_93e972
L_93e972:
	extb.f 0x0,r0
L_93e976:
	mov_s r0,0x0
L_93e978:
	beq_s L_93e97c
	.global L_93e97a
L_93e97a:
	mov_s r0,0x1
	.global L_93e97c
L_93e97c:
	extb.f 0x0,r0
L_93e980:
	bne_s L_93e9cc
L_93e982:
	ld_s r2,[r14,0x8]
L_93e984:
	mov_s r0,0x1
L_93e986:
	bl.d L_92d9d4
L_93e98a:
	mov_s r3,r15
	.global L_93e98c
L_93e98c:
	mov_s r0,r43
L_93e98e:
	bbit0 r0,0x1f,L_93e98c
L_93e992:
	mov_s r0,r51
L_93e994:
	bmsk r1,r0,0x3
L_93e998:
	st.as r1,[gp,0x38]
L_93e99c:
	lsr_s r0,r0,0x4
L_93e99e:
	st.as r0,[gp,0x39]
	.global L_93e9a2
L_93e9a2:
	mov_s r0,r45
L_93e9a4:
	bbit0 r0,0x1f,L_93e9a2
L_93e9a8:
	mov_s r0,0x18
L_93e9aa:
	asl_s r0,r0,0x18
L_93e9ac:
	mov_s r32,r0
L_93e9ae:
	st.ab r0,[r25,0x4]
L_93e9b2:
	bclr r25,r25,0xa
L_93e9b6:
	ld_s r1,[r14,0x4]
L_93e9b8:
	ld_s r0,[gp,0x3c]
L_93e9ba:
	bbit0 r0,r1,L_93e9c4
L_93e9be:
	ld_s r0,[gp,0xcc]
L_93e9c0:
	bbit1 r0,0x1,L_93ea3a
	.global L_93e9c4
L_93e9c4:
	ld_s r0,[r14,0xc]
L_93e9c6:
	bset_s r0,r0,0x8
L_93e9c8:
	st_s r0,[r14,0xc]
L_93e9ca:
	b_s L_93ea3a
	.global L_93e9cc
L_93e9cc:
	ld_s r0,[gp,0xcc]
L_93e9ce:
	bbit0 r0,0x1,L_93e9f6
L_93e9d2:
	mov_s r0,r14
L_93e9d4:
	mov_s r1,0x1
L_93e9d6:
	bl.d L_9249b4
L_93e9da:
	mov_s r2,0x0
L_93e9dc:
	ld_s r0,[gp,0xd0]
L_93e9de:
	bset_s r0,r0,0x9
L_93e9e0:
	st.as r0,[gp,0x34]
L_93e9e4:
	b_s L_93ea3a
	.global L_93e9e6
L_93e9e6:
	ld_s r0,[r14,0xc]
L_93e9e8:
	bbit0 r0,0xc,L_93e9f6
L_93e9ec:
	bl L_92949c
L_93e9f0:
	ld_s r0,[r14,0xc]
L_93e9f2:
	bclr_s r0,r0,0xb
L_93e9f4:
	st_s r0,[r14,0xc]
	.global L_93e9f6
L_93e9f6:
	ld_s r0,[gp,0xcc]
L_93e9f8:
	bbit0 r0,0x1,L_93ea2c
L_93e9fc:
	ld_s r0,[gp,-0x34]
L_93e9fe:
	breq_s r0,0,L_93ea18
L_93ea00:
	mov_s r14,0x801be8
L_93ea06:
	bl.d L_92be0c
L_93ea0a:
	mov_s r0,r14
L_93ea0c:
	cmp_s r0,0x0
L_93ea0e:
	and_s r13,r13,r0
L_93ea10:
	bl.ne.d L_92574c
L_93ea14:
	mov.ne r0,r14
	.global L_93ea18
L_93ea18:
	asl_s r13,r13,0xb
L_93ea1a:
	bset_s r13,r13,0xe
L_93ea1c:
	bset_s r13,r13,0x1b
L_93ea1e:
	bset_s r13,r13,0x1c
L_93ea20:
	mov_s r32,r13
L_93ea22:
	st.ab r13,[r25,0x4]
L_93ea26:
	bclr r25,r25,0xa
L_93ea2a:
	b_s L_93ea3a
	.global L_93ea2c
L_93ea2c:
	mov_s r0,0x18
L_93ea2e:
	asl_s r0,r0,0x18
L_93ea30:
	mov_s r32,r0
L_93ea32:
	st.ab r0,[r25,0x4]
L_93ea36:
	bclr r25,r25,0xa
	.global L_93ea3a
L_93ea3a:
	b L_92029c
L_93ea3e:
	nop_s
