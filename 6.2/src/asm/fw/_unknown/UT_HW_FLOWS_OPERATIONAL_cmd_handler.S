/* UT_HW_FLOWS_OPERATIONAL_cmd_handler @ 0x8fa884, 1312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_FLOWS_OPERATIONAL_cmd_handler:: ut_subtype_id=0x%x
 *   UT_HW_FLOWS_SUBTYPE_PHY_TX_REPETITIVE_PACKET applicabale only in WMI_ONLY_FW
 *   UT_HW_FLOWS_SUBTYPE_TEST_TRIAL_1 [0]=0x%x, [1]=0x%x
 *   UT_HW_FLOWS_SUBTYPE_PHY_TX_SELF_TRANSMIT_W_MCS_GAIN applicabale only in WMI_ONLY_FW
 *   -->> [UT CMD] UT_HW_FLOWS_SUBTYPE_RF_XPM_READ_BYTE cmd: | rf_id=%d | xpm_bit_address=0x%x |
 *   hwf_rf_xpm_read_byte(): result status=%d | xpm_readout_value=0x%x
 *   hwf_rf_xpm_read_byte(): Command failed due to bad input arguments
 *   -->> [UT CMD] UT_HW_FLOWS_SUBTYPE_RF_XPM_READ_BLOCK cmd | device_id=%d | xpm_start_bit_address=0x%x | num_bytes=%d
 * Зовут его: wmi_ut_handler
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, bits__lowest_set_bit8, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, hw__is_fpga_platform, hwf_calib_all, hwf_calib_lo_power_flow, hwf_rf_check_rf_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global UT_HW_FLOWS_OPERATIONAL_cmd_handler
UT_HW_FLOWS_OPERATIONAL_cmd_handler:
	.global L_8fa884
L_8fa884:
	push_s blink
L_8fa886:
	bl L_8c01c4
L_8fa88a:
	sub_s sp,sp,0x8
L_8fa88c:
	mov_s r16,r0
L_8fa88e:
	mov_s r13,r1
L_8fa890:
	add r18,r1,0x4
L_8fa894:
	mov_s r1,0x9
L_8fa896:
	bl.d L_8eae60
L_8fa89a:
	ldw_s r2,[r13,0x2]
L_8fa89c:
	mov_s r17,r0
L_8fa89e:
	mov_s r1,0x101bdcc
L_8fa8a4:
	mov_s r0,0x20
L_8fa8a6:
	bl.d L_8dcc10
L_8fa8aa:
	ldw_s r2,[r13,0x2]
L_8fa8ac:
	ldw_s r2,[r13,0x2]
L_8fa8ae:
	mov_s r14,0x0
L_8fa8b0:
	cmp_s r2,0x98a
L_8fa8b6:
	mov_s r15,0x8
L_8fa8b8:
	beq_s L_8faa6e
L_8fa8ba:
	bgt L_8fa938
L_8fa8be:
	cmp r2,0x700
L_8fa8c2:
	beq_s L_8fa9f4
L_8fa8c4:
	bgt L_8fa91a
L_8fa8c8:
	cmp_s r2,0x1
L_8fa8ca:
	beq_s L_8fa984
L_8fa8cc:
	bgt_s L_8fa904
L_8fa8ce:
	cmp_s r2,0x0
L_8fa8d0:
	bne L_8fad90
L_8fa8d4:
	bl L_8da2c8
L_8fa8d8:
	breq r0,0x0,L_8fa970
L_8fa8dc:
	mov_s r0,blink
L_8fa8de:
	bl.d L_8c9b28
L_8fa8e2:
	mov_s r1,0xac
L_8fa8e4:
	mov_s r1,0x886080
L_8fa8ea:
	ld_s r0,[r1,0x54]
L_8fa8ec:
	mov_s r14,0x12340000
L_8fa8f2:
	bic r0,r0,0xfe
L_8fa8f6:
	or r0,r0,0x22446688
L_8fa8fe:
	st_s r0,[r1,0x54]
L_8fa900:
	b L_8fad80
	.global L_8fa904
L_8fa904:
	cmp r2,0x305
L_8fa908:
	beq_s L_8fa9e4
L_8fa90a:
	cmp r2,0x306
L_8fa90e:
	bne L_8fad90
L_8fa912:
	mov_s r1,0x101be08
L_8fa918:
	b_s L_8fa9ea
	.global L_8fa91a
L_8fa91a:
	sub r1,r2,0x97f
L_8fa922:
	cmp_s r1,0x5
L_8fa924:
	bhi L_8fad90
L_8fa928:
	ldw.x.as r1,[0x8036b0,r1]
L_8fa930:
	add r0,pcl,0x8
L_8fa934:
	add1_s r0,r0,r1
L_8fa936:
	j_s [r0]
	.global L_8fa938
L_8fa938:
	cmp_s r2,0xa03
L_8fa93e:
	beq L_8fad4a
L_8fa942:
	cmp_s r2,0xa02
L_8fa948:
	beq_s L_8faa26
L_8fa94a:
	breq r2,0xa01,L_8faa16
L_8fa952:
	sub r1,r2,0x98b
L_8fa95a:
	cmp_s r1,0x6
L_8fa95c:
	bhi L_8fad90
L_8fa960:
	ldw.x.as r1,[0x8036bc,r1]
L_8fa968:
	add r0,pcl,0x8
L_8fa96c:
	add1_s r0,r0,r1
L_8fa96e:
	j_s [r0]
	.global L_8fa970
L_8fa970:
	mov_s r0,0x884000
L_8fa976:
	st 0x55443311,[r0, 0x5c]
L_8fa97e:
	b.d L_8fad80
L_8fa982:
	mov_s r14,0x1
	.global L_8fa984
L_8fa984:
	ld_s r2,[r13,0x4]
L_8fa986:
	mov_s r1,0x101be58
L_8fa98c:
	mov_s r0,0x20
L_8fa98e:
	bl.d L_8dcc80
L_8fa992:
	ld_s r3,[r13,0x8]
L_8fa994:
	bl L_8da2c8
L_8fa998:
	ld_s r1,[r13,0x4]
L_8fa99a:
	breq_s r0,0,L_8fa9c8
L_8fa99c:
	bic.f r1,r1,0x7f
L_8fa9a0:
	bne_s L_8fa9be
	.global L_8fa9a2
L_8fa9a2:
	mov_s r2,0x886080
L_8fa9a8:
	ld_s r1,[r2,0x54]
L_8fa9aa:
	ld_s r0,[r13,0x4]
L_8fa9ac:
	bic r1,r1,0xfe
L_8fa9b0:
	asl_s r0,r0
L_8fa9b2:
	or_s r0,r0,r1
L_8fa9b4:
	st_s r0,[r2,0x54]
L_8fa9b6:
	mov_s r14,0x12340001
L_8fa9bc:
	b_s L_8fa9d2
	.global L_8fa9be
L_8fa9be:
	mov_s r0,blink
L_8fa9c0:
	bl.d L_8c9b28
L_8fa9c4:
	mov_s r1,0xac
L_8fa9c6:
	b_s L_8fa9a2
	.global L_8fa9c8
L_8fa9c8:
	mov_s r0,0x884000
L_8fa9ce:
	st_s r1,[r0,0x5c]
L_8fa9d0:
	mov_s r14,0x1
	.global L_8fa9d2
L_8fa9d2:
	ld_s r0,[r13,0x4]
L_8fa9d4:
	mov_s r15,0xc
L_8fa9d6:
	st r0,[r17, 0x8]
L_8fa9da:
	ld_s r0,[r13,0x8]
L_8fa9dc:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_8fa9de:
	st r0,[r17, 0xc]
L_8fa9e2:
	b_s L_8faaca
	.global L_8fa9e4
L_8fa9e4:
	mov_s r1,0x101be8c
	.global L_8fa9ea
L_8fa9ea:
	bl.d L_8dcba8
L_8fa9ee:
	mov_s r0,0x10
L_8fa9f0:
	b L_8fad80
	.global L_8fa9f4
L_8fa9f4:
	bl.d L_8f448c
L_8fa9f8:
	mov_s r14,0x1
L_8fa9fa:
	b L_8fad80
L_8fa9fe:
	bl.d L_8d6e88
L_8faa02:
	ld_s r0,[r13,0x4]
L_8faa04:
	b.d L_8fad80
L_8faa08:
	mov_s r14,0x1
L_8faa0a:
	bl.d L_8d6f30
L_8faa0e:
	ld_s r0,[r13,0x4]
L_8faa10:
	b.d L_8fad80
L_8faa14:
	mov_s r14,0x1
	.global L_8faa16
L_8faa16:
	bl L_8d6f68
	.global L_8faa1a
L_8faa1a:
	st r0,[r17, 0x8]
L_8faa1e:
	mov_s r15,0xc
L_8faa20:
	b.d L_8fad80
L_8faa24:
	mov_s r14,0x1
	.global L_8faa26
L_8faa26:
	bl.d L_8d6fec
L_8faa2a:
	ldb_s r0,[r13,0x4]
L_8faa2c:
	b_s L_8faa1a
L_8faa2e:
	ldb r4,[r13, 0x14]
L_8faa32:
	ldb r5,[r13, 0x18]
L_8faa36:
	ldb r6,[r13, 0x1c]
L_8faa3a:
	ldb r7,[r13, 0x20]
L_8faa3e:
	ldb_s r0,[r13,0x4]
L_8faa40:
	ldb_s r1,[r13,0x8]
L_8faa42:
	ldb_s r2,[r13,0xc]
L_8faa44:
	bl.d L_8d7154
L_8faa48:
	ldb_s r3,[r13,0x10]
L_8faa4a:
	b.d L_8fad80
L_8faa4e:
	mov_s r14,0x1
L_8faa50:
	mov_s r0,0x8036ac
L_8faa56:
	ld_s r0,[r0]
L_8faa58:
	add r4,sp,0x4
L_8faa5c:
	st_s r0,[sp,0x4]
L_8faa5e:
	ldb_s r0,[r13,0x4]
L_8faa60:
	ldb_s r1,[r13,0x8]
L_8faa62:
	ldb_s r2,[r13,0xc]
L_8faa64:
	bl.d L_8d70d4
L_8faa68:
	ldb_s r3,[r13,0x10]
L_8faa6a:
	ld_s r0,[sp,0x4]
L_8faa6c:
	b_s L_8faa1a
	.global L_8faa6e
L_8faa6e:
	ld.as r18,[r18,r14]
L_8faa72:
	mov_s r1,0x101bee0
L_8faa78:
	mov_s r0,0x21
L_8faa7a:
	mov_s r2,r18
L_8faa7c:
	ld_s r13,[r13,0x8]
L_8faa7e:
	bl.d L_8dcc80
L_8faa82:
	mov_s r3,r13
L_8faa84:
	st r14,[r17, 0x8]
L_8faa88:
	mov_s r0,r18
L_8faa8a:
	mov_s r1,r13
L_8faa8c:
	bl.d L_8f4c28
L_8faa90:
	mov_s r2,r14
L_8faa92:
	brne r0,0x1,L_8faabe
L_8faa96:
	mov_s r0,0xff
L_8faa98:
	stb_s r0,[sp,0x4]
L_8faa9a:
	add_s r2,sp,0x4
L_8faa9c:
	mov_s r0,r18
L_8faa9e:
	bl.d L_8f4bd8
L_8faaa2:
	mov_s r1,r13
L_8faaa4:
	mov_s r14,r0
L_8faaa6:
	ldb_s r0,[sp,0x4]
L_8faaa8:
	mov_s r1,0x101bf3c
L_8faaae:
	st r0,[r17, 0x8]
L_8faab2:
	mov_s r0,0x21
L_8faab4:
	mov_s r2,r14
L_8faab6:
	bl.d L_8dcc80
L_8faaba:
	ldb_s r3,[sp,0x4]
L_8faabc:
	b_s L_8faaca
	.global L_8faabe
L_8faabe:
	mov_s r1,0x101bf80
L_8faac4:
	bl.d L_8dcba8
L_8faac8:
	mov_s r0,0x1
	.global L_8faaca
L_8faaca:
	/* add_s r15,0x4 */
	.byte 0x04,0xe7
