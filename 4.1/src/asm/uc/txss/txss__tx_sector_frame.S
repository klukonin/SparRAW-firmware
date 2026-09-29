/* txss__tx_sector_frame @ 0x936864, 712 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txss.c
 * Зовут его: txss__flow_body, txss_rx_step
 * Зовёт сам: __ld_r19_to_r13_ret_uc, __st_r19_to_r13_uc, bcon_txss_sweep_step, bf_s1_w1_uc, direct_tx__program_cmd34, mac__cmd_29000001, mac__current_sector_index, mac__program_tx_common, mac__select_sector_and_wait_b, tail_bcon_sweep_step_b, uc_sysassert, uc_wait_event_busy
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.txss__tx_sector_frame,"ax",@progbits
	.global txss__tx_sector_frame
txss__tx_sector_frame:
	.global L_936864
L_936864:
	push_s blink
L_936866:
	bl L_920200
L_93686a:
	mov_s r18,r0
L_93686c:
	mov_s r15,r2
L_93686e:
	st.a r3,[sp,-0xc]
L_936872:
	mov r16,r4
L_936876:
	mov r19,r5
L_93687a:
	mov r17,r6
L_93687e:
	mov_s r2,0x1c
L_936880:
	brne r1,0x5,L_936890
L_936884:
	mul64_s r0,r2
L_936886:
	add r13,mlo,0x801bac
L_93688e:
	b_s L_93689a
	.global L_936890
L_936890:
	mul64_s r1,r2
L_936892:
	add r13,mlo,0x801cec
	.global L_93689a
L_93689a:
	add_s r14,sp,0x4
L_93689c:
	mov_s r0,r14
L_93689e:
	bl.d L_93432c
L_9368a2:
	mov_s r1,r17
L_9368a4:
	brne r15,0x1,L_936904
L_9368a8:
	mov_s r0,0x3e
L_9368aa:
	asl_s r0,r0,0x18
L_9368ac:
	mov_s r32,r0
L_9368ae:
	st.ab r0,[r25,0x4]
L_9368b2:
	bclr r25,r25,0xa
L_9368b6:
	mov_s r0,0x37000020
L_9368bc:
	mov_s r32,r0
L_9368be:
	st.ab r0,[r25,0x4]
L_9368c2:
	bclr r25,r25,0xa
L_9368c6:
	mov_s r1,0x801458
L_9368cc:
	ld_s r0,[r1,0xc]
L_9368ce:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9368d0:
	st_s r0,[r1,0xc]
L_9368d2:
	mov_s r0,r14
L_9368d4:
	mov_s r1,r13
L_9368d6:
	bl.d L_930de4
L_9368da:
	mov_s r2,r17
L_9368dc:
	mov_s r0,0x801cbc
L_9368e2:
	ld_s r0,[r0,0x2c]
L_9368e4:
	bset_s r0,r0,0x18
L_9368e6:
	bset_s r0,r0,0x1a
L_9368e8:
	bset_s r0,r0,0x1c
L_9368ea:
	mov_s r32,r0
L_9368ec:
	st.ab r0,[r25,0x4]
L_9368f0:
	bclr r25,r25,0xa
L_9368f4:
	mov_s r0,0x14000007
L_9368fa:
	mov_s r32,r0
L_9368fc:
	st.ab r0,[r25,0x4]
L_936900:
	bclr r25,r25,0xa
	.global L_936904
L_936904:
	mov_s r0,0x10
L_936906:
	bl.d L_924ea8
L_93690a:
	mov_s r1,0x16
L_93690c:
	bl L_92a3c0
L_936910:
	brne r15,0x1,L_936990
L_936914:
	bl.d L_931664
L_936918:
	mov_s r0,0x6
L_93691a:
	mov_s r0,0x2008000
L_936920:
	mov_s r32,r0
L_936922:
	st.ab r0,[r25,0x4]
L_936926:
	bclr r25,r25,0xa
L_93692a:
	ld_s r0,[gp,0xdc]
L_93692c:
	and r1,r0,0x10
L_936930:
	mov_s r0,0x0
L_936932:
	or.f 0x0,r1,r0
L_936936:
	beq_s L_936956
L_936938:
	ld_s r0,[gp,0xe8]
L_93693a:
	bic r0,r0,-0x3
L_93693e:
	cmp_s r0,0x2
L_936940:
	mov_s r0,0x1
L_936942:
	sub_s.ne r0,r0,r0
L_936944:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_936946:
	or r1,r0,0x19800830
L_93694e:
	ld_s r0,[gp,0xec]
L_936950:
	asl_s r0,r0,0xe
L_936952:
	or_s r0,r0,r1
L_936954:
	b_s L_93695c
	.global L_936956
L_936956:
	mov_s r0,0x19000001
	.global L_93695c
L_93695c:
	mov_s r32,r0
L_93695e:
	st.ab r0,[r25,0x4]
L_936962:
	bclr r25,r25,0xa
	.global L_936966
L_936966:
	mov_s r0,r45
L_936968:
	bbit0 r0,0x1f,L_936966
L_93696c:
	ld_s r0,[gp,0xdc]
L_93696e:
	and r1,r0,0x10
L_936972:
	mov_s r0,0x0
L_936974:
	or.f 0x0,r1,r0
L_936978:
	mov_s r0,0x18
L_93697a:
	asl.ne r0,r0,0x18
L_93697e:
	mov.eq r0,0x18001000
L_936986:
	mov_s r32,r0
L_936988:
	st.ab r0,[r25,0x4]
L_93698c:
	bclr r25,r25,0xa
	.global L_936990
L_936990:
	cmp r19,0x0
L_936994:
	mov.ne r0,r19
L_936998:
	jlne [r0]
L_93699c:
	mov_s r2,0x801b7c
L_9369a2:
	stw 0x864,[r2, 0x14]
L_9369aa:
	ld_s r1,[sp,0x0]
L_9369ac:
	mov_s r3,0x801b90
L_9369b2:
	mov_s r0,0x0
L_9369b4:
	breq_s r1,0,L_9369de
L_9369b6:
	mov_s r1,0x800fcc
L_9369bc:
	ld_s r14,[r1]
L_9369be:
	bmsk r3,r14,0x5
L_9369c2:
	lsr_s r14,r14,0x6
L_9369c4:
	bmsk_s r14,r14,0x1
L_9369c6:
	/* asl_s r14,r14,0x6 */
	.byte 0x06,0xbe
