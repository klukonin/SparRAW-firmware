/* softfloat_df_add @ 0x920974, 1888 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_build_schedule_tables, softfloat_df_sub
 */
	.section .text.softfloat_df_add,"ax",@progbits
	.global softfloat_df_add
softfloat_df_add:
	.global L_920974
L_920974:
	add r4,r1,r1
L_920978:
	add r5,r3,r3
L_92097c:
	cmp r4,r5
L_920980:
	cmp.eq r0,r2
L_920984:
	bcc L_920994
L_920988:
	mov_s r12,r0
L_92098a:
	mov_s r0,r2
L_92098c:
	mov_s r2,r12
L_92098e:
	mov_s r12,r1
L_920990:
	mov_s r1,r3
L_920992:
	mov_s r3,r12
	.global L_920994
L_920994:
	mov r12,0x7ff
L_920998:
	asl r12,r12,0x15
L_92099c:
	add1 r4,r12,r1
L_9209a0:
	add1 r5,r12,r3
L_9209a4:
	asl r12,r12,0x2
L_9209a8:
	cmp r4,r12
L_9209ac:
	cmp.cs r5,r12
L_9209b0:
	bcc L_920b7c
L_9209b4:
	lsr r4,r1,0x14
L_9209b8:
	lsr r5,r3,0x14
L_9209bc:
	sub r6,r4,r5
L_9209c0:
	bmsk r6,r6,0xa
L_9209c4:
	xor r7,r1,r3
L_9209c8:
	asl r1,r1,0xb
L_9209cc:
	lsr r12,r0,0x15
L_9209d0:
	or_s r1,r1,r12
L_9209d2:
	asl r0,r0,0xb
L_9209d6:
	asl r3,r3,0xb
L_9209da:
	lsr r12,r2,0x15
L_9209de:
	or_s r3,r3,r12
L_9209e0:
	asl r2,r2,0xb
L_9209e4:
	bset_s r3,r3,0x1f
L_9209e6:
	rsub.f r12,r6,0x20
L_9209ea:
	bhi.d L_920a04
L_9209ee:
	lsr r5,r2,r6
L_9209f2:
	cmp r6,0x40
L_9209f6:
	lsr r5,r3,r6
L_9209fa:
	mov.cc r5,0x0
L_9209fe:
	b.d L_920a14
L_920a02:
	mov_s r12,0x0
	.global L_920a04
L_920a04:
	cmp r6,0x0
L_920a08:
	asl r12,r3,r12
L_920a0c:
	or.ne r5,r5,r12
L_920a10:
	lsr r12,r3,r6
	.global L_920a14
L_920a14:
	lsr.f r7,r7,0x1f
L_920a18:
	bne.d L_920a78
L_920a1c:
	bset_s r1,r1,0x1f
L_920a1e:
	add.f r5,r5,r0
L_920a22:
	adc.f r12,r12,r1
L_920a26:
	bcc.d L_920a36
L_920a2a:
	sub.cc r4,r4,0x1
L_920a2e:
	rrc.f r12,r12
L_920a32:
	rrc r5,r5
	.global L_920a36
L_920a36:
	lsr.f r0,r5,0xb
L_920a3a:
	asl r1,r12,0x15
L_920a3e:
	or_s r0,r0,r1
L_920a40:
	lsr r1,r12,0xb
L_920a44:
	asl r4,r4,0x14
L_920a48:
	jcc.d [blink]
L_920a4c:
	add_s r1,r1,r4
L_920a4e:
	cmp r6,0x20
L_920a52:
	mov.cs r3,r2
L_920a56:
	mov.cs r2,0x0
L_920a5a:
	bmsk r3,r3,r6
L_920a5e:
	or.f r3,r3,r2
L_920a62:
	bmsk.eq.f r5,r5,0x9
L_920a66:
	btst.eq r0,0x0
L_920a6a:
	mov.ne r7,0x1
L_920a6e:
	add.f r0,r0,r7
L_920a72:
	j_s.d [blink]
L_920a74:
	adc r1,r1,0x0
	.global L_920a78
L_920a78:
	rsub.f r5,r5,r0
L_920a7c:
	sbc.f r12,r1,r12
L_920a80:
	bpl.d L_920ad0
