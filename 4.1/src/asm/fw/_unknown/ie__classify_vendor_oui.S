/* ie__classify_vendor_oui @ 0x8f1de4, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   OUI is WSC IE Len %d.
 *   OUI is P2P IE Len %d.
 * Зовут его: mgmt_tx__probe_resp_ies
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, tx_mgmt_get_ie
 */
	.section .text.ie__classify_vendor_oui,"ax",@progbits
	.global ie__classify_vendor_oui
ie__classify_vendor_oui:
	.global L_8f1de4
L_8f1de4:
	push_s blink
L_8f1de6:
	bl L_8c02bc
L_8f1dea:
	mov_s r16,r2
L_8f1dec:
	mov_s r15,r3
L_8f1dee:
	mov_s r13,r4
L_8f1df0:
	brlt.d r1,0x2,L_8f1e72
L_8f1df4:
	mov_s r14,0x0
	.global L_8f1df6
L_8f1df6:
	mov_s r2,r16
L_8f1df8:
	bl.d L_8f1d84
L_8f1dfc:
	mov_s r3,r13
L_8f1dfe:
	mov.f r14,r0
L_8f1e02:
	beq_s L_8f1e6e
L_8f1e04:
	ldb_s r3,[r14,0x1]
L_8f1e06:
	brne_s r15,0,L_8f1e20
L_8f1e08:
	ldb_s r0,[r14,0x2]
L_8f1e0a:
	brne_s r0,0,L_8f1e20
L_8f1e0c:
	ldb_s r0,[r14,0x3]
L_8f1e0e:
	cmp_s r0,0x50
L_8f1e10:
	bne_s L_8f1e20
L_8f1e12:
	ldb_s r0,[r14,0x4]
L_8f1e14:
	cmp r0,0xf2
L_8f1e18:
	bne_s L_8f1e20
L_8f1e1a:
	ldb_s r0,[r14,0x5]
L_8f1e1c:
	breq r0,0x4,L_8f1e4c
	.global L_8f1e20
L_8f1e20:
	ldb_s r0,[r14,0x1]
L_8f1e22:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8f1e24:
	brne r15,0x1,L_8f1e42
L_8f1e28:
	ldb_s r1,[r14,0x2]
L_8f1e2a:
	cmp_s r1,0x50
L_8f1e2c:
	bne_s L_8f1e42
L_8f1e2e:
	ldb_s r1,[r14,0x3]
L_8f1e30:
	cmp_s r1,0x6f
L_8f1e32:
	bne_s L_8f1e42
L_8f1e34:
	ldb_s r1,[r14,0x4]
L_8f1e36:
	cmp r1,0x9a
L_8f1e3a:
	bne_s L_8f1e42
L_8f1e3c:
	ldb_s r1,[r14,0x5]
L_8f1e3e:
	breq r1,0x9,L_8f1e62
	.global L_8f1e42
L_8f1e42:
	ldb_s r1,[r13]
L_8f1e44:
	sub_s r1,r1,r0
L_8f1e46:
	extb_s r1,r1
L_8f1e48:
	add_s r0,r0,r14
L_8f1e4a:
	b_s L_8f1df6
	.global L_8f1e4c
L_8f1e4c:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_8f1e4e:
	extb_s r3,r3
L_8f1e50:
	stb_s r3,[r13]
L_8f1e52:
	mov_s r2,0x100bdcc
	.global L_8f1e58
L_8f1e58:
	mov_s r0,0xd
L_8f1e5a:
	bl.d L_8edfcc
L_8f1e5e:
	mov_s r1,0x2
L_8f1e60:
	b_s L_8f1e72
	.global L_8f1e62
L_8f1e62:
	extb_s r3,r0
L_8f1e64:
	mov_s r2,0x100bde4
L_8f1e6a:
	stb_s r0,[r13]
L_8f1e6c:
	b_s L_8f1e58
	.global L_8f1e6e
L_8f1e6e:
	mov_s r14,0x0
L_8f1e70:
	stb_s r14,[r13]
	.global L_8f1e72
L_8f1e72:
	b.d L_8c0324
L_8f1e76:
	mov_s r0,r14
