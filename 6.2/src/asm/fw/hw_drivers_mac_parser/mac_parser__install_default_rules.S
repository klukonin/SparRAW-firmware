/* mac_parser__install_default_rules @ 0x8dfc58, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_parser__uses_rgf_886280
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__install_default_rules
mac_parser__install_default_rules:
	.global L_8dfc58
L_8dfc58:
	push_s blink
L_8dfc5a:
	bl L_8c01dc
L_8dfc5e:
	sub_s sp,sp,0x8
L_8dfc60:
	mov_s r16,r0
L_8dfc62:
	mov_s r13,0x8
L_8dfc64:
	b_s L_8dfca4
	.global L_8dfc66
L_8dfc66:
	mov_s r14,0x0
L_8dfc68:
	bset_s r14,r14,0xf
	.global L_8dfc6a
L_8dfc6a:
	or_s r3,r3,r14
L_8dfc6c:
	stw_s r3,[r0,0x2]
L_8dfc6e:
	cmp_s r1,0x1c
L_8dfc70:
	mov_s r3,0x1
L_8dfc72:
	sub.eq r3,r3,r3
L_8dfc76:
	asl_s r3,r3,0x10
L_8dfc78:
	or r14,r3,0x8f7f
L_8dfc80:
	cmp_s r1,0x17
L_8dfc82:
	mov_s r3,0x1
L_8dfc84:
	sub_s.ne r3,r3,r3
L_8dfc86:
	asl r15,r3,0x11
L_8dfc8a:
	or_s r14,r14,r15
L_8dfc8c:
	asl r15,r16,0x12
L_8dfc90:
	or_s r14,r14,r15
L_8dfc92:
	asl_s r2,r2,0x16
L_8dfc94:
	or_s r2,r2,r14
L_8dfc96:
	asl_s r3,r3,0x1e
L_8dfc98:
	or_s r2,r2,r3
L_8dfc9a:
	st_s r2,[r0,0x4]
L_8dfc9c:
	bl.d L_8dfbd8
L_8dfca0:
	mov_s r2,0x3
L_8dfca2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dfca4
L_8dfca4:
	brhs r13,0xf,L_8dfd0e
L_8dfca8:
	mov_s r0,sp
L_8dfcaa:
	asl_s r1,r13,0x2
L_8dfcac:
	or r1,r1,0x401
L_8dfcb0:
	stw r1,[sp]
L_8dfcb4:
	add r1,r13,0xf
L_8dfcb8:
	cmp_s r1,0x1d
L_8dfcba:
	mov.eq r1,0x35
L_8dfcbe:
	cmp_s r1,0x1c
L_8dfcc0:
	cmp.ne r1,0x36
L_8dfcc4:
	cmp.ne r1,0x34
L_8dfcc8:
	cmp.ne r1,0x37
L_8dfccc:
	bne_s L_8dfcd2
L_8dfcce:
	mov_s r2,0x1
L_8dfcd0:
	b_s L_8dfcd4
	.global L_8dfcd2
L_8dfcd2:
	mov_s r2,0x3
	.global L_8dfcd4
L_8dfcd4:
	cmp_s r1,0x1c
L_8dfcd6:
	mov_s r14,0x1
L_8dfcd8:
	sub.eq r14,r14,r14
L_8dfcdc:
	cmp_s r1,0x17
L_8dfcde:
	cmp.ne r1,0x18
L_8dfce2:
	mov_s r3,0x20
L_8dfce4:
	sub_s.ne r3,r3,r3
L_8dfce6:
	or_s r14,r14,r3
L_8dfce8:
	cmp_s r1,0x18
L_8dfcea:
	mov_s r3,0x1
L_8dfcec:
	sub_s.ne r3,r3,r3
L_8dfcee:
	/* asl_s r3,r3,0x6 */
	.byte 0x06,0xbb
L_8dfcf0:
	or_s r3,r3,r14
L_8dfcf2:
	cmp_s r1,0x1c
L_8dfcf4:
	mov_s r14,0xa
L_8dfcf6:
	mov.ne r14,0x10
L_8dfcfa:
	asl_s r14,r14,0x9
L_8dfcfc:
	or_s r3,r3,r14
L_8dfcfe:
	cmp_s r1,0x1c
L_8dfd00:
	cmp.ne r1,0x18
L_8dfd04:
	cmp.ne r1,0x17
L_8dfd08:
	beq_s L_8dfc66
L_8dfd0a:
	mov_s r14,0x0
L_8dfd0c:
	b_s L_8dfc6a
	.global L_8dfd0e
L_8dfd0e:
	b.d L_8c0244
L_8dfd12:
	add_s sp,sp,0x8
