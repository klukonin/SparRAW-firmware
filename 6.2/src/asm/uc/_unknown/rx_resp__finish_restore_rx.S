/* rx_resp__finish_restore_rx @ 0x9336d8, 592 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_funcs__handle_ppdu_report
 * Зовёт сам: internal_tx__read_result_889568, internal_tx__read_result_889570, mac__set_rf_chain_state, mac_evt__enable_bit_sync_b, phy__read_regs_883844, rx_mode__configure, uc_exception__bad_instruction, uc_read_tsf_lo, uc_spin_until_event, uc_sysassert
 * Глобалы (через gp): 0x80053c, 0x80056c, 0x8005f4, 0x8005f8, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_resp__finish_restore_rx
rx_resp__finish_restore_rx:
	.global L_9336d8
L_9336d8:
	st.a r13,[sp,-0x14]
L_9336dc:
	st blink,[sp, 0x4]
L_9336e0:
	st_s r14,[sp,0x8]
L_9336e2:
	st_s r15,[sp,0xc]
L_9336e4:
	st r16,[sp, 0x10]
L_9336e8:
	mov_s r15,r0
L_9336ea:
	mov_s r16,r1
L_9336ec:
	mov_s r13,r2
L_9336ee:
	mov_s r3,0x0
L_9336f0:
	ld.as r1,[gp,-0x11]
L_9336f4:
	st.a r3,[sp,-0x14]
L_9336f8:
	and r1,r1,0xffff0fff
L_933700:
	st.as r1,[gp,-0x11]
L_933704:
	or r1,r1,0x1d000000
L_93370c:
	mov r32,r1
L_933710:
	st.ab r1,[r25,0x4]
L_933714:
	bclr r25,r25,0xa
L_933718:
	nop_s
L_93371a:
	nop_s
L_93371c:
	nop_s
L_93371e:
	bmsk r2,r40,0x2
L_933722:
	or r2,r2,0xcac000
L_93372a:
	mov_s r32,r2
L_93372c:
	st.ab r2,[r25,0x4]
L_933730:
	bclr r25,r25,0xa
L_933734:
	ld r3,[0x800748]
L_93373c:
	lr r3,[r3]
L_933740:
	bmsk_s r3,r3,0x17
L_933742:
	mov_s r32,r3
L_933744:
	st.ab r3,[r25,0x4]
L_933748:
	bclr r25,r25,0xa
L_93374c:
	bmsk r8,r40,0x2
L_933750:
	or r8,r8,0xcac100
L_933758:
	mov r32,r8
L_93375c:
	st.ab r8,[r25,0x4]
L_933760:
	bclr r25,r25,0xa
L_933764:
	ld r7,[0x800748]
L_93376c:
	lr r7,[r7]
L_933770:
	bmsk r7,r7,0x17
L_933774:
	mov r32,r7
L_933778:
	st.ab r7,[r25,0x4]
L_93377c:
	bclr r25,r25,0xa
L_933780:
	bl.d L_936544
L_933784:
	mov r0,0x6
L_933788:
	breq r13,0x0,L_933830
L_93378c:
	mov_s r14,0x8013d4
L_933792:
	ld_s r0,[r14,0x4]
L_933794:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933796:
	cmp_s r0,0x9
L_933798:
	bhi.d L_933918
L_93379c:
	st r0,[r14, 0x4]
	.global L_9337a0
L_9337a0:
	bl L_929ed4
L_9337a4:
	mov r13,0x802424
L_9337ac:
	bl.d L_929ec8
L_9337b0:
	st r0,[r13]
L_9337b4:
	st_s r0,[r13,0x4]
L_9337b6:
	ld_s r0,[r14,0x4]
L_9337b8:
	mov_s r1,0x857368
L_9337be:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_9337c0:
	add1_s r0,r0,r0
L_9337c2:
	add_s r0,r0,r1
L_9337c4:
	bl.d L_929ea8
L_9337c8:
	mov r1,0x10
L_9337cc:
	ld_s r0,[r13]
L_9337ce:
	mov_s r1,0x0
L_9337d0:
	mov r2,0xc
L_9337d4:
	bl.d L_920484
L_9337d8:
	mov r3,r1
L_9337dc:
	st_s r0,[sp,0x4]
L_9337de:
	st_s r1,[sp,0x8]
L_9337e0:
	ld_s r0,[r13,0x4]
L_9337e2:
	mov_s r1,0x0
L_9337e4:
	mov r2,0xc
L_9337e8:
	bl.d L_920484
L_9337ec:
	mov r3,r1
L_9337f0:
	ld r9,[r14, 0x4]
L_9337f4:
	st_s r1,[sp,0x10]
L_9337f6:
	asl r9,r9,0x5
L_9337fa:
	st_s r0,[sp,0xc]
L_9337fc:
	add1 r9,r9,r9
L_933800:
	ld r11,[sp, 0xc]
L_933804:
	add r7,r9,0x857400
L_93380c:
	ldw r4,[sp, 0x10]
L_933810:
	st r11,[r7, -0xa8]
L_933814:
	stw r4,[r7, -0xa4]
L_933818:
	ldw r11,[sp, 0x4]
L_93381c:
	ldw r10,[sp, 0x6]
L_933820:
	ldw r9,[sp, 0x8]
L_933824:
	stw r11,[r7, -0xa2]
L_933828:
	stw r10,[r7, -0xa0]
L_93382c:
	stw r9,[r7, -0x9e]
	.global L_933830
L_933830:
	brne r16,0x5,L_933840
L_933834:
	mov r0,0x1
L_933838:
	bl.d L_92f4bc
L_93383c:
	ld r1,[r15]
	.global L_933840
L_933840:
	ld r6,[0x802288]
L_933848:
	mov_s r13,0x0
L_93384a:
	ld.as r10,[gp,0x33]
L_93384e:
	st_s r13,[sp,0x0]
L_933850:
	and r1,r10,0x2
L_933854:
	or.f 0x0,r1,r13
L_933858:
	mov r2,sp
L_93385c:
	beq.d L_933870
L_933860:
	ld.as r11,[gp,0x34]
L_933864:
	bic r11,r11,-0x120
L_933868:
	cmp r11,0x100
L_93386c:
	beq L_9338b4
	.global L_933870
L_933870:
	mov_s r0,0x1
L_933872:
	st_s r0,[r2]
L_933874:
	ld_s r0,[gp,0x44]
L_933876:
	mov_s r3,0x802978
L_93387c:
	breq.d r0,0x0,L_93389c
L_933880:
	ld r8,[r3, 0x78]
L_933884:
	asl r6,r6,0x4
L_933888:
	add2 r6,r6,r6
L_93388c:
	ld r2,[r6,0x801108]
L_933894:
	st r2,[r8, 0x2c]
L_933898:
	ld r8,[r3, 0x78]
	.global L_93389c
L_93389c:
	mov r0,0x1
L_9338a0:
	bl.d L_92f42c
L_9338a4:
	ld r1,[r8, 0x2c]
L_9338a8:
	ld.as r1,[gp,0x11]
L_9338ac:
	breq r1,0x0,L_9338b4
L_9338b0:
	st.as r13,[gp,0x11]
	.global L_9338b4
L_9338b4:
	mov r0,0x0
L_9338b8:
	bl.d L_9366dc
L_9338bc:
	bset r0,r0,0xf
L_9338c0:
	bl.d L_936544
L_9338c4:
	mov r0,0x5
L_9338c8:
	ld r5,[sp]
L_9338cc:
	brne r5,0x1,L_9338f8
L_9338d0:
	ld.as r10,[gp,0x5e]
L_9338d4:
	ld r11,[0x802944]
L_9338dc:
	and r10,r10,0xfcffffff
L_9338e4:
	asl r11,r11,0x18
L_9338e8:
	or r10,r10,r11
L_9338ec:
	st.as r10,[gp,0x5e]
L_9338f0:
	st r10,[0x889488]
	.global L_9338f8
L_9338f8:
	bl L_9364c8
L_9338fc:
	st.as r0,[gp,0x5]
L_933900:
	mov_s r0,0x1
L_933902:
	add_s sp,sp,0x14
L_933904:
	ld blink,[sp, 0x4]
L_933908:
	ld_s r14,[sp,0x8]
L_93390a:
	ld_s r15,[sp,0xc]
L_93390c:
	ld r16,[sp, 0x10]
L_933910:
	j.d [blink]
L_933914:
	ld.ab r13,[sp,0x14]
	.global L_933918
L_933918:
	mov_s r0,blink
L_93391a:
	mov_s r1,0x144b
L_933920:
	bl L_926618
L_933924:
	b_s L_9337a0
L_933926:
	nop_s
