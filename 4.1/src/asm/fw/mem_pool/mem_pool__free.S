/* mem_pool__free @ 0x8c9268, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mem_pool.cpp
 * Зовут его: STREAM_MGR__2, TX_API__free_memory, conn_mgr__find_reusable_cid, conn_mgr__free_cid_db_element, conn_mgr__ranking_remove, free_dband_info, fw_mailbox__enqueue, fw_mailbox__enqueue_msg, mem_pool__free_8062c4, mem_pool__free_locked
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_div_unsigned, fw_sysassert_fatal
 */
	.section .text.mem_pool__free,"ax",@progbits
	.global mem_pool__free
mem_pool__free:
	.global L_8c9268
L_8c9268:
	push_s blink
L_8c926a:
	bl L_8c02c4
L_8c926e:
	mov_s r14,r0
L_8c9270:
	ld_s r0,[r0,0xc]
L_8c9272:
	mov_s r13,r1
L_8c9274:
	breq_s r0,0,L_8c92a8
	.global L_8c9276
L_8c9276:
	ld_s r0,[r14,0x4]
L_8c9278:
	rsub r0,r0,r13
L_8c927c:
	bl.d L_8c03b4
L_8c9280:
	ld_s r1,[r14,0x8]
L_8c9282:
	brne_s r1,0,L_8c92ba
	.global L_8c9284
L_8c9284:
	ld_s r0,[r14,0x4]
L_8c9286:
	brlo r13,r0,L_8c92cc
L_8c928a:
	ld_s r2,[r14,0x8]
L_8c928c:
	ld_s r1,[r14,0x10]
L_8c928e:
	mulu64 r1,r2
L_8c9292:
	add_s r0,r0,mlo
L_8c9294:
	brhs r13,r0,L_8c92cc
	.global L_8c9298
L_8c9298:
	ld_s r0,[r14]
L_8c929a:
	st_s r0,[r13]
L_8c929c:
	ld_s r0,[r14,0xc]
L_8c929e:
	st_s r13,[r14]
L_8c92a0:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8c92a2:
	b.d L_8c0334
L_8c92a6:
	st_s r0,[r14,0xc]
	.global L_8c92a8
L_8c92a8:
	mov_s r0,blink
L_8c92aa:
	mov_s r2,0x1001b84
L_8c92b0:
	mov_s r1,0xe7
L_8c92b2:
	bl.d L_8c82c0
L_8c92b6:
	mov_s r3,0x70
L_8c92b8:
	b_s L_8c9276
	.global L_8c92ba
L_8c92ba:
	mov_s r0,blink
L_8c92bc:
	mov_s r2,0x1001b84
L_8c92c2:
	mov_s r1,0xe8
L_8c92c4:
	bl.d L_8c82c0
L_8c92c8:
	mov_s r3,0x71
L_8c92ca:
	b_s L_8c9284
	.global L_8c92cc
L_8c92cc:
	mov_s r0,blink
L_8c92ce:
	mov_s r2,0x1001b84
L_8c92d4:
	mov_s r1,0xe9
L_8c92d6:
	bl.d L_8c82c0
L_8c92da:
	mov_s r3,0x72
L_8c92dc:
	b_s L_8c9298
L_8c92de:
	nop_s
