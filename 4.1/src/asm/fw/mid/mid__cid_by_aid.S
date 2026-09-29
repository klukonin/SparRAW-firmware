/* mid__cid_by_aid @ 0x8c9ebc, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Received Broadcast AID
 *   Received unknown AID: %d. During direct communication case
 *   Found CID for AID: %d. CID is: %d
 *   mid.cpp
 * Зовут его: ese_cfg__apply, parse_ese
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, iter__has_more, iter__init, iter__next
 */
	.section .text.mid__cid_by_aid,"ax",@progbits
	.global mid__cid_by_aid
mid__cid_by_aid:
	.global L_8c9ebc
L_8c9ebc:
	push_s blink
L_8c9ebe:
	bl L_8c02c0
L_8c9ec2:
	sub_s sp,sp,0x4
L_8c9ec4:
	mov_s r14,r0
L_8c9ec6:
	mov_s r13,r1
L_8c9ec8:
	mov_s r15,sp
L_8c9eca:
	add r1,r0,0x18
L_8c9ece:
	bl.d L_8e1138
L_8c9ed2:
	mov_s r0,r15
L_8c9ed4:
	cmp r13,0xff
L_8c9ed8:
	bne_s L_8c9efc
L_8c9eda:
	mov_s r2,0x100ba7c
L_8c9ee0:
	mov_s r0,0xb
L_8c9ee2:
	bl.d L_8edfb0
L_8c9ee6:
	mov_s r1,0x2
L_8c9ee8:
	ldb r0,[r14, 0x24]
L_8c9eec:
	b_s L_8c9f56
	.global L_8c9eee
L_8c9eee:
	bl.d L_8db188
L_8c9ef2:
	mov_s r0,r15
L_8c9ef4:
	mov_s r14,r0
L_8c9ef6:
	ldb_s r0,[r0,0x9]
L_8c9ef8:
	breq r13,r0,L_8c9f18
	.global L_8c9efc
L_8c9efc:
	bl.d L_8cb674
L_8c9f00:
	mov_s r0,r15
L_8c9f02:
	brne_s r0,0,L_8c9eee
L_8c9f04:
	mov_s r2,0x100ba94
L_8c9f0a:
	mov_s r0,0xb
L_8c9f0c:
	mov_s r1,0x2
L_8c9f0e:
	bl.d L_8edfcc
L_8c9f12:
	mov_s r3,r13
L_8c9f14:
	mov_s r0,0x0
L_8c9f16:
	b_s L_8c9f56
	.global L_8c9f18
L_8c9f18:
	ldb r4,[r14, 0x8]
L_8c9f1c:
	mov_s r2,0x100bad0
L_8c9f22:
	mov_s r0,0xb
L_8c9f24:
	mov_s r1,0x2
L_8c9f26:
	bl.d L_8edff8
L_8c9f2a:
	mov_s r3,r13
L_8c9f2c:
	ldb r0,[r14, 0xfc]
L_8c9f30:
	breq r0,0x7,L_8c9f4c
L_8c9f34:
	mov_s r0,blink
L_8c9f36:
	mov_s r2,0x100aedc
L_8c9f3c:
	mov_s r1,0x1225
L_8c9f42:
	mov_s r3,0x5
L_8c9f44:
	bl.d L_8c82c0
L_8c9f48:
	bset_s r3,r3,0xb
L_8c9f4a:
	b_s L_8c9efc
	.global L_8c9f4c
L_8c9f4c:
	ldb_s r1,[r14,0x8]
L_8c9f4e:
	mov_s r0,0x0
L_8c9f50:
	bset r0,r0,r1
L_8c9f54:
	extw_s r0,r0
	.global L_8c9f56
L_8c9f56:
	b.d L_8c032c
L_8c9f5a:
	add_s sp,sp,0x4
