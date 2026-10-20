/* ies_block__merge @ 0x8da098, 344 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   app_ies.cpp
 *   Exclude the P2P IE from frame type %d, length %d, Data[0]=0x%x.
 *   ies_block::merge() type-%d, length-%d.
 * Зовут его: mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, ie_iter__init, ie_iter__next, memcpy_fw
 */
	.section .text.ies_block__merge,"ax",@progbits
	.global ies_block__merge
ies_block__merge:
	.global L_8da098
L_8da098:
	push_s blink
L_8da09a:
	bl L_8c02a8
L_8da09e:
	sub_s sp,sp,0x18
L_8da0a0:
	mov_s r19,r0
L_8da0a2:
	mov_s r17,r2
L_8da0a4:
	mov_s r0,sp
L_8da0a6:
	bl.d L_8e112c
L_8da0aa:
	mov_s r16,r0
L_8da0ac:
	add_s r0,sp,0xc
L_8da0ae:
	mov_s r18,r0
L_8da0b0:
	bl.d L_8e112c
L_8da0b4:
	mov_s r1,r17
L_8da0b6:
	mov r20,0x0
L_8da0ba:
	bl.d L_8db160
L_8da0be:
	mov_s r0,r16
L_8da0c0:
	mov_s r15,r0
L_8da0c2:
	bl.d L_8db160
L_8da0c6:
	mov_s r0,r18
L_8da0c8:
	mov_s r13,r0
	.global L_8da0ca
L_8da0ca:
	mov.f r14,r15
L_8da0ce:
	mov_s r0,0x0
L_8da0d0:
	cmp.ne r13,0x0
L_8da0d4:
	beq_s L_8da140
L_8da0d6:
	ldb_s r1,[r14]
L_8da0d8:
	ldb_s r2,[r13]
L_8da0da:
	brlt r1,r2,L_8da10c
L_8da0de:
	brne r1,r2,L_8da146
L_8da0e2:
	cmp r1,0xdd
L_8da0e6:
	bne_s L_8da130
L_8da0e8:
	add_s r3,r14,0x2
L_8da0ea:
	add_s r2,r13,0x2
L_8da0ec:
	ldb_s r15,[r3]
L_8da0ee:
	ldb_s r1,[r2]
L_8da0f0:
	brne r15,r1,L_8da106
L_8da0f4:
	ldb_s r15,[r3,0x1]
L_8da0f6:
	ldb_s r1,[r2,0x1]
L_8da0f8:
	brne r15,r1,L_8da106
L_8da0fc:
	ldb_s r3,[r3,0x2]
L_8da0fe:
	ldb_s r1,[r2,0x2]
L_8da100:
	cmp_s r3,r1
L_8da102:
	mov.eq r0,0x1
	.global L_8da106
L_8da106:
	extb_s r0,r0
L_8da108:
	breq r0,0x1,L_8da116
	.global L_8da10c
L_8da10c:
	bl.d L_8db160
L_8da110:
	mov_s r0,r16
L_8da112:
	mov_s r15,r0
L_8da114:
	b_s L_8da152
	.global L_8da116
L_8da116:
	mov_s r0,blink
L_8da118:
	mov_s r2,0x100ee8c
L_8da11e:
	mov_s r1,0x11b9
L_8da124:
	bl.d L_8c82c0
L_8da128:
	mov_s r3,0xf7
L_8da12a:
	mov r20,0x0
L_8da12e:
	b_s L_8da1e6
	.global L_8da130
L_8da130:
	bl.d L_8db160
L_8da134:
	mov_s r0,r16
L_8da136:
	mov_s r15,r0
L_8da138:
	bl.d L_8db160
L_8da13c:
	mov_s r0,r18
L_8da13e:
	b_s L_8da150
	.global L_8da140
L_8da140:
	brne_s r14,0,L_8da10c
L_8da142:
	breq r13,0x0,L_8da1e6
	.global L_8da146
L_8da146:
	bl.d L_8db160
L_8da14a:
	mov_s r0,r18
L_8da14c:
	mov_s r15,r14
L_8da14e:
	mov_s r14,r13
	.global L_8da150
L_8da150:
	mov_s r13,r0
	.global L_8da152
L_8da152:
	breq_s r14,0,L_8da192
	.global L_8da154
L_8da154:
	add_s r0,r14,0x2
L_8da156:
	ldb r5,[r0]
L_8da15a:
	cmp r5,0x50
L_8da15e:
	ldb r4,[r14, 0x1]
L_8da162:
	bne_s L_8da1aa
L_8da164:
	ldb_s r1,[r0,0x1]
L_8da166:
	cmp_s r1,0x6f
L_8da168:
	bne_s L_8da1aa
L_8da16a:
	ldb_s r1,[r0,0x2]
L_8da16c:
	cmp r1,0x9a
L_8da170:
	bne_s L_8da1aa
L_8da172:
	ldb_s r0,[r0,0x3]
L_8da174:
	brne r0,0x9,L_8da1aa
L_8da178:
	ld r0,[r17, 0x8]
L_8da17c:
	brne r0,0x1,L_8da1aa
L_8da180:
	mov_s r2,0x100eed4
L_8da186:
	mov_s r0,0xd
L_8da188:
	mov_s r1,0x2
L_8da18a:
	bl.d L_8ee034
L_8da18e:
	ldb_s r3,[r14]
L_8da190:
	b_s L_8da0ca
	.global L_8da192
L_8da192:
	mov_s r0,blink
L_8da194:
	mov_s r2,0x100ee8c
L_8da19a:
	mov_s r1,0x11ba
L_8da1a0:
	bl.d L_8c82c0
L_8da1a4:
	mov r3,0x125
L_8da1a8:
	b_s L_8da154
	.global L_8da1aa
L_8da1aa:
	add r21,r4,0x2
L_8da1ae:
	extw r21,r21
L_8da1b2:
	ld r0,[r19]
L_8da1b6:
	mov_s r1,r14
L_8da1b8:
	bl.d L_8c0460
L_8da1bc:
	mov_s r2,r21
L_8da1be:
	mov_s r2,0x100ef14
L_8da1c4:
	ldb r4,[r14, 0x1]
L_8da1c8:
	mov_s r0,0xd
L_8da1ca:
	mov_s r1,0x2
L_8da1cc:
	bl.d L_8edff8
L_8da1d0:
	ldb_s r3,[r14]
L_8da1d2:
	ld r1,[r19]
L_8da1d6:
	add r20,r20,r21
L_8da1da:
	add_s r1,r1,r21
L_8da1dc:
	st r1,[r19]
L_8da1e0:
	extw r20,r20
L_8da1e4:
	b_s L_8da0ca
	.global L_8da1e6
L_8da1e6:
	mov_s r0,r20
L_8da1e8:
	b.d L_8c02fc
L_8da1ec:
	add_s sp,sp,0x18
L_8da1ee:
	nop_s
