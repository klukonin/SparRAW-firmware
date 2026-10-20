/* tx_mgmt_get_ie @ 0x8f1d84, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_mgmt_get_ie: id %d, len %d.
 * Зовут его: ie__classify_vendor_oui, mgmt_tx__probe_resp_ies
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2
 */
	.section .text.tx_mgmt_get_ie,"ax",@progbits
	.global tx_mgmt_get_ie
tx_mgmt_get_ie:
	.global L_8f1d84
L_8f1d84:
	push_s blink
L_8f1d86:
	bl L_8c02bc
L_8f1d8a:
	mov_s r14,r0
L_8f1d8c:
	mov_s r16,r1
L_8f1d8e:
	mov_s r15,r2
L_8f1d90:
	brge.d r1,0x2,L_8f1d9a
L_8f1d94:
	mov_s r13,r3
	.global L_8f1d96
L_8f1d96:
	mov_s r14,0x0
L_8f1d98:
	b_s L_8f1ddc
	.global L_8f1d9a
L_8f1d9a:
	mov_s r2,0x100bdac
L_8f1da0:
	mov_s r0,0xd
L_8f1da2:
	mov_s r1,0x2
L_8f1da4:
	mov_s r3,r15
L_8f1da6:
	bl.d L_8edff8
L_8f1daa:
	mov r4,r16
L_8f1dae:
	mov_s r1,0x0
L_8f1db0:
	stb_s r1,[r13]
L_8f1db2:
	b_s L_8f1dc6
	.global L_8f1db4
L_8f1db4:
	stb r16,[r13]
L_8f1db8:
	ldb_s r0,[r14,0x1]
L_8f1dba:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8f1dbc:
	sub r16,r16,r0
L_8f1dc0:
	extb r16,r16
L_8f1dc4:
	add_s r14,r14,r0
	.global L_8f1dc6
L_8f1dc6:
	ldb_s r0,[r14]
L_8f1dc8:
	breq r15,r0,L_8f1dd0
L_8f1dcc:
	brge r16,0x3,L_8f1db4
	.global L_8f1dd0
L_8f1dd0:
	ldb_s r0,[r14,0x1]
L_8f1dd2:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8f1dd4:
	brge r16,r0,L_8f1ddc
L_8f1dd8:
	stb_s r1,[r13]
L_8f1dda:
	b_s L_8f1d96
	.global L_8f1ddc
L_8f1ddc:
	b.d L_8c0324
L_8f1de0:
	mov_s r0,r14
L_8f1de2:
	nop_s
