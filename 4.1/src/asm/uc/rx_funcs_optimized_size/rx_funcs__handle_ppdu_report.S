/* rx_funcs__handle_ppdu_report @ 0x92d740, 1028 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_funcs_optimized_size.c
 * Зовут его: rx_flow__run
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, get_tx_eligibility, hw_modes_mac__switch_core, mac_mode__switch_after_ppdu, rf_sector__find_by_id, rf_sector__program_selected, rx__mac_prepare, rx__send_response_frame, rx__switch_to_rx_mode, rx_funcs__on_rx_type_0x14, rx_funcs__record_level_800fa0
 * Глобалы (через gp): 0x8005d8, 0x800604, 0x800608
 */
	.section .text.rx_funcs__handle_ppdu_report,"ax",@progbits
	.global rx_funcs__handle_ppdu_report
rx_funcs__handle_ppdu_report:
	.global L_92d740
L_92d740:
	push_s blink
L_92d742:
	bl.d L_920210
L_92d746:
	mov_s r0,0x1
L_92d748:
	sub_s sp,sp,0xc
L_92d74a:
	st.as r0,[gp,-0x10]
L_92d74e:
	mov_s r0,0xeeee0a
L_92d754:
	mov_s r32,r0
L_92d756:
	st.ab r0,[r25,0x4]
L_92d75a:
	bclr r25,r25,0xa
L_92d75e:
	mov_s r0,0x0
L_92d760:
	bset_s r0,r0,0x10
L_92d762:
	bl.d L_931808
L_92d766:
	mov_s r1,0x0
L_92d768:
	ldb_s r0,[gp,-0xf3]
L_92d76a:
	brne_s r0,0,L_92d788
L_92d76c:
	ldb_s r0,[gp,-0xf9]
L_92d76e:
	bmsk_s r0,r0,0x0
L_92d770:
	bset_s r0,r0,0x19
L_92d772:
	bset_s r0,r0,0x1c
L_92d774:
	bset_s r0,r0,0x1d
L_92d776:
	mov_s r32,r0
L_92d778:
	st.ab r0,[r25,0x4]
L_92d77c:
	bclr r25,r25,0xa
L_92d780:
	ldb_s r0,[gp,-0xf9]
L_92d782:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92d784:
	stb r0,[gp, -0xf9]
	.global L_92d788
L_92d788:
	mov_s r0,r38
L_92d78a:
	mov_s r13,0x801418
L_92d790:
	bbit0 r0,0xb,L_92d79c
L_92d794:
	lsr r0,r38,0x8
L_92d798:
	bmsk_s r0,r0,0x2
L_92d79a:
	b_s L_92d7be
	.global L_92d79c
L_92d79c:
	mov_s r0,r36
L_92d79e:
	bbit0 r0,0x7,L_92d7ae
L_92d7a2:
	mov_s r0,0x804014
	.global L_92d7a8
L_92d7a8:
	bl L_930114
L_92d7ac:
	b_s L_92d7be
	.global L_92d7ae
L_92d7ae:
	mov_s r0,r36
L_92d7b0:
	btst_s r0,0x6
L_92d7b2:
	mov.ne r0,0x80401a
L_92d7ba:
	bne_s L_92d7a8
L_92d7bc:
	mov_s r0,0x8
	.global L_92d7be
L_92d7be:
	st_s r0,[r13]
L_92d7c0:
	mov_s r0,r37
L_92d7c2:
	mov_s r13,0x804010
L_92d7c8:
	bbit0 r0,0x0,L_92d816
L_92d7cc:
	ld_s r0,[gp,0xdc]
L_92d7ce:
	bbit1 r0,0xa,L_92d7fe
L_92d7d2:
	mov_s r0,0x801418
L_92d7d8:
	ld_s r0,[r0]
L_92d7da:
	mov_s r1,0x801198
L_92d7e0:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_92d7e2:
	add3_s r0,r0,r0
L_92d7e4:
	bl.d L_92b848
L_92d7e8:
	ld_s r0,[r1,r0]
L_92d7ea:
	bl L_93137c
L_92d7ee:
	mov_s r0,0x801b60
L_92d7f4:
	bl.d L_92f12c
L_92d7f8:
	mov_s r1,0x8
L_92d7fa:
	bl L_9377bc
	.global L_92d7fe
L_92d7fe:
	mov_s r1,0x801038
L_92d804:
	ld_s r0,[r1]
L_92d806:
	bset_s r0,r0,0x4
L_92d808:
	st_s r0,[r1]
L_92d80a:
	mov_s r1,0x801458
L_92d810:
	ld_s r0,[r1,0x70]
L_92d812:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92d814:
	st_s r0,[r1,0x70]
	.global L_92d816
L_92d816:
	mov_s r2,0x80401a
