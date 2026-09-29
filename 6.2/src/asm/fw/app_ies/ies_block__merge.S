/* ies_block__merge @ 0x8ddfd0, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Exclude the P2P IE from frame type %d, length %d, Data[0]=0x%x.
 * Зовут его: mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp, mgmt_tx__build_assoc_resp_8f9e88, mgmt_tx__build_probe_req, mgmt_tx__build_probe_resp
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, app_ie__walk_list, fw_log_emit3, fw_sysassert_fatal, ie_iter__init, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ies_block__merge
ies_block__merge:
	.global L_8ddfd0
L_8ddfd0:
	push_s blink
L_8ddfd2:
	bl L_8c01c8
L_8ddfd6:
	sub_s sp,sp,0x18
L_8ddfd8:
	mov_s r17,r0
L_8ddfda:
	mov_s r16,r2
L_8ddfdc:
	mov_s r0,sp
L_8ddfde:
	bl.d L_8e5de8
L_8ddfe2:
	mov_s r19,r0
L_8ddfe4:
	add_s r0,sp,0xc
L_8ddfe6:
	mov_s r18,r0
L_8ddfe8:
	bl.d L_8e5de8
L_8ddfec:
	mov_s r1,r16
L_8ddfee:
	mov r20,0x0
L_8ddff2:
	bl.d L_8df404
L_8ddff6:
	mov_s r0,r19
L_8ddff8:
	mov_s r15,r0
L_8ddffa:
	bl.d L_8df404
L_8ddffe:
	mov_s r0,r18
L_8de000:
	mov_s r13,r0
	.global L_8de002
L_8de002:
	mov.f r14,r15
L_8de006:
	mov_s r0,0x0
L_8de008:
	cmp.ne r13,0x0
L_8de00c:
	beq_s L_8de070
L_8de00e:
	ldb_s r1,[r14]
L_8de010:
	ldb_s r2,[r13]
L_8de012:
	brlt r1,r2,L_8de044
L_8de016:
	brne r1,r2,L_8de076
L_8de01a:
	cmp r1,0xdd
L_8de01e:
	bne_s L_8de060
L_8de020:
	add_s r3,r14,0x2
L_8de022:
	add_s r2,r13,0x2
L_8de024:
	ldb_s r15,[r3]
L_8de026:
	ldb_s r1,[r2]
L_8de028:
	brne r15,r1,L_8de03e
L_8de02c:
	ldb_s r15,[r3,0x1]
L_8de02e:
	ldb_s r1,[r2,0x1]
L_8de030:
	brne r15,r1,L_8de03e
L_8de034:
	ldb_s r3,[r3,0x2]
L_8de036:
	ldb_s r1,[r2,0x2]
L_8de038:
	cmp_s r3,r1
L_8de03a:
	mov.eq r0,0x1
	.global L_8de03e
L_8de03e:
	extb_s r0,r0
L_8de040:
	breq r0,0x1,L_8de04e
	.global L_8de044
L_8de044:
	bl.d L_8df404
L_8de048:
	mov_s r0,r19
L_8de04a:
	mov_s r15,r0
L_8de04c:
	b_s L_8de082
	.global L_8de04e
L_8de04e:
	mov_s r0,blink
L_8de050:
	mov_s r1,0x11b9
L_8de056:
	bl.d L_8c9b28
L_8de05a:
	mov r20,0x0
L_8de05e:
	b_s L_8de0f4
	.global L_8de060
L_8de060:
	bl.d L_8df404
L_8de064:
	mov_s r0,r19
L_8de066:
	mov_s r15,r0
L_8de068:
	bl.d L_8df404
L_8de06c:
	mov_s r0,r18
L_8de06e:
	b_s L_8de080
	.global L_8de070
L_8de070:
	brne_s r14,0,L_8de044
L_8de072:
	breq r13,0x0,L_8de0f4
	.global L_8de076
L_8de076:
	bl.d L_8df404
L_8de07a:
	mov_s r0,r18
L_8de07c:
	mov_s r15,r14
L_8de07e:
	mov_s r14,r13
	.global L_8de080
L_8de080:
	mov_s r13,r0
	.global L_8de082
L_8de082:
	breq_s r14,0,L_8de0be
	.global L_8de084
L_8de084:
	add_s r0,r14,0x2
L_8de086:
	ldb r4,[r0]
L_8de08a:
	cmp r4,0x50
L_8de08e:
	ldb_s r3,[r14,0x1]
L_8de090:
	bne_s L_8de0cc
L_8de092:
	ldb_s r1,[r0,0x1]
L_8de094:
	cmp_s r1,0x6f
L_8de096:
	bne_s L_8de0cc
L_8de098:
	ldb_s r1,[r0,0x2]
L_8de09a:
	cmp r1,0x9a
L_8de09e:
	bne_s L_8de0cc
L_8de0a0:
	ldb_s r0,[r0,0x3]
L_8de0a2:
	brne r0,0x9,L_8de0cc
L_8de0a6:
	ld r0,[r16, 0x8]
L_8de0aa:
	brne r0,0x1,L_8de0cc
L_8de0ae:
	mov_s r1,0x1010e9c
L_8de0b4:
	mov_s r0,0x2d
L_8de0b6:
	bl.d L_8dcd00
L_8de0ba:
	ldb_s r2,[r14]
L_8de0bc:
	b_s L_8de002
	.global L_8de0be
L_8de0be:
	mov_s r0,blink
L_8de0c0:
	mov_s r1,0x11ba
L_8de0c6:
	bl L_8c9b28
L_8de0ca:
	b_s L_8de084
	.global L_8de0cc
L_8de0cc:
	add r21,r3,0x2
L_8de0d0:
	extw r21,r21
L_8de0d4:
	ld r0,[r17]
L_8de0d8:
	mov_s r1,r14
L_8de0da:
	bl.d L_8c0380
L_8de0de:
	mov_s r2,r21
L_8de0e0:
	ld r1,[r17]
L_8de0e4:
	add r20,r20,r21
L_8de0e8:
	add_s r1,r1,r21
L_8de0ea:
	st r1,[r17]
L_8de0ee:
	extw r20,r20
L_8de0f2:
	b_s L_8de002
	.global L_8de0f4
L_8de0f4:
	mov_s r0,r20
L_8de0f6:
	b.d L_8c021c
L_8de0fa:
	add_s sp,sp,0x18
