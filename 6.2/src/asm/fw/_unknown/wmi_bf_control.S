/* wmi_bf_control @ 0x8ec068, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BF control: BRP en/dis=%d, TXSS en/dis=%d, long_term is_TH_update=%d
 *   Updating triggers enable dword: 0x%x
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit1, fw_log_emit3, lmac_cmd_pool__alloc, lmac_if__post_cmd, mem_pool__alloc_locked, memcpy_fw, memset0_words, wmi_evt__post
 * Глобалы (через gp): 0x8003cc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_bf_control
wmi_bf_control:
	.global L_8ec068
L_8ec068:
	push_s blink
L_8ec06a:
	bl L_8c01d4
L_8ec06e:
	sub_s sp,sp,0x4
L_8ec070:
	mov_s r13,r0
L_8ec072:
	add r16,r0,0x1e
L_8ec076:
	mov_s r18,r1
L_8ec078:
	bl.d L_8c33d0
L_8ec07c:
	mov_s r0,r1
L_8ec07e:
	mov_s r15,r0
L_8ec080:
	bl.d L_8c1cd8
L_8ec084:
	mov_s r1,0x4
L_8ec086:
	ldb r4,[r13, 0x8]
L_8ec08a:
	mov_s r1,0x1007ba8
L_8ec090:
	ldb_s r2,[r13,0x6]
L_8ec092:
	mov_s r0,0x20
L_8ec094:
	bl.d L_8dcd00
L_8ec098:
	ldb_s r3,[r13,0x5]
L_8ec09a:
	mov_s r14,0x8014b0
L_8ec0a0:
	ldb_s r0,[r13,0x5]
L_8ec0a2:
	stb_s r0,[r14,0xd]
L_8ec0a4:
	ldb_s r0,[r13,0x6]
L_8ec0a6:
	mov r17,0x0
L_8ec0aa:
	stb_s r0,[r14,0xe]
L_8ec0ac:
	ldb_s r0,[r13,0x7]
L_8ec0ae:
	st.as r0,[gp,0x92]
L_8ec0b2:
	ldb_s r0,[r13,0x8]
L_8ec0b4:
	cmp_s r0,0x0
L_8ec0b6:
	mov.ne lp_count,0xd
L_8ec0ba:
	mov.ne r0,r17
L_8ec0be:
	lpne L_8ec0f4
L_8ec0c2:
	add2 r10,r16,r0
L_8ec0c6:
	ldb r2,[r10, 0x1]
L_8ec0ca:
	ldb r3,[r10]
L_8ec0ce:
	asl_s r2,r2,0x8
L_8ec0d0:
	or_s r3,r3,r2
L_8ec0d2:
	ldb r2,[r10, 0x2]
L_8ec0d6:
	mov_s r1,0x801448
L_8ec0dc:
	asl_s r2,r2,0x10
L_8ec0de:
	or_s r3,r3,r2
L_8ec0e0:
	ldb r2,[r10, 0x3]
L_8ec0e4:
	add2_s r1,r1,r0
L_8ec0e6:
	asl_s r2,r2,0x18
L_8ec0e8:
	or_s r3,r3,r2
L_8ec0ea:
	mulu64 r3,0x3e8
L_8ec0ee:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ec0f0:
	st mlo,[r1]
	.global L_8ec0f4
L_8ec0f4:
	ldb_s r0,[r13,0x9]
L_8ec0f6:
	breq_s r0,0,L_8ec0fa
L_8ec0f8:
	stb_s r0,[r14,0x8]
	.global L_8ec0fa
L_8ec0fa:
	ldb_s r0,[r13,0xa]
L_8ec0fc:
	breq_s r0,0,L_8ec100
L_8ec0fe:
	stb_s r0,[r14,0xa]
	.global L_8ec100
L_8ec100:
	ldb_s r0,[r13,0xb]
L_8ec102:
	breq_s r0,0,L_8ec106
L_8ec104:
	stb_s r0,[r14,0x9]
	.global L_8ec106
L_8ec106:
	ldb_s r0,[r13,0x10]
L_8ec108:
	breq_s r0,0,L_8ec10c
L_8ec10a:
	stb_s r0,[r14,0xb]
	.global L_8ec10c
L_8ec10c:
	ldw_s r0,[r13,0xe]
L_8ec10e:
	ldw_s r1,[r13,0xc]
L_8ec110:
	asl_s r0,r0,0x10
L_8ec112:
	or_s r1,r1,r0
L_8ec114:
	breq_s r1,0,L_8ec118
L_8ec116:
	st_s r1,[r14]
	.global L_8ec118
L_8ec118:
	bl L_8c3284
L_8ec11c:
	mov_s r1,r14
L_8ec11e:
	mov_s r16,r0
L_8ec120:
	bl.d L_8c0380
L_8ec124:
	mov_s r2,0x10
L_8ec126:
	mov_s r0,r16
L_8ec128:
	mov_s r1,0x10
L_8ec12a:
	mov_s r2,r1
L_8ec12c:
	mov_s r14,0x0
L_8ec12e:
	bl.d L_8e5204
L_8ec132:
	mov_s r3,r14
L_8ec134:
	mov_s r1,0x1007bf0
L_8ec13a:
	ldw_s r0,[r13,0x2]
L_8ec13c:
	ldw_s r2,[r13]
L_8ec13e:
	asl_s r0,r0,0x10
L_8ec140:
	or_s r2,r2,r0
L_8ec142:
	bl.d L_8dcc10
L_8ec146:
	mov_s r0,0x20
L_8ec148:
	bl L_8c3284
L_8ec14c:
	ldw_s r2,[r13,0x2]
L_8ec14e:
	ldw_s r1,[r13]
L_8ec150:
	asl_s r2,r2,0x10
L_8ec152:
	or_s r1,r1,r2
L_8ec154:
	st_s r1,[r0]
L_8ec156:
	mov_s r1,0x14
L_8ec158:
	mov_s r2,0x4
L_8ec15a:
	bl.d L_8e5204
L_8ec15e:
	mov_s r3,r14
L_8ec160:
	stb_s r14,[r15]
L_8ec162:
	st_s r14,[sp,0x0]
L_8ec164:
	mov_s r0,r18
L_8ec166:
	mov_s r1,r15
L_8ec168:
	mov_s r2,r14
L_8ec16a:
	mov_s r3,0x19aa
L_8ec170:
	mov r4,0x4
L_8ec174:
	mov_s r5,r14
L_8ec176:
	mov_s r6,r14
L_8ec178:
	bl.d L_8e4fc4
L_8ec17c:
	mov_s r7,r14
L_8ec17e:
	b.d L_8c0234
L_8ec182:
	add_s sp,sp,0x4
