/* TX_API__alloc_tx_payload @ 0x8c3414, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::alloc_tx_payload mem pool allocation failed assigning fw_tx_packet_error_buffer (tx_status=0x%x)
 * Зовут его: add_bcon, add_discovery_bcon, ba_sm__send_addba_req, ba_sm__send_delba, ba_sm__setup_result, discovery_handle_probe_req, find_main_sm__bf_ntf, find_main_sm__probe_req_in_search, handle_packet_splitmac, l2mgr__set_app_ie
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal, mem_pool__allocate, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__alloc_tx_payload
TX_API__alloc_tx_payload:
	.global L_8c3414
L_8c3414:
	push_s blink
L_8c3416:
	bl L_8c01e4
L_8c341a:
	mov_s r0,0x842304
L_8c3420:
	bl.d L_8c354c
L_8c3424:
	sub_s sp,sp,0x8
L_8c3426:
	mov_s r13,sp
L_8c3428:
	brne_s r0,0,L_8c3462
L_8c342a:
	mov_s r14,0x805ac0
L_8c3430:
	breq_s r14,0,L_8c3482
	.global L_8c3432
L_8c3432:
	st_s r14,[r13]
L_8c3434:
	add_s r14,r14,0x24
L_8c3436:
	st_s r14,[r13,0x4]
L_8c3438:
	ld_s r2,[sp,0x0]
L_8c343a:
	mov_s r1,0x1018388
L_8c3440:
	mov_s r0,0x17
L_8c3442:
	bl.d L_8dcc10
L_8c3446:
	ldb_s r2,[r2,0x11]
L_8c3448:
	ld_s r0,[sp,0x0]
L_8c344a:
	ldb_s r0,[r0,0x11]
L_8c344c:
	cmp r0,0xfd
L_8c3450:
	mov.ne r0,blink
L_8c3454:
	mov.ne r1,0x134c
L_8c345c:
	bl.ne L_8c9b28
L_8c3460:
	b_s L_8c3468
	.global L_8c3462
L_8c3462:
	st_s r0,[sp,0x0]
L_8c3464:
	add_s r0,r0,0x24
L_8c3466:
	st_s r0,[sp,0x4]
	.global L_8c3468
L_8c3468:
	ld_s r0,[sp,0x4]
L_8c346a:
	bl.d L_8c1cd8
L_8c346e:
	mov r1,0x500
L_8c3472:
	ld_s r1,[sp,0x0]
L_8c3474:
	mov_s r0,0x0
L_8c3476:
	st_s r0,[r1,0x18]
L_8c3478:
	st_s r0,[r1,0x1c]
L_8c347a:
	ld_s r0,[sp,0x4]
L_8c347c:
	b.d L_8c0254
L_8c3480:
	add_s sp,sp,0x8
	.global L_8c3482
L_8c3482:
	mov_s r0,blink
L_8c3484:
	mov_s r1,0x11d6
L_8c348a:
	bl L_8c9b28
L_8c348e:
	b_s L_8c3432