L_92d81c:
	mov_s r1,0x80100c
L_92d822:
	ldw_s r3,[r2]
L_92d824:
	ldw_s r0,[r1,0x1c]
L_92d826:
	cmp_s r3,r0
L_92d828:
	bne L_92db2a
L_92d82c:
	ldw_s r3,[r2,0x2]
L_92d82e:
	ldw_s r0,[r1,0x1e]
L_92d830:
	cmp_s r3,r0
L_92d832:
	bne L_92db2a
L_92d836:
	ldw_s r2,[r2,0x4]
L_92d838:
	ldw_s r0,[r1,0x20]
L_92d83a:
	cmp_s r2,r0
L_92d83c:
	bne L_92db2a
L_92d840:
	ld_s r0,[gp,0xe0]
L_92d842:
	bbit0 r0,0x15,L_92d856
L_92d846:
	mov_s r0,r37
L_92d848:
	bbit0 r0,0x18,L_92d856
L_92d84c:
	mov_s r0,r39
L_92d84e:
	btst_s r0,0xf
L_92d850:
	bl.ne L_9248e8
L_92d854:
	b_s L_92d8b0
	.global L_92d856
L_92d856:
	mov_s r0,r36
L_92d858:
	bbit0 r0,0x6,L_92d892
L_92d85c:
	mov_s r0,r37
L_92d85e:
	bbit0 r0,0x18,L_92d86e
L_92d862:
	mov_s r1,0x801038
L_92d868:
	ld_s r0,[r1]
L_92d86a:
	bset_s r0,r0,0x0
L_92d86c:
	b_s L_92d8ae
	.global L_92d86e
L_92d86e:
	mov_s r0,r37
L_92d870:
	bbit0 r0,0x19,L_92d880
L_92d874:
	mov_s r1,0x801038
L_92d87a:
	ld_s r0,[r1]
L_92d87c:
	bset_s r0,r0,0x2
L_92d87e:
	b_s L_92d8ae
	.global L_92d880
L_92d880:
	mov_s r0,r37
L_92d882:
	bbit0 r0,0x1a,L_92d8b0
L_92d886:
	mov_s r1,0x801038
L_92d88c:
	ld_s r0,[r1]
L_92d88e:
	bset_s r0,r0,0x3
L_92d890:
	b_s L_92d8ae
	.global L_92d892
L_92d892:
	mov_s r0,r36
L_92d894:
	bbit0 r0,0x19,L_92d89e
L_92d898:
	bl L_92aa7c
L_92d89c:
	b_s L_92d8b0
	.global L_92d89e
L_92d89e:
	mov_s r0,r37
L_92d8a0:
	bbit0 r0,0x0,L_92d8b0
L_92d8a4:
	mov_s r1,0x801038
L_92d8aa:
	ld_s r0,[r1]
L_92d8ac:
	bset_s r0,r0,0x4
	.global L_92d8ae
L_92d8ae:
	st_s r0,[r1]
	.global L_92d8b0
L_92d8b0:
	ld_s r0,[gp,0xe0]
L_92d8b2:
	cmp_s r0,0x800000
L_92d8b8:
	beq L_92da98
L_92d8bc:
	bgt L_92d93c
L_92d8c0:
	cmp_s r0,0x100000
L_92d8c6:
	beq_s L_92d986
L_92d8c8:
	bgt_s L_92d8d8
L_92d8ca:
	cmp_s r0,0x80000
L_92d8d0:
	beq L_92db2a
L_92d8d4:
	b L_92db18
	.global L_92d8d8
L_92d8d8:
	cmp_s r0,0x200000
L_92d8de:
	beq_s L_92d9c2
L_92d8e0:
	cmp_s r0,0x400000
L_92d8e6:
	bne L_92db18
L_92d8ea:
	mov_s r0,r37
L_92d8ec:
	btst_s r0,0x1a
L_92d8ee:
	mov_s r14,0x801038
L_92d8f4:
	beq L_92db2a
L_92d8f8:
	mov_s r0,sp
L_92d8fa:
	add_s r1,sp,0x4
L_92d8fc:
	bl.d L_92616c
L_92d900:
	add_s r2,sp,0x8
L_92d902:
	bl.d L_922a10
L_92d906:
	ldb.x r0,[sp, 0x8]
L_92d90a:
	ld_s r0,[r14]
L_92d90c:
	bset_s r0,r0,0x3
L_92d90e:
	st_s r0,[r14]
L_92d910:
	mov_s r0,0x801418
L_92d916:
	ldb_s r1,[r13,0x13]
L_92d918:
	ld_s r0,[r0]
L_92d91a:
	bmsk_s r1,r1,0x4
L_92d91c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92d91e:
	add1_s r0,r0,r0
L_92d920:
	add_s r0,r0,0x800ef4