L_8faacc:
	b.d L_8fad80
L_8faad0:
	extw_s r15,r15
L_8faad2:
	ld.as r15,[r18,r14]
L_8faad6:
	ld r18,[r13, 0x8]
L_8faada:
	mov_s r1,0x101bfc4
L_8faae0:
	mov_s r0,0x21
L_8faae2:
	mov_s r2,r15
L_8faae4:
	mov_s r3,r18
L_8faae6:
	ld r19,[r13, 0xc]
L_8faaea:
	bl.d L_8dcd00
L_8faaee:
	mov r4,r19
L_8faaf2:
	add r13,r17,0x8
L_8faaf6:
	ld r0,[r16, 0x74]
L_8faafa:
	sub r1,r13,r17
L_8faafe:
	sub r4,r0,r1
L_8fab02:
	mov_s r0,r15
L_8fab04:
	mov_s r1,r18
L_8fab06:
	mov_s r2,r19
L_8fab08:
	mov_s r3,r13
L_8fab0a:
	bl.d L_8f46f4
L_8fab0e:
	mov_s r5,r14
L_8fab10:
	brne r0,0x1,L_8fab24
L_8fab14:
	mov_s r0,r15
L_8fab16:
	mov_s r1,r18
L_8fab18:
	mov_s r2,r19