L_9369c8:
	or_s r3,r3,r14
L_9369ca:
	mov_s r14,0x801b9c
L_9369d0:
	ld_s r1,[r1,0x8]
L_9369d2:
	stb_s r3,[r14,0x7]
L_9369d4:
	sub_s r1,r1,0x13
L_9369d6:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_9369d8:
	stb_s r1,[r14,0x8]
L_9369da:
	stb_s r0,[r14,0x9]
L_9369dc:
	b_s L_9369f4
	.global L_9369de
L_9369de:
	ldw_s r1,[r13,0x1a]
L_9369e0:
	stb_s r0,[r3,0x14]
L_9369e2:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_9369e4:
	stb_s r1,[r3,0x13]
L_9369e6:
	stb_s r0,[r3,0x15]
L_9369e8:
	ldb_s r1,[r13,0x18]
L_9369ea:
	add r0,r3,0x14
L_9369ee:
	bmsk_s r1,r1,0x1
L_9369f0:
	bl L_937970
	.global L_9369f4
L_9369f4:
	breq r16,0x0,L_936a04
L_9369f8:
	breq r16,0x1,L_936a24
L_9369fc:
	breq r16,0x2,L_936a2c
L_936a00:
	mov_s r14,0x0
L_936a02:
	b_s L_936a32
	.global L_936a04
L_936a04:
	asl r0,r18,0x3
L_936a08:
	add3_s r0,r0,r0
L_936a0a:
	add_s r0,r0,0x801190
L_936a10:
	ldw_s r1,[r0,0x2c]
L_936a12:
	mov_s r14,0x15990
L_936a18:
	stw_s r1,[r2,0x18]
L_936a1a:
	ldw_s r1,[r0,0x2e]
L_936a1c:
	ldw_s r0,[r0,0x30]
L_936a1e:
	stw_s r1,[r2,0x1a]
L_936a20:
	stw_s r0,[r2,0x1c]
