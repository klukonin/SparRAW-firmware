/* ie__classify_vendor_oui @ 0x8e9e04, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   OUI is WSC IE Len %d.
 *   OUI is P2P IE Len %d.
 *   OUI is USER DEFINED IE Len %d.
 * Зовут его: mgmt_tx__probe_resp_ies_8d8378
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, tx_mgmt_get_ie
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie__classify_vendor_oui
ie__classify_vendor_oui:
	.global L_8e9e04
L_8e9e04:
	push_s blink
L_8e9e06:
	bl L_8c01dc
L_8e9e0a:
	mov_s r16,r2
L_8e9e0c:
	mov_s r15,r3
L_8e9e0e:
	mov_s r13,r4
L_8e9e10:
	brlt.d r1,0x2,L_8e9eb6
L_8e9e14:
	mov_s r14,0x0
	.global L_8e9e16
L_8e9e16:
	mov_s r2,r16
L_8e9e18:
	bl.d L_8e9db0
L_8e9e1c:
	mov_s r3,r13
L_8e9e1e:
	mov.f r14,r0
L_8e9e22:
	beq_s L_8e9eb2
L_8e9e24:
	ldb_s r2,[r14,0x1]
L_8e9e26:
	brne_s r15,0,L_8e9e40
L_8e9e28:
	ldb_s r0,[r14,0x2]
L_8e9e2a:
	brne_s r0,0,L_8e9e40
L_8e9e2c:
	ldb_s r0,[r14,0x3]
L_8e9e2e:
	cmp_s r0,0x50
L_8e9e30:
	bne_s L_8e9e40
L_8e9e32:
	ldb_s r0,[r14,0x4]
L_8e9e34:
	cmp r0,0xf2
L_8e9e38:
	bne_s L_8e9e40
L_8e9e3a:
	ldb_s r0,[r14,0x5]
L_8e9e3c:
	breq r0,0x4,L_8e9e82
	.global L_8e9e40
L_8e9e40:
	brne r15,0x1,L_8e9e5e
L_8e9e44:
	ldb_s r0,[r14,0x2]
L_8e9e46:
	cmp_s r0,0x50
L_8e9e48:
	bne_s L_8e9e5e
L_8e9e4a:
	ldb_s r0,[r14,0x3]
L_8e9e4c:
	cmp_s r0,0x6f
L_8e9e4e:
	bne_s L_8e9e5e
L_8e9e50:
	ldb_s r0,[r14,0x4]
L_8e9e52:
	cmp r0,0x9a
L_8e9e56:
	bne_s L_8e9e5e
L_8e9e58:
	ldb_s r0,[r14,0x5]
L_8e9e5a:
	breq r0,0x9,L_8e9e96
	.global L_8e9e5e
L_8e9e5e:
	ldb_s r0,[r14,0x1]
L_8e9e60:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e9e62:
	brne r15,0x4,L_8e9e78
L_8e9e66:
	ldb_s r1,[r14,0x2]
L_8e9e68:
	brne r1,0xf,L_8e9e78
L_8e9e6c:
	ldb_s r1,[r14,0x3]
L_8e9e6e:
	brne r1,0x24,L_8e9e78
L_8e9e72:
	ldb_s r1,[r14,0x4]
L_8e9e74:
	cmp_s r1,0x5b
L_8e9e76:
	beq_s L_8e9ea6
	.global L_8e9e78
L_8e9e78:
	ldb_s r1,[r13]
L_8e9e7a:
	sub_s r1,r1,r0
L_8e9e7c:
	extb_s r1,r1
L_8e9e7e:
	add_s r0,r0,r14
L_8e9e80:
	b_s L_8e9e16
	.global L_8e9e82
L_8e9e82:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8e9e84:
	extb_s r2,r2
L_8e9e86:
	stb_s r2,[r13]
L_8e9e88:
	mov_s r1,0x100fc84
	.global L_8e9e8e
L_8e9e8e:
	bl.d L_8dcc10
L_8e9e92:
	mov_s r0,0x2d
L_8e9e94:
	b_s L_8e9eb6
	.global L_8e9e96
L_8e9e96:
	ldb_s r2,[r14,0x1]
L_8e9e98:
	mov_s r1,0x100fc9c
L_8e9e9e:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8e9ea0:
	extb_s r2,r2
L_8e9ea2:
	stb_s r2,[r13]
L_8e9ea4:
	b_s L_8e9e8e
	.global L_8e9ea6
L_8e9ea6:
	extb_s r2,r0
L_8e9ea8:
	mov_s r1,0x100fcb4
L_8e9eae:
	stb_s r0,[r13]
L_8e9eb0:
	b_s L_8e9e8e
	.global L_8e9eb2
L_8e9eb2:
	mov_s r14,0x0
L_8e9eb4:
	stb_s r14,[r13]
	.global L_8e9eb6
L_8e9eb6:
	b.d L_8c0244
L_8e9eba:
	mov_s r0,r14