L_8fab1a:
	bl.d L_8f4b70
L_8fab1e:
	mov_s r3,r13
L_8fab20:
	mov_s r14,r0
L_8fab22:
	b_s L_8fab30
	.global L_8fab24
L_8fab24:
	mov_s r1,0x101c038
L_8fab2a:
	bl.d L_8dcba8
L_8fab2e:
	mov_s r0,0x1
	.global L_8fab30
L_8fab30:
	add r15,r19,0x8
L_8fab34:
	b.d L_8fad80
L_8fab38:
	extw_s r15,r15
L_8fab3a:
	ld.as r19,[r18,r14]
L_8fab3e:
	ld r18,[r13, 0x8]
L_8fab42:
	ld r20,[r13, 0xc]
L_8fab46:
	mov_s r1,0x101c07c
L_8fab4c:
	mov_s r0,0x21
L_8fab4e:
	mov_s r2,r19
L_8fab50:
	mov_s r3,r18
L_8fab52:
	ld_s r13,[r13,0x10]
L_8fab54:
	bl.d L_8dcd00
L_8fab58:
	mov r4,r20
L_8fab5c:
	mov_s r1,0x101c0fc
L_8fab62:
	mov_s r0,0x21
L_8fab64:
	bl.d L_8dcc10
L_8fab68:
	mov_s r2,r13
