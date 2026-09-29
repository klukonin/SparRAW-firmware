/* brd_if__build_tx_sector_list @ 0x8ddbbc, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if_class__init_board_file_interface
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, brd_if__clear_block_info_thunk, brd_if__section_info_reset_thunk, fw_divmod_unsigned, fw_sysassert_fatal, rf_tbl__lookup_by_module
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__build_tx_sector_list
brd_if__build_tx_sector_list:
	.global L_8ddbbc
L_8ddbbc:
	push_s blink
L_8ddbbe:
	bl.d L_8c01c0
L_8ddbc2:
	mov_s r1,0x0
L_8ddbc4:
	sub_s sp,sp,0x34
L_8ddbc6:
	mov_s r13,r0
L_8ddbc8:
	mov_s r0,sp
L_8ddbca:
	mov_s r16,r0
L_8ddbcc:
	bl.d L_8c18d0
L_8ddbd0:
	mov_s r20,r1
L_8ddbd2:
	add_s r0,sp,0x18
L_8ddbd4:
	mov_s r23,r0
L_8ddbd6:
	bl.d L_8c18cc
L_8ddbda:
	mov_s r1,0x0
L_8ddbdc:
	ld_s r0,[r13,0x44]
L_8ddbde:
	mov_s r1,0x3
L_8ddbe0:
	ld_s r3,[r0,0x8]
L_8ddbe2:
	mov_s r0,r13
L_8ddbe4:
	jl_s.d [r3]
L_8ddbe6:
	mov_s r2,r16
L_8ddbe8:
	breq_s r0,0,L_8ddc20
	.global L_8ddbea
L_8ddbea:
	ld_s r1,[r13,0x48]
L_8ddbec:
	ldb r19,[sp, 0x14]
L_8ddbf0:
	ld_s r0,[sp,0x8]
L_8ddbf2:
	add_s r1,r1,0x8
L_8ddbf4:
	add r21,r0,r1
L_8ddbf8:
	add3 r18,r13,0x8
L_8ddbfc:
	stb r20,[r18]
L_8ddc00:
	ld_s r0,[sp,0x4]
L_8ddc02:
	brlo.d r0,0x1,L_8ddcd0
L_8ddc06:
	add r14,r21,0x10
L_8ddc0a:
	mov r17,0x0
	.global L_8ddc0e
L_8ddc0e:
	add r1,r17,0x1
L_8ddc12:
	extw_s r1,r1
L_8ddc14:
	brge.d r1,0x2,L_8ddc2e
L_8ddc18:
	sub r0,r19,0x1
L_8ddc1c:
	mov_s r2,r19
L_8ddc1e:
	b_s L_8ddc3e
	.global L_8ddc20
L_8ddc20:
	mov_s r0,blink
L_8ddc22:
	mov_s r1,0x1368
L_8ddc28:
	bl L_8c9b28
L_8ddc2c:
	b_s L_8ddbea
	.global L_8ddc2e
L_8ddc2e:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8ddc30:
	extw_s r1,r1
L_8ddc32:
	mov_s lp_count,r1
L_8ddc34:
	mov_s r2,r19
L_8ddc36:
	lp L_8ddc3e
L_8ddc3a:
	and_s r2,r2,r0
L_8ddc3c:
	sub_s r0,r2,0x1
	.global L_8ddc3e
L_8ddc3e:
	bic r1,r2,r0
L_8ddc42:
	extb_s r1,r1
L_8ddc44:
	stb r20,[sp, 0x30]
L_8ddc48:
	stb r20,[sp, 0x31]
L_8ddc4c:
	add_s r3,sp,0x30
L_8ddc4e:
	add r4,sp,0x31
L_8ddc52:
	mov_s r0,r13
L_8ddc54:
	bl.d L_8cca88
L_8ddc58:
	mov_s r2,0x0
L_8ddc5a:
	ld_s r0,[r13,0x44]
L_8ddc5c:
	ldb r22,[sp, 0x30]
L_8ddc60:
	mov_s r1,r16
L_8ddc62:
	ld_s r15,[r0,0xc]
L_8ddc64:
	mov_s r0,r13
L_8ddc66:
	mov_s r2,r17
L_8ddc68:
	jl_s.d [r15]
L_8ddc6a:
	mov_s r3,r23
L_8ddc6c:
	mov_s r15,0x0
L_8ddc6e:
	b_s L_8ddca2
	.global L_8ddc70
L_8ddc70:
	breq_s r0,0,L_8ddc98
L_8ddc72:
	mov_s r0,r15
L_8ddc74:
	bl.d L_8c02d4
L_8ddc78:
	mov_s r1,0x6
L_8ddc7a:
	ldb r1,[r13,r22]
L_8ddc7e:
	cmp r1,0xff
L_8ddc82:
	bne_s L_8ddc98
L_8ddc84:
	ldb_s r1,[sp,0x30]
L_8ddc86:
	add_s r1,r1,r0
L_8ddc88:
	ldb r0,[r18]
L_8ddc8c:
	add_s r12,r13,r0
L_8ddc8e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ddc90:
	extb_s r0,r0
L_8ddc92:
	stb_s r1,[r12]
L_8ddc94:
	stb r0,[r18]
	.global L_8ddc98
L_8ddc98:
	add r22,r22,0x1
L_8ddc9c:
	extb r22,r22
L_8ddca0:
	/* add_s r15,0x6 */
	.byte 0x06,0xe7
	.global L_8ddca2
L_8ddca2:
	ld r0,[r21, 0x8]
L_8ddca6:
	lsr_s r0,r0,0x8
L_8ddca8:
	bmsk_s r0,r0,0xb
L_8ddcaa:
	brhs r15,r0,L_8ddcc6
L_8ddcae:
	mov_s r0,0x0
L_8ddcb0:
	mov_s r1,r0
	.global L_8ddcb2
L_8ddcb2:
	brhs r1,0x6,L_8ddc70
L_8ddcb6:
	ld_s r2,[r14]
L_8ddcb8:
	brne_s r2,0,L_8ddcbe
L_8ddcba:
	ld_s r2,[r14,0x4]
L_8ddcbc:
	breq_s r2,0,L_8ddcc0
	.global L_8ddcbe
L_8ddcbe:
	mov_s r0,0x1
	.global L_8ddcc0
L_8ddcc0:
	add_s r14,r14,0x8
L_8ddcc2:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_8ddcc4:
	b_s L_8ddcb2
	.global L_8ddcc6
L_8ddcc6:
	ld_s r0,[sp,0x4]
L_8ddcc8:
	add r17,r17,0x1
L_8ddccc:
	brlo r17,r0,L_8ddc0e
	.global L_8ddcd0
L_8ddcd0:
	ldb r0,[r18]
L_8ddcd4:
	breq_s r0,0,L_8ddcdc
	.global L_8ddcd6
L_8ddcd6:
	b.d L_8c020c
L_8ddcda:
	add_s sp,sp,0x34
	.global L_8ddcdc
L_8ddcdc:
	mov_s r0,blink
L_8ddcde:
	mov_s r1,0x1562
L_8ddce4:
	bl L_8c9b28
L_8ddce8:
	b_s L_8ddcd6
L_8ddcea:
	nop_s
