/* txop_initiator_open_txop_flow @ 0x934884, 900 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_slot_flows.c
 *   txop_initiator_open_txop_flow():TRUE TxOP opened (sent RTS/Self-CTS)
 * Зовут его: tx_initiator_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bi_tx__check_idle_and_start, direct_tx__program_cmd34, mac__program_tx_rate, mac__program_tx_with_qid, mac__program_tx_with_rate, mac__set_rf_chain_state, mac_counter__program_0008, mac_counter__program_3009, mtp_queue__release_mgmt, tail_uc_wait_two_events
 * Глобалы (через gp): 0x800570, 0x8005b8, 0x800604, 0x800608, 0x800610, 0x800614
 */
	.section .text.txop_initiator_open_txop_flow,"ax",@progbits
	.global txop_initiator_open_txop_flow
txop_initiator_open_txop_flow:
	.global L_934884
L_934884:
	push_s blink
L_934886:
	bl L_920210
L_93488a:
	ld_s r0,[gp,0xe0]
L_93488c:
	mov_s r1,0x801a18
L_934892:
	and r0,r0,0x40000000
L_93489a:
	sub.f r13,r0,0x0
L_93489e:
	ld_s r14,[r1,0x60]
L_9348a0:
	mov_s r0,0x13
L_9348a2:
	st_s r0,[r14,0x14]
L_9348a4:
	ld_s r1,[r1,0x60]
L_9348a6:
	mov.ne r13,0x1
L_9348aa:
	ld_s r0,[r1,0x4]
L_9348ac:
	mov_s r2,0x801130
L_9348b2:
	add1_s r0,r0,r0
L_9348b4:
	ldb_s r0,[r2,r0]
L_9348b6:
	sub_s sp,sp,0x10
L_9348b8:
	breq_s r0,0,L_9348c0
L_9348ba:
	ld_s r0,[r1,0x14]
L_9348bc:
	bset_s r0,r0,0x6
L_9348be:
	st_s r0,[r1,0x14]
	.global L_9348c0
L_9348c0:
	ld_s r0,[gp,-0x44]
L_9348c2:
	and r0,r0,0xffff0fff
L_9348ca:
	bset r1,r0,0xc
L_9348ce:
	bset_s r1,r1,0xd
L_9348d0:
	or r0,r0,0x1d003000
L_9348d8:
	st.as r1,[gp,-0x11]
L_9348dc:
	mov_s r32,r0
L_9348de:
	st.ab r0,[r25,0x4]
L_9348e2:
	bclr r25,r25,0xa
L_9348e6:
	nop_s
L_9348e8:
	nop_s
L_9348ea:
	nop_s
L_9348ec:
	extw r15,r40
L_9348f0:
	mov_s r1,sp
L_9348f2:
	mov_s r0,r14
L_9348f4:
	mov_s r2,0x0
L_9348f6:
	bl.d L_937b84
L_9348fa:
	mov_s r3,r13
L_9348fc:
	brne_s r0,0,L_934944
L_9348fe:
	ld_s r1,[r14,0x14]
L_934900:
	bic r1,r1,-0x41
L_934904:
	extb r0,r45
L_934908:
	and_s r0,r0,r1
L_93490a:
	cmp_s r0,0x0
L_93490c:
	mov_s r0,0x1
L_93490e:
	sub_s.ne r0,r0,r0
L_934910:
	extb.f 0x0,r0
L_934914:
	bne_s L_934a04
L_934916:
	mov_s r0,0x1
L_934918:
	st_s r0,[r14,0x1c]
L_93491a:
	bl.d L_921fc0
L_93491e:
	mov_s r0,r14
L_934920:
	bl.d L_92a36c
L_934924:
	ld_s r0,[r14,0x4]
	.global L_934926
L_934926:
	mov_s r0,r43
L_934928:
	bbit0 r0,0x1f,L_934926
L_93492c:
	mov_s r0,r51
L_93492e:
	bmsk r1,r0,0x3
L_934932:
	st.as r1,[gp,0x3a]
L_934936:
	lsr_s r0,r0,0x4
L_934938:
	st.as r0,[gp,0x3b]
	.global L_93493c
L_93493c:
	mov_s r0,r45
L_93493e:
	bbit0 r0,0x1f,L_93493c
L_934942:
	b_s L_934a04
	.global L_934944