L_8fab6a:
	mov_s r0,r19
L_8fab6c:
	mov_s r1,r18
L_8fab6e:
	bl.d L_8f4c28
L_8fab72:
	mov_s r2,r14
L_8fab74:
	brne r0,0x1,L_8fab8a
L_8fab78:
	mov_s r0,r19
L_8fab7a:
	mov_s r1,r18
L_8fab7c:
	mov_s r2,r20
L_8fab7e:
	bl.d L_8f49d4
L_8fab82:
	mov_s r3,r13
L_8fab84:
	b.d L_8fad80
L_8fab88:
	mov_s r14,r0
	.global L_8fab8a
L_8fab8a:
	mov_s r1,0x101bf80
L_8fab90:
	b_s L_8facc8
L_8fab92:
	ld.as r20,[r18,r14]
L_8fab96:
	ldb_s r0,[r13,0xc]
L_8fab98:
	ld r19,[r13, 0x8]
L_8fab9c:
	st_s r0,[sp,0x0]
L_8fab9e:
	ld r18,[r13, 0x10]
L_8faba2:
	ld r22,[r13, 0x14]
L_8faba6:
	mov_s r1,0x101c114
L_8fabac:
	mov_s r0,0x21
L_8fabae:
	mov_s r2,r20
L_8fabb0:
	mov_s r3,r19
L_8fabb2:
	ld r21,[r13, 0x18]
L_8fabb6:
	bl.d L_8dcd00
L_8fabba:
	ld r4,[sp]
L_8fabbe:
	mov_s r1,0x101c184
L_8fabc4:
	mov_s r0,0x21
L_8fabc6:
	mov_s r2,r18
L_8fabc8:
	mov_s r3,r22
L_8fabca:
	bl.d L_8dcd00
