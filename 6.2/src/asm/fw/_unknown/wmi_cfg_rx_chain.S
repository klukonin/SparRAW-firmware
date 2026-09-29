/* wmi_cfg_rx_chain @ 0x8fb7fc, 804 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Opening sniffer mode
 *       configuring CP (Control Phy) sniffing
 *       configuring DP (Data Phy) sniffing
 *       configuring AD (Auto Detection) sniffing
 *       configuring PRS TBL, PRS RGFs, PRP RGFs
 *       stopping PCP
 *       opening RX for channel (%d)
 *   OOB mode force RX MAX MSDU to %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: RADIO_MGR__set_primary_channel, __ld_r22_to_r13_ret, __st_r22_to_r13, disc_sm__sw_data_stopped, dma_mgr__configure_ring, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, host_if__send_pair, l2_offload__cfg_rx_decap, lmac_if__send_phy_ina_det_cfg
 * Глобалы (через gp): 0x8002a8, 0x8002d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_cfg_rx_chain
wmi_cfg_rx_chain:
	.global L_8fb7fc
L_8fb7fc:
	push_s blink
L_8fb7fe:
	bl L_8c01c4
L_8fb802:
	sub_s sp,sp,0x3c
L_8fb804:
	mov_s r14,r0
L_8fb806:
	bl.d L_8c32d8
L_8fb80a:
	mov_s r17,r1
L_8fb80c:
	mov.f r16,r0
L_8fb810:
	beq_s L_8fb828
	.global L_8fb812
L_8fb812:
	ldw_s r0,[r14,0x26]
L_8fb814:
	ldw_s r1,[r14,0x24]
L_8fb816:
	asl_s r0,r0,0x10
L_8fb818:
	or_s r1,r1,r0
L_8fb81a:
	mov r19,0x1
L_8fb81e:
	breq r1,0x1,L_8fb836
L_8fb822:
	add r13,r14,0x20
L_8fb826:
	b_s L_8fb95a
	.global L_8fb828
L_8fb828:
	mov_s r0,blink
L_8fb82a:
	mov_s r1,0x1342
L_8fb830:
	bl L_8c9b28
L_8fb834:
	b_s L_8fb812
	.global L_8fb836
L_8fb836:
	add_s r13,sp,0x4
L_8fb838:
	mov_s r1,0x800bdc
L_8fb83e:
	mov_s r0,r13
L_8fb840:
	bl.d L_8c0380
L_8fb844:
	mov_s r2,0x24
L_8fb846:
	mov_s r1,0x100d74c
L_8fb84c:
	bl.d L_8dcba8
L_8fb850:
	mov_s r0,0x2b
L_8fb852:
	ldw_s r0,[r14,0x2e]
L_8fb854:
	ldw_s r1,[r14,0x2c]
L_8fb856:
	asl_s r0,r0,0x10
L_8fb858:
	or_s r1,r1,r0
L_8fb85a:
	mov_s r15,0x2
L_8fb85c:
	stb_s r15,[r14,0x11]
L_8fb85e:
	brne_s r1,0,L_8fb876
L_8fb860:
	mov_s r1,0x100d764
L_8fb866:
	bl.d L_8dcba8
L_8fb86a:
	mov_s r0,0x2b
L_8fb86c:
	ld_s r0,[sp,0x24]
L_8fb86e:
	bclr_s r0,r0,0x1
	.global L_8fb870
L_8fb870:
	bclr_s r0,r0,0x0
L_8fb872:
	st_s r0,[sp,0x24]
L_8fb874:
	b_s L_8fb8b4
	.global L_8fb876
L_8fb876:
	brne r1,0x1,L_8fb892
L_8fb87a:
	mov_s r1,0x100d790
L_8fb880:
	bl.d L_8dcba8
L_8fb884:
	mov_s r0,0x2b
L_8fb886:
	ld_s r0,[sp,0x24]
L_8fb888:
	bic r0,r0,0x3
L_8fb88c:
	st_s r0,[sp,0x24]
L_8fb88e:
	stb_s r15,[sp,0x8]
L_8fb890:
	b_s L_8fb8b4
	.global L_8fb892
L_8fb892:
	brne r1,0x2,L_8fb8a8
L_8fb896:
	mov_s r1,0x100d7b8
L_8fb89c:
	bl.d L_8dcba8
L_8fb8a0:
	mov_s r0,0x2b
L_8fb8a2:
	ld_s r0,[sp,0x24]
L_8fb8a4:
	bset_s r0,r0,0x1
L_8fb8a6:
	b_s L_8fb870
	.global L_8fb8a8
L_8fb8a8:
	mov_s r0,blink
L_8fb8aa:
	mov_s r1,0x11e3
L_8fb8b0:
	bl L_8c9b28
	.global L_8fb8b4
L_8fb8b4:
	bl.d L_8dbb24
L_8fb8b8:
	mov_s r0,r13
L_8fb8ba:
	mov_s r1,0x100d7e8
L_8fb8c0:
	bl.d L_8dcba8
L_8fb8c4:
	mov_s r0,0x2b
L_8fb8c6:
	mov_s r1,0x886200
L_8fb8cc:
	ld_s r0,[r1,0x58]
L_8fb8ce:
	mov_s r13,0x0
L_8fb8d0:
	bic r0,r0,0x1f
L_8fb8d4:
	bset_s r0,r0,0x1
L_8fb8d6:
	st_s r0,[r1,0x58]
L_8fb8d8:
	ld_s r0,[r1]
L_8fb8da:
	bset_s r0,r0,0x8
L_8fb8dc:
	st_s r0,[r1]
L_8fb8de:
	mov_s r1,0x886800
L_8fb8e4:
	ld_s r0,[r1,0x38]
L_8fb8e6:
	bset_s r0,r0,0x0
L_8fb8e8:
	st_s r0,[r1,0x38]
L_8fb8ea:
	mov_s r0,0x886d80
L_8fb8f0:
	st 0x31000400,[r0, 0x48]
L_8fb8f8:
	bl.d L_8da488
L_8fb8fc:
	mov_s r0,r13
L_8fb8fe:
	breq_s r0,0,L_8fb92c
L_8fb900:
	mov_s r1,0x100d814
L_8fb906:
	bl.d L_8dcba8
L_8fb90a:
	mov_s r0,0x2b
L_8fb90c:
	stw r13,[sp, 0x28]
L_8fb910:
	add_s r0,sp,0x28
L_8fb912:
	bl.d L_8ec840
L_8fb916:
	mov_s r1,r13
L_8fb918:
	mov_s r0,0xc3500
L_8fb91e:
	mov lp_count,r0
L_8fb922:
	nop_s
L_8fb924:
	lp L_8fb92c
L_8fb928:
	nop_s
L_8fb92a:
	nop_s
	.global L_8fb92c
L_8fb92c:
	mov_s r1,0x100d828
L_8fb932:
	add r13,r14,0x20
L_8fb936:
	mov_s r0,0x2b
L_8fb938:
	bl.d L_8dcc10
L_8fb93c:
	ldb_s r2,[r13,0x10]
L_8fb93e:
	mov_s r2,0x805160
L_8fb944:
	ld_s r1,[r2,0x8]
L_8fb946:
	extb r5,r17
L_8fb94a:
	ldb_s r0,[r13,0x10]
L_8fb94c:
	ld_s r2,[r2,0xc]
L_8fb94e:
	ld.as r3,[gp,0x54]
L_8fb952:
	bl.d L_8e6cec
L_8fb956:
	mov r4,0x1
	.global L_8fb95a
L_8fb95a:
	bl L_8ccec4
L_8fb95e:
	mov_s r18,r0
L_8fb960:
	ldw_s r0,[r14,0xe]
L_8fb962:
	mov_s r15,0x1f28
L_8fb968:
	min r21,r0,r15
L_8fb96c:
	mov_s r0,0x803c00
L_8fb972:
	ld_s r0,[r0,0xc]
L_8fb974:
	breq_s r0,0,L_8fb986
L_8fb976:
	mov_s r1,0x100d848
L_8fb97c:
	mov_s r0,0x2b
L_8fb97e:
	bl.d L_8dcc10
L_8fb982:
	mov_s r2,r15
L_8fb984:
	mov_s r21,r15
	.global L_8fb986
L_8fb986:
	ldb_s r0,[r13,0x2]
L_8fb988:
	brne r0,0x1,L_8fb994
L_8fb98c:
	st.as r19,[gp,0x49]
L_8fb990:
	mov_s r15,0x40
L_8fb992:
	b_s L_8fb9a2
	.global L_8fb994
L_8fb994:
	asl r15,r18
L_8fb998:
	cmp_s r15,0x40
L_8fb99a:
	bhi_s L_8fb9c4
	.global L_8fb99c
L_8fb99c:
	mov_s r0,0x0
L_8fb99e:
	st.as r0,[gp,0x49]
	.global L_8fb9a2
L_8fb9a2:
	mov_s r1,0x100d86c
L_8fb9a8:
	ldb r4,[r13, 0x2]
L_8fb9ac:
	mov_s r0,0x2b
L_8fb9ae:
	mov_s r2,r21
L_8fb9b0:
	bl.d L_8dcd00
L_8fb9b4:
	mov_s r3,r18
L_8fb9b6:
	ldw r20,[r14, 0x34]
L_8fb9ba:
	brge r20,0x3,L_8fb9d2
	.global L_8fb9be
L_8fb9be:
	mov r20,0x0
L_8fb9c2:
	b_s L_8fb9fe
	.global L_8fb9c4
L_8fb9c4:
	mov_s r0,blink
L_8fb9c6:
	mov_s r1,0x11e4
L_8fb9cc:
	bl L_8c9b28
L_8fb9d0:
	b_s L_8fb99c
	.global L_8fb9d2
L_8fb9d2:
	brlt r20,0x1,L_8fb9e2
L_8fb9d6:
	rsub r0,r20,0x0
L_8fb9da:
	and r0,r0,r20
L_8fb9de:
	breq r0,r20,L_8fb9fe
	.global L_8fb9e2
L_8fb9e2:
	mov_s r1,0x100d8b0
L_8fb9e8:
	mov_s r0,0x2b
L_8fb9ea:
	bl.d L_8dcc10
L_8fb9ee:
	mov_s r2,r20
L_8fb9f0:
	mov_s r0,blink
L_8fb9f2:
	mov_s r1,0x1343
L_8fb9f8:
	bl L_8c9b28
L_8fb9fc:
	b_s L_8fb9be
	.global L_8fb9fe
L_8fb9fe:
	extw r22,r15
L_8fba02:
	bl.d L_8e7138
L_8fba06:
	mov_s r0,r22
L_8fba08:
	bl L_8f9c1c
L_8fba0c:
	bl.d L_8ccb68
L_8fba10:
	mov_s r0,0x2
L_8fba12:
	mov_s r15,r0
L_8fba14:
	ldw_s r0,[r14,0x26]
L_8fba16:
	ldw_s r1,[r14,0x24]
L_8fba18:
	asl_s r0,r0,0x10
L_8fba1a:
	or_s r1,r1,r0
L_8fba1c:
	brne r1,0x1,L_8fba46
L_8fba20:
	st r19,[sp]
L_8fba24:
	mov_s r0,r15
L_8fba26:
	mov_s r1,0x2
L_8fba28:
	mov_s r2,0x3
L_8fba2a:
	mov_s r3,r21
L_8fba2c:
	mov r4,0x1000
L_8fba34:
	mov r5,r4
L_8fba38:
	mov r6,0x8
L_8fba3c:
	bl.d L_8d93a0
L_8fba40:
	mov r7,r22
L_8fba44:
	b_s L_8fba74
	.global L_8fba46
L_8fba46:
	mov_s r0,0x0
L_8fba48:
	st_s r0,[sp,0x0]
L_8fba4a:
	mov_s r0,r15
L_8fba4c:
	mov_s r1,0x2
L_8fba4e:
	mov_s r2,0x3
L_8fba50:
	mov_s r3,r21
L_8fba52:
	mov r4,0x1000
L_8fba5a:
	mov r5,r4
L_8fba5e:
	mov r6,0x8
L_8fba62:
	bl.d L_8d93a0
L_8fba66:
	mov r7,r22
L_8fba6a:
	ldb_s r0,[r13,0x2]
L_8fba6c:
	brne r0,0x1,L_8fba74
L_8fba70:
	st r19,[r15, 0xc]
	.global L_8fba74
L_8fba74:
	mov_s r0,r15
L_8fba76:
	mov_s r1,0x2
L_8fba78:
	bl.d L_8e1298
L_8fba7c:
	mov_s r2,0x0
L_8fba7e:
	extb r3,r18
L_8fba82:
	mov_s r0,r15
L_8fba84:
	mov_s r1,0x0
L_8fba86:
	mov_s r2,0x0
L_8fba88:
	bl.d L_8c44bc
L_8fba8c:
	mov r4,r22
L_8fba90:
	mov_s r1,0x100d8f0
L_8fba96:
	mov_s r0,0x2b
L_8fba98:
	bl.d L_8dcc10
L_8fba9c:
	ldw_s r2,[r14,0x34]
L_8fba9e:
	ldb_s r0,[r14,0x5]
L_8fbaa0:
	ldb_s r1,[r14,0x4]
L_8fbaa2:
	asl_s r0,r0,0x8
L_8fbaa4:
	or_s r1,r1,r0
L_8fbaa6:
	ldb_s r0,[r14,0x6]
L_8fbaa8:
	ldb_s r2,[r14,0x8]
L_8fbaaa:
	asl_s r0,r0,0x10
L_8fbaac:
	or_s r1,r1,r0
L_8fbaae:
	ldb_s r0,[r14,0x7]
L_8fbab0:
	ldw r4,[r14, 0x20]
L_8fbab4:
	asl_s r0,r0,0x18
L_8fbab6:
	or_s r1,r1,r0
L_8fbab8:
	ldb_s r0,[r14,0x9]
L_8fbaba:
	ldw r5,[r14, 0x1a]
L_8fbabe:
	asl_s r0,r0,0x8
L_8fbac0:
	or_s r2,r2,r0
L_8fbac2:
	ldb_s r0,[r14,0xa]
L_8fbac4:
	ldw_s r3,[r14,0xc]
L_8fbac6:
	asl_s r0,r0,0x10
L_8fbac8:
	or_s r2,r2,r0
L_8fbaca:
	ldb_s r0,[r14,0xb]
L_8fbacc:
	mov r6,0x0
L_8fbad0:
	asl_s r0,r0,0x18
L_8fbad2:
	or_s r2,r2,r0
L_8fbad4:
	mov_s r0,0x2
L_8fbad6:
	bl.d L_8c6e90
L_8fbada:
	mov r7,r20
L_8fbade:
	bl.d L_8c7070
L_8fbae2:
	mov_s r0,r14
L_8fbae4:
	bl L_8d0834
L_8fbae8:
	mov_s r1,0x100d914
L_8fbaee:
	st r0,[r16]
L_8fbaf2:
	st r19,[r16, 0x4]
L_8fbaf6:
	mov_s r0,0x2b
L_8fbaf8:
	bl.d L_8dcc10
L_8fbafc:
	mov_s r2,r17
L_8fbafe:
	mov_s r0,r16
L_8fbb00:
	mov_s r1,0xc1
L_8fbb02:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8fbb04:
	mov_s r2,0x8
L_8fbb06:
	mov_s r3,r17
L_8fbb08:
	mov r4,0x0
L_8fbb0c:
	mov r5,0x0
L_8fbb10:
	bl.d L_8e5474
L_8fbb14:
	mov r6,0x0
L_8fbb18:
	b.d L_8c0214
L_8fbb1c:
	add_s sp,sp,0x3c
L_8fbb1e:
	nop_s
