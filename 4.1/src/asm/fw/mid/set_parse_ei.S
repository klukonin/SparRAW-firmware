/* set_parse_ei @ 0x8e1c30, 540 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [PRS]set_parse_ei: EI_ID %d stype %x EI_LEN %d
 *   [PRS] ESE EI ID=%d, EI_LEN=%d (pos_to_end %d)
 *   [PRS] unknown EI ID=%d, EI_LEN=%d
 * Зовут его: rx_mgmt_prs__parse
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, fw_log__emit3
 */
	.section .text.set_parse_ei,"ax",@progbits
	.global set_parse_ei
set_parse_ei:
	.global L_8e1c30
L_8e1c30:
	push_s blink
L_8e1c32:
	bl.d L_8c02c4
L_8e1c36:
	mov r7,r4
L_8e1c3a:
	cmp_s r3,0x38
L_8e1c3c:
	mov r4,r6
L_8e1c40:
	beq.d L_8e1e36
L_8e1c44:
	mov_s r13,0x0
L_8e1c46:
	bgt L_8e1c62
L_8e1c4a:
	cmp_s r3,0x37
L_8e1c4c:
	bhi L_8e1e36
L_8e1c50:
	ldb r10,[0x802634,r3]
L_8e1c58:
	add r0,pcl,0xa
L_8e1c5c:
	add1 r0,r0,r10
L_8e1c60:
	j_s [r0]
	.global L_8e1c62
L_8e1c62:
	cmp r3,0x98
L_8e1c66:
	beq L_8e1e36
L_8e1c6a:
	bgt L_8e1c96
L_8e1c6e:
	cmp_s r3,0x3d
L_8e1c70:
	mov_s r12,0x66
L_8e1c72:
	cmp.ne r3,r12
L_8e1c76:
	beq L_8e1e36
L_8e1c7a:
	mov_s r0,r3
L_8e1c7c:
	sub r0,r0,0x8f
L_8e1c80:
	cmp_s r0,0x8
L_8e1c82:
	bhi L_8e1e36
L_8e1c86:
	ldb r0,[0x80266c,r0]
L_8e1c8e:
	add r14,pcl,0xa
L_8e1c92:
	add1_s r14,r14,r0
L_8e1c94:
	j_s [r14]
	.global L_8e1c96
L_8e1c96:
	cmp r3,0xdd
L_8e1c9a:
	beq_s L_8e1d70
L_8e1c9c:
	cmp r3,0xbe
L_8e1ca0:
	beq_s L_8e1d4c
L_8e1ca2:
	mov_s r14,r3
L_8e1ca4:
	sub r14,r14,0x99
L_8e1ca8:
	cmp_s r14,0x8
L_8e1caa:
	bhi L_8e1e36
L_8e1cae:
	ldb r14,[0x802678,r14]
L_8e1cb6:
	add r0,pcl,0xa
L_8e1cba:
	add1_s r0,r0,r14
L_8e1cbc:
	j_s [r0]
L_8e1cbe:
	ld_s r0,[r2,0xc]
L_8e1cc0:
	breq_s r0,0,L_8e1cd8
L_8e1cc2:
	mov_s r2,0x1010ba8
L_8e1cc8:
	mov_s r0,0xd
L_8e1cca:
	mov_s r1,r13
L_8e1ccc:
	mov_s r3,r13
L_8e1cce:
	bl.d L_8ee034
L_8e1cd2:
	mov r5,r7
L_8e1cd6:
	b_s L_8e1d02
	.global L_8e1cd8
L_8e1cd8:
	st_s r1,[r2,0xc]
L_8e1cda:
	stb r7,[r2, 0x9]
L_8e1cde:
	stb_s r13,[r2,0x8]
L_8e1ce0:
	b_s L_8e1d36
L_8e1ce2:
	mov_s r3,0x1
	.global L_8e1ce4
L_8e1ce4:
	ld_s r0,[r2,0x14]
L_8e1ce6:
	breq r0,0x0,L_8e1d66
L_8e1cea:
	b_s L_8e1d02
L_8e1cec:
	ld_s r0,[r2,0x1c]
L_8e1cee:
	mov_s r3,0x7
L_8e1cf0:
	brne_s r0,0,L_8e1d02