L_8fabce:
	mov r4,r21
L_8fabd2:
	mov_s r0,r20
L_8fabd4:
	mov_s r1,r19
L_8fabd6:
	bl.d L_8f4c28
L_8fabda:
	mov_s r2,r14
L_8fabdc:
	brne r0,0x1,L_8fabf8
L_8fabe0:
	mov_s r0,r20
L_8fabe2:
	mov_s r1,r19
L_8fabe4:
	ld_s r2,[sp,0x0]
L_8fabe6:
	mov_s r3,r18
L_8fabe8:
	mov r4,r22
L_8fabec:
	bl.d L_8f4ab0
L_8fabf0:
	mov r5,r21
L_8fabf4:
	mov_s r14,r0
L_8fabf6:
	b_s L_8fad80
	.global L_8fabf8
L_8fabf8:
	mov_s r1,0x101c1cc
L_8fabfe:
	b_s L_8facc8
L_8fac00:
	ld.as r18,[r18,r14]
L_8fac04:
	ld_s r14,[r13,0x8]
L_8fac06:
	ld r22,[r13, 0xc]
L_8fac0a:
	ld r20,[r13, 0x10]
L_8fac0e:
	ld r19,[r13, 0x14]
L_8fac12:
	ld r21,[r13, 0x18]
L_8fac16:
	mov_s r1,0x101c214
L_8fac1c:
	mov_s r0,0x21
L_8fac1e:
	mov_s r2,r18
L_8fac20:
	mov_s r3,r14
L_8fac22:
	bl.d L_8dcd00
L_8fac26:
	mov r4,r22
L_8fac2a:
	mov_s r1,0x101c184
L_8fac30:
	mov_s r0,0x21
L_8fac32:
	mov_s r2,r20
L_8fac34:
	mov_s r3,r19
L_8fac36:
	bl.d L_8dcd00
L_8fac3a:
	mov r4,r21
L_8fac3e:
	ld r0,[r16, 0x70]
L_8fac42:
	add_s r13,r13,0x1c
L_8fac44:
	sub r4,r0,0x1c
L_8fac48:
	mov_s r0,r18
L_8fac4a:
	mov_s r1,r14
L_8fac4c:
	mov_s r2,r22
L_8fac4e:
	mov_s r3,r13
L_8fac50:
	bl.d L_8f46f4
L_8fac54:
	mov r5,0x0
L_8fac58:
	brne r0,0x1,L_8fac7e
L_8fac5c:
	cmp r22,0x48
L_8fac60:
	bhs_s L_8fac7e
L_8fac62:
	mov_s r0,r18
L_8fac64:
	mov_s r1,r14
L_8fac66:
	mov_s r2,r22
L_8fac68:
	mov_s r3,r13
L_8fac6a:
	mov r4,r20
L_8fac6e:
	mov r5,r19
L_8fac72:
	bl.d L_8f4a30
L_8fac76:
	mov r6,r21
L_8fac7a:
	mov_s r14,r0
L_8fac7c:
	b_s L_8fad80
	.global L_8fac7e
L_8fac7e:
	mov_s r14,0x0
L_8fac80:
	mov_s r1,0x101c288
L_8fac86:
	bl.d L_8dcba8
L_8fac8a:
	mov_s r0,0x1
L_8fac8c:
	mov_s r15,0x8
L_8fac8e:
	b_s L_8fad80
L_8fac90:
	ld r18,[r13, 0x4]
L_8fac94:
	mov_s r1,0x101c2d0
L_8fac9a:
	mov_s r0,0x21
L_8fac9c:
	bl.d L_8dcc10
L_8faca0:
	mov_s r2,r18
L_8faca2:
	mov_s r1,0x101c318
L_8faca8:
	mov_s r0,r18
L_8facaa:
	bl.d L_8e2f18
L_8facae:
	mov_s r2,r14
L_8facb0:
	add_s r13,r13,0x8
L_8facb2:
	brne r0,0x1,L_8facc2
L_8facb6:
	mov_s r0,r18
L_8facb8:
	bl.d L_8f4890
L_8facbc:
	mov_s r1,r13
L_8facbe:
	mov_s r14,0x1