L_936a22:
	b_s L_936a32
	.global L_936a24
L_936a24:
	mov_s r14,0x159f8
L_936a2a:
	b_s L_936a32
	.global L_936a2c
L_936a2c:
	mov_s r14,0x159f0
	.global L_936a32
L_936a32:
	brne r15,0x5,L_936ace
L_936a36:
	ld_s r0,[gp,-0x48]
L_936a38:
	or r0,r0,0x27007e00
L_936a40:
	mov_s r32,r0
L_936a42:
	st.ab r0,[r25,0x4]
L_936a46:
	bclr r25,r25,0xa
L_936a4a:
	mov_s r0,0x2004002
L_936a50:
	mov_s r32,r0
L_936a52:
	st.ab r0,[r25,0x4]
L_936a56:
	bclr r25,r25,0xa
L_936a5a:
	add_s r0,sp,0x4
L_936a5c:
	mov_s r1,r13
L_936a5e:
	bl.d L_930de4
L_936a62:
	mov_s r2,r17
L_936a64:
	ld_s r0,[gp,-0x44]
L_936a66:
	and r0,r0,0xffff0fff
L_936a6e:
	bset r1,r0,0xd
L_936a72:
	bset_s r1,r1,0xf
L_936a74:
	or r0,r0,0x1d00a000
L_936a7c:
	st.as r1,[gp,-0x11]
L_936a80:
	mov_s r32,r0
L_936a82:
	st.ab r0,[r25,0x4]
L_936a86:
	bclr r25,r25,0xa
L_936a8a:
	mov_s r0,0x2
L_936a8c:
	bset_s r0,r0,0xe
L_936a8e:
	bl.d L_931808
L_936a92:
	mov_s r1,0x0
L_936a94:
	bl L_931640
L_936a98:
	mov_s r1,r40
L_936a9a:
	mov_s r0,r42
L_936a9c:
	bbit1 r0,0xe,L_936aa4
L_936aa0:
	bbit1 r1,0x18,L_936abe
	.global L_936aa4
L_936aa4:
	mov_s r0,r45
L_936aa6:
	bbit0 r0,0x1f,L_936aa4
L_936aaa:
	mov_s r0,0x29000002
L_936ab0:
	mov_s r32,r0
L_936ab2:
	st.ab r0,[r25,0x4]
L_936ab6:
	bclr r25,r25,0xa
L_936aba:
	mov_s r13,0x0
L_936abc:
	b_s L_936b0c
	.global L_936abe
L_936abe:
	mov_s r0,0x29000002
L_936ac4:
	mov_s r32,r0
L_936ac6:
	st.ab r0,[r25,0x4]
L_936aca:
	bclr r25,r25,0xa
	.global L_936ace
L_936ace:
	asl r0,r18,0x2
L_936ad2:
	add1_s r0,r0,r0
L_936ad4:
	mov_s r1,0x800ef4
L_936ada:
	ld_s r0,[r1,r0]
L_936adc:
	brhs r0,0x12,L_936b14
	.global L_936ae0
L_936ae0:
	ld r4,[sp]
L_936ae4:
	add_s r2,sp,0x4
L_936ae6:
	mov_s r0,0x801b60
L_936aec:
	mov_s r1,r15
L_936aee:
	mov_s r3,r14
L_936af0:
	bl.d L_935a4c
L_936af4:
	mov r5,0x1
L_936af8:
	mov_s r13,r0
L_936afa:
	brne r0,0x1,L_936b0c
L_936afe:
	mov_s r0,0x81
L_936b00:
	asl_s r0,r0,0x12
L_936b02:
	mov_s r32,r0
L_936b04:
	st.ab r0,[r25,0x4]
L_936b08:
	bclr r25,r25,0xa
	.global L_936b0c
L_936b0c:
	mov_s r0,r13
L_936b0e:
	b.d L_92025c
L_936b12:
	add_s sp,sp,0xc
	.global L_936b14
L_936b14:
	mov_s r0,blink
L_936b16:
	mov_s r2,0x1002304
L_936b1c:
	mov r1,0x103
L_936b20:
	bl.d L_925548
L_936b24:
	mov r3,0x327
L_936b28:
	b_s L_936ae0
L_936b2a:
	nop_s
