/* get_selected_rf_sector_index_cmd_handler @ 0x92639c, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   get_selected_rf_sector_index_cmd_handler(): Invalid sector type specified %d, cid=%d
 *   txrx_api_cmd_handler.c
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, memcpy_uc, uc_read_tsf64, uc_send_evt__get_rf_sector_done, uc_sysassert
 */
	.section .text.get_selected_rf_sector_index_cmd_handler,"ax",@progbits
	.global get_selected_rf_sector_index_cmd_handler
get_selected_rf_sector_index_cmd_handler:
	.global L_92639c
L_92639c:
	push_s blink
L_92639e:
	bl.d L_92020c
L_9263a2:
	mov_s r2,0x10
L_9263a4:
	sub_s sp,sp,0x10
L_9263a6:
	mov_s r13,r0
L_9263a8:
	mov_s r0,sp
L_9263aa:
	mov_s r1,0x800cac
L_9263b0:
	bl.d L_920310
L_9263b4:
	mov_s r16,r0
L_9263b6:
	ldb_s r14,[r13,0x1]
L_9263b8:
	ldb_s r0,[r13]
L_9263ba:
	brne r14,0x1,L_9263d4
L_9263be:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_9263c0:
	add3_s r0,r0,r0
L_9263c2:
	mov_s r1,0x801198
L_9263c8:
	ld_s r0,[r1,r0]
L_9263ca:
	lsr_s r0,r0,0x8
L_9263cc:
	bmsk_s r0,r0,0xe
L_9263ce:
	stw r0,[sp]
L_9263d2:
	b_s L_926436
	.global L_9263d4
L_9263d4:
	brne_s r14,0,L_9263e0
L_9263d6:
	add_s r0,r0,0x60
L_9263d8:
	extb_s r0,r0
L_9263da:
	stw r0,[sp]
L_9263de:
	b_s L_926436
	.global L_9263e0
L_9263e0:
	mov_s r3,0x80209c
L_9263e6:
	ldb_s r1,[r3,0x4]
L_9263e8:
	mov_s r2,0x1001934
L_9263ee:
	bbit0 r1,0x0,L_926422
L_9263f2:
	ld_s r1,[r3]
L_9263f4:
	mov_s r13,0x8020b0
L_9263fa:
	add_s r15,r1,0x2
L_9263fc:
	extb_s r15,r15
L_9263fe:
	add2 r15,r13,r15
L_926402:
	st_s r0,[r15]
L_926404:
	add_s r0,r1,0x1
L_926406:
	extb_s r0,r0
L_926408:
	add2 r0,r13,r0
L_92640c:
	st_s r14,[r0]
L_92640e:
	bmsk r0,r2,0x13
L_926412:
	bset_s r0,r0,0x1b
L_926414:
	bset_s r0,r0,0x1d
L_926416:
	bset_s r0,r0,0x1f
L_926418:
	extb_s r2,r1
L_92641a:
	add2_s r13,r13,r2
L_92641c:
	st_s r0,[r13]
L_92641e:
	/* add_s r1,0x3 */
	.byte 0x03,0xe1
L_926420:
	st_s r1,[r3]
	.global L_926422
L_926422:
	mov_s r0,blink
L_926424:
	mov_s r2,0x1001830
L_92642a:
	mov r1,0x105
L_92642e:
	bl.d L_925548
L_926432:
	mov r3,0x328
	.global L_926436
L_926436:
	bl.d L_930cb0
L_92643a:
	add_s r0,sp,0x8
L_92643c:
	mov_s r0,0x0
L_92643e:
	stb r0,[sp, 0x2]
L_926442:
	bl.d L_925c14
L_926446:
	mov_s r0,r16
L_926448:
	b.d L_920274
L_92644c:
	add_s sp,sp,0x10
L_92644e:
	nop_s