L_920a84:
	mov_s r0,0x0
	.global L_920a86
L_920a86:
	lsr.f r0,r5,0xb
L_920a8a:
	asl r1,r12,0x15
L_920a8e:
	or_s r0,r0,r1
L_920a90:
	lsr r1,r12,0xb
L_920a94:
	sub r4,r4,0x1
L_920a98:
	asl r4,r4,0x14
L_920a9c:
	jcc.d [blink]
L_920aa0:
	add_s r1,r1,r4
L_920aa2:
	cmp r6,0x20
L_920aa6:
	mov.cs r3,r2
L_920aaa:
	mov.cs r2,0x0
L_920aae:
	bmsk r3,r3,r6
L_920ab2:
	or.f r3,r3,r2
L_920ab6:
	mov.ne r7,0x0
L_920aba:
	and.f r7,r7,r0
L_920abe:
	bmsk.eq.f r5,r5,0x9
L_920ac2:
	mov.ne r7,0x1
L_920ac6:
	add.f r0,r0,r7
L_920aca:
	j_s.d [blink]
L_920acc:
	adc r1,r1,0x0
	.global L_920ad0
L_920ad0:
	cmp.eq r5,0x0
L_920ad4:
	jeq.d [blink]
L_920ad8:
	mov_s r1,0x0
L_920ada:
	norm r0,r12
L_920ade:
	cmp_s r0,0x1f
L_920ae0:
	/* bcs.d 0x00920af2 */
	.byte 0x12,0x00,0x25,0x00
L_920ae4:
	/* _add_s r0,0x1 */
	.byte 0x01,0xe0
L_920ae6:
	norm.f r0,r5
L_920aea:
	mov.mi r0,0x20
L_920aee:
	add.pl r0,r0,0x21
	.global L_920af2
L_920af2:
	rsub.f r1,r0,0x20
L_920af6:
	bhi.d L_920b10
L_920afa:
	asl r12,r12,r0
L_920afe:
	cmp_s r0,0x40
L_920b00:
	asl r12,r5,r0
L_920b04:
	mov.cc r12,0x0
L_920b08:
	b.d L_920b1e
L_920b0c:
	mov r5,0x0
	.global L_920b10
L_920b10:
	cmp_s r0,0x0
L_920b12:
	lsr r1,r5,r1
L_920b16:
	or.ne r12,r12,r1
L_920b1a:
	asl r5,r5,r0
	.global L_920b1e
L_920b1e:
	bmsk r1,r4,0xa
L_920b22:
	rsub.f r0,r0,r1
L_920b26:
	and r4,r4,0x800
L_920b2e:
	bne.d L_920b3e
L_920b32:
	add.eq r0,r0,0x1
L_920b36:
	lsr.f r12,r12
L_920b3a:
	rrc r5,r5
	.global L_920b3e
L_920b3e:
	bcc.d L_920a86
L_920b42:
	or.cc r4,r4,r0
L_920b46:
	rsub r0,r0,0x1
L_920b4a:
	rsub.f r1,r0,0x20
L_920b4e:
	bhi.d L_920b66
L_920b52:
	lsr r5,r5,r0
L_920b56:
	cmp_s r0,0x40
L_920b58:
	lsr r5,r12,r0
L_920b5c:
	mov.cc r5,0x0
L_920b60:
	b.d L_920b74
L_920b64:
	mov_s r12,0x0
	.global L_920b66
L_920b66:
	cmp_s r0,0x0
L_920b68:
	asl r1,r12,r1
L_920b6c:
	or.ne r5,r5,r1
L_920b70:
	lsr r12,r12,r0
	.global L_920b74
L_920b74:
	b.d L_920a86
L_920b78:
	add r4,r4,0x1
	.global L_920b7c
L_920b7c:
	asl.f r10,r1
L_920b80:
	adc r4,0x0,0x0
L_920b88:
	beq L_920e2c
	.global L_920b8c
L_920b8c:
	asl.f r11,r3
L_920b90:
	adc r5,0x0,0x0
L_920b98:
	beq L_920e5a
	.global L_920b9c
L_920b9c:
	cmp r11,r10
L_920ba0:
	cmp.eq r2,r0
L_920ba4:
	mov_s r10,r0
