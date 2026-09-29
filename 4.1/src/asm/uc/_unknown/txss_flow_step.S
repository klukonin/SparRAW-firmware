/* txss_flow_step @ 0x936658, 524 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__init_sweep
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_b_s0_w5_uc, bf_w_s0_w2_uc, bf_w_s2_w2_uc, bf_w_s4_w4_uc, bf_w_s8_w4_uc, direct_tx__issue_cmd_33, direct_tx__program_cmd34, direct_tx__push_payload, get_g_80087c, mac__program_tx_common
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.txss_flow_step,"ax",@progbits
	.global txss_flow_step
txss_flow_step:
	.global L_936658
L_936658:
	push_s blink
L_93665a:
	bl L_920214
L_93665e:
	sub_s sp,sp,0x18
L_936660:
	mov_s r13,r1
L_936662:
	mov_s r14,r2
L_936664:
	mov_s r0,0x20000400
L_93666a:
	mov_s r32,r0
L_93666c:
	st.ab r0,[r25,0x4]
L_936670:
	bclr r25,r25,0xa
L_936674:
	breq_s r14,0,L_9366a0
L_936676:
	mov_s r0,0x3e
L_936678:
	asl_s r0,r0,0x18
L_93667a:
	mov_s r32,r0
L_93667c:
	st.ab r0,[r25,0x4]
L_936680:
	bclr r25,r25,0xa
L_936684:
	mov_s r0,0x37000020
L_93668a:
	mov_s r32,r0
L_93668c:
	st.ab r0,[r25,0x4]
L_936690:
	bclr r25,r25,0xa
L_936694:
	mov_s r1,0x801458
L_93669a:
	ld_s r0,[r1,0xc]
L_93669c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93669e:
	st_s r0,[r1,0xc]
	.global L_9366a0
L_9366a0:
	mov_s r0,0x886d00
L_9366a6:
	ld_s r0,[r0]
L_9366a8:
	extw_s r0,r0
L_9366aa:
	lsr r1,r0,0x8
L_9366ae:
	mov_s r0,0x800a38
L_9366b4:
	ld_s r0,[r0,0x14]
L_9366b6:
	add_s r0,r0,r1
L_9366b8:
	bset_s r0,r0,0x18
L_9366ba:
	bset_s r0,r0,0x1a
L_9366bc:
	bset_s r0,r0,0x1c
L_9366be:
	mov_s r32,r0
L_9366c0:
	st.ab r0,[r25,0x4]
L_9366c4:
	bclr r25,r25,0xa
L_9366c8:
	mov_s r0,0x14000007
L_9366ce:
	mov_s r32,r0
L_9366d0:
	st.ab r0,[r25,0x4]
L_9366d4:
	bclr r25,r25,0xa
L_9366d8:
	mov_s r3,0x0
L_9366da:
	mov_s r0,sp
L_9366dc:
	mov_s r1,r3
L_9366de:
	bl.d L_93797c
L_9366e2:
	stw r3,[sp]
L_9366e6:
	mov_s r1,0x1
L_9366e8:
	bl.d L_9379ac
L_9366ec:
	mov_s r2,sp
L_9366ee:
	mov_s r1,0x6
L_9366f0:
	bl L_9379d0
L_9366f4:
	mov_s r1,0x9
L_9366f6:
	bl L_937a00
L_9366fa:
	mov_s r0,0x800fcc
L_936700:
	ld_s r14,[r0]
L_936702:
	stb r3,[sp, 0x12]
L_936706:
	bmsk r1,r14,0x5
L_93670a:
	lsr_s r14,r14,0x6
L_93670c:
	bmsk_s r14,r14,0x1
L_93670e:
	/* asl_s r14,r14,0x6 */
	.byte 0x06,0xbe
L_936710:
	or_s r1,r1,r14
L_936712:
	stb_s r1,[sp,0x10]
L_936714:
	ld_s r1,[r0,0x8]
L_936716:
	sub_s r1,r1,0x13
L_936718:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93671a:
	stb r1,[sp, 0x11]
L_93671e:
	mov_s r1,r3
L_936720:
	stb_s r1,[r2,0x13]
L_936722:
	lsr_s r1,r1,0x8
L_936724:
	stb_s r1,[r2,0x14]
L_936726:
	lsr_s r1,r1,0x8
L_936728:
	stb_s r1,[r2,0x15]
L_93672a:
	lsr_s r1,r1,0x8
L_93672c:
	stb_s r1,[r2,0x16]
L_93672e:
	ldb r0,[r0, 0x68]
L_936732:
	bbit0 r0,r13,L_936740
L_936736:
	add r0,sp,0x13
L_93673a:
	mov_s r1,0x10
L_93673c:
	bl L_937958
	.global L_936740
L_936740:
	/* asl_s r13,r13,0x3 */
	.byte 0x03,0xbd
L_936742:
	add3_s r13,r13,r13
L_936744:
	stb_s r3,[r2,0x17]
