/* mac_parser_step_b @ 0x8dfe14, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_parser__uses_rgf_886280
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser_step_b
mac_parser_step_b:
	.global L_8dfe14
L_8dfe14:
	push_s blink
L_8dfe16:
	bl L_8c01dc
L_8dfe1a:
	sub_s sp,sp,0x8
L_8dfe1c:
	mov_s r16,r0
L_8dfe1e:
	mov_s r13,0x2
L_8dfe20:
	b_s L_8dfe74
	.global L_8dfe22
L_8dfe22:
	mov_s r14,0x0
L_8dfe24:
	bset_s r14,r14,0xf
	.global L_8dfe26
L_8dfe26:
	or_s r2,r2,r14
L_8dfe28:
	stw_s r2,[r0,0x2]
L_8dfe2a:
	cmp_s r1,0x1c
L_8dfe2c:
	mov_s r2,0x1
L_8dfe2e:
	sub.eq r2,r2,r2
L_8dfe32:
	asl_s r2,r2,0x10
L_8dfe34:
	or r14,r2,0x8f7f
L_8dfe3c:
	cmp_s r1,0x17
L_8dfe3e:
	mov_s r2,0x1
L_8dfe40:
	sub_s.ne r2,r2,r2
L_8dfe42:
	asl r15,r2,0x11
L_8dfe46:
	or_s r14,r14,r15
L_8dfe48:
	asl r15,r16,0x12
L_8dfe4c:
	or_s r14,r14,r15
L_8dfe4e:
	asl_s r3,r3,0x16
L_8dfe50:
	or_s r3,r3,r14
L_8dfe52:
	asl_s r2,r2,0x1e
L_8dfe54:
	or_s r2,r2,r3
L_8dfe56:
	st_s r2,[r0,0x4]
L_8dfe58:
	cmp_s r13,0x8
L_8dfe5a:
	mov_s r2,0x1
L_8dfe5c:
	sub.cs r2,r2,r2
L_8dfe60:
	ldw r3,[sp, 0x2]
L_8dfe64:
	asl_s r2,r2,0x8
L_8dfe66:
	or_s r2,r2,r3
L_8dfe68:
	stw r2,[sp, 0x2]
L_8dfe6c:
	bl.d L_8dfbd8
L_8dfe70:
	mov_s r2,0x3
L_8dfe72:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dfe74
L_8dfe74:
	brhs r13,0xb,L_8dfede
L_8dfe78:
	mov_s r0,sp
L_8dfe7a:
	asl_s r1,r13,0x6
L_8dfe7c:
	or r1,r1,0x419
L_8dfe80:
	stw r1,[sp]
L_8dfe84:
	add r1,r13,0x2e
L_8dfe88:
	cmp_s r1,0x35
L_8dfe8a:
	mov.eq r1,0x10
L_8dfe8e:
	cmp_s r1,0x1c
L_8dfe90:
	cmp.ne r1,0x36
L_8dfe94:
	cmp.ne r1,0x34
L_8dfe98:
	cmp.ne r1,0x37
L_8dfe9c:
	bne_s L_8dfea2
L_8dfe9e:
	mov_s r3,0x1
L_8dfea0:
	b_s L_8dfea4
	.global L_8dfea2
L_8dfea2:
	mov_s r3,0x3
	.global L_8dfea4
L_8dfea4:
	cmp_s r1,0x1c
L_8dfea6:
	mov_s r14,0x1
L_8dfea8:
	sub.eq r14,r14,r14
L_8dfeac:
	cmp_s r1,0x17
L_8dfeae:
	cmp.ne r1,0x18
L_8dfeb2:
	mov_s r2,0x20
L_8dfeb4:
	sub_s.ne r2,r2,r2
L_8dfeb6:
	or_s r14,r14,r2
L_8dfeb8:
	cmp_s r1,0x18
L_8dfeba:
	mov_s r2,0x1
L_8dfebc:
	sub_s.ne r2,r2,r2
L_8dfebe:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_8dfec0:
	or_s r2,r2,r14
L_8dfec2:
	cmp_s r1,0x1c
L_8dfec4:
	mov_s r14,0xa
L_8dfec6:
	mov.ne r14,0x10
L_8dfeca:
	asl_s r14,r14,0x9
L_8dfecc:
	or_s r2,r2,r14
L_8dfece:
	cmp_s r1,0x1c
L_8dfed0:
	cmp.ne r1,0x18
L_8dfed4:
	cmp.ne r1,0x17
L_8dfed8:
	beq_s L_8dfe22
L_8dfeda:
	mov_s r14,0x0
L_8dfedc:
	b_s L_8dfe26
	.global L_8dfede
L_8dfede:
	b.d L_8c0244
L_8dfee2:
	add_s sp,sp,0x8
