/* handle_omni_sector_info @ 0x8cd940, 472 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   handle_omni_sector_info: RFs(0x%x) with RX sectors info in brd file aren't part of all RFs(0x%x)
 *   handle_omni_sector_info: wrong RX sectors info in brd file
 *   handle_omni_sector_info: expected MASSIVE or SINGLE; the wrong usage mode (%d)
 *   handle_omni_sector_info: wrong RX sectors nuber (%d) for diversity; or wrong topology(%d)
 * Зовут его: marlon_r_if_class__config_channel
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_divmod_signed, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, hwd_abif__dvs_rfca_cmd_enable, marlon_r_if_class__rf_write_with_block_retries, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global handle_omni_sector_info
handle_omni_sector_info:
	.global L_8cd940
L_8cd940:
	push_s blink
L_8cd942:
	bl.d L_8c01cc
L_8cd946:
	mov_s r2,0x30
L_8cd948:
	st.a r0,[sp,-0x34]
L_8cd94c:
	mov_s r15,r1
L_8cd94e:
	add r16,sp,0x4
L_8cd952:
	mov_s r1,0x802014
L_8cd958:
	bl.d L_8c0380
L_8cd95c:
	mov_s r0,r16
L_8cd95e:
	ld_s r13,[sp,0x0]
L_8cd960:
	ld r19,[r15, 0xc]
L_8cd964:
	mov_s r20,r13
L_8cd966:
	add r13,r13,0x440
L_8cd96a:
	ldb r17,[r13, 0x1d]
L_8cd96e:
	ldb_s r3,[r13,0x1e]
L_8cd970:
	mov r18,0x0
L_8cd974:
	and r0,r3,r17
L_8cd978:
	add r20,r20,0x400
L_8cd97c:
	breq r0,r17,L_8cd98c
L_8cd980:
	mov_s r1,0x1005d5c
L_8cd986:
	mov_s r0,0x10
L_8cd988:
	mov_s r2,r17
L_8cd98a:
	b_s L_8cdb0e
	.global L_8cd98c
L_8cd98c:
	brne r19,0x0,L_8cd9a8
L_8cd990:
	mov_s r1,0x1005dc0
L_8cd996:
	bl.d L_8dcba8
L_8cd99a:
	mov_s r0,r18
L_8cd99c:
	mov_s r0,blink
L_8cd99e:
	mov_s r1,0x1571
L_8cd9a4:
	bl L_8c9b28
	.global L_8cd9a8
L_8cd9a8:
	mov_s r14,0x0
L_8cd9aa:
	mov_s r0,r17
L_8cd9ac:
	b_s L_8cd9b6
	.global L_8cd9ae
L_8cd9ae:
	sub_s r1,r0,0x1
L_8cd9b0:
	and_s r0,r0,r1
L_8cd9b2:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cd9b4:
	extw_s r14,r14
	.global L_8cd9b6
L_8cd9b6:
	brne_s r0,0,L_8cd9ae
L_8cd9b8:
	add_s r1,r14,r14
L_8cd9ba:
	add1_s r1,r1,r1
L_8cd9bc:
	bl.d L_8c02dc
L_8cd9c0:
	ldw_s r0,[r15,0x12]
L_8cd9c2:
	mov r5,0x1
L_8cd9c6:
	stw_s r0,[r13,0x26]
L_8cd9c8:
	ldw_s r0,[r13,0x26]
L_8cd9ca:
	add_s r0,r0,r0
L_8cd9cc:
	add1 r6,r0,r0
L_8cd9d0:
	brlt.d r14,0x1,L_8cda44
L_8cd9d4:
	mov_s r2,0x0
L_8cd9d6:
	mov_s r4,r14
L_8cd9d8:
	extw r4,r4
	.global L_8cd9dc
L_8cd9dc:
	mov_s r14,0x0
L_8cd9de:
	mov_s r1,r19
L_8cd9e0:
	mov_s r3,r14
L_8cd9e2:
	b_s L_8cd9fa
	.global L_8cd9e4
L_8cd9e4:
	ld_s r15,[r1]
L_8cd9e6:
	breq r5,0x0,L_8cd9f0
L_8cd9ea:
	add3 r0,sp,r3
L_8cd9ee:
	st_s r15,[r0,0x8]
	.global L_8cd9f0
L_8cd9f0:
	ld.ab r0,[r1,0x4]
L_8cd9f4:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8cd9f6:
	or_s r14,r14,r0
L_8cd9f8:
	extw_s r3,r3
	.global L_8cd9fa
L_8cd9fa:
	brlt r3,0x6,L_8cd9e4
L_8cd9fe:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8cda00:
	extw_s r2,r2
L_8cda02:
	breq_s r14,0,L_8cda38
L_8cda04:
	cmp_s r2,0x1
L_8cda06:
	sub r1,r17,0x1
L_8cda0a:
	mov.le r3,r17
L_8cda0e:
	ble_s L_8cda20
L_8cda10:
	sub_s r0,r2,0x1
L_8cda12:
	extw_s r0,r0
L_8cda14:
	mov_s lp_count,r0
L_8cda16:
	mov_s r3,r17
L_8cda18:
	lp L_8cda20
L_8cda1c:
	and_s r3,r3,r1
L_8cda1e:
	sub_s r1,r3,0x1
	.global L_8cda20
L_8cda20:
	ldb r0,[r20, 0x70]
L_8cda24:
	bic_s r3,r3,r1
L_8cda26:
	or_s r3,r3,r0
L_8cda28:
	stb r3,[r20, 0x70]
L_8cda2c:
	add r18,r18,0x1
L_8cda30:
	extw r18,r18
L_8cda34:
	mov r5,0x0
	.global L_8cda38
L_8cda38:
	sub r4,r4,0x1
L_8cda3c:
	brhs.d r4,0x1,L_8cd9dc
L_8cda40:
	add2 r19,r19,r6
	.global L_8cda44
L_8cda44:
	mov.f r0,r18
L_8cda48:
	beq_s L_8cdb12
L_8cda4a:
	ld r3,[r20, 0x68]
L_8cda4e:
	brne r0,0x1,L_8cdb00
L_8cda52:
	cmp_s r3,0x3
L_8cda54:
	cmp.ne r3,0x1
L_8cda58:
	beq_s L_8cda68
L_8cda5a:
	mov_s r1,0x1005dfc
L_8cda60:
	mov_s r0,0x0
L_8cda62:
	bl.d L_8dcc10
L_8cda66:
	mov_s r2,r3
	.global L_8cda68
L_8cda68:
	ldb_s r2,[r13,0x1e]
L_8cda6a:
	mov_s r0,0x0
L_8cda6c:
	b_s L_8cda76
	.global L_8cda6e
L_8cda6e:
	sub_s r1,r2,0x1
L_8cda70:
	and_s r2,r2,r1
L_8cda72:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cda74:
	extw_s r0,r0
	.global L_8cda76
L_8cda76:
	brne_s r2,0,L_8cda6e
L_8cda78:
	brlt.d r0,0x1,L_8cdacc
L_8cda7c:
	mov_s r14,0x1
L_8cda7e:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8cda80:
	extw_s r0,r0
L_8cda82:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8cda84
L_8cda84:
	mov_s r15,r0
L_8cda86:
	ldb_s r1,[r13,0x1e]
L_8cda88:
	brlt.d r14,0x2,L_8cda9e
L_8cda8c:
	sub_s r2,r1,0x1
L_8cda8e:
	sub_s r0,r14,0x1
L_8cda90:
	extw lp_count,r0
L_8cda94:
	nop_s
L_8cda96:
	lp L_8cda9e
L_8cda9a:
	and_s r1,r1,r2
L_8cda9c:
	sub_s r2,r1,0x1
	.global L_8cda9e
L_8cda9e:
	bic r0,r1,r2
L_8cdaa2:
	extb_s r0,r0
L_8cdaa4:
	bl.d L_8ce910
L_8cdaa8:
	mov_s r1,0x0
L_8cdaaa:
	ld_s r0,[sp,0x0]
L_8cdaac:
	mov_s r1,0x0
L_8cdaae:
	mov_s r2,r16
L_8cdab0:
	mov_s r3,0x6
L_8cdab2:
	mov r4,0x10
L_8cdab6:
	mov r5,0x5
L_8cdaba:
	bl.d L_8e3418
L_8cdabe:
	mov r6,0x1
L_8cdac2:
	sub_s r0,r15,0x1
L_8cdac4:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cdac6:
	brhs.d r0,0x1,L_8cda84
L_8cdaca:
	extw_s r14,r14
	.global L_8cdacc
L_8cdacc:
	ldw_s r0,[r13,0x26]
L_8cdace:
	mov_s r2,0x857720
L_8cdad4:
	stb_s r0,[r2,0x1c]
L_8cdad6:
	mov_s r1,0x84783c
L_8cdadc:
	ldb_s r0,[r1,0x1]
L_8cdade:
	brne_s r0,0,L_8cdb12
L_8cdae0:
	ldb_s r0,[r2,0x14]
L_8cdae2:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8cdae4:
	ldw_s r2,[r13,0x26]
L_8cdae6:
	extb_s r0,r0
L_8cdae8:
	brlt.d r2,0x1,L_8cdb12
L_8cdaec:
	mov_s r3,0x0
	.global L_8cdaee
L_8cdaee:
	add1 r2,r1,r3
L_8cdaf2:
	stb_s r0,[r2,0x1]
L_8cdaf4:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8cdaf6:
	ldw_s r2,[r13,0x26]
L_8cdaf8:
	extb_s r3,r3
L_8cdafa:
	brlt r3,r2,L_8cdaee
L_8cdafe:
	b_s L_8cdb12
	.global L_8cdb00
L_8cdb00:
	breq r3,0x2,L_8cdb12
L_8cdb04:
	ldw_s r2,[r13,0x26]
L_8cdb06:
	mov_s r1,0x1005e4c
L_8cdb0c:
	mov_s r0,0x0
	.global L_8cdb0e
L_8cdb0e:
	bl L_8dcc80
	.global L_8cdb12
L_8cdb12:
	b.d L_8c0224
L_8cdb16:
	add_s sp,sp,0x34