L_920ba6:
	bls L_920bc0
L_920baa:
	mov_s r0,r2
L_920bac:
	mov_s r2,r10
L_920bae:
	mov_s r10,r1
L_920bb0:
	mov_s r1,r3
L_920bb2:
	mov_s r3,r10
L_920bb4:
	mov r10,r4
L_920bb8:
	mov r4,r5
L_920bbc:
	mov r5,r10
	.global L_920bc0
L_920bc0:
	asl r6,r1
L_920bc4:
	lsr.f r6,r6,0x15
L_920bc8:
	bic r1,r1,0xfff00000
L_920bd0:
	or.ne r1,r1,0x100000
L_920bd8:
	bne.d L_920c34
L_920bdc:
	mov_s r0,r0
L_920bde:
	cmp_s r1,0x0
L_920be0:
	beq L_920bec
L_920be4:
	b.d L_920bfe
L_920be8:
	norm r10,r1
	.global L_920bec
L_920bec:
	cmp_s r0,0x0
L_920bee:
	mov r10,0x1f
L_920bf2:
	bmi L_920bfe
L_920bf6:
	norm r10,r0
L_920bfa:
	add r10,r10,0x20
	.global L_920bfe
L_920bfe:
	sub r10,r10,0xa
L_920c02:
	sub r6,r6,r10
L_920c06:
	add r6,r6,0x1
L_920c0a:
	sub.f r11,0x20,r10
L_920c12:
	lsr r11,r0,r11
L_920c16:
	bgt L_920c28
L_920c1a:
	sub r11,r10,0x20
L_920c1e:
	asl r1,r0,r11
L_920c22:
	b.d L_920c34
L_920c26:
	mov_s r0,0x0
	.global L_920c28
L_920c28:
	asl r0,r0,r10
L_920c2c:
	asl r10,r1,r10
L_920c30:
	or r1,r11,r10
	.global L_920c34
L_920c34:
	asl r7,r3
L_920c38:
	lsr.f r7,r7,0x15
L_920c3c:
	bic r8,r3,0xfff00000
L_920c44:
	or.ne r8,r8,0x100000
L_920c4c:
	bne.d L_920caa
L_920c50:
	mov_s r2,r2
L_920c52:
	cmp r8,0x0
L_920c56:
	beq L_920c62
L_920c5a:
	b.d L_920c74
L_920c5e:
	norm r10,r8
	.global L_920c62
L_920c62:
	cmp_s r2,0x0
L_920c64:
	mov r10,0x1f
L_920c68:
	bmi L_920c74
L_920c6c:
	norm r10,r2
L_920c70:
	add r10,r10,0x20
	.global L_920c74
L_920c74:
	sub r10,r10,0xa
L_920c78:
	sub r7,r7,r10
L_920c7c:
	add r7,r7,0x1
L_920c80:
	sub.f r11,0x20,r10
L_920c88:
	lsr r11,r2,r11
L_920c8c:
	bgt L_920c9e
L_920c90:
	sub r11,r10,0x20
L_920c94:
	asl r8,r2,r11
L_920c98:
	b.d L_920caa
L_920c9c:
	mov_s r2,0x0
	.global L_920c9e
L_920c9e:
	asl r2,r2,r10
L_920ca2:
	asl r10,r8,r10
L_920ca6:
	or r8,r11,r10
	.global L_920caa
L_920caa:
	cmp r6,0x7ff
L_920cae:
	mov 0x0,0x0
L_920cb2:
	beq L_921074
L_920cb6:
	cmp r7,0x7ff
L_920cba:
	mov 0x0,0x0
L_920cbe:
	beq.d L_9210ce
L_920cc2:
	sub r11,r6,r7
L_920cc6:
	cmp r11,0x36
L_920cca:
	sub r9,r9,r9
L_920cce:
	bgt L_920e16
L_920cd2:
	sub.f r10,r11,0x2
L_920cd6:
	mov 0x0,0x0
L_920cda:
	beq L_920d6a
L_920cde:
	bgt L_920d02
L_920ce2:
	asl.f r2,r2
L_920ce6:
	rlc r8,r8
L_920cea:
	add.f r10,r10,0x1
L_920cee:
	mov 0x0,0x0
L_920cf2:
	beq L_920d6a