L_92d926:
	stb_s r1,[r0,0xa]
L_92d928:
	ldb_s r1,[r13,0x13]
L_92d92a:
	btst_s r1,0x6
L_92d92c:
	btst.eq r1,0x7
L_92d930:
	bne_s L_92da90
L_92d932:
	ldb_s r1,[r0,0xb]
L_92d934:
	bset_s r1,r1,0x0
L_92d936:
	stb_s r1,[r0,0xb]
L_92d938:
	b L_92db2a
	.global L_92d93c
L_92d93c:
	cmp_s r0,0x8000000
L_92d942:
	beq L_92db2a
L_92d946:
	bgt_s L_92d964
L_92d948:
	cmp_s r0,0x4000000
L_92d94e:
	bne L_92db18
L_92d952:
	mov_s r0,0x801038
L_92d958:
	ld_s r0,[r0]
L_92d95a:
	btst_s r0,0x5
L_92d95c:
	beq L_92db2a
L_92d960:
	b L_92db12
	.global L_92d964
L_92d964:
	cmp_s r0,0x10000000
L_92d96a:
	beq_s L_92dafa
L_92d96c:
	cmp_s r0,0x20000000
L_92d972:
	bne L_92db18
L_92d976:
	mov_s r0,0x801038
L_92d97c:
	ld_s r0,[r0]
L_92d97e:
	btst_s r0,0xa
L_92d980:
	beq L_92db2a
L_92d984:
	b_s L_92db12
	.global L_92d986
L_92d986:
	mov_s r0,r37
L_92d988:
	bbit0 r0,0x18,L_92d9c2
L_92d98c:
	mov_s r1,0x801a08
L_92d992:
	ldw_s r0,[gp,0xb0]
L_92d994:
	ldw_s r1,[r1,0xc]
L_92d996:
	breq r0,r1,L_92d9c2
L_92d99a:
	stw.as r1,[gp,0x58]
L_92d99e:
	or r1,r1,0x1730000
L_92d9a6:
	mov_s r0,0x886d00
L_92d9ac:
	st_s r1,[r0]
L_92d9ae:
	sync
L_92d9b2:
	mov_s r0,0x38000200
L_92d9b8:
	mov_s r32,r0
L_92d9ba:
	st.ab r0,[r25,0x4]
L_92d9be:
	bclr r25,r25,0xa
	.global L_92d9c2
L_92d9c2:
	mov_s r0,r37
L_92d9c4:
	btst_s r0,0x18
L_92d9c6:
	mov_s r2,0x801038
L_92d9cc:
	beq_s L_92db2a
L_92d9ce:
	mov_s r0,0x804010
L_92d9d4:
	ldw_s r3,[r0,0x10]
L_92d9d6:
	ld_s r1,[r2]
L_92d9d8:
	bbit1 r3,0x0,L_92d9e2
L_92d9dc:
	ld_s r0,[gp,0xdc]
L_92d9de:
	bbit1 r0,0x6,L_92d9ec
	.global L_92d9e2
L_92d9e2:
	bbit0 r3,0x0,L_92da72
L_92d9e6:
	ld_s r0,[gp,0xdc]
L_92d9e8:
	bbit0 r0,0x5,L_92da72
	.global L_92d9ec
L_92d9ec:
	bset_s r1,r1,0x0
L_92d9ee:
	st_s r1,[r2]
L_92d9f0:
	mov_s r0,sp
L_92d9f2:
	add_s r1,sp,0x4
L_92d9f4:
	bl.d L_937238
L_92d9f8:
	mov_s r2,0x0
L_92d9fa:
	mov_s r0,r39
L_92d9fc:
	ld.as r2,[gp,0x37]
L_92da00:
	bbit0 r0,0xf,L_92da78
L_92da04:
	mov_s r14,0x801418
L_92da0a:
	ld_s r0,[r14]
L_92da0c:
	mov_s r1,0x801b3c
L_92da12:
	ld.as r13,[r1,r0]
L_92da16:
	mov_s r3,0x801038
L_92da1c:
	ld_s r1,[r3]
L_92da1e:
	bset_s r1,r1,0x1
L_92da20:
	st_s r1,[r3]
L_92da22:
	bbit0 r2,0x5,L_92da3e
L_92da26:
	ld_s r1,[sp,0x0]
L_92da28:
	ld_s r2,[sp,0x4]
L_92da2a:
	bl.d L_937448
L_92da2e:
	mov_s r3,0x1
L_92da30:
	ld_s r0,[r14]
L_92da32:
	mov_s r1,0x801198
L_92da38:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_92da3a:
	add3_s r0,r0,r0
L_92da3c:
	ld_s r13,[r1,r0]
	.global L_92da3e
L_92da3e:
	mov_s r0,0x37000005
L_92da44:
	mov_s r32,r0
