/* mac_parser_step_a @ 0x8dfee4, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_parser__uses_rgf_886280, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser_step_a
mac_parser_step_a:
	.global L_8dfee4
L_8dfee4:
	push_s blink
L_8dfee6:
	bl.d L_8c01dc
L_8dfeea:
	mov_s r2,0x10
L_8dfeec:
	sub_s sp,sp,0x18
L_8dfeee:
	mov_s r16,r0
L_8dfef0:
	mov_s r1,0x803970
L_8dfef6:
	bl.d L_8c0380
L_8dfefa:
	add_s r0,sp,0x8
L_8dfefc:
	mov_s r14,0x0
L_8dfefe:
	mov_s r13,sp
L_8dff00:
	b_s L_8dff26
	.global L_8dff02
L_8dff02:
	mov_s r2,0x1
	.global L_8dff04
L_8dff04:
	asl r0,r16,0x12
L_8dff08:
	or r0,r0,0x3ef7f
L_8dff10:
	or_s r0,r0,r2
L_8dff12:
	or r0,r0,0x5c00000
L_8dff1a:
	st_s r0,[r13,0x4]
L_8dff1c:
	mov_s r0,r13
L_8dff1e:
	bl.d L_8dfbd8
L_8dff22:
	mov_s r2,0x3
L_8dff24:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dff26
L_8dff26:
	brge r14,0x4,L_8dff8a
L_8dff2a:
	bmsk r3,r14,0x0
L_8dff2e:
	and r1,r14,0x2
L_8dff32:
	asr.f r2,r1
L_8dff36:
	asl_s r0,r3,0x6
L_8dff38:
	or r15,r0,0x22
L_8dff3c:
	asl_s r0,r2,0x7
L_8dff3e:
	or_s r15,r15,r0
L_8dff40:
	add2 r0,sp,r14
L_8dff44:
	ld_s r0,[r0,0x8]
L_8dff46:
	add_s r3,r3,0x3c
L_8dff48:
	or_s r15,r15,r0
L_8dff4a:
	stw r15,[sp]
L_8dff4e:
	add_s r1,r1,r3
L_8dff50:
	btst.ne r14,0x0
L_8dff54:
	mov_s r0,0x8
L_8dff56:
	bne_s L_8dff5a
L_8dff58:
	mov_s r0,0x0
	.global L_8dff5a
L_8dff5a:
	or r0,r0,0x17
L_8dff5e:
	cmp_s r2,0x0
L_8dff60:
	btst.ne r14,0x0
L_8dff64:
	mov_s r3,0x20
L_8dff66:
	bne_s L_8dff6a
L_8dff68:
	mov_s r3,0x1a
	.global L_8dff6a
L_8dff6a:
	asl_s r3,r3,0x9
L_8dff6c:
	or_s r0,r0,r3
L_8dff6e:
	cmp_s r1,0x2c
L_8dff70:
	mov_s r3,0x1
L_8dff72:
	sub.eq r3,r3,r3
L_8dff76:
	asl_s r3,r3,0xe
L_8dff78:
	or_s r0,r0,r3
L_8dff7a:
	bset_s r0,r0,0xf
L_8dff7c:
	stw_s r0,[r13,0x2]
L_8dff7e:
	btst_s r14,0x0
L_8dff80:
	cmp.eq r2,0x0
L_8dff84:
	beq_s L_8dff02
L_8dff86:
	mov_s r2,0x0
L_8dff88:
	b_s L_8dff04
	.global L_8dff8a
L_8dff8a:
	mov r0,0x432
L_8dff8e:
	stw r0,[sp]
L_8dff92:
	stw 0xb417,[sp, 0x2]
L_8dff9a:
	asl r16,r16,0x12
L_8dff9e:
	or r0,r16,0x5c3ef7f
L_8dffa6:
	st_s r0,[sp,0x4]
L_8dffa8:
	mov_s r0,r13
L_8dffaa:
	mov_s r1,0x2c
L_8dffac:
	bl.d L_8dfbd8
L_8dffb0:
	mov_s r2,0x3
L_8dffb2:
	b.d L_8c0244
L_8dffb6:
	add_s sp,sp,0x18