L_920cf6:
	asl.f r2,r2
L_920cfa:
	b.d L_920d6a
L_920cfe:
	rlc r8,r8
	.global L_920d02
L_920d02:
	cmp r10,0x20
L_920d06:
	mov r11,0x0
L_920d0a:
	blt.d L_920d32
L_920d0e:
	sub r10,r10,0x20
L_920d12:
	mov.f r9,r2
L_920d16:
	bne L_920d26
L_920d1a:
	sub r11,0x20,r10
L_920d22:
	asl r9,r8,r11
	.global L_920d26
L_920d26:
	lsr r2,r8,r10
L_920d2a:
	b.d L_920d6a
L_920d2e:
	mov r8,0x0
	.global L_920d32
L_920d32:
	sub r11,0x20,r10
L_920d3a:
	asl r9,r2,r11
L_920d3e:
	sub.f r11,0x20,r10
L_920d46:
	asl r11,r8,r11
L_920d4a:
	bgt L_920d5e
L_920d4e:
	add r11,r10,0x20
L_920d52:
	lsr r2,r8,r11
L_920d56:
	b.d L_920d6a
L_920d5a:
	mov r8,0x0
	.global L_920d5e
L_920d5e:
	lsr r2,r2,r10
L_920d62:
	lsr r8,r8,r10
L_920d66:
	or r2,r2,r11
	.global L_920d6a
L_920d6a:
	asl.f r0,r0
L_920d6e:
	rlc r1,r1
L_920d72:
	asl.f r0,r0
L_920d76:
	rlc r1,r1
L_920d7a:
	cmp r4,r5
L_920d7e:
	mov 0x0,0x0
L_920d82:
	bne L_920f72
L_920d86:
	add.f r0,r0,r2
L_920d8a:
	adc r1,r1,r8
L_920d8e:
	and.f 0x0,r1,0x800000
L_920d96:
	mov 0x0,0x0
L_920d9a:
	beq L_920dae
L_920d9e:
	add r6,r6,0x1
L_920da2:
	lsr.f r1,r1
L_920da6:
	rrc.f r0,r0
L_920daa:
	or.cs r9,r9,0x1
	.global L_920dae
L_920dae:
	and.f 0x0,r0,0x2
L_920db2:
	mov 0x0,0x0
L_920db6:
	beq.d L_920dee
L_920dba:
	cmp r9,0x0
L_920dbe:
	tst.eq r0,0x5
L_920dc2:
	mov 0x0,0x0
L_920dc6:
	beq L_920dee
L_920dca:
	add.f r0,r0,0x2
L_920dce:
	add.cs r1,r1,0x1
L_920dd2:
	and.f 0x0,r1,0x800000
L_920dda:
	mov 0x0,0x0
L_920dde:
	beq L_920dee
L_920de2:
	lsr.f r1,r1
L_920de6:
	rrc r0,r0
L_920dea:
	add r6,r6,0x1
	.global L_920dee
L_920dee:
	lsr.f r1,r1
L_920df2:
	rrc r0,r0
L_920df6:
	lsr.f r1,r1
L_920dfa:
	rrc r0,r0
	.global L_920dfe
L_920dfe:
	sub.f 0x0,r6,0x0
L_920e02:
	mov 0x0,0x0
L_920e06:
	ble L_920e6e
L_920e0a:
	cmp r6,0x7ff
L_920e0e:
	mov 0x0,0x0
L_920e12:
	bge L_920f58
	.global L_920e16
L_920e16:
	bic r1,r1,0x100000
L_920e1e:
	asl r2,r6,0x14
L_920e22:
	or_s r1,r1,r2
L_920e24:
	ror r2,r4
L_920e28:
	or_s r1,r1,r2
L_920e2a:
	j_s [blink]
	.global L_920e2c
L_920e2c:
	cmp_s r0,0x0
L_920e2e:
	mov 0x0,0x0
L_920e32:
	bne L_920b8c
L_920e36:
	cmp_s r3,0x80000000
L_920e3c:
	mov 0x0,0x0
L_920e40:
	mov.ne r1,r3
L_920e44:
	bne L_920e56
L_920e48:
	cmp_s r2,0x0
L_920e4a:
	mov 0x0,0x0