L_934944:
	ld_s r13,[r14,0x24]
L_934946:
	bmsk.f r13,r13,0x1
L_93494a:
	beq_s L_934a3e
L_93494c:
	brlo r15,0x31,L_934a24
L_934950:
	brne r13,0x1,L_9349a4
L_934954:
	ld_s r0,[gp,0xe0]
L_934956:
	mov_s r15,0x0
L_934958:
	bset_s r0,r0,0x2
L_93495a:
	st.as r0,[gp,0x38]
L_93495e:
	mov_s r0,0x10
L_934960:
	bl.d L_924ea8
L_934964:
	mov_s r1,r0
L_934966:
	bl.d L_92a318
L_93496a:
	mov_s r0,0x0
	.global L_93496c
L_93496c:
	mov_s r0,r43
L_93496e:
	bbit0 r0,0x1f,L_93496c
L_934972:
	mov_s r0,r51
L_934974:
	bmsk r1,r0,0x3
L_934978:
	st.as r1,[gp,0x3a]
L_93497c:
	lsr_s r0,r0,0x4
L_93497e:
	st.as r0,[gp,0x3b]
L_934982:
	st_s r15,[sp,0x0]
	.global L_934984
L_934984:
	mov_s r0,r45
L_934986:
	bbit0 r0,0x1f,L_934984
L_93498a:
	ld_s r0,[r14]
L_93498c:
	mov_s r1,0xb
L_93498e:
	bl.d L_9332d4
L_934992:
	mov_s r2,0x0
L_934994:
	ld_s r0,[r14,0x14]
L_934996:
	extb r1,r45
L_93499a:
	and_s r0,r0,r1
L_93499c:
	cmp_s r0,0x0
L_93499e:
	mov_s r0,0x1
L_9349a0:
	sub_s.ne r0,r0,r0
L_9349a2:
	b_s L_9349b6
	.global L_9349a4
L_9349a4:
	mov_s r0,blink
L_9349a6:
	mov_s r2,0x1002520
L_9349ac:
	mov_s r1,0x7a
L_9349ae:
	bl.d L_925548
L_9349b2:
	mov_s r3,0x81
L_9349b4:
	mov_s r0,0x0
	.global L_9349b6
L_9349b6:
	breq_s r0,0,L_934a04
	.global L_9349b8
L_9349b8:
	ld_s r0,[gp,0xe8]
L_9349ba:
	bic r0,r0,-0x3
L_9349be:
	cmp_s r0,0x2
L_9349c0:
	mov_s r0,0x1
L_9349c2:
	sub_s.ne r0,r0,r0
L_9349c4:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_9349c6:
	or r1,r0,0x19000b00
L_9349ce:
	ld_s r0,[gp,0xec]
L_9349d0:
	asl_s r0,r0,0xe
L_9349d2:
	or_s r0,r0,r1
L_9349d4:
	mov_s r32,r0
L_9349d6:
	st.ab r0,[r25,0x4]
L_9349da:
	bclr r25,r25,0xa
L_9349de:
	mov_s r1,sp
L_9349e0:
	bl.d L_93409c
L_9349e4:
	mov_s r0,r14
L_9349e6:
	brne r0,0x0,L_934a60
L_9349ea:
	mov_s r1,0x801458
L_9349f0:
	ld_s r0,[r1,0x4]
L_9349f2:
	st.as 0x800,[gp,0x38]
L_9349fa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9349fc:
	st_s r0,[r1,0x4]
L_9349fe:
	b.d L_934c02
L_934a02:
	mov_s r0,0x0
	.global L_934a04
L_934a04:
	bl.d L_931a78
L_934a08:
	mov_s r0,0x2
L_934a0a:
	mov_s r1,0x801458
L_934a10:
	ld_s r0,[r1,0x1c]
L_934a12:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934a14:
	st_s r0,[r1,0x1c]
L_934a16:
	ld_s r0,[gp,0xe0]
L_934a18:
	bset_s r0,r0,0xd
L_934a1a:
	st.as r0,[gp,0x38]
L_934a1e:
	b.d L_934c02
L_934a22:
	mov_s r0,0x0
	.global L_934a24
L_934a24:
	ld_s r0,[gp,0xe0]
L_934a26:
	mov_s r1,0x801458
L_934a2c:
	bset_s r0,r0,0xf
L_934a2e:
	st.as r0,[gp,0x38]
