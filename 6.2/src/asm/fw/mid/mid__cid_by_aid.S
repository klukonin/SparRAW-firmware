/* mid__cid_by_aid @ 0x8cc06c, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Received Broadcast AID
 *   Received unknown AID: %d. During direct communication case
 *   Found CID for AID: %d. CID is: %d
 * Зовут его: ese__peer_cid_by_aid
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__cid_by_aid
mid__cid_by_aid:
	.global L_8cc06c
L_8cc06c:
	push_s blink
L_8cc06e:
	bl L_8c01e0
L_8cc072:
	sub_s sp,sp,0x4
L_8cc074:
	mov_s r14,r0
L_8cc076:
	mov_s r13,r1
L_8cc078:
	mov_s r15,sp
L_8cc07a:
	add r1,r0,0x18
L_8cc07e:
	bl.d L_8e5df4
L_8cc082:
	mov_s r0,r15
L_8cc084:
	cmp r13,0xff
L_8cc088:
	bne_s L_8cc0aa
L_8cc08a:
	mov_s r1,0x100cf98
L_8cc090:
	bl.d L_8dcba8
L_8cc094:
	mov_s r0,0x2b
L_8cc096:
	ldb r0,[r14, 0x24]
L_8cc09a:
	b_s L_8cc0f8
	.global L_8cc09c
L_8cc09c:
	bl.d L_8df438
L_8cc0a0:
	mov_s r0,r15
L_8cc0a2:
	mov_s r14,r0
L_8cc0a4:
	ldb_s r0,[r0,0x9]
L_8cc0a6:
	breq r13,r0,L_8cc0c4
	.global L_8cc0aa
L_8cc0aa:
	bl.d L_8cdcb8
L_8cc0ae:
	mov_s r0,r15
L_8cc0b0:
	brne_s r0,0,L_8cc09c
L_8cc0b2:
	mov_s r1,0x100cfb0
L_8cc0b8:
	mov_s r0,0x2b
L_8cc0ba:
	bl.d L_8dcc10
L_8cc0be:
	mov_s r2,r13
L_8cc0c0:
	mov_s r0,0x0
L_8cc0c2:
	b_s L_8cc0f8
	.global L_8cc0c4
L_8cc0c4:
	mov_s r1,0x100cfec
L_8cc0ca:
	mov_s r0,0x2b
L_8cc0cc:
	mov_s r2,r13
L_8cc0ce:
	bl.d L_8dcc80
L_8cc0d2:
	ldb_s r3,[r14,0x8]
L_8cc0d4:
	ldb r0,[r14,0x124]
L_8cc0dc:
	breq r0,0x7,L_8cc0ee
L_8cc0e0:
	mov_s r0,blink
L_8cc0e2:
	mov_s r1,0x1225
L_8cc0e8:
	bl L_8c9b28
L_8cc0ec:
	b_s L_8cc0aa
	.global L_8cc0ee
L_8cc0ee:
	ldb_s r1,[r14,0x8]
L_8cc0f0:
	mov_s r0,0x0
L_8cc0f2:
	bset r0,r0,r1
L_8cc0f6:
	extw_s r0,r0
	.global L_8cc0f8
L_8cc0f8:
	b.d L_8c024c
L_8cc0fc:
	add_s sp,sp,0x4
L_8cc0fe:
	nop_s