L_920e4e:
	mov.ne r1,r3
L_920e52:
	mov.eq r1,r1
	.global L_920e56
L_920e56:
	mov_s r0,r2
L_920e58:
	j_s [blink]
	.global L_920e5a
L_920e5a:
	cmp_s r2,0x0
L_920e5c:
	mov 0x0,0x0
L_920e60:
	bne L_920b9c
L_920e64:
	mov 0x0,0x0
L_920e68:
	j_s [blink]
L_920e6a:
	mov 0x0,0x0
	.global L_920e6e
L_920e6e:
	sub r10,0x0,r6
L_920e76:
	sub.f r10,r10,0x1
L_920e7a:
	mov 0x0,0x0
L_920e7e:
	blt L_920f0a
L_920e82:
	beq L_920f12
L_920e86:
	cmp r10,0x20
L_920e8a:
	mov 0x0,0x0
L_920e8e:
	blt L_920eb8
L_920e92:
	sub r10,r10,0x20
L_920e96:
	or.f r9,r9,r0
L_920e9a:
	mov r11,-0x1
L_920e9e:
	bne L_920eae
L_920ea2:
	asl r11,r11,r10
L_920ea6:
	xor r11,r11,-0x1
L_920eaa:
	and r9,r1,r11
	.global L_920eae
L_920eae:
	lsr r0,r1,r10
L_920eb2:
	b.d L_920f12
L_920eb6:
	mov_s r1,0x0
	.global L_920eb8
L_920eb8:
	cmp r9,0x0
L_920ebc:
	mov r11,-0x1
L_920ec0:
	bne L_920edc
L_920ec4:
	cmp r10,0x20
L_920ec8:
	sub.ge r11,r11,r11
L_920ecc:
	bge L_920ed4
L_920ed0:
	asl r11,r11,r10
	.global L_920ed4
L_920ed4:
	xor r11,r11,-0x1
L_920ed8:
	and r9,r0,r11
	.global L_920edc
L_920edc:
	sub.f r11,0x20,r10
L_920ee4:
	asl r11,r1,r11
L_920ee8:
	bgt L_920efa
L_920eec:
	add r11,r10,0x20
L_920ef0:
	lsr r0,r1,r11
L_920ef4:
	b.d L_920f06
L_920ef8:
	mov_s r1,0x0
	.global L_920efa
L_920efa:
	lsr r0,r0,r10
L_920efe:
	lsr r1,r1,r10
L_920f02:
	or r0,r0,r11
	.global L_920f06
L_920f06:
	b L_920f12
	.global L_920f0a
L_920f0a:
	asl.f r0,r0
L_920f0e:
	rlc r1,r1
	.global L_920f12
L_920f12:
	and.f 0x0,r0,0x2
L_920f16:
	mov 0x0,0x0
L_920f1a:
	beq L_920f36
L_920f1e:
	and r10,r0,0x5
L_920f22:
	or.f 0x0,r10,r9
L_920f26:
	mov 0x0,0x0
L_920f2a:
	beq L_920f36
L_920f2e:
	add.f r0,r0,0x2
L_920f32:
	adc r1,r1,0x0
	.global L_920f36
L_920f36:
	lsr.f r1,r1
L_920f3a:
	rrc r0,r0
L_920f3e:
	lsr.f r1,r1
L_920f42:
	rrc r0,r0
L_920f46:
	sub r6,r6,r6
L_920f4a:
	and.f 0x0,r1,0x100000
L_920f52:
	add.ne r6,r6,0x1
L_920f56:
	b_s L_920e16
	.global L_920f58
L_920f58:
	mov r6,0x7ff
L_920f5c:
	mov_s r1,0x100000
L_920f62:
	mov_s r0,0x0
L_920f64:
	b_s L_920e16
	.global L_920f66
L_920f66:
	sub r6,r6,r6
L_920f6a:
	mov_s r1,0x0
L_920f6c:
	b.d L_920e16
L_920f70:
	mov_s r0,0x0
	.global L_920f72
L_920f72:
	sub.f r0,r0,r2
L_920f76:
	sbc r1,r1,r8
L_920f7a:
	and.f 0x0,r1,0x400000
L_920f82:
	mov 0x0,0x0
