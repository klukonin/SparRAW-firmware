/* mlme_sm__assoc_req_handle @ 0x8e9940, 640 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   REJECT ASSOCIATING REQ from CID %d
 *   mlme_sm.cpp
 *   PCP Assoc Req OLD VS: networkType %x,test mode = %x, srv_id_1 = %x
 *   PCP Assoc Req with networkType %x, test_mode = %x, pbc = %x
 *   Save Assoc Req DMG Capabilities len %d 0x%x 0x%x
 *   Handle associate event State %d
 * Зовёт сам: RADIO_MGR__lock_primary, TX_API__alloc_tx_payload, __ld_r20_to_r13_ret, __st_r20_to_r13, build_vendor_ie, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, log_hexdump, memcpy_fw, mgmt_buf__free, mgmt_pkt__release
 * Глобалы (через gp): 0x8002d4
 */
	.section .text.mlme_sm__assoc_req_handle,"ax",@progbits
	.global mlme_sm__assoc_req_handle
mlme_sm__assoc_req_handle:
L_8e9940:
	push_s blink
L_8e9942:
	bl L_8c02ac
L_8e9946:
	mov_s r13,r0
L_8e9948:
	ld_s r0,[gp,0x164]
L_8e994a:
	mov_s r14,r1
L_8e994c:
	mulu64 r0,0x3e8
L_8e9950:
	ld_s r0,[r13,0x3c]
L_8e9952:
	mov r18,mlo
L_8e9956:
	ld_s r1,[r0,0xc]
L_8e9958:
	sub_s sp,sp,0xc
L_8e995a:
	ld_s r1,[r1,0x50]
L_8e995c:
	mov_s r0,0x0
L_8e995e:
	cmp_s r1,0x2
L_8e9960:
	cmp.ne r1,0x3
L_8e9964:
	mov.eq r0,0x1
L_8e9968:
	extb.f 0x0,r0
L_8e996c:
	beq L_8e9b76
L_8e9970:
	mov_s r0,0xd
L_8e9972:
	st_s r0,[sp,0x4]
L_8e9974:
	mov_s r0,0x0
L_8e9976:
	mov_s r17,r0
L_8e9978:
	st_s r0,[sp,0x8]
L_8e997a:
	breq r14,0x0,L_8e9a1c
	.global L_8e997e
L_8e997e:
	ld_s r0,[r13,0x3c]
L_8e9980:
	ld r16,[r0, 0xc]
L_8e9984:
	breq r16,0x0,L_8e9a32
	.global L_8e9988
L_8e9988:
	bl.d L_8c5b18
L_8e998c:
	mov_s r0,r13
L_8e998e:
	ld_s r0,[r14,0x8]
L_8e9990:
	add_s r3,sp,0x4
L_8e9992:
	ldw_s r2,[r0]
L_8e9994:
	ld_s r1,[r14,0xc]
L_8e9996:
	lsr_s r2,r2,0x4
L_8e9998:
	mov_s r0,r16
L_8e999a:
	bl.d L_8c44ec
L_8e999e:
	bmsk_s r2,r2,0x3
L_8e99a0:
	brne r0,0x0,L_8e9a5e
L_8e99a4:
	ld_s r0,[r13,0x30]
L_8e99a6:
	brne r0,0x0,L_8e9a5e
L_8e99aa:
	mov_s r0,0x25
L_8e99ac:
	stw r0,[r13, 0x44]
L_8e99b0:
	mov_s r2,0x100f294
L_8e99b6:
	mov_s r0,0xa
L_8e99b8:
	mov_s r1,0x1
L_8e99ba:
	bl.d L_8edfcc
L_8e99be:
	ldb r3,[r14, 0x36]
L_8e99c2:
	bl L_8c2c80
L_8e99c6:
	st_s r0,[r13,0x40]
L_8e99c8:
	breq r0,0x0,L_8e9a48
	.global L_8e99cc
L_8e99cc:
	ld_s r3,[r13,0x3c]
L_8e99ce:
	add_s r1,sp,0x8
L_8e99d0:
	ld_s r0,[r13,0x40]
L_8e99d2:
	bl.d L_8f1c40
L_8e99d6:
	ld_s r2,[r3,0xc]
L_8e99d8:
	mov r7,0x2a8f0
L_8e99e0:
	ldw r4,[sp, 0x8]
L_8e99e4:
	st r17,[sp]
L_8e99e8:
	ld_s r0,[r13,0x3c]
L_8e99ea:
	mov_s r1,0x0
L_8e99ec:
	mov_s r2,0x1
L_8e99ee:
	ld_s r3,[r13,0x40]
L_8e99f0:
	mov r5,0x7