L_8facc0:
	b_s L_8fad80
	.global L_8facc2
L_8facc2:
	mov_s r1,0x101c32c
	.global L_8facc8
L_8facc8:
	bl.d L_8dcba8
L_8faccc:
	mov_s r0,0x1
L_8facce:
	b_s L_8fad80
L_8facd0:
	ld_s r13,[r13,0x4]
L_8facd2:
	mov_s r1,0x101c36c
L_8facd8:
	mov_s r0,0x21
L_8facda:
	bl.d L_8dcc10
L_8facde:
	mov_s r2,r13
L_8face0:
	mov_s r1,0x101c3b4
L_8face6:
	mov_s r0,r13
L_8face8:
	bl.d L_8e2f18
L_8facec:
	mov_s r2,r14
L_8facee:
	add r15,r17,0x8
L_8facf2:
	brne r0,0x1,L_8fad02
L_8facf6:
	mov_s r0,r13
L_8facf8:
	bl.d L_8f47dc
L_8facfc:
	mov_s r1,r15
L_8facfe:
	mov_s r14,0x1
L_8fad00:
	b_s L_8fad0e
	.global L_8fad02
L_8fad02:
	mov_s r1,0x101c3c8
L_8fad08:
	bl.d L_8dcba8
L_8fad0c:
	mov_s r0,0x1
	.global L_8fad0e
L_8fad0e:
	mov_s r15,0x88
L_8fad10:
	b_s L_8fad80
L_8fad12:
	ld r18,[r13, 0x4]
L_8fad16:
	mov_s r1,0x101c408
L_8fad1c:
	mov_s r0,0x21
L_8fad1e:
	mov_s r2,r18
L_8fad20:
	ld_s r13,[r13,0x8]
L_8fad22:
	bl.d L_8dcc80
L_8fad26:
	mov_s r3,r13
L_8fad28:
	mov_s r0,r18
L_8fad2a:
	mov_s r1,r13
L_8fad2c:
	bl.d L_8f4960
L_8fad30:
	mov_s r2,r14
L_8fad32:
	brne r0,0x1,L_8fad42
L_8fad36:
	mov_s r0,r18
L_8fad38:
	bl.d L_8f491c
L_8fad3c:
	mov_s r1,r13
L_8fad3e:
	mov_s r14,r0
L_8fad40:
	b_s L_8fad80
	.global L_8fad42
L_8fad42:
	mov_s r1,0x101c460
L_8fad48:
	b_s L_8facc8
	.global L_8fad4a
L_8fad4a:
	mov_s r1,0x101c4a8
L_8fad50:
	bl.d L_8dcba8
L_8fad54:
	mov_s r0,0x21
L_8fad56:
	add r0,r17,0x4
L_8fad5a:
	bl.d L_8c1cd8
L_8fad5e:
	mov_s r1,0xec
L_8fad60:
	mov_s r0,0x8042c8
L_8fad66:
	ldb r6,[r0]
L_8fad6a:
	ld r4,[r13, 0x14]
L_8fad6e:
	ldb r5,[r13, 0x18]
L_8fad72:
	ldb_s r0,[r13,0x4]
L_8fad74:
	ldb_s r1,[r13,0x8]
L_8fad76:
	ld_s r2,[r13,0xc]
L_8fad78:
	bl.d L_8d5fa8
L_8fad7c:
	ld_s r3,[r13,0x10]
L_8fad7e:
	mov_s r14,r0
	.global L_8fad80
L_8fad80:
	st r14,[r17, 0x4]
L_8fad84:
	mov_s r0,r16
L_8fad86:
	mov_s r1,r17
L_8fad88:
	bl.d L_8eae78
L_8fad8c:
	mov_s r2,r15
L_8fad8e:
	b_s L_8fad9c
	.global L_8fad90
L_8fad90:
	mov_s r0,r16
L_8fad92:
	mov_s r1,0x9
L_8fad94:
	asl_s r1,r1,0x8
L_8fad96:
	bl.d L_8e5728
L_8fad9a:
	ldw_s r3,[r13]
	.global L_8fad9c
L_8fad9c:
	b.d L_8c0214
L_8fada0:
	add_s sp,sp,0x8
L_8fada2:
	nop_s