L_934a32:
	ld_s r0,[r1,0x20]
L_934a34:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934a36:
	st_s r0,[r1,0x20]
L_934a38:
	b.d L_934c02
L_934a3c:
	mov_s r0,0x0
	.global L_934a3e
L_934a3e:
	and.f 0x0,r43,0xc000
L_934a46:
	beq_s L_934a4e
L_934a48:
	mov_s r0,r43
L_934a4a:
	bbit0 r0,0x1a,L_9349b8
	.global L_934a4e
L_934a4e:
	mov_s r0,0x20000400
L_934a54:
	mov_s r32,r0
L_934a56:
	st.ab r0,[r25,0x4]
L_934a5a:
	bclr r25,r25,0xa
L_934a5e:
	b_s L_9349b8
	.global L_934a60
L_934a60:
	ld_s r0,[gp,-0x48]
L_934a62:
	or r0,r0,0x27004000
L_934a6a:
	mov_s r32,r0
L_934a6c:
	st.ab r0,[r25,0x4]
L_934a70:
	bclr r25,r25,0xa
L_934a74:
	mov_s r0,0x2004000
L_934a7a:
	mov_s r32,r0
L_934a7c:
	st.ab r0,[r25,0x4]
L_934a80:
	bclr r25,r25,0xa
L_934a84:
	breq_s r13,0,L_934a8a
	.global L_934a86
L_934a86:
	mov_s r13,0x0
L_934a88:
	b_s L_934b0c
	.global L_934a8a
L_934a8a:
	mov_s r1,0x801a18
L_934a90:
	ld_s r0,[r1,0x60]
L_934a92:
	mov_s r2,0x801131
L_934a98:
	ld_s r0,[r0,0x4]
L_934a9a:
	add1_s r0,r0,r0
L_934a9c:
	ldb_s r0,[r2,r0]
L_934a9e:
	breq_s r0,0,L_934aba
L_934aa0:
	lsr r0,r45,0x5
L_934aa4:
	bxor r0,r0,0x0
L_934aa8:
	ld_s r2,[r1,0x60]
L_934aaa:
	bbit1 r0,0x0,L_934aba
L_934aae:
	ld_s r0,[r2,0xc]
L_934ab0:
	bset_s r0,r0,0x1
L_934ab2:
	st_s r0,[r2,0xc]
L_934ab4:
	ld_s r0,[r1,0x60]
L_934ab6:
	mov_s r2,0x0
L_934ab8:
	st_s r2,[r0,0x1c]
	.global L_934aba
L_934aba:
	ld_s r0,[r1,0x60]
L_934abc:
	ld_s r0,[r0,0xc]
L_934abe:
	bbit1 r0,0x8,L_934a86
L_934ac2:
	lsr r0,r43,0xe
L_934ac6:
	bmsk.f r0,r0,0x1
L_934aca:
	beq_s L_934ae4
L_934acc:
	mov_s r13,0x0
L_934ace:
	brne r0,0x1,L_934b0c
L_934ad2:
	mov_s r0,0x801a18
L_934ad8:
	ld_s r1,[r0,0x60]
L_934ada:
	ld_s r0,[r1,0xc]
L_934adc:
	or r0,r0,0xe
L_934ae0:
	st_s r0,[r1,0xc]
L_934ae2:
	b_s L_934b0c
	.global L_934ae4
L_934ae4:
	mov_s r1,r43
L_934ae6:
	ld_s r0,[gp,0xe0]
L_934ae8:
	btst_s r1,0x1b
L_934aea:
	bset.ne r0,r0,0x1
L_934aee:
	bset.eq r0,r0,0x0
L_934af2:
	st.as r0,[gp,0x38]
L_934af6:
	mov_s r13,0x0
L_934af8:
	bbit1 r0,0x12,L_934b0c
L_934afc:
	mov_s r0,0x801a18
L_934b02:
	ld_s r1,[r0,0x60]
L_934b04:
	mov_s r0,0x1
L_934b06:
	bl.d L_9372dc
L_934b0a:
	ld_s r1,[r1,0x4]
	.global L_934b0c
L_934b0c:
	mov_s r0,0x0
L_934b0e:
	bl.d L_9317fc
L_934b12:
	bset_s r0,r0,0xe
L_934b14:
	ld_s r0,[gp,0xdc]
L_934b16:
	ld_s r1,[r14]