L_8e1cf2:
	st_s r1,[r2,0x1c]
L_8e1cf4:
	stb r7,[r2, 0x19]
L_8e1cf8:
	stb_s r3,[r2,0x18]
L_8e1cfa:
	b_s L_8e1d36
L_8e1cfc:
	ld_s r0,[r2,0x24]
L_8e1cfe:
	mov_s r3,0xc
L_8e1d00:
	breq_s r0,0,L_8e1d08
	.global L_8e1d02
L_8e1d02:
	mov r0,-0x1
L_8e1d06:
	b_s L_8e1df4
	.global L_8e1d08
L_8e1d08:
	st_s r1,[r2,0x24]
L_8e1d0a:
	stb r7,[r2, 0x21]
L_8e1d0e:
	stb r3,[r2, 0x20]
L_8e1d12:
	b_s L_8e1d36
L_8e1d14:
	ld_s r0,[r2,0x44]
L_8e1d16:
	mov_s r3,0x30
L_8e1d18:
	brne_s r0,0,L_8e1d02
L_8e1d1a:
	st_s r1,[r2,0x44]
L_8e1d1c:
	stb r7,[r2, 0x41]
L_8e1d20:
	stb r3,[r2, 0x40]
L_8e1d24:
	b_s L_8e1d36
L_8e1d26:
	ld_s r0,[r2,0x74]
L_8e1d28:
	mov_s r3,0x94
L_8e1d2a:
	brne_s r0,0,L_8e1d36
L_8e1d2c:
	st_s r1,[r2,0x74]
L_8e1d2e:
	stb r7,[r2, 0x71]
L_8e1d32:
	stb r3,[r2, 0x70]
	.global L_8e1d36
L_8e1d36:
	mov_s r0,r13
L_8e1d38:
	b_s L_8e1df4
L_8e1d3a:
	ld_s r0,[r2,0x7c]
L_8e1d3c:
	mov_s r3,0x97
L_8e1d3e:
	brne_s r0,0,L_8e1d02
L_8e1d40:
	st_s r1,[r2,0x7c]
L_8e1d42:
	stb r7,[r2, 0x79]
L_8e1d46:
	stb r3,[r2, 0x78]
L_8e1d4a:
	b_s L_8e1d36
	.global L_8e1d4c
L_8e1d4c:
	add r2,r2,0x80
L_8e1d50:
	ld_s r0,[r2,0xc]
L_8e1d52:
	brne_s r0,0,L_8e1d02
L_8e1d54:
	st_s r1,[r2,0xc]
L_8e1d56:
	stb r7,[r2, 0x9]
L_8e1d5a:
	stb_s r3,[r2,0x8]
L_8e1d5c:
	b_s L_8e1d36
L_8e1d5e:
	mov_s r3,0x9e
L_8e1d60:
	add r2,r2,0x80
L_8e1d64:
	b_s L_8e1ce4
	.global L_8e1d66
L_8e1d66:
	st_s r1,[r2,0x14]
L_8e1d68:
	stb r7,[r2, 0x11]
L_8e1d6c:
	stb_s r3,[r2,0x10]
L_8e1d6e:
	b_s L_8e1d36
	.global L_8e1d70
L_8e1d70:
	add3 r0,r2,0x10
L_8e1d74:
	stb_s r13,[r0,0x19]
L_8e1d76:
	st_s r13,[r0,0x1c]
L_8e1d78:
	add r2,r2,0xa0
L_8e1d7c:
	stb_s r13,[r2,0x1]
L_8e1d7e:
	st_s r13,[r0,0x24]
L_8e1d80:
	ldb_s r14,[r1]
L_8e1d82:
	brne_s r14,0,L_8e1d9c
L_8e1d84:
	ldb_s r14,[r1,0x1]
L_8e1d86:
	cmp r14,0xaa
L_8e1d8a:
	bne_s L_8e1d9c
L_8e1d8c:
	ldb_s r14,[r1,0x2]
L_8e1d8e:
	cmp_s r14,0x6c
L_8e1d90:
	bne_s L_8e1d9c
L_8e1d92:
	stb_s r3,[r0,0x18]
L_8e1d94:
	stb r7,[r0, 0x19]
