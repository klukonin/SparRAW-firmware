/* mac_parser_step_b @ 0x8dbd44, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_parser__write_rule
 */
	.section .text.mac_parser_step_b,"ax",@progbits
	.global mac_parser_step_b
mac_parser_step_b:
	.global L_8dbd44
L_8dbd44:
	push_s blink
L_8dbd46:
	bl L_8c02bc
L_8dbd4a:
	sub_s sp,sp,0x8
L_8dbd4c:
	mov_s r16,r0
L_8dbd4e:
	mov_s r13,0x2
L_8dbd50:
	b_s L_8dbda4
	.global L_8dbd52
L_8dbd52:
	mov_s r14,0x0
L_8dbd54:
	bset_s r14,r14,0xf
	.global L_8dbd56
L_8dbd56:
	or_s r2,r2,r14
L_8dbd58:
	stw_s r2,[r0,0x2]
L_8dbd5a:
	cmp_s r1,0x1c
L_8dbd5c:
	mov_s r2,0x1
L_8dbd5e:
	sub.eq r2,r2,r2
L_8dbd62:
	asl_s r2,r2,0x10
L_8dbd64:
	or r14,r2,0x8f7f
L_8dbd6c:
	cmp_s r1,0x17
L_8dbd6e:
	mov_s r2,0x1
L_8dbd70:
	sub_s.ne r2,r2,r2
L_8dbd72:
	asl r15,r2,0x11
L_8dbd76:
	or_s r14,r14,r15
L_8dbd78:
	asl r15,r16,0x12
L_8dbd7c:
	or_s r14,r14,r15
L_8dbd7e:
	asl_s r3,r3,0x16
L_8dbd80:
	or_s r3,r3,r14
L_8dbd82:
	asl_s r2,r2,0x1e
L_8dbd84:
	or_s r2,r2,r3
L_8dbd86:
	st_s r2,[r0,0x4]
L_8dbd88:
	cmp_s r13,0x8
L_8dbd8a:
	mov_s r2,0x1
L_8dbd8c:
	sub.cs r2,r2,r2
L_8dbd90:
	ldw r3,[sp, 0x2]
L_8dbd94:
	asl_s r2,r2,0x8
L_8dbd96:
	or_s r2,r2,r3
L_8dbd98:
	stw r2,[sp, 0x2]
L_8dbd9c:
	bl.d L_8dbb00
L_8dbda0:
	mov_s r2,0x3
L_8dbda2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dbda4
L_8dbda4:
	brhs r13,0xb,L_8dbe0e
L_8dbda8:
	mov_s r0,sp
L_8dbdaa:
	asl_s r1,r13,0x6
L_8dbdac:
	or r1,r1,0x419
L_8dbdb0:
	stw r1,[sp]
L_8dbdb4:
	add r1,r13,0x2e
L_8dbdb8:
	cmp_s r1,0x35
L_8dbdba:
	mov.eq r1,0x10
L_8dbdbe:
	cmp_s r1,0x1c
L_8dbdc0:
	cmp.ne r1,0x36
L_8dbdc4:
	cmp.ne r1,0x34
L_8dbdc8:
	cmp.ne r1,0x37
L_8dbdcc:
	bne_s L_8dbdd2
L_8dbdce:
	mov_s r3,0x1
L_8dbdd0:
	b_s L_8dbdd4
	.global L_8dbdd2
L_8dbdd2:
	mov_s r3,0x3
	.global L_8dbdd4
L_8dbdd4:
	cmp_s r1,0x1c
L_8dbdd6:
	mov_s r14,0x1
L_8dbdd8:
	sub.eq r14,r14,r14
L_8dbddc:
	cmp_s r1,0x17
L_8dbdde:
	cmp.ne r1,0x18
L_8dbde2:
	mov_s r2,0x20
L_8dbde4:
	sub_s.ne r2,r2,r2
L_8dbde6:
	or_s r14,r14,r2
L_8dbde8:
	cmp_s r1,0x18
L_8dbdea:
	mov_s r2,0x1
L_8dbdec:
	sub_s.ne r2,r2,r2
L_8dbdee:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_8dbdf0:
	or_s r2,r2,r14
L_8dbdf2:
	cmp_s r1,0x1c
L_8dbdf4:
	mov_s r14,0xa
L_8dbdf6:
	mov.ne r14,0x10
L_8dbdfa:
	asl_s r14,r14,0x9
L_8dbdfc:
	or_s r2,r2,r14
L_8dbdfe:
	cmp_s r1,0x1c
L_8dbe00:
	cmp.ne r1,0x18
L_8dbe04:
	cmp.ne r1,0x17
L_8dbe08:
	beq_s L_8dbd52
L_8dbe0a:
	mov_s r14,0x0
L_8dbe0c:
	b_s L_8dbd56
	.global L_8dbe0e
L_8dbe0e:
	b.d L_8c0324
L_8dbe12:
	add_s sp,sp,0x8
