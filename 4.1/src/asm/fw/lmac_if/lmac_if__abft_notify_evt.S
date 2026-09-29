/* lmac_if__abft_notify_evt @ 0x8d8188, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Discovery ABFT Notify status %d (BF_DONE_OK = 1)
 *   BF for unknown CID
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__arm_retry_timer, conn_mgr__by_cid, connection__on_bf_result, dashboard__bf_results, frag_8c22b0, fw_log__emit0, fw_log__emit1, handle_abft_event, lmac_if__bf_done_evt
 */
	.section .text.lmac_if__abft_notify_evt,"ax",@progbits
	.global lmac_if__abft_notify_evt
lmac_if__abft_notify_evt:
	.global L_8d8188
L_8d8188:
	push_s blink
L_8d818a:
	bl L_8c02c4
L_8d818e:
	mov_s r13,r0
L_8d8190:
	bl.d L_8c9e44
L_8d8194:
	ldb_s r0,[r0,0x4]
L_8d8196:
	mov_s r14,r0
L_8d8198:
	bl.d L_8d8218
L_8d819c:
	mov_s r0,r13
L_8d819e:
	breq_s r14,0,L_8d81f4
L_8d81a0:
	add2 r0,r14,0x19
L_8d81a4:
	bl.d L_8c22b0
L_8d81a8:
	mov_s r1,r13
L_8d81aa:
	ld_s r0,[r13,0xc]
L_8d81ac:
	cmp_s r0,0x1
L_8d81ae:
	mov_s r0,r14
L_8d81b0:
	bne_s L_8d81ec
L_8d81b2:
	ld_s r1,[r13,0x10]
L_8d81b4:
	bl.d L_8c4990
L_8d81b8:
	ld_s r2,[r13]
L_8d81ba:
	mov_s r0,r14
L_8d81bc:
	bl.d L_8dfc14
L_8d81c0:
	mov_s r1,0x1
L_8d81c2:
	mov_s r0,0x80345c
L_8d81c8:
	ld_s r0,[r0,0xc]
L_8d81ca:
	breq_s r0,0,L_8d820c
L_8d81cc:
	mov_s r2,0x10042a0
L_8d81d2:
	mov_s r0,0x0
L_8d81d4:
	mov_s r1,0x2
L_8d81d6:
	bl.d L_8edfcc
L_8d81da:
	ld_s r3,[r13,0xc]
L_8d81dc:
	ld_s r0,[r14,0xc]
L_8d81de:
	mov_s r1,r14
L_8d81e0:
	add r0,r0,0x234
L_8d81e4:
	bl.d L_8ebe88
L_8d81e8:
	ld_s r2,[r13,0xc]
L_8d81ea:
	b_s L_8d820c
	.global L_8d81ec
L_8d81ec:
	bl.d L_8dfc14
L_8d81f0:
	mov_s r1,0x0
L_8d81f2:
	b_s L_8d820c
	.global L_8d81f4
L_8d81f4:
	mov_s r0,0x80345c
L_8d81fa:
	ld_s r0,[r0,0xc]
L_8d81fc:
	breq_s r0,0,L_8d820c
L_8d81fe:
	mov_s r2,0x10042d4
L_8d8204:
	mov_s r0,0x0
L_8d8206:
	bl.d L_8edfb0
L_8d820a:
	mov_s r1,0x2
	.global L_8d820c
L_8d820c:
	mov_s r0,r13
L_8d820e:
	bl.d L_8e57a4
L_8d8212:
	mov_s r1,r14
L_8d8214:
	b L_8c0334
