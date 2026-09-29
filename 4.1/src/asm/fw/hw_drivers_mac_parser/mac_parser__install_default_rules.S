/* mac_parser__install_default_rules @ 0x8dbb80, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_parser__write_rule
 */
	.section .text.mac_parser__install_default_rules,"ax",@progbits
	.global mac_parser__install_default_rules
mac_parser__install_default_rules:
	.global L_8dbb80
L_8dbb80:
	push_s blink
L_8dbb82:
	bl L_8c02bc
L_8dbb86:
	sub_s sp,sp,0x8
L_8dbb88:
	mov_s r16,r0
L_8dbb8a:
	mov_s r13,0x8
L_8dbb8c:
	b_s L_8dbbcc
	.global L_8dbb8e
L_8dbb8e:
	mov_s r14,0x0
L_8dbb90:
	bset_s r14,r14,0xf
	.global L_8dbb92
L_8dbb92:
	or_s r3,r3,r14
L_8dbb94:
	stw_s r3,[r0,0x2]
L_8dbb96:
	cmp_s r1,0x1c
L_8dbb98:
	mov_s r3,0x1
L_8dbb9a:
	sub.eq r3,r3,r3
L_8dbb9e:
	asl_s r3,r3,0x10
L_8dbba0:
	or r14,r3,0x8f7f
L_8dbba8:
	cmp_s r1,0x17
L_8dbbaa:
	mov_s r3,0x1
L_8dbbac:
	sub_s.ne r3,r3,r3
L_8dbbae:
	asl r15,r3,0x11
L_8dbbb2:
	or_s r14,r14,r15
L_8dbbb4:
	asl r15,r16,0x12
L_8dbbb8:
	or_s r14,r14,r15
L_8dbbba:
	asl_s r2,r2,0x16
L_8dbbbc:
	or_s r2,r2,r14
L_8dbbbe:
	asl_s r3,r3,0x1e
L_8dbbc0:
	or_s r2,r2,r3
L_8dbbc2:
	st_s r2,[r0,0x4]
L_8dbbc4:
	bl.d L_8dbb00
L_8dbbc8:
	mov_s r2,0x3
L_8dbbca:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dbbcc
L_8dbbcc:
	brhs r13,0xf,L_8dbc36
L_8dbbd0:
	mov_s r0,sp
L_8dbbd2:
	asl_s r1,r13,0x2
L_8dbbd4:
	or r1,r1,0x401
L_8dbbd8:
	stw r1,[sp]
L_8dbbdc:
	add r1,r13,0xf
L_8dbbe0:
	cmp_s r1,0x1d
L_8dbbe2:
	mov.eq r1,0x35
L_8dbbe6:
	cmp_s r1,0x1c
L_8dbbe8:
	cmp.ne r1,0x36
L_8dbbec:
	cmp.ne r1,0x34
L_8dbbf0:
	cmp.ne r1,0x37
L_8dbbf4:
	bne_s L_8dbbfa
L_8dbbf6:
	mov_s r2,0x1
L_8dbbf8:
	b_s L_8dbbfc
	.global L_8dbbfa
L_8dbbfa:
	mov_s r2,0x3
	.global L_8dbbfc
L_8dbbfc:
	cmp_s r1,0x1c
L_8dbbfe:
	mov_s r14,0x1
L_8dbc00:
	sub.eq r14,r14,r14
L_8dbc04:
	cmp_s r1,0x17
L_8dbc06:
	cmp.ne r1,0x18
L_8dbc0a:
	mov_s r3,0x20
L_8dbc0c:
	sub_s.ne r3,r3,r3
L_8dbc0e:
	or_s r14,r14,r3
L_8dbc10:
	cmp_s r1,0x18
L_8dbc12:
	mov_s r3,0x1
L_8dbc14:
	sub_s.ne r3,r3,r3
L_8dbc16:
	/* asl_s r3,r3,0x6 */
	.byte 0x06,0xbb
L_8dbc18:
	or_s r3,r3,r14
L_8dbc1a:
	cmp_s r1,0x1c
L_8dbc1c:
	mov_s r14,0xa
L_8dbc1e:
	mov.ne r14,0x10
L_8dbc22:
	asl_s r14,r14,0x9
L_8dbc24:
	or_s r3,r3,r14
L_8dbc26:
	cmp_s r1,0x1c
L_8dbc28:
	cmp.ne r1,0x18
L_8dbc2c:
	cmp.ne r1,0x17
L_8dbc30:
	beq_s L_8dbb8e
L_8dbc32:
	mov_s r14,0x0
L_8dbc34:
	b_s L_8dbb92
	.global L_8dbc36
L_8dbc36:
	b.d L_8c0324
L_8dbc3a:
	add_s sp,sp,0x8