L_934b18:
	and r3,r0,0x2
L_934b1c:
	mov_s r0,0x0
L_934b1e:
	or.f 0x0,r3,r0
L_934b22:
	ld.as r2,[gp,0x38]
L_934b26:
	beq_s L_934b32
L_934b28:
	bic r2,r2,-0x120
L_934b2c:
	cmp r2,0x100
L_934b30:
	beq_s L_934b5e
	.global L_934b32
L_934b32:
	ld_s r0,[gp,0x48]
L_934b34:
	mov_s r3,0x801a18
L_934b3a:
	ld_s r2,[r3,0x60]
L_934b3c:
	breq_s r0,0,L_934b4c
L_934b3e:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_934b40:
	mov_s r0,0x801194
L_934b46:
	add3_s r1,r1,r1
L_934b48:
	ld_s r0,[r0,r1]
L_934b4a:
	st_s r0,[r2,0x28]
	.global L_934b4c
L_934b4c:
	ld_s r1,[r3,0x60]
L_934b4e:
	mov_s r0,0x1
L_934b50:
	bl.d L_92b934
L_934b54:
	ld_s r1,[r1,0x28]
L_934b56:
	ld_s r0,[gp,0x48]
L_934b58:
	breq_s r0,0,L_934b5e
L_934b5a:
	st.as r13,[gp,0x12]
	.global L_934b5e
L_934b5e:
	mov_s r2,0x80209c
L_934b64:
	ldb_s r0,[r2,0x5]
L_934b66:
	mov_s r1,0x1002530
L_934b6c:
	bbit0 r0,0x2,L_934b8c
L_934b70:
	bmsk_s r1,r1,0x13
L_934b72:
	ld_s r0,[r2]
L_934b74:
	or r1,r1,0xa2100000
L_934b7c:
	extb_s r13,r0
L_934b7e:
	mov_s r3,0x8020b0
L_934b84:
	add2_s r3,r3,r13
L_934b86:
	st_s r1,[r3]
L_934b88:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934b8a:
	st_s r0,[r2]
	.global L_934b8c
L_934b8c:
	mov_s r0,0xeeee02
L_934b92:
	mov_s r32,r0
L_934b94:
	st.ab r0,[r25,0x4]
L_934b98:
	bclr r25,r25,0xa
L_934b9c:
	mov_s r0,0x0
L_934b9e:
	bl.d L_9317fc
L_934ba2:
	bset_s r0,r0,0xf
L_934ba4:
	ld_s r0,[r14,0xc]
L_934ba6:
	btst_s r0,0x3
L_934ba8:
	mov.ne r0,r14
L_934bac:
	bl.ne.d L_933f90
L_934bb0:
	sub_s.ne r1,r1,r1
L_934bb2:
	bl.d L_931f54
L_934bb6:
	mov_s r0,0x0
L_934bb8:
	st.as r0,[gp,0x24]
L_934bbc:
	ld_s r1,[r14]
L_934bbe:
	mov_s r2,0x8016d8
L_934bc4:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_934bc6:
	add1_s r1,r1,r1
L_934bc8:
	ld_s r1,[r2,r1]
L_934bca:
	sub.f r1,r1,0x0
L_934bce:
	mov.ne r1,0x1
L_934bd2:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_934bd4:
	add_s r1,r1,0x8
L_934bd6:
	st_s r1,[r0,0x10]
L_934bd8:
	ld_s r0,[gp,0x90]
L_934bda:
	mov_s r1,0x10
L_934bdc:
	st_s r1,[r0,0xc]
L_934bde:
	mov_s r0,0x2
L_934be0:
	st.as r0,[gp,0x37]
L_934be4:
	ld_s r0,[gp,0xe0]
L_934be6:
	bset_s r0,r0,0x8
L_934be8:
	st.as r0,[gp,0x38]
L_934bec:
	bl.d L_9316a8
L_934bf0:
	mov_s r0,0x6
L_934bf2:
	mov_s r1,0x80090c
L_934bf8:
	ldw_s r0,[r1,0x26]
L_934bfa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934bfc:
	extw_s r0,r0
L_934bfe:
	stw_s r0,[r1,0x26]
L_934c00:
	mov_s r0,0x1
	.global L_934c02
L_934c02:
	b.d L_92027c
L_934c06:
	add_s sp,sp,0x10