L_8e1d98:
	st_s r1,[r0,0x1c]
L_8e1d9a:
	b_s L_8e1d36
	.global L_8e1d9c
L_8e1d9c:
	ldb_s r14,[r1]
L_8e1d9e:
	brne r14,0x4,L_8e1dbc
L_8e1da2:
	ldb_s r14,[r1,0x1]
L_8e1da4:
	cmp r14,0xce
L_8e1da8:
	bne_s L_8e1dbc
L_8e1daa:
	ldb_s r14,[r1,0x2]
L_8e1dac:
	brne r14,0x14,L_8e1dbc
L_8e1db0:
	stb_s r3,[r2]
L_8e1db2:
	stb r7,[r2, 0x1]
L_8e1db6:
	st_s r1,[r0,0x24]
L_8e1db8:
	st_s r13,[r0,0x1c]
L_8e1dba:
	b_s L_8e1dd6
	.global L_8e1dbc
L_8e1dbc:
	ldb_s r0,[r1]
L_8e1dbe:
	cmp_s r0,0x50
L_8e1dc0:
	bne_s L_8e1dda
L_8e1dc2:
	ldb_s r0,[r1,0x1]
L_8e1dc4:
	cmp_s r0,0x6f
L_8e1dc6:
	bne_s L_8e1dda
L_8e1dc8:
	ldb_s r0,[r1,0x2]
L_8e1dca:
	cmp r0,0x9a
L_8e1dce:
	bne_s L_8e1dda
L_8e1dd0:
	ldb_s r0,[r1,0x3]
L_8e1dd2:
	brne r0,0x9,L_8e1dda
	.global L_8e1dd6
L_8e1dd6:
	mov_s r0,0x0
L_8e1dd8:
	b_s L_8e1df4
	.global L_8e1dda
L_8e1dda:
	ldb_s r0,[r1]
L_8e1ddc:
	brne_s r0,0,L_8e1df2
L_8e1dde:
	ldb_s r0,[r1,0x1]
L_8e1de0:
	cmp_s r0,0x50
L_8e1de2:
	bne_s L_8e1df2
L_8e1de4:
	ldb_s r0,[r1,0x2]
L_8e1de6:
	cmp r0,0xf2
L_8e1dea:
	bne_s L_8e1df2
L_8e1dec:
	ldb_s r0,[r1,0x3]
L_8e1dee:
	breq r0,0x4,L_8e1dd6
	.global L_8e1df2
L_8e1df2:
	mov_s r0,0x1
	.global L_8e1df4
L_8e1df4:
	b L_8c0334
L_8e1df8:
	ld r0,[r2, 0xac]
L_8e1dfc:
	cmp_s r0,0x0
L_8e1dfe:
	mov_s r3,0x9d
L_8e1e00:
	bne_s L_8e1d02
L_8e1e02:
	st r1,[r2, 0xac]
L_8e1e06:
	stb r7,[r2, 0xa9]
L_8e1e0a:
	stb r3,[r2, 0xa8]
L_8e1e0e:
	b_s L_8e1d36
L_8e1e10:
	ld_s r0,[r2,0x6c]
L_8e1e12:
	cmp_s r0,0x0
L_8e1e14:
	mov_s r3,0x90
L_8e1e16:
	bne_s L_8e1d02
L_8e1e18:
	st_s r1,[r2,0x6c]
L_8e1e1a:
	add_s r2,r2,0x60
L_8e1e1c:
	stb r7,[r2, 0x9]
L_8e1e20:
	stb_s r3,[r2,0x8]
L_8e1e22:
	mov_s r2,0x1010bd8
L_8e1e28:
	mov_s r0,0xd
L_8e1e2a:
	mov_s r1,0x2
L_8e1e2c:
	bl.d L_8ee034
L_8e1e30:
	mov r4,r7
L_8e1e34:
	b_s L_8e1d36
	.global L_8e1e36
L_8e1e36:
	mov_s r2,0x1010c08
L_8e1e3c:
	mov_s r0,0xd
L_8e1e3e:
	mov_s r1,0x1
L_8e1e40:
	bl.d L_8edff8
L_8e1e44:
	mov r4,r7
L_8e1e48:
	b_s L_8e1df2
L_8e1e4a:
	nop_s
