/* bi_manager__rx_flow_body @ 0x932704, 320 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_rx_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bi_rx__send_response, mac__build_tx_common_params, mac__cmd_29000001, mac__select_all_sectors_and_wait, mac__select_sector_and_wait_b, mac__set_rf_chain_state, tail_uc_wait_two_events, uc_spin_until_event
 * Глобалы (через gp): 0x800604, 0x800608
 */
	.section .text.bi_manager__rx_flow_body,"ax",@progbits
	.global bi_manager__rx_flow_body
bi_manager__rx_flow_body:
	.global L_932704
L_932704:
	push_s blink
L_932706:
	bl L_920210
L_93270a:
	st.a r0,[sp,-0x8]
L_93270e:
	st_s r1,[sp,0x4]
L_932710:
	mov.f r14,r2
L_932714:
	mov_s r13,0x26
L_932716:
	mov.eq r13,0x15
L_93271a:
	ld_s r0,[sp,0x0]
L_93271c:
	mov_s r1,0x801198
L_932722:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_932724:
	add3_s r0,r0,r0
L_932726:
	ld_s r15,[r1,r0]
L_932728:
	mov_s r1,0x2
L_93272a:
	bset_s r1,r1,0xd
L_93272c:
	mov_s r0,0x0
L_93272e:
	st.as r0,[gp,0x38]
L_932732:
	ld_s r0,[gp,-0x44]
L_932734:
	st.as r1,[gp,0x37]
L_932738:
	and r0,r0,0xffff0fff
L_932740:
	bset r1,r0,0xd
L_932744:
	bset_s r1,r1,0xf
L_932746:
	st.as r1,[gp,-0x11]
L_93274a:
	or r0,r0,0x1d00a000
L_932752:
	mov_s r32,r0
L_932754:
	st.ab r0,[r25,0x4]
L_932758:
	bclr r25,r25,0xa
L_93275c:
	bl L_931980
L_932760:
	bl L_931640
L_932764:
	mov_s r1,r40
L_932766:
	mov_s r0,r42
L_932768:
	bbit1 r0,0xe,L_932770
L_93276c:
	bbit1 r1,0x18,L_93278a
	.global L_932770
L_932770:
	mov_s r0,r45
L_932772:
	bbit0 r0,0x1f,L_932770
L_932776:
	mov_s r0,0x29000002
L_93277c:
	mov_s r32,r0
L_93277e:
	st.ab r0,[r25,0x4]
L_932782:
	bclr r25,r25,0xa
L_932786:
	mov_s r0,0x0
L_932788:
	b_s L_93283c
	.global L_93278a
L_93278a:
	breq_s r14,0,L_93279c
L_93278c:
	mov_s r0,0x20000400
L_932792:
	mov_s r32,r0
L_932794:
	st.ab r0,[r25,0x4]
L_932798:
	bclr r25,r25,0xa
	.global L_93279c
L_93279c:
	ld_s r2,[sp,0x4]
L_93279e:
	mov_s r0,0x5
L_9327a0:
	mov_s r1,r15
L_9327a2:
	bl.d L_92bb2c
L_9327a6:
	mov_s r3,0x0
L_9327a8:
	bset_s r13,r13,0x18
L_9327aa:
	bset_s r13,r13,0x1a
L_9327ac:
	bset_s r13,r13,0x1c
L_9327ae:
	mov_s r32,r13
L_9327b0:
	st.ab r13,[r25,0x4]
L_9327b4:
	bclr r25,r25,0xa
L_9327b8:
	mov_s r0,0x14000007
L_9327be:
	mov_s r32,r0
L_9327c0:
	st.ab r0,[r25,0x4]
L_9327c4:
	bclr r25,r25,0xa
L_9327c8:
	mov_s r0,0x2008000
L_9327ce:
	mov_s r32,r0
L_9327d0:
	st.ab r0,[r25,0x4]
L_9327d4:
	bclr r25,r25,0xa
L_9327d8:
	mov_s r0,0x19000001
L_9327de:
	mov_s r32,r0
L_9327e0:
	st.ab r0,[r25,0x4]
L_9327e4:
	bclr r25,r25,0xa
L_9327e8:
	ld_s r0,[sp,0x0]
L_9327ea:
	mov_s r2,0x9
L_9327ec:
	ld_s r1,[sp,0x4]
L_9327ee:
	bl.d L_933dd8
L_9327f2:
	mov_s r3,r14
L_9327f4:
	bl.d L_931664
L_9327f8:
	mov_s r0,0x6
L_9327fa:
	mov_s r0,0x0
L_9327fc:
	bl.d L_9317fc
L_932800:
	bset_s r0,r0,0xf
L_932802:
	mov_s r1,0x80090c
L_932808:
	ldb_s r0,[r1,0xf]
L_93280a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93280c:
	extb_s r0,r0
L_93280e:
	stb_s r0,[r1,0xf]
L_932810:
	bl.d L_9316a8
L_932814:
	mov_s r0,0x6
L_932816:
	mov_s r0,0x14
L_932818:
	asl_s r0,r0,0x18
L_93281a:
	mov_s r32,r0
L_93281c:
	st.ab r0,[r25,0x4]
L_932820:
	bclr r25,r25,0xa
L_932824:
	ld_s r0,[sp,0x0]
L_932826:
	mov_s r1,0x801194
L_93282c:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_93282e:
	add3_s r0,r0,r0
L_932830:
	ld_s r1,[r1,r0]
L_932832:
	mov_s r13,0x1
L_932834:
	bl.d L_92b934
L_932838:
	mov_s r0,r13
L_93283a:
	mov_s r0,r13
	.global L_93283c
L_93283c:
	b.d L_92027c
L_932840:
	add_s sp,sp,0x8
L_932842:
	nop_s
