/* ucode_cmd_0x0b_handler @ 0x937da4, 604 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, bi_cfg__pack_words_thunk, disable_tsf_event, mac__program_tx_with_qid, macq__probe_empty, memcpy_uc, rf__store_last_module_index, uc_sysassert, ucode_cmd_0b__apply
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x0b_handler
ucode_cmd_0x0b_handler:
	.global L_937da4
L_937da4:
	push_s blink
L_937da6:
	push_s r13
L_937da8:
	mov_s r13,r0
L_937daa:
	mov_s r0,0x802f44
L_937db0:
	bl.d L_92b174
L_937db4:
	sub_s sp,sp,0x40
L_937db6:
	mov_s r0,0x8022a8
L_937dbc:
	add3 r1,r13,0xa
L_937dc0:
	bl.d L_920330
L_937dc4:
	mov_s r2,0x20
L_937dc6:
	mov_s r0,0x802a20
L_937dcc:
	bl.d L_92b198
L_937dd0:
	add_s r1,r13,0x4
L_937dd2:
	ld_s r0,[r13]
L_937dd4:
	cmp_s r0,0x0
L_937dd6:
	beq_s L_937ec2
L_937dd8:
	cmp_s r0,0x1
L_937dda:
	beq_s L_937ed4
L_937ddc:
	cmp_s r0,0x2
L_937dde:
	bne L_937fb4
L_937de2:
	bl.d L_938000
L_937de6:
	mov_s r0,0x0
L_937de8:
	bl.d L_92dab8
L_937dec:
	mov_s r0,0x1e
L_937dee:
	cmp_s r0,0x0
L_937df0:
	beq_s L_937eca
	.global L_937df2
L_937df2:
	mov_s r0,0x886500
L_937df8:
	ld_s r0,[r0,0x6c]
L_937dfa:
	bmsk.f 0x0,r0,0x3
L_937dfe:
	mov.ne r0,blink
L_937e02:
	bl.ne.d L_926618
L_937e06:
	mov.ne r1,0x3
L_937e0a:
	mov_s r0,0x1c000006
L_937e10:
	mov_s r32,r0
L_937e12:
	st.ab r0,[r25,0x4]
L_937e16:
	bclr r25,r25,0xa
L_937e1a:
	mov_s r0,0x460001e8
L_937e20:
	mov_s r32,r0
L_937e22:
	st.ab r0,[r25,0x4]
L_937e26:
	bclr r25,r25,0xa
L_937e2a:
	mov_s r1,0x8022c8
L_937e30:
	ld_s r0,[r1,0x14]
L_937e32:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937e34:
	st_s r0,[r1,0x14]
	.global L_937e36
L_937e36:
	mov_s r0,r53
L_937e38:
	bbit0 r0,0x2,L_937e36
L_937e3c:
	ld_s r0,[gp,-0x44]
L_937e3e:
	and r0,r0,0xfff0ffff
L_937e46:
	bset r1,r0,0x10
L_937e4a:
	or r0,r0,0x1d010000
L_937e52:
	st.as r1,[gp,-0x11]
L_937e56:
	mov_s r32,r0
L_937e58:
	st.ab r0,[r25,0x4]
L_937e5c:
	bclr r25,r25,0xa
L_937e60:
	nop_s
L_937e62:
	nop_s
L_937e64:
	nop_s
	.global L_937e66
L_937e66:
	mov_s r0,r47
L_937e68:
	bbit1 r0,0x0,L_937e66
L_937e6c:
	mov_s r0,0x4428001e
L_937e72:
	mov_s r32,r0
L_937e74:
	st.ab r0,[r25,0x4]
L_937e78:
	bclr r25,r25,0xa
L_937e7c:
	mov_s r0,0x45000001
L_937e82:
	mov_s r32,r0
L_937e84:
	st.ab r0,[r25,0x4]
L_937e88:
	bclr r25,r25,0xa
L_937e8c:
	mov_s r0,0x460001f1
L_937e92:
	mov_s r32,r0
L_937e94:
	st.ab r0,[r25,0x4]
L_937e98:
	bclr r25,r25,0xa
L_937e9c:
	mov_s r0,0x1e
L_937e9e:
	bl.d L_92d93c
L_937ea2:
	st_s r0,[sp,0x4]
	.global L_937ea4
L_937ea4:
	mov_s r0,r43
L_937ea6:
	bbit0 r0,0x1f,L_937ea4
L_937eaa:
	mov_s r0,r51
L_937eac:
	bmsk r1,r0,0x3
L_937eb0:
	st.as r1,[gp,0x38]
L_937eb4:
	lsr_s r0,r0,0x4
L_937eb6:
	st.as r0,[gp,0x39]
	.global L_937eba
L_937eba:
	mov_s r0,r45
L_937ebc:
	bbit0 r0,0x1f,L_937eba
L_937ec0:
	b_s L_937fb4
	.global L_937ec2
L_937ec2:
	bl.d L_938000
L_937ec6:
	mov_s r0,0x1
L_937ec8:
	b_s L_937fb4
	.global L_937eca
L_937eca:
	mov_s r0,blink
L_937ecc:
	bl.d L_926618
L_937ed0:
	mov_s r1,0x7
L_937ed2:
	b_s L_937df2
	.global L_937ed4
L_937ed4:
	ldb_s r0,[gp,-0xf0]
L_937ed6:
	cmp_s r0,0x1
L_937ed8:
	bl.eq L_925a10
L_937edc:
	bl.d L_92dab8
L_937ee0:
	mov_s r0,0x1e
L_937ee2:
	cmp_s r0,0x0
L_937ee4:
	beq_s L_937ff6
	.global L_937ee6
L_937ee6:
	mov_s r0,0x886500
L_937eec:
	ld_s r0,[r0,0x6c]
L_937eee:
	bmsk.f 0x0,r0,0x3
L_937ef2:
	mov.ne r0,blink
L_937ef6:
	bl.ne.d L_926618
L_937efa:
	mov.ne r1,0x3
L_937efe:
	mov_s r0,0x1c000006
L_937f04:
	mov_s r32,r0
L_937f06:
	st.ab r0,[r25,0x4]
L_937f0a:
	bclr r25,r25,0xa
L_937f0e:
	mov_s r0,0x460001e8
L_937f14:
	mov_s r32,r0
L_937f16:
	st.ab r0,[r25,0x4]
L_937f1a:
	bclr r25,r25,0xa
L_937f1e:
	mov_s r1,0x8022c8
L_937f24:
	ld_s r0,[r1,0x14]
L_937f26:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937f28:
	st_s r0,[r1,0x14]
	.global L_937f2a
L_937f2a:
	mov_s r0,r53
L_937f2c:
	bbit0 r0,0x2,L_937f2a
L_937f30:
	ld_s r0,[gp,-0x44]
L_937f32:
	and r0,r0,0xfff0ffff
L_937f3a:
	bset r1,r0,0x10
L_937f3e:
	or r0,r0,0x1d010000
L_937f46:
	st.as r1,[gp,-0x11]
L_937f4a:
	mov_s r32,r0
L_937f4c:
	st.ab r0,[r25,0x4]
L_937f50:
	bclr r25,r25,0xa
L_937f54:
	nop_s
L_937f56:
	nop_s
L_937f58:
	nop_s
	.global L_937f5a
L_937f5a:
	mov_s r0,r47
L_937f5c:
	bbit1 r0,0x0,L_937f5a
L_937f60:
	mov_s r0,0x4428001e
L_937f66:
	mov_s r32,r0
L_937f68:
	st.ab r0,[r25,0x4]
L_937f6c:
	bclr r25,r25,0xa
L_937f70:
	mov_s r0,0x45000001
L_937f76:
	mov_s r32,r0
L_937f78:
	st.ab r0,[r25,0x4]
L_937f7c:
	bclr r25,r25,0xa
L_937f80:
	mov_s r0,0x460001f1
L_937f86:
	mov_s r32,r0
L_937f88:
	st.ab r0,[r25,0x4]
L_937f8c:
	bclr r25,r25,0xa
L_937f90:
	mov_s r0,0x1e
L_937f92:
	bl.d L_92d93c
L_937f96:
	st_s r0,[sp,0x4]
	.global L_937f98
L_937f98:
	mov_s r0,r43
L_937f9a:
	bbit0 r0,0x1f,L_937f98
L_937f9e:
	mov_s r0,r51
L_937fa0:
	bmsk r1,r0,0x3
L_937fa4:
	st.as r1,[gp,0x38]
L_937fa8:
	lsr_s r0,r0,0x4
L_937faa:
	st.as r0,[gp,0x39]
	.global L_937fae
L_937fae:
	mov_s r0,r45
L_937fb0:
	bbit0 r0,0x1f,L_937fae
	.global L_937fb4
L_937fb4:
	ld_s r0,[r13]
L_937fb6:
	cmp_s r0,0x0
L_937fb8:
	cmp.ne r0,0x2
L_937fbc:
	bne_s L_937ff0
L_937fbe:
	mov_s r2,0x8022a8
L_937fc4:
	ldb_s r3,[r2,0x7]
L_937fc6:
	mov_s r0,0x80165c
L_937fcc:
	ldw.as r0,[r0,r3]
L_937fd0:
	mov_s r1,0x802a14
L_937fd6:
	st_s r0,[r1]
L_937fd8:
	mov_s r0,0x801674
L_937fde:
	ldw.as r3,[r0,r3]
L_937fe2:
	ldb_s r0,[r2,0xa]
L_937fe4:
	st_s r3,[r1,0x4]
L_937fe6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937fe8:
	mulu64 r0,r3
L_937fec:
	st mlo,[r1, 0x8]
	.global L_937ff0
L_937ff0:
	b.d L_9202ac
L_937ff4:
	add_s sp,sp,0x40
	.global L_937ff6
L_937ff6:
	mov_s r0,blink
L_937ff8:
	bl.d L_926618
L_937ffc:
	mov_s r1,0x7
L_937ffe:
	b_s L_937ee6
