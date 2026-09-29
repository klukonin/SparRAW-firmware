/* set_parse_ei @ 0x8e6a54, 524 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [PRS]set_parse_ei: EI_ID %d stype %x EI_LEN %d
 *   [PRS] ESE EI ID=%d, EI_LEN=%d (pos_to_end %d)
 *   [PRS] unknown EI ID=%d, EI_LEN=%d
 * Зовут его: rx_mgmt_prs__parse
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global set_parse_ei
set_parse_ei:
	.global L_8e6a54
L_8e6a54:
	push_s blink
L_8e6a56:
	bl.d L_8c01e4
L_8e6a5a:
	mov_s r0,r2
L_8e6a5c:
	mov_s r2,r3
L_8e6a5e:
	cmp_s r2,0x38
L_8e6a60:
	mov_s r3,r6
L_8e6a62:
	beq.d L_8e6c50
L_8e6a66:
	mov_s r13,0x0
L_8e6a68:
	bgt L_8e6a84
L_8e6a6c:
	cmp_s r2,0x37
L_8e6a6e:
	bhi L_8e6c50
L_8e6a72:
	ldb r10,[0x802c74,r2]
L_8e6a7a:
	add r14,pcl,0xc
L_8e6a7e:
	add1 r14,r14,r10
L_8e6a82:
	j_s [r14]
	.global L_8e6a84
L_8e6a84:
	cmp r2,0x98
L_8e6a88:
	beq L_8e6c50
L_8e6a8c:
	bgt L_8e6ab8
L_8e6a90:
	cmp_s r2,0x3d
L_8e6a92:
	mov_s r12,0x66
L_8e6a94:
	cmp.ne r2,r12
L_8e6a98:
	beq L_8e6c50
L_8e6a9c:
	mov_s r14,r2
L_8e6a9e:
	sub r14,r14,0x8f
L_8e6aa2:
	cmp_s r14,0x8
L_8e6aa4:
	bhi L_8e6c50
L_8e6aa8:
	ldb r14,[0x802cac,r14]
L_8e6ab0:
	add r3,pcl,0x8
L_8e6ab4:
	add1_s r3,r3,r14
L_8e6ab6:
	j_s [r3]
	.global L_8e6ab8
L_8e6ab8:
	cmp r2,0xdd
L_8e6abc:
	beq_s L_8e6b8c
L_8e6abe:
	cmp r2,0xbe
L_8e6ac2:
	beq_s L_8e6b68
L_8e6ac4:
	mov_s r14,r2
L_8e6ac6:
	sub r14,r14,0x99
L_8e6aca:
	cmp_s r14,0x8
L_8e6acc:
	bhi L_8e6c50
L_8e6ad0:
	ldb r14,[0x802cb8,r14]
L_8e6ad8:
	add r3,pcl,0x8
L_8e6adc:
	add1_s r3,r3,r14
L_8e6ade:
	j_s [r3]
L_8e6ae0:
	ld_s r2,[r0,0xc]
L_8e6ae2:
	breq_s r2,0,L_8e6af4
L_8e6ae4:
	mov_s r1,0x1014120
L_8e6aea:
	mov_s r0,0xd
L_8e6aec:
	bl.d L_8dcd00
L_8e6af0:
	mov_s r2,r13
L_8e6af2:
	b_s L_8e6b1e
	.global L_8e6af4
L_8e6af4:
	st_s r1,[r0,0xc]
L_8e6af6:
	stb r4,[r0, 0x9]
L_8e6afa:
	stb_s r13,[r0,0x8]
L_8e6afc:
	b_s L_8e6b52
L_8e6afe:
	mov_s r3,0x1
	.global L_8e6b00
L_8e6b00:
	ld_s r2,[r0,0x14]
L_8e6b02:
	breq r2,0x0,L_8e6b82
L_8e6b06:
	b_s L_8e6b1e
L_8e6b08:
	ld_s r2,[r0,0x1c]
L_8e6b0a:
	mov_s r3,0x7
L_8e6b0c:
	brne_s r2,0,L_8e6b1e
L_8e6b0e:
	st_s r1,[r0,0x1c]
L_8e6b10:
	stb r4,[r0, 0x19]
L_8e6b14:
	stb_s r3,[r0,0x18]
L_8e6b16:
	b_s L_8e6b52
L_8e6b18:
	ld_s r2,[r0,0x24]
L_8e6b1a:
	mov_s r3,0xc
L_8e6b1c:
	breq_s r2,0,L_8e6b24
	.global L_8e6b1e
L_8e6b1e:
	mov r0,-0x1
L_8e6b22:
	b_s L_8e6c0e
	.global L_8e6b24
L_8e6b24:
	st_s r1,[r0,0x24]
L_8e6b26:
	stb r4,[r0, 0x21]
L_8e6b2a:
	stb r3,[r0, 0x20]
L_8e6b2e:
	b_s L_8e6b52
L_8e6b30:
	ld_s r2,[r0,0x44]
L_8e6b32:
	mov_s r3,0x30
L_8e6b34:
	brne_s r2,0,L_8e6b1e
L_8e6b36:
	st_s r1,[r0,0x44]
L_8e6b38:
	stb r4,[r0, 0x41]
L_8e6b3c:
	stb r3,[r0, 0x40]
L_8e6b40:
	b_s L_8e6b52
L_8e6b42:
	ld_s r2,[r0,0x74]
L_8e6b44:
	mov_s r3,0x94
L_8e6b46:
	brne_s r2,0,L_8e6b52
L_8e6b48:
	st_s r1,[r0,0x74]
L_8e6b4a:
	stb r4,[r0, 0x71]
L_8e6b4e:
	stb r3,[r0, 0x70]
	.global L_8e6b52
L_8e6b52:
	mov_s r0,r13
L_8e6b54:
	b_s L_8e6c0e
L_8e6b56:
	ld_s r2,[r0,0x7c]
L_8e6b58:
	mov_s r3,0x97
L_8e6b5a:
	brne_s r2,0,L_8e6b1e
L_8e6b5c:
	st_s r1,[r0,0x7c]
L_8e6b5e:
	stb r4,[r0, 0x79]
L_8e6b62:
	stb r3,[r0, 0x78]
L_8e6b66:
	b_s L_8e6b52
	.global L_8e6b68
L_8e6b68:
	add r0,r0,0x80
L_8e6b6c:
	ld_s r3,[r0,0xc]
L_8e6b6e:
	brne_s r3,0,L_8e6b1e
L_8e6b70:
	st_s r1,[r0,0xc]
L_8e6b72:
	stb r4,[r0, 0x9]
L_8e6b76:
	stb_s r2,[r0,0x8]
L_8e6b78:
	b_s L_8e6b52
L_8e6b7a:
	mov_s r3,0x9e
L_8e6b7c:
	add r0,r0,0x80
L_8e6b80:
	b_s L_8e6b00
	.global L_8e6b82
L_8e6b82:
	st_s r1,[r0,0x14]
L_8e6b84:
	stb r4,[r0, 0x11]
L_8e6b88:
	stb_s r3,[r0,0x10]
L_8e6b8a:
	b_s L_8e6b52
	.global L_8e6b8c
L_8e6b8c:
	ldb_s r3,[r1]
L_8e6b8e:
	brne_s r3,0,L_8e6bae
L_8e6b90:
	ldb_s r3,[r1,0x1]
L_8e6b92:
	cmp r3,0xaa
L_8e6b96:
	bne_s L_8e6bae
L_8e6b98:
	ldb_s r3,[r1,0x2]
L_8e6b9a:
	cmp_s r3,0x6c
L_8e6b9c:
	bne_s L_8e6bae
L_8e6b9e:
	add r0,r0,0x80
L_8e6ba2:
	stb_s r2,[r0,0x18]
L_8e6ba4:
	stb r4,[r0, 0x19]
L_8e6ba8:
	st_s r1,[r0,0x1c]
L_8e6baa:
	st_s r13,[r0,0x24]
L_8e6bac:
	b_s L_8e6b52
	.global L_8e6bae
L_8e6bae:
	ldb_s r3,[r1]
L_8e6bb0:
	brne r3,0x4,L_8e6bd6
L_8e6bb4:
	ldb_s r3,[r1,0x1]
L_8e6bb6:
	cmp r3,0xce
L_8e6bba:
	bne_s L_8e6bd6
L_8e6bbc:
	ldb_s r3,[r1,0x2]
L_8e6bbe:
	brne r3,0x14,L_8e6bd6
L_8e6bc2:
	stb r2,[r0, 0xa0]
L_8e6bc6:
	stb r4,[r0, 0xa1]
L_8e6bca:
	st r1,[r0, 0xa4]
L_8e6bce:
	mov_s r13,0x0
L_8e6bd0:
	st r13,[r0, 0x9c]
L_8e6bd4:
	b_s L_8e6b52
	.global L_8e6bd6
L_8e6bd6:
	ldb_s r0,[r1]
L_8e6bd8:
	cmp_s r0,0x50
L_8e6bda:
	bne_s L_8e6bf0
L_8e6bdc:
	ldb_s r0,[r1,0x1]
L_8e6bde:
	cmp_s r0,0x6f
L_8e6be0:
	bne_s L_8e6bf0
L_8e6be2:
	ldb_s r0,[r1,0x2]
L_8e6be4:
	cmp r0,0x9a
L_8e6be8:
	bne_s L_8e6bf0
L_8e6bea:
	ldb_s r0,[r1,0x3]
L_8e6bec:
	breq r0,0x9,L_8e6c08
	.global L_8e6bf0
L_8e6bf0:
	ldb_s r0,[r1]
L_8e6bf2:
	brne_s r0,0,L_8e6c0c
L_8e6bf4:
	ldb_s r0,[r1,0x1]
L_8e6bf6:
	cmp_s r0,0x50
L_8e6bf8:
	bne_s L_8e6c0c
L_8e6bfa:
	ldb_s r0,[r1,0x2]
L_8e6bfc:
	cmp r0,0xf2
L_8e6c00:
	bne_s L_8e6c0c
L_8e6c02:
	ldb_s r0,[r1,0x3]
L_8e6c04:
	brne r0,0x4,L_8e6c0c
	.global L_8e6c08
L_8e6c08:
	mov_s r0,0x0
L_8e6c0a:
	b_s L_8e6c0e
	.global L_8e6c0c
L_8e6c0c:
	mov_s r0,0x1
	.global L_8e6c0e
L_8e6c0e:
	b L_8c0254
L_8e6c12:
	ld r2,[r0, 0xac]
L_8e6c16:
	cmp_s r2,0x0
L_8e6c18:
	mov_s r3,0x9d
L_8e6c1a:
	bne_s L_8e6b1e
L_8e6c1c:
	st r1,[r0, 0xac]
L_8e6c20:
	stb r4,[r0, 0xa9]
L_8e6c24:
	stb r3,[r0, 0xa8]
L_8e6c28:
	b_s L_8e6b52
L_8e6c2a:
	ld_s r3,[r0,0x6c]
L_8e6c2c:
	cmp_s r3,0x0
L_8e6c2e:
	mov_s r2,0x90
L_8e6c30:
	bne_s L_8e6b1e
L_8e6c32:
	st_s r1,[r0,0x6c]
L_8e6c34:
	add_s r0,r0,0x60
L_8e6c36:
	stb r4,[r0, 0x9]
L_8e6c3a:
	stb_s r2,[r0,0x8]
L_8e6c3c:
	mov_s r1,0x1014150
L_8e6c42:
	mov_s r0,0x2d
L_8e6c44:
	mov_s r3,r4
L_8e6c46:
	bl.d L_8dcd00
L_8e6c4a:
	mov r4,r5
L_8e6c4e:
	b_s L_8e6b52
	.global L_8e6c50
L_8e6c50:
	mov_s r1,0x1014180
L_8e6c56:
	mov_s r0,0x1d
L_8e6c58:
	bl.d L_8dcc80
L_8e6c5c:
	mov_s r3,r4
L_8e6c5e:
	b_s L_8e6c0c
