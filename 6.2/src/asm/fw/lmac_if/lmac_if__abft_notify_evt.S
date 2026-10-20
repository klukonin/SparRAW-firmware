/* lmac_if__abft_notify_evt @ 0x8db330, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Discovery ABFT Notify status %d (BF_DONE_OK = 1)
 *   BF for unknown CID
 * Зовут его: lmac_if__ucode_event_dispatch, lmac_if_link_lost_evt_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__arm_retry_timer, conn__snapshot_step, conn_mgr__by_cid, connection__on_bf_result, dashboard__bf_results, fw_log_emit0, fw_log_emit1, handle_abft_event, lmac_if__bf_done_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__abft_notify_evt
lmac_if__abft_notify_evt:
	.global L_8db330
L_8db330:
	push_s blink
L_8db332:
	bl L_8c01e4
L_8db336:
	mov_s r13,r0
L_8db338:
	bl.d L_8cbffc
L_8db33c:
	ldb_s r0,[r0,0x4]
L_8db33e:
	mov_s r14,r0
L_8db340:
	bl.d L_8db3c8
L_8db344:
	mov_s r0,r13
L_8db346:
	breq_s r14,0,L_8db3a4
L_8db348:
	add3 r0,r14,0xe
L_8db34c:
	bl.d L_8c28d0
L_8db350:
	mov_s r1,r13
L_8db352:
	ld_s r0,[r13,0x2c]
L_8db354:
	cmp_s r0,0x1
L_8db356:
	mov_s r0,r14
L_8db358:
	bne_s L_8db39c
L_8db35a:
	ld_s r1,[r13,0x30]
L_8db35c:
	bl.d L_8c54ec
L_8db360:
	ld_s r2,[r13]
L_8db362:
	mov_s r0,r14
L_8db364:
	bl.d L_8e48d0
L_8db368:
	mov_s r1,0x1
L_8db36a:
	ldw_s r0,[r13,0xa]
L_8db36c:
	stw_s r0,[r14,0xc]
L_8db36e:
	ldb.x r0,[r13, 0xc]
L_8db372:
	stb_s r0,[r14,0x14]
L_8db374:
	mov_s r0,0x803c00
L_8db37a:
	ld_s r0,[r0,0xc]
L_8db37c:
	breq_s r0,0,L_8db3ba
L_8db37e:
	mov_s r1,0x1003f64
L_8db384:
	mov_s r0,0x20
L_8db386:
	bl.d L_8dcc10
L_8db38a:
	ld_s r2,[r13,0x2c]
L_8db38c:
	ld_s r0,[r14,0x18]
L_8db38e:
	mov_s r1,r14
L_8db390:
	add r0,r0,0x234
L_8db394:
	bl.d L_8f3b6c
L_8db398:
	ld_s r2,[r13,0x2c]
L_8db39a:
	b_s L_8db3ba
	.global L_8db39c
L_8db39c:
	bl.d L_8e48d0
L_8db3a0:
	mov_s r1,0x0
L_8db3a2:
	b_s L_8db3ba
	.global L_8db3a4
L_8db3a4:
	mov_s r0,0x803c00
L_8db3aa:
	ld_s r0,[r0,0xc]
L_8db3ac:
	breq_s r0,0,L_8db3ba
L_8db3ae:
	mov_s r1,0x1003f98
L_8db3b4:
	bl.d L_8dcba8
L_8db3b8:
	mov_s r0,0x20
	.global L_8db3ba
L_8db3ba:
	mov_s r0,r13
L_8db3bc:
	bl.d L_8eab44
L_8db3c0:
	mov_s r1,r14
L_8db3c2:
	b L_8c0254
L_8db3c6:
	nop_s
