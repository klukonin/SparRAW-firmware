/* llist__remove @ 0x8de4ec, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   llist.cpp
 * Зовут его: TX_API__awake_peer_ntf, TX_API__callback_and_release, conn_mgr__find_reusable_cid, conn_mgr__ranking_remove, fwq_tx__flush_list_packets_by_cid, fwq_tx__long_retry_failures, fwq_tx__long_retry_handler, mid_list__remove_entry, radio_mgr__unlink_request, rm_main_sm__primary_handle_free
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.llist__remove,"ax",@progbits
	.global llist__remove
llist__remove:
	.global L_8de4ec
L_8de4ec:
	push_s blink
L_8de4ee:
	bl L_8c02c4
L_8de4f2:
	mov.f r14,r1
L_8de4f6:
	mov_s r13,r0
L_8de4f8:
	beq_s L_8de51a
	.global L_8de4fa
L_8de4fa:
	ld_s r0,[r14,0x4]
L_8de4fc:
	brne r13,r0,L_8de52c
	.global L_8de500
L_8de500:
	ld_s r0,[r13]
L_8de502:
	breq_s r0,0,L_8de53e
	.global L_8de504
L_8de504:
	ld_s r1,[r13,0x4]
L_8de506:
	brne r14,r1,L_8de552
L_8de50a:
	ld_s r0,[r13,0x8]
L_8de50c:
	brne r14,r0,L_8de514
L_8de510:
	mov_s r0,0x0
L_8de512:
	st_s r0,[r13,0x8]
	.global L_8de514
L_8de514:
	ld_s r0,[r14]
L_8de516:
	st_s r0,[r13,0x4]
L_8de518:
	b_s L_8de57a
	.global L_8de51a
L_8de51a:
	mov_s r0,blink
L_8de51c:
	mov_s r2,0x1001de0
L_8de522:
	mov_s r1,0xda
L_8de524:
	bl.d L_8c82c0
L_8de528:
	mov_s r3,0x63
L_8de52a:
	b_s L_8de4fa
	.global L_8de52c
L_8de52c:
	mov_s r0,blink
L_8de52e:
	mov_s r2,0x1001de0
L_8de534:
	mov_s r1,0xdb
L_8de536:
	bl.d L_8c82c0
L_8de53a:
	mov_s r3,0x64
L_8de53c:
	b_s L_8de500
	.global L_8de53e
L_8de53e:
	mov_s r0,blink
L_8de540:
	mov_s r2,0x1001de0
L_8de546:
	mov_s r1,0xdc
L_8de548:
	bl.d L_8c82c0
L_8de54c:
	mov_s r3,0x65
L_8de54e:
	b_s L_8de504
	.global L_8de550
L_8de550:
	mov_s r1,r0
	.global L_8de552
L_8de552:
	breq_s r1,0,L_8de55a
L_8de554:
	ld_s r0,[r1]
L_8de556:
	brne r14,r0,L_8de550
	.global L_8de55a
L_8de55a:
	brne_s r1,0,L_8de56e
L_8de55c:
	mov_s r0,blink
L_8de55e:
	mov_s r2,0x1001de0
L_8de564:
	mov_s r1,0xdd
L_8de566:
	bl.d L_8c82c0
L_8de56a:
	mov_s r3,0x7a
L_8de56c:
	b_s L_8de586
	.global L_8de56e
L_8de56e:
	ld_s r0,[r14]
L_8de570:
	st_s r0,[r1]
L_8de572:
	ld_s r0,[r13,0x8]
L_8de574:
	brne r14,r0,L_8de57a
L_8de578:
	st_s r1,[r13,0x8]
	.global L_8de57a
L_8de57a:
	mov_s r0,0x0
L_8de57c:
	st_s r0,[r14]
L_8de57e:
	st_s r0,[r14,0x4]
L_8de580:
	ld_s r0,[r13]
L_8de582:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8de584:
	st_s r0,[r13]
	.global L_8de586
L_8de586:
	b L_8c0334
L_8de58a:
	nop_s