L_8e99f4:
	bl.d L_8e0e08
L_8e99f8:
	mov r6,0x50
L_8e99fc:
	ld_s r1,[r13,0x3c]
L_8e99fe:
	mov_s r0,r13
L_8e9a00:
	ldb_s r1,[r1,0x8]
L_8e9a02:
	mov_s r3,0x5
L_8e9a04:
	ld_s r2,[sp,0x4]
L_8e9a06:
	bl.d L_8da490
L_8e9a0a:
	mov r4,0x0
L_8e9a0e:
	bl.d L_8c955c
L_8e9a12:
	mov_s r0,r14
L_8e9a14:
	bl.d L_8c9538
L_8e9a18:
	mov_s r0,r14
L_8e9a1a:
	b_s L_8e9bbc
	.global L_8e9a1c
L_8e9a1c:
	mov_s r0,blink
L_8e9a1e:
	mov_s r2,0x100f220
L_8e9a24:
	mov_s r1,0x11f7
L_8e9a2a:
	bl.d L_8c82c0
L_8e9a2e:
	mov_s r3,0xac
L_8e9a30:
	b_s L_8e997e
	.global L_8e9a32
L_8e9a32:
	mov_s r0,blink
L_8e9a34:
	mov_s r2,0x100f220
L_8e9a3a:
	mov_s r1,0x11f8
L_8e9a40:
	bl.d L_8c82c0
L_8e9a44:
	mov_s r3,0xae
L_8e9a46:
	b_s L_8e9988
	.global L_8e9a48
L_8e9a48:
	mov_s r0,blink
L_8e9a4a:
	mov_s r2,0x100f220
L_8e9a50:
	mov_s r1,0x11f9
L_8e9a56:
	bl.d L_8c82c0
L_8e9a5a:
	mov_s r3,0xc1
L_8e9a5c:
	b_s L_8e99cc
	.global L_8e9a5e
L_8e9a5e:
	ld_s r1,[r14,0xc]
L_8e9a60:
	ld r15,[r1, 0x9c]
L_8e9a64:
	breq_s r15,0,L_8e9ac0
L_8e9a66:
	ld_s r0,[r13,0x3c]
L_8e9a68:
	ldb_s r3,[r15,0xa]
L_8e9a6a:
	ld_s r2,[r0,0xc]
L_8e9a6c:
	ldb_s r1,[r15,0xb]
L_8e9a6e:
	add3 r0,r2,0x9
L_8e9a72:
	asl_s r1,r1,0x8
L_8e9a74:
	or_s r3,r3,r1
L_8e9a76:
	mov_s r1,0x0
L_8e9a78:
	bl.d L_8e1bb4
L_8e9a7c:
	ld_s r2,[r2,0x14]
L_8e9a7e:
	ld_s r0,[r13,0x3c]
L_8e9a80:
	ldb_s r2,[r15,0xb]
L_8e9a82:
	ldb_s r1,[r15,0xa]
L_8e9a84:
	asl_s r2,r2,0x8
L_8e9a86:
	or_s r1,r1,r2
L_8e9a88:
	st_s r1,[r0,0x38]
L_8e9a8a:
	mov_s r2,0x100f2b8
L_8e9a90:
	ldb_s r0,[r15,0x9]
L_8e9a92:
	ldb_s r3,[r15,0x8]
L_8e9a94:
	asl_s r0,r0,0x8
L_8e9a96:
	or_s r3,r3,r0
L_8e9a98:
	ldb_s r0,[r15,0xb]
L_8e9a9a:
	ldb r4,[r15, 0xa]
L_8e9a9e:
	asl_s r0,r0,0x8
L_8e9aa0:
	or r4,r4,r0
L_8e9aa4:
	ldb r5,[r15, 0x4]
L_8e9aa8:
	mov_s r0,0xa
L_8e9aaa:
	bl.d L_8ee034
L_8e9aae:
	mov_s r1,0x2
L_8e9ab0:
	ld_s r1,[r14,0xc]
L_8e9ab2:
	ld r0,[r1, 0x9c]
L_8e9ab6:
	bl.d L_8c7f90
L_8e9aba:
	ldb r1,[r1, 0x99]
L_8e9abe:
	b_s L_8e9b30
	.global L_8e9ac0
L_8e9ac0:
	ld r0,[r1, 0xa4]
L_8e9ac4:
	breq_s r0,0,L_8e9b30
L_8e9ac6:
	add3 r15,r1,0x14
L_8e9aca:
	bl.d L_8c7f90
L_8e9ace:
	ldb_s r1,[r15,0x1]
L_8e9ad0:
	add3 r0,r16,0x9
L_8e9ad4:
	mov_s r16,r0