L_936746:
	add_s r13,r13,0x801190
L_93674c:
	ldw_s r0,[r13,0x2c]
L_93674e:
	stw_s r0,[r2,0x4]
L_936750:
	ldw_s r0,[r13,0x2e]
L_936752:
	stw_s r0,[r2,0x6]
L_936754:
	ldw_s r0,[r13,0x30]
L_936756:
	stw_s r0,[r2,0x8]
L_936758:
	mov_s r0,0x10
L_93675a:
	bl.d L_924ea8
L_93675e:
	mov_s r1,0x18
L_936760:
	bl L_92a3c0
L_936764:
	mov_s r0,0x2008000
L_93676a:
	mov_s r32,r0
L_93676c:
	st.ab r0,[r25,0x4]
L_936770:
	bclr r25,r25,0xa
L_936774:
	ld_s r0,[gp,0xdc]
L_936776:
	and r1,r0,0x10
L_93677a:
	mov_s r0,0x0
L_93677c:
	or.f 0x0,r1,r0
L_936780:
	beq_s L_9367a2
L_936782:
	ld_s r0,[gp,0xe8]
L_936784:
	ld.as r1,[gp,0x3b]
L_936788:
	bic r0,r0,-0x3
L_93678c:
	cmp_s r0,0x2
L_93678e:
	mov_s r0,0x1
L_936790:
	sub_s.ne r0,r0,r0
L_936792:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_936794:
	or r0,r0,0x19800830
L_93679c:
	asl_s r1,r1,0xe
L_93679e:
	or_s r0,r0,r1
L_9367a0:
	b_s L_9367a8
	.global L_9367a2
L_9367a2:
	mov_s r0,0x19000001
	.global L_9367a8
L_9367a8:
	mov_s r32,r0
L_9367aa:
	st.ab r0,[r25,0x4]
L_9367ae:
	bclr r25,r25,0xa
	.global L_9367b2
L_9367b2:
	mov_s r0,r45
L_9367b4:
	bbit0 r0,0x1f,L_9367b2
L_9367b8:
	ld_s r0,[gp,0xdc]
L_9367ba:
	and r1,r0,0x10
L_9367be:
	mov_s r0,0x0
L_9367c0:
	or.f 0x0,r1,r0
L_9367c4:
	mov_s r0,0x18
L_9367c6:
	asl.ne r0,r0,0x18
L_9367ca:
	mov.eq r0,0x18001000
L_9367d2:
	mov_s r32,r0
L_9367d4:
	st.ab r0,[r25,0x4]
L_9367d8:
	bclr r25,r25,0xa
L_9367dc:
	mov_s r13,sp
L_9367de:
	mov_s r0,r13
L_9367e0:
	bl.d L_924ef4
L_9367e4:
	mov_s r1,0xa
L_9367e6:
	ld_s r0,[gp,-0x18]
L_9367e8:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_9367ea:
	st.as r0,[gp,-0x6]
L_9367ee:
	mov_s r0,0x33000443
L_9367f4:
	mov_s r32,r0
L_9367f6:
	st.ab r0,[r25,0x4]
L_9367fa:
	bclr r25,r25,0xa
L_9367fe:
	bl L_924f7c
L_936802:
	ldb r34,[r13, 0x10]
L_936806:
	ldb r34,[r13, 0x11]
L_93680a:
	ldb r34,[r13, 0x12]
L_93680e:
	ld_s r0,[gp,-0x18]
L_936810:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_936812:
	st.as r0,[gp,-0x6]
L_936816:
	ldb r33,[r13, 0x13]
L_93681a:
	ldb_s r1,[r13,0x14]
L_93681c:
	asl_s r1,r1,0x8
L_93681e:
	or r33,r33,r1
L_936822:
	ldb_s r1,[r13,0x15]
L_936824:
	asl_s r1,r1,0x10
L_936826:
	or r33,r33,r1
L_93682a:
	ldb_s r1,[r13,0x16]
L_93682c:
	asl_s r1,r1,0x18
L_93682e:
	or r33,r33,r1
L_936832:
	ld_s r0,[gp,-0x18]
L_936834:
	/* sub_s r0,r0,0x4 */
	.byte 0x64,0xb8
L_936836:
	st.as r0,[gp,-0x6]
L_93683a:
	ldb r34,[r13, 0x17]
L_93683e:
	ld_s r0,[gp,-0x18]
L_936840:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_936842:
	bl.d L_924e6c
L_936846:
	st.as r0,[gp,-0x6]
L_93684a:
	bl.d L_931664
L_93684e:
	mov_s r0,0x6
L_936850:
	bl L_930f34
L_936854:
	mov_s r0,0x0
L_936856:
	bl.d L_9317fc
L_93685a:
	bset_s r0,r0,0xf
L_93685c:
	mov_s r0,0x1
L_93685e:
	b.d L_920284
L_936862:
	add_s sp,sp,0x18