L_920f86:
	bne L_920fa6
L_920f8a:
	asl.f r0,r0
L_920f8e:
	rlc r1,r1
L_920f92:
	sub r6,r6,0x1
L_920f96:
	and.f 0x0,r1,0x400000
L_920f9e:
	mov 0x0,0x0
L_920fa2:
	beq L_920ff6
	.global L_920fa6
L_920fa6:
	and.f 0x0,r0,0x2
L_920faa:
	mov 0x0,0x0
L_920fae:
	beq.d L_920ff6
L_920fb2:
	and.f 0x0,r0,0x1
L_920fb6:
	mov 0x0,0x0
L_920fba:
	bne L_920fd6
L_920fbe:
	cmp r9,0x0
L_920fc2:
	mov 0x0,0x0
L_920fc6:
	bne L_920ff6
L_920fca:
	and.f 0x0,r0,0x4
L_920fce:
	mov 0x0,0x0
L_920fd2:
	beq L_920ff6
	.global L_920fd6
L_920fd6:
	add.f r0,r0,0x2
L_920fda:
	adc r1,r1,0x0
L_920fde:
	and.f 0x0,r1,0x800000
L_920fe6:
	add.ne r6,r6,0x1
L_920fea:
	beq L_920ff6
L_920fee:
	lsr.f r1,r1
L_920ff2:
	rrc r0,r0
	.global L_920ff6
L_920ff6:
	lsr.f r1,r1
L_920ffa:
	rrc r0,r0
L_920ffe:
	lsr.f r1,r1
L_921002:
	rrc r0,r0
L_921006:
	sub.f 0x0,r1,0x100000
L_92100e:
	mov 0x0,0x0
L_921012:
	bge L_920dfe
L_921016:
	cmp_s r1,0x0
L_921018:
	beq L_921024
L_92101c:
	norm r2,r1
L_921020:
	b L_921038
	.global L_921024
L_921024:
	cmp_s r0,0x0
L_921026:
	ble L_92102e
L_92102a:
	norm r2,r0
	.global L_92102e
L_92102e:
	add.gt r2,r2,0x20
L_921032:
	beq_s L_920f66
L_921034:
	mov.lt r2,0x1f
	.global L_921038
L_921038:
	sub_s r2,r2,0xa
L_92103a:
	sub.f r11,0x20,r2
L_921042:
	lsr r11,r0,r11
L_921046:
	bgt L_921058
L_92104a:
	sub r11,r2,0x20
L_92104e:
	asl r1,r0,r11
L_921052:
	b.d L_921064
L_921056:
	mov_s r0,0x0
	.global L_921058
L_921058:
	asl r1,r1,r2
L_92105c:
	or r1,r1,r11
L_921060:
	asl r0,r0,r2
	.global L_921064
L_921064:
	sub.f r6,r6,r2
L_921068:
	mov 0x0,0x0
L_92106c:
	ble L_920e6e
L_921070:
	b L_920e16
	.global L_921074
L_921074:
	cmp_s r1,0x100000
L_92107a:
	cmp.eq r0,0x0
L_92107e:
	ror r1,r4
L_921082:
	sub_s r0,r0,r0
L_921084:
	beq L_921092
	.global L_921088
L_921088:
	or r1,r1,0x7ff80000
L_921090:
	j_s [blink]
	.global L_921092
L_921092:
	cmp r7,0x7ff
L_921096:
	mov 0x0,0x0
L_92109a:
	bne L_9210c2
L_92109e:
	cmp r8,0x100000
L_9210a6:
	cmp.eq r2,0x0
L_9210aa:
	mov 0x0,0x0
L_9210ae:
	beq L_9210b8
L_9210b2:
	ror r1,r5
L_9210b6:
	b_s L_921088
	.global L_9210b8
L_9210b8:
	cmp r4,r5
L_9210bc:
	mov 0x0,0x0
L_9210c0:
	bne_s L_921088
	.global L_9210c2
L_9210c2:
	or r1,r1,0x7ff00000
L_9210ca:
	mov_s r0,0x0
L_9210cc:
	j_s [blink]
	.global L_9210ce
L_9210ce:
	mov_s r1,r3
L_9210d0:
	mov_s r0,r2
L_9210d2:
	j_s [blink]
