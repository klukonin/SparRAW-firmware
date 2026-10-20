/* tx_mgmt_get_ie @ 0x8e9db0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_mgmt_get_ie: id %d, len %d.
 * Зовут его: ie__classify_vendor_oui, mgmt_tx__probe_resp_ies_8d8378
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_mgmt_get_ie
tx_mgmt_get_ie:
	.global L_8e9db0
L_8e9db0:
	push_s blink
L_8e9db2:
	bl L_8c01dc
L_8e9db6:
	mov_s r14,r0
L_8e9db8:
	mov_s r13,r1
L_8e9dba:
	mov_s r16,r2
L_8e9dbc:
	brge.d r1,0x2,L_8e9dc6
L_8e9dc0:
	mov_s r15,r3
	.global L_8e9dc2
L_8e9dc2:
	mov_s r14,0x0
L_8e9dc4:
	b_s L_8e9dfc
	.global L_8e9dc6
L_8e9dc6:
	mov_s r1,0x100fc64
L_8e9dcc:
	mov_s r0,0x2d
L_8e9dce:
	bl.d L_8dcc80
L_8e9dd2:
	mov_s r3,r13
L_8e9dd4:
	mov_s r1,0x0
L_8e9dd6:
	stb_s r1,[r15]
L_8e9dd8:
	b_s L_8e9de6
	.global L_8e9dda
L_8e9dda:
	stb_s r13,[r15]
L_8e9ddc:
	ldb_s r0,[r14,0x1]
L_8e9dde:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e9de0:
	sub_s r13,r13,r0
L_8e9de2:
	extb_s r13,r13
L_8e9de4:
	add_s r14,r14,r0
	.global L_8e9de6
L_8e9de6:
	ldb_s r0,[r14]
L_8e9de8:
	breq r0,r16,L_8e9df0
L_8e9dec:
	brge r13,0x3,L_8e9dda
	.global L_8e9df0
L_8e9df0:
	ldb_s r0,[r14,0x1]
L_8e9df2:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8e9df4:
	brge r13,r0,L_8e9dfc
L_8e9df8:
	stb_s r1,[r15]
L_8e9dfa:
	b_s L_8e9dc2
	.global L_8e9dfc
L_8e9dfc:
	b.d L_8c0244
L_8e9e00:
	mov_s r0,r14
L_8e9e02:
	nop_s
