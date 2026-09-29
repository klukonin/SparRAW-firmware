/* direct_tx__send_from_desc @ 0x93869c, 484 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: direct_tx__send_ctrl_frame
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, direct_tx__issue_cmd_33, direct_tx__program_cmd34, mac__cmd_29000001, mac__program_rx_window, mac__program_tx_with_rate, mac__select_all_sectors_and_wait, mac__set_rf_chain_state, mac_evt__enable_bit_sync_b, rx_mode__configure, tx_fifo__write_bytes
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__send_from_desc
direct_tx__send_from_desc:
	.global L_93869c
L_93869c:
	push_s blink
L_93869e:
	bl L_920224
L_9386a2:
	mov_s r14,r0
L_9386a4:
	push_s r1
L_9386a6:
	mov r18,r4
L_9386aa:
	mov r16,r5
L_9386ae:
	mov_s r15,r6
L_9386b0:
	ldw r17,[r0]
L_9386b4:
	breq_s r2,0,L_9386c2
L_9386b6:
	ld_s r0,[gp,-0xc]
L_9386b8:
	asl_s r3,r3,0x8
L_9386ba:
	or r13,r0,0x30
L_9386be:
	or_s r13,r13,r3
L_9386c0:
	b_s L_9386d0
	.global L_9386c2
L_9386c2:
	ld_s r0,[sp,0x0]
L_9386c4:
	mov_s r1,0x80110c
L_9386ca:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9386cc:
	add2_s r0,r0,r0
L_9386ce:
	ld_s r13,[r1,r0]
	.global L_9386d0
L_9386d0:
	mov_s r0,0x10
L_9386d2:
	bl.d L_9257a8
L_9386d6:
	mov_s r1,r15
L_9386d8:
	ldw_s r0,[r14,0x2]
L_9386da:
	bset_s r0,r0,0x18
L_9386dc:
	bset_s r0,r0,0x1a
L_9386de:
	bset_s r0,r0,0x1c
L_9386e0:
	mov_s r32,r0
L_9386e2:
	st.ab r0,[r25,0x4]
L_9386e6:
	bclr r25,r25,0xa
L_9386ea:
	mov_s r0,0x14000007
L_9386f0:
	mov_s r32,r0
L_9386f2:
	st.ab r0,[r25,0x4]
L_9386f6:
	bclr r25,r25,0xa
L_9386fa:
	bl.d L_92d8e8
L_9386fe:
	mov_s r0,r16
L_938700:
	ld_s r0,[gp,-0x44]
L_938702:
	and r0,r0,0xffff0fff
L_93870a:
	bset r1,r0,0xd
L_93870e:
	bset_s r1,r1,0xf
L_938710:
	or r0,r0,0x1d00a000
L_938718:
	st.as r1,[gp,-0x11]
L_93871c:
	mov_s r32,r0
L_93871e:
	st.ab r0,[r25,0x4]
L_938722:
	bclr r25,r25,0xa
L_938726:
	mov r33,r17
L_93872a:
	ld_s r0,[gp,-0x14]
L_93872c:
	/* sub_s r0,r0,0x4 */
	.byte 0x64,0xb8
L_93872e:
	st.as r0,[gp,-0x5]
L_938732:
	mov_s r0,0x0
L_938734:
	bl.d L_92f4bc
L_938738:
	ld_s r1,[sp,0x0]
L_93873a:
	bl L_936870
L_93873e:
	bl L_936520
L_938742:
	mov_s r1,r40
L_938744:
	mov_s r0,r42
L_938746:
	bbit1 r0,0xe,L_93874e
L_93874a:
	bbit1 r1,0x18,L_938770
	.global L_93874e
L_93874e:
	mov_s r0,r45
L_938750:
	bbit0 r0,0x1f,L_93874e
L_938754:
	mov_s r0,0x29000002
L_93875a:
	mov_s r32,r0
L_93875c:
	st.ab r0,[r25,0x4]
L_938760:
	bclr r25,r25,0xa
L_938764:
	mov_s r0,0x3
L_938766:
	bl.d L_92f4bc
L_93876a:
	ld_s r1,[sp,0x0]
L_93876c:
	mov_s r0,0x0
