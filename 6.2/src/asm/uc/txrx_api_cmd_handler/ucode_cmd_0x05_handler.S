/* ucode_cmd_0x05_handler @ 0x93abf4, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf__reset_sta, bits__uc_set32_s4_w4, bits__uc_set32_s8_w15, field_rw_0x29__92ebec, memset0_words_uc, rx_mode__bits_uc_set32_s0_w4, sta_ctx__reset_counters, ucode_cmd_05__index
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x05_handler
ucode_cmd_0x05_handler:
	.global L_93abf4
L_93abf4:
	push_s blink
L_93abf6:
	bl L_92022c
L_93abfa:
	ldb_s r15,[r0,0xc]
L_93abfc:
	mov_s r14,r0
L_93abfe:
	ld_s r0,[r0,0x10]
L_93ac00:
	asl_s r13,r15,0x4
L_93ac02:
	add2_s r13,r13,r13
L_93ac04:
	add_s r13,r13,0x801104
L_93ac0a:
	brne r0,0x1,L_93ac68
L_93ac0e:
	ldw_s r0,[r13,0x2]
L_93ac10:
	mov_s r1,0x0
L_93ac12:
	bclr_s r0,r0,0x0
L_93ac14:
	stw_s r0,[r13,0x2]
L_93ac16:
	mov_s r2,0x8010b0
L_93ac1c:
	ldb_s r0,[r2,0x11]
L_93ac1e:
	bclr r0,r0,r15
L_93ac22:
	stb_s r0,[r2,0x11]
L_93ac24:
	add r0,gp,r15
L_93ac28:
	stb r1,[r0, 0x9c]
L_93ac2c:
	lr r13,[0xa]
L_93ac30:
	bclr r0,r13,0x1
L_93ac34:
	flag r0
L_93ac38:
	mov_s r0,r15
L_93ac3a:
	bl.d L_92210c
L_93ac3e:
	mov_s r1,0x1
L_93ac40:
	mov_s r0,0x802f80
L_93ac46:
	bl.d L_93d004
L_93ac4a:
	mov_s r1,r15
L_93ac4c:
	lr r0,[0xa]
L_93ac50:
	bic r13,r13,-0x3
L_93ac54:
	or_s r13,r13,r0
L_93ac56:
	flag r13
L_93ac5a:
	mov_s r0,0x801be8
L_93ac60:
	bl.d L_92ebec
L_93ac64:
	mov_s r1,r15
L_93ac66:
	b_s L_93ad4e
	.global L_93ac68
L_93ac68:
	brne r0,0x0,L_93ace8
L_93ac6c:
	mov_s r1,0x8010b0
L_93ac72:
	ldb_s r0,[r1,0x11]
L_93ac74:
	mov r16,0x1
L_93ac78:
	bclr r0,r0,r15
L_93ac7c:
	stb_s r0,[r1,0x11]
L_93ac7e:
	mov_s r1,0x0
L_93ac80:
	add r0,gp,r15
L_93ac84:
	stb r1,[r0, 0x9c]
L_93ac88:
	mov_s r0,0x801be8
L_93ac8e:
	bl.d L_920cdc
L_93ac92:
	mov_s r1,r15
L_93ac94:
	mov_s r0,r13
L_93ac96:
	bl.d L_920a84
L_93ac9a:
	mov_s r1,0x50
L_93ac9c:
	ldw_s r0,[r13,0x2]
L_93ac9e:
	add r2,r14,0x20
L_93aca2:
	or r0,r0,0x3
L_93aca6:
	stw_s r0,[r13,0x2]
L_93aca8:
	ldw_s r0,[r14,0xe]
L_93acaa:
	add3 r1,r13,0x8
L_93acae:
	st_s r0,[r13,0x10]
L_93acb0:
	ld_s r0,[r14,0x14]
L_93acb2:
	st_s r0,[r13,0x28]
L_93acb4:
	ldw_s r0,[r14,0x1c]
L_93acb6:
	stw_s r0,[r13,0x30]
L_93acb8:
	ldw_s r0,[r14,0x1e]
L_93acba:
	stw_s r0,[r13,0x32]
L_93acbc:
	ldw_s r0,[r14,0x20]
L_93acbe:
	stw_s r0,[r13,0x34]
L_93acc0:
	ldb_s r0,[r2,0x4]
L_93acc2:
	stb_s r0,[r1,0x8]
L_93acc4:
	ldb_s r0,[r2,0x5]
L_93acc6:
	stb_s r0,[r1,0x9]
L_93acc8:
	ldb_s r0,[r2,0x6]
L_93acca:
	stb r16,[r1, 0xc]
L_93acce:
	stb_s r0,[r1,0xa]
L_93acd0:
	mov_s r0,0x40
L_93acd2:
	stb_s r0,[r1,0xd]
L_93acd4:
	mov_s r0,0x8020c4
L_93acda:
	add2_s r0,r0,r15
L_93acdc:
	st 0x29528,[r0]
L_93ace4:
	mov_s r0,0x5
L_93ace6:
	stw_s r0,[r13]
	.global L_93ace8
L_93ace8:
	ld_s r0,[r14,0x10]
L_93acea:
	brne r0,0x2,L_93acf8
L_93acee:
	ldw_s r0,[r14,0xa]
L_93acf0:
	brne r0,0xffff,L_93ad34
	.global L_93acf8
L_93acf8:
	ldw_s r1,[r14,0x2]
L_93acfa:
	add r0,r13,0x8
L_93acfe:
	bmsk_s r1,r1,0xe
L_93ad00:
	bl L_93e414
L_93ad04:
	ldb_s r1,[r14]
L_93ad06:
	bmsk_s r1,r1,0x3
L_93ad08:
	bl L_93e39c
L_93ad0c:
	mov_s r1,0x3
L_93ad0e:
	bl L_93e3f0
L_93ad12:
	ldw_s r1,[r14,0x6]
L_93ad14:
	cmp r1,0xff
L_93ad18:
	bne_s L_93ad1e
L_93ad1a:
	add3 r1,r15,0xc
	.global L_93ad1e
L_93ad1e:
	bmsk_s r1,r1,0xe
L_93ad20:
	add_s r0,r13,0x4
L_93ad22:
	bl L_93e414
L_93ad26:
	ldb_s r1,[r14,0x4]
L_93ad28:
	bmsk_s r1,r1,0x3
L_93ad2a:
	bl L_93e39c
L_93ad2e:
	mov_s r1,0x2
L_93ad30:
	bl L_93e3f0
	.global L_93ad34
L_93ad34:
	ldw_s r1,[r14,0xa]
L_93ad36:
	add r0,r13,0xc
L_93ad3a:
	bmsk_s r1,r1,0xe
L_93ad3c:
	bl L_93e414
L_93ad40:
	ldb_s r1,[r14,0x8]
L_93ad42:
	bmsk_s r1,r1,0x3
L_93ad44:
	bl L_93e39c
L_93ad48:
	mov_s r1,0x2
L_93ad4a:
	bl L_93e3f0
	.global L_93ad4e
L_93ad4e:
	b L_920294
L_93ad52:
	nop_s
