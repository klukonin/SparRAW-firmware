/* pbss_sta_list_update @ 0x8d88c4, 572 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__action
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, add_pbss_dmg_capinfo_list, conn_mgr__by_cid, hexdump_words, memcpy_fw, pbss__add_sta, pbss__del_sta, pbss__sta_entry_flag, radio_mgr__alloc_request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pbss_sta_list_update
pbss_sta_list_update:
	.global L_8d88c4
L_8d88c4:
	push_s blink
L_8d88c6:
	bl L_8c01d4
L_8d88ca:
	sub_s sp,sp,0x38
L_8d88cc:
	mov_s r15,r0
L_8d88ce:
	mov_s r13,r1
L_8d88d0:
	bl.d L_8cbffc
L_8d88d4:
	mov_s r0,r2
L_8d88d6:
	mov_s r16,r0
L_8d88d8:
	sub r17,r13,0x2
L_8d88dc:
	extw r17,r17
L_8d88e0:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8d88e2:
	mov_s r0,r15
L_8d88e4:
	bl.d L_8c9790
L_8d88e8:
	mov_s r1,r17
L_8d88ea:
	cmp r16,0x0
L_8d88ee:
	beq L_8d8afa
L_8d88f2:
	ld r13,[r16, 0x18]
L_8d88f6:
	add r14,r16,0x1c
L_8d88fa:
	add_s r0,sp,0x30
L_8d88fc:
	mov_s r1,r15
L_8d88fe:
	bl.d L_8c0380
L_8d8902:
	mov_s r2,0x6
L_8d8904:
	add r18,r15,0x6
L_8d8908:
	sub r17,r17,0x6
L_8d890c:
	extw r17,r17
L_8d8910:
	mov_s r15,0x0
L_8d8912:
	b_s L_8d891c
	.global L_8d8914
L_8d8914:
	mov_s r0,0x0
	.global L_8d8916
L_8d8916:
	stb r0,[r1, 0x28]
L_8d891a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8d891c
L_8d891c:
	brge r15,0x8,L_8d8934
L_8d8920:
	add3 r0,r13,0x9
L_8d8924:
	bl.d L_8cc9b0
L_8d8928:
	extw_s r1,r15
L_8d892a:
	add r1,sp,r15
L_8d892e:
	breq_s r0,0,L_8d8914
L_8d8930:
	mov_s r0,0x3
L_8d8932:
	b_s L_8d8916
	.global L_8d8934
L_8d8934:
	mov_s r15,sp
L_8d8936:
	mov_s r0,r15
L_8d8938:
	add r1,r18,0x2
L_8d893c:
	bl.d L_8c0380
L_8d8940:
	mov_s r2,0x11
L_8d8942:
	mov_s r0,r15
L_8d8944:
	bl.d L_8c9790
L_8d8948:
	mov_s r1,0x11
L_8d894a:
	ldb r0,[sp, 0x6]
L_8d894e:
	cmp_s r0,0x8
L_8d8950:
	bge L_8d8afa
L_8d8954:
	add_s r13,r13,0x48
L_8d8956:
	mov_s r0,r13
L_8d8958:
	bl.d L_8c2b50
L_8d895c:
	mov_s r1,r15
L_8d895e:
	cmp_s r0,0x0
L_8d8960:
	ldb r1,[sp, 0x6]
L_8d8964:
	add_s r1,r1,sp
L_8d8966:
	beq_s L_8d8a82
L_8d8968:
	mov_s r0,0x8004a4
L_8d896e:
	ldb_s r3,[r0]
L_8d8970:
	ldb_s r2,[sp,0x0]
L_8d8972:
	brne r3,r2,L_8d89a6
L_8d8976:
	ldb_s r15,[r0,0x1]
L_8d8978:
	ldb r3,[sp, 0x1]
L_8d897c:
	brne r15,r3,L_8d89a6
L_8d8980:
	ldb_s r15,[r0,0x2]
L_8d8982:
	ldb r3,[sp, 0x2]
L_8d8986:
	brne r15,r3,L_8d89a6
L_8d898a:
	ldb_s r15,[r0,0x3]
L_8d898c:
	ldb r3,[sp, 0x3]
L_8d8990:
	brne r15,r3,L_8d89a6
L_8d8994:
	ldb_s r15,[r0,0x4]
L_8d8996:
	ldb_s r3,[sp,0x4]
L_8d8998:
	brne r15,r3,L_8d89a6
L_8d899c:
	ldb_s r3,[r0,0x5]
L_8d899e:
	ldb r0,[sp, 0x5]
L_8d89a2:
	breq r3,r0,L_8d8a82
	.global L_8d89a6
L_8d89a6:
	ldb_s r0,[r14]
L_8d89a8:
	brne r2,r0,L_8d8a86
L_8d89ac:
	ldb_s r2,[r14,0x1]
L_8d89ae:
	ldb r0,[sp, 0x1]
L_8d89b2:
	brne r0,r2,L_8d8a86
L_8d89b6:
	ldb_s r2,[r14,0x2]
L_8d89b8:
	ldb r0,[sp, 0x2]
L_8d89bc:
	brne r0,r2,L_8d8a86
L_8d89c0:
	ldb_s r2,[r14,0x3]
L_8d89c2:
	ldb r0,[sp, 0x3]
L_8d89c6:
	brne r0,r2,L_8d8a86
L_8d89ca:
	ldb_s r2,[r14,0x4]
L_8d89cc:
	ldb_s r0,[sp,0x4]
L_8d89ce:
	brne r0,r2,L_8d8a86
L_8d89d2:
	ldb_s r2,[r14,0x5]
L_8d89d4:
	ldb r0,[sp, 0x5]
L_8d89d8:
	brne r0,r2,L_8d8a86
L_8d89dc:
	b_s L_8d8a82
	.global L_8d89de
L_8d89de:
	add_s r15,sp,0x14
L_8d89e0:
	mov_s r0,r15
L_8d89e2:
	add r1,r18,0x2
L_8d89e6:
	bl.d L_8c0380
L_8d89ea:
	mov_s r2,0x11
L_8d89ec:
	ldb r0,[sp, 0x1a]
L_8d89f0:
	cmp_s r0,0x8
L_8d89f2:
	bge L_8d8afa
L_8d89f6:
	mov_s r0,r15
L_8d89f8:
	bl.d L_8c9790
L_8d89fc:
	mov_s r1,0x11
L_8d89fe:
	mov_s r0,r13
L_8d8a00:
	bl.d L_8c2b50
L_8d8a04:
	mov_s r1,r15
L_8d8a06:
	ldb r1,[sp, 0x1a]
L_8d8a0a:
	add_s r1,r1,sp
L_8d8a0c:
	breq_s r0,0,L_8d8a82
L_8d8a0e:
	mov_s r0,0x8004a4
L_8d8a14:
	ldb_s r3,[r0]
L_8d8a16:
	ldb_s r2,[sp,0x14]
L_8d8a18:
	brne r3,r2,L_8d8a4c
L_8d8a1c:
	ldb_s r15,[r0,0x1]
L_8d8a1e:
	ldb r3,[sp, 0x15]
L_8d8a22:
	brne r15,r3,L_8d8a4c
L_8d8a26:
	ldb_s r15,[r0,0x2]
L_8d8a28:
	ldb r3,[sp, 0x16]
L_8d8a2c:
	brne r15,r3,L_8d8a4c
L_8d8a30:
	ldb_s r15,[r0,0x3]
L_8d8a32:
	ldb r3,[sp, 0x17]
L_8d8a36:
	brne r15,r3,L_8d8a4c
L_8d8a3a:
	ldb_s r15,[r0,0x4]
L_8d8a3c:
	ldb_s r3,[sp,0x18]
L_8d8a3e:
	brne r15,r3,L_8d8a4c
L_8d8a42:
	ldb_s r3,[r0,0x5]
L_8d8a44:
	ldb r0,[sp, 0x19]
L_8d8a48:
	breq r3,r0,L_8d8a82
	.global L_8d8a4c
L_8d8a4c:
	ldb_s r0,[r14]
L_8d8a4e:
	brne r0,r2,L_8d8a86
L_8d8a52:
	ldb_s r2,[r14,0x1]
L_8d8a54:
	ldb r0,[sp, 0x15]
L_8d8a58:
	brne r2,r0,L_8d8a86
L_8d8a5c:
	ldb_s r2,[r14,0x2]
L_8d8a5e:
	ldb r0,[sp, 0x16]
L_8d8a62:
	brne r2,r0,L_8d8a86
L_8d8a66:
	ldb_s r2,[r14,0x3]
L_8d8a68:
	ldb r0,[sp, 0x17]
L_8d8a6c:
	brne r2,r0,L_8d8a86
L_8d8a70:
	ldb_s r2,[r14,0x4]
L_8d8a72:
	ldb_s r0,[sp,0x18]
L_8d8a74:
	brne r2,r0,L_8d8a86
L_8d8a78:
	ldb_s r2,[r14,0x5]
L_8d8a7a:
	ldb r0,[sp, 0x19]
L_8d8a7e:
	brne r2,r0,L_8d8a86
	.global L_8d8a82
L_8d8a82:
	mov_s r0,0x1
L_8d8a84:
	b_s L_8d8a88
	.global L_8d8a86
L_8d8a86:
	mov_s r0,0x2
	.global L_8d8a88
L_8d8a88:
	sub r17,r17,0x13
L_8d8a8c:
	extw r17,r17
L_8d8a90:
	stb r0,[r1, 0x28]
L_8d8a94:
	brlo.d r17,0x11,L_8d8aa6
L_8d8a98:
	add r18,r18,0x13
L_8d8a9c:
	ldb r0,[r18]
L_8d8aa0:
	cmp r0,0x94
L_8d8aa4:
	beq_s L_8d89de
	.global L_8d8aa6
L_8d8aa6:
	mov_s r14,0x0
L_8d8aa8:
	b_s L_8d8abe
	.global L_8d8aaa
L_8d8aaa:
	breq_s r0,0,L_8d8abc
L_8d8aac:
	extw_s r1,r14
L_8d8aae:
	bl.d L_8cc9b0
L_8d8ab2:
	mov_s r0,r13
L_8d8ab4:
	mov_s r1,r0
L_8d8ab6:
	bl.d L_8e01a4
L_8d8aba:
	mov_s r0,r16
	.global L_8d8abc
L_8d8abc:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8d8abe
L_8d8abe:
	brge r14,0x8,L_8d8afa
L_8d8ac2:
	add r1,sp,r14
L_8d8ac6:
	ldb r1,[r1, 0x28]
L_8d8aca:
	cmp_s r1,0x0
L_8d8acc:
	cmp.ne r1,0x1
L_8d8ad0:
	beq_s L_8d8abc
L_8d8ad2:
	mov_s r0,0x803c00
L_8d8ad8:
	ld_s r0,[r0,0xc]
L_8d8ada:
	breq r1,0x2,L_8d8aaa
L_8d8ade:
	breq_s r0,0,L_8d8af0
L_8d8ae0:
	extw_s r1,r14
L_8d8ae2:
	bl.d L_8cc9b0
L_8d8ae6:
	mov_s r0,r13
L_8d8ae8:
	mov_s r1,r0
L_8d8aea:
	bl.d L_8e01f4
L_8d8aee:
	mov_s r0,r16
	.global L_8d8af0
L_8d8af0:
	extb_s r1,r14
L_8d8af2:
	bl.d L_8e2724
L_8d8af6:
	mov_s r0,r13
L_8d8af8:
	b_s L_8d8abc
	.global L_8d8afa
L_8d8afa:
	b.d L_8c0234
L_8d8afe:
	add_s sp,sp,0x38
