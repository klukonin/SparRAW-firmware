/* mac_parser_step_a @ 0x8dbe14, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_parser__write_rule, memcpy_fw
 */
	.section .text.mac_parser_step_a,"ax",@progbits
	.global mac_parser_step_a
mac_parser_step_a:
	.global L_8dbe14
L_8dbe14:
	push_s blink
L_8dbe16:
	bl.d L_8c02bc
L_8dbe1a:
	mov_s r2,0x10
L_8dbe1c:
	sub_s sp,sp,0x18
L_8dbe1e:
	mov_s r16,r0
L_8dbe20:
	mov_s r1,0x803104
L_8dbe26:
	bl.d L_8c0460
L_8dbe2a:
	add_s r0,sp,0x8
L_8dbe2c:
	mov_s r14,0x0
L_8dbe2e:
	mov_s r13,sp
L_8dbe30:
	b_s L_8dbe56
	.global L_8dbe32
L_8dbe32:
	mov_s r2,0x1
	.global L_8dbe34
L_8dbe34:
	asl r0,r16,0x12
L_8dbe38:
	or r0,r0,0x3ef7f
L_8dbe40:
	or_s r0,r0,r2
L_8dbe42:
	or r0,r0,0x5c00000
L_8dbe4a:
	st_s r0,[r13,0x4]
L_8dbe4c:
	mov_s r0,r13
L_8dbe4e:
	bl.d L_8dbb00
L_8dbe52:
	mov_s r2,0x3
L_8dbe54:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dbe56
L_8dbe56:
	brge r14,0x4,L_8dbeba
L_8dbe5a:
	bmsk r3,r14,0x0
L_8dbe5e:
	and r1,r14,0x2
L_8dbe62:
	asr.f r2,r1
L_8dbe66:
	asl_s r0,r3,0x6
L_8dbe68:
	or r15,r0,0x22
L_8dbe6c:
	asl_s r0,r2,0x7
L_8dbe6e:
	or_s r15,r15,r0
L_8dbe70:
	add2 r0,sp,r14
L_8dbe74:
	ld_s r0,[r0,0x8]
L_8dbe76:
	add_s r3,r3,0x3c
L_8dbe78:
	or_s r15,r15,r0
L_8dbe7a:
	stw r15,[sp]
L_8dbe7e:
	add_s r1,r1,r3
L_8dbe80:
	btst.ne r14,0x0
L_8dbe84:
	mov_s r0,0x8
L_8dbe86:
	bne_s L_8dbe8a
L_8dbe88:
	mov_s r0,0x0
	.global L_8dbe8a
L_8dbe8a:
	or r0,r0,0x17
L_8dbe8e:
	cmp_s r2,0x0
L_8dbe90:
	btst.ne r14,0x0
L_8dbe94:
	mov_s r3,0x20
L_8dbe96:
	bne_s L_8dbe9a
L_8dbe98:
	mov_s r3,0x1a
	.global L_8dbe9a
L_8dbe9a:
	asl_s r3,r3,0x9
L_8dbe9c:
	or_s r0,r0,r3
L_8dbe9e:
	cmp_s r1,0x2c
L_8dbea0:
	mov_s r3,0x1
L_8dbea2:
	sub.eq r3,r3,r3
L_8dbea6:
	asl_s r3,r3,0xe
L_8dbea8:
	or_s r0,r0,r3
L_8dbeaa:
	bset_s r0,r0,0xf
L_8dbeac:
	stw_s r0,[r13,0x2]
L_8dbeae:
	btst_s r14,0x0
L_8dbeb0:
	cmp.eq r2,0x0
L_8dbeb4:
	beq_s L_8dbe32
L_8dbeb6:
	mov_s r2,0x0
L_8dbeb8:
	b_s L_8dbe34
	.global L_8dbeba
L_8dbeba:
	mov r0,0x432
L_8dbebe:
	stw r0,[sp]
L_8dbec2:
	stw 0xb417,[sp, 0x2]
L_8dbeca:
	asl r16,r16,0x12
L_8dbece:
	or r0,r16,0x5c3ef7f
L_8dbed6:
	st_s r0,[sp,0x4]
L_8dbed8:
	mov_s r0,r13
L_8dbeda:
	mov_s r1,0x2c
L_8dbedc:
	bl.d L_8dbb00
L_8dbee0:
	mov_s r2,0x3
L_8dbee2:
	b.d L_8c0324
L_8dbee6:
	add_s sp,sp,0x18