L_8e9ad6:
	bl.d L_8db770
L_8e9ada:
	mov_s r1,r15
L_8e9adc:
	mov_s r19,r0
L_8e9ade:
	mov_s r0,r16
L_8e9ae0:
	bl.d L_8db708
L_8e9ae4:
	mov_s r1,r15
L_8e9ae6:
	mov_s r20,r0
L_8e9ae8:
	mov_s r0,r16
L_8e9aea:
	bl.d L_8db7e0
L_8e9aee:
	mov_s r1,r15
L_8e9af0:
	mov.f r5,r0
L_8e9af4:
	mov_s r15,0x0
L_8e9af6:
	mov.ne r15,0x3
L_8e9afa:
	bne_s L_8e9b04
L_8e9afc:
	cmp r19,0x0
L_8e9b00:
	mov.ne r15,0x1
	.global L_8e9b04
L_8e9b04:
	ld_s r0,[r13,0x3c]
L_8e9b06:
	mov_s r2,0x100f2fc
L_8e9b0c:
	ld r16,[r0, 0xc]
L_8e9b10:
	mov_s r0,0xa
L_8e9b12:
	mov_s r1,0x2
L_8e9b14:
	mov_s r3,r20
L_8e9b16:
	bl.d L_8ee034
L_8e9b1a:
	mov r4,r19
L_8e9b1e:
	add3 r0,r16,0x9
L_8e9b22:
	mov_s r1,r20
L_8e9b24:
	bl.d L_8e2284
L_8e9b28:
	mov_s r2,r15
L_8e9b2a:
	ld_s r0,[r13,0x3c]
L_8e9b2c:
	st r19,[r0, 0x38]
	.global L_8e9b30
L_8e9b30:
	ld_s r3,[r14,0xc]
L_8e9b32:
	ld_s r15,[r3,0x74]
L_8e9b34:
	breq_s r15,0,L_8e9b6a
L_8e9b36:
	ldb r4,[r15, 0x1]
L_8e9b3a:
	mov_s r2,0x100f338
L_8e9b40:
	ldb r3,[r3, 0x71]
L_8e9b44:
	mov_s r0,0xa
L_8e9b46:
	mov_s r1,0x2
L_8e9b48:
	bl.d L_8ee034
L_8e9b4c:
	mov r5,r4
L_8e9b50:
	ld_s r0,[r13,0x3c]
L_8e9b52:
	mov_s r1,r15
L_8e9b54:
	ld_s r2,[r14,0xc]
L_8e9b56:
	add r0,r0,0x187
L_8e9b5a:
	bl.d L_8c0460
L_8e9b5e:
	ldb r2,[r2, 0x71]
L_8e9b62:
	mov_s r0,r15
L_8e9b64:
	bl.d L_8c7f90
L_8e9b68:
	mov_s r1,0x11
	.global L_8e9b6a
L_8e9b6a:
	st_s r14,[r13,0x48]
L_8e9b6c:
	bl.d L_8c955c
L_8e9b70:
	mov_s r0,r14
L_8e9b72:
	stw r17,[r13, 0x44]
	.global L_8e9b76
L_8e9b76:
	mov_s r2,0x100f36c
L_8e9b7c:
	mov_s r0,0xa
L_8e9b7e:
	mov_s r1,0x2
L_8e9b80:
	bl.d L_8edfcc
L_8e9b84:
	ldb_s r3,[r13]
L_8e9b86:
	ld_s r0,[r13,0x34]
L_8e9b88:
	brne_s r0,0,L_8e9b9e
L_8e9b8a:
	ld_s r0,[r13,0x3c]
L_8e9b8c:
	mov_s r1,r13
L_8e9b8e:
	ld_s r2,[r0,0xc]
L_8e9b90:
	mov_s r0,0x1dd38
L_8e9b96:
	bl.d L_8d9288
L_8e9b9a:
	ldb_s r2,[r2,0x10]
L_8e9b9c:
	st_s r0,[r13,0x34]
	.global L_8e9b9e
L_8e9b9e:
	ld_s r0,[r13,0x38]
L_8e9ba0:
	brne_s r0,0,L_8e9bbc
L_8e9ba2:
	mov_s r0,0x29918
L_8e9ba8:
	mov_s r1,r13
L_8e9baa:
	mov_s r2,0x0
L_8e9bac:
	mov_s r3,0x1
L_8e9bae:
	mov r4,r18
L_8e9bb2:
	mov_s r5,r2
L_8e9bb4:
	bl.d L_8dc92c
L_8e9bb8:
	mov_s r6,r2
L_8e9bba:
	st_s r0,[r13,0x38]
	.global L_8e9bbc
L_8e9bbc:
	b.d L_8c0304