L_92da46:
	st.ab r0,[r25,0x4]
L_92da4a:
	bclr r25,r25,0xa
L_92da4e:
	mov_s r0,0x37000002
L_92da54:
	mov_s r32,r0
L_92da56:
	st.ab r0,[r25,0x4]
L_92da5a:
	bclr r25,r25,0xa
L_92da5e:
	or r13,r13,0x3f000000
L_92da66:
	mov_s r32,r13
L_92da68:
	st.ab r13,[r25,0x4]
L_92da6c:
	bclr r25,r25,0xa
L_92da70:
	b_s L_92db3e
	.global L_92da72
L_92da72:
	bclr_s r1,r1,0x0
L_92da74:
	st_s r1,[r2]
L_92da76:
	b_s L_92db2a
	.global L_92da78
L_92da78:
	bbit0 r2,0x5,L_92db2a
L_92da7c:
	mov_s r0,0x801418
L_92da82:
	ld_s r0,[r0]
L_92da84:
	ld_s r1,[sp,0x0]
L_92da86:
	ld_s r2,[sp,0x4]
L_92da88:
	bl.d L_937448
L_92da8c:
	mov_s r3,0x1
L_92da8e:
	b_s L_92db2a
	.global L_92da90
L_92da90:
	ldb_s r1,[r0,0xb]
L_92da92:
	bclr_s r1,r1,0x0
L_92da94:
	stb_s r1,[r0,0xb]
L_92da96:
	b_s L_92db2a
	.global L_92da98
L_92da98:
	mov_s r0,r37
L_92da9a:
	mov_s r14,0x801038
L_92daa0:
	bbit0 r0,0x19,L_92db2a
L_92daa4:
	mov_s r0,sp
L_92daa6:
	add_s r1,sp,0x4
L_92daa8:
	bl.d L_92616c
L_92daac:
	add_s r2,sp,0x8
L_92daae:
	bl.d L_922a10
L_92dab2:
	ldb.x r0,[sp, 0x8]
L_92dab6:
	mov_s r15,0x801418
L_92dabc:
	ld_s r0,[r15]
L_92dabe:
	ld_s r1,[sp,0x0]
L_92dac0:
	ld_s r2,[sp,0x4]
L_92dac2:
	bl.d L_937448
L_92dac6:
	mov_s r3,0x1
L_92dac8:
	ld_s r0,[r14]
L_92daca:
	ld_s r1,[r15]
L_92dacc:
	bset_s r0,r0,0x2
L_92dace:
	st_s r0,[r14]
L_92dad0:
	ldb_s r0,[r13,0x13]
L_92dad2:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_92dad4:
	add1_s r1,r1,r1
L_92dad6:
	bmsk_s r0,r0,0x4
L_92dad8:
	add_s r1,r1,0x800ef4
L_92dade:
	stb_s r0,[r1,0xa]
L_92dae0:
	ldb_s r0,[r13,0x13]
L_92dae2:
	btst_s r0,0x6
L_92dae4:
	btst.eq r0,0x7
L_92dae8:
	bne_s L_92daf2
L_92daea:
	ldb_s r0,[r1,0xb]
L_92daec:
	bset_s r0,r0,0x0
L_92daee:
	stb_s r0,[r1,0xb]
L_92daf0:
	b_s L_92db3e
	.global L_92daf2
L_92daf2:
	ldb_s r0,[r1,0xb]
L_92daf4:
	bclr_s r0,r0,0x0
L_92daf6:
	stb_s r0,[r1,0xb]
L_92daf8:
	b_s L_92db3e
	.global L_92dafa
L_92dafa:
	mov_s r0,0x801038
L_92db00:
	ld_s r0,[r0]
L_92db02:
	btst_s r0,0xb
L_92db04:
	btst.ne r0,0xa
L_92db08:
	btst.eq r0,0x2
L_92db0c:
	beq_s L_92db2a
L_92db0e:
	bbit0 r0,0x2,L_92db3e
	.global L_92db12
L_92db12:
	bl L_927944
L_92db16:
	b_s L_92db3e
	.global L_92db18
L_92db18:
	mov_s r0,blink
L_92db1a:
	mov_s r2,0x1002428
L_92db20:
	mov_s r1,0x18
L_92db22:
	bl.d L_925548
L_92db26:
	mov r3,0x1c1
	.global L_92db2a
L_92db2a:
	mov_s r0,0x801038
L_92db30:
	ld_s r0,[r0]
L_92db32:
	cmp_s r0,0x0
L_92db34:
	bl.ne.d L_936d50
L_92db38:
	sub_s.ne r0,r0,r0
L_92db3a:
	bl L_92b7c4
	.global L_92db3e
L_92db3e:
	b.d L_92027c
L_92db42:
	add_s sp,sp,0xc