L_93876e:
	b_s L_93887a
	.global L_938770
L_938770:
	mov_s r0,0x5
L_938772:
	mov_s r1,r13
L_938774:
	mov_s r2,r16
L_938776:
	bl.d L_92f798
L_93877a:
	mov_s r3,0x0
L_93877c:
	mov_s r0,0x2008000
L_938782:
	mov_s r32,r0
L_938784:
	st.ab r0,[r25,0x4]
L_938788:
	bclr r25,r25,0xa
L_93878c:
	mov_s r0,0x19000001
L_938792:
	mov_s r32,r0
L_938794:
	st.ab r0,[r25,0x4]
L_938798:
	bclr r25,r25,0xa
	.global L_93879c
L_93879c:
	mov_s r0,r45
L_93879e:
	bbit0 r0,0x1f,L_93879c
L_9387a2:
	mov_s r0,0x18001000
L_9387a8:
	mov_s r32,r0
L_9387aa:
	st.ab r0,[r25,0x4]
L_9387ae:
	bclr r25,r25,0xa
L_9387b2:
	ld_s r0,[sp,0x0]
L_9387b4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9387b6:
	add2_s r0,r0,r0
L_9387b8:
	add_s r0,r0,0x801104
L_9387be:
	add r1,r0,0x30
L_9387c2:
	ldw_s r0,[r0,0x30]
L_9387c4:
	bset r34,r0,0x18
L_9387c8:
	ldw_s r0,[r1,0x2]
L_9387ca:
	bset r34,r0,0x18
L_9387ce:
	ldw_s r0,[r1,0x4]
L_9387d0:
	bset r34,r0,0x18
L_9387d4:
	ld_s r0,[gp,-0x14]
L_9387d6:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_9387d8:
	st.as r0,[gp,-0x5]
L_9387dc:
	bl.d L_936544
L_9387e0:
	mov_s r0,0x6
L_9387e2:
	ld_s r0,[gp,-0x44]
L_9387e4:
	and r0,r0,0xfff0ffff
L_9387ec:
	bset r1,r0,0x12
L_9387f0:
	or r0,r0,0x1d040000
L_9387f8:
	st.as r1,[gp,-0x11]
L_9387fc:
	mov_s r32,r0
L_9387fe:
	st.ab r0,[r25,0x4]
L_938802:
	bclr r25,r25,0xa
L_938806:
	nop_s
L_938808:
	nop_s
L_93880a:
	nop_s
L_93880c:
	mov_s r12,r47
L_93880e:
	bic.f r12,r12,-0x71
L_938812:
	beq_s L_938822
	.global L_938814
L_938814:
	breq r18,0x0,L_938830
L_938818:
	mov_s r0,0x801024
L_93881e:
	ld_s r1,[r0]
L_938820:
	b_s L_93883e
	.global L_938822
L_938822:
	mov_s r0,blink
L_938824:
	mov_s r1,0x133b
L_93882a:
	bl L_926618
L_93882e:
	b_s L_938814
	.global L_938830
L_938830:
	ld_s r0,[sp,0x0]
L_938832:
	mov_s r1,0x801108
L_938838:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93883a:
	add2_s r0,r0,r0
L_93883c:
	ld_s r1,[r1,r0]
	.global L_93883e
L_93883e:
	bl.d L_92f42c
L_938842:
	mov_s r0,0x1
L_938844:
	ld_s r0,[gp,-0x14]
L_938846:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_938848:
	st.as r0,[gp,-0x5]
L_93884c:
	mov_s r0,0x33000443
L_938852:
	mov_s r32,r0
L_938854:
	st.ab r0,[r25,0x4]
L_938858:
	bclr r25,r25,0xa
L_93885c:
	bl L_925874
L_938860:
	add r0,r14,0x10
L_938864:
	bl.d L_9257f4
L_938868:
	sub r1,r15,0x10
L_93886c:
	bl L_925774
L_938870:
	mov_s r0,0x0
L_938872:
	bl.d L_9366dc
L_938876:
	bset_s r0,r0,0xf
L_938878:
	mov_s r0,0x1
	.global L_93887a
L_93887a:
	b.d L_920284
L_93887e:
	add_s sp,sp,0x4
