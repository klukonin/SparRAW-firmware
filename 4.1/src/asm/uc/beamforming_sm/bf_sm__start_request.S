/* bf_sm__start_request @ 0x922560, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__pop_request_fifo
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_sm__reset_sta_rate, get_g_80051c, rate_search__start_for_sta, rf_sector__clear_sta_bit, tbl_8018b5__byte_by_index, ucode_pm__set_busy_flag
 */
	.section .text.bf_sm__start_request,"ax",@progbits
	.global bf_sm__start_request
bf_sm__start_request:
	.global L_922560
L_922560:
	push_s blink
L_922562:
	bl L_920214
L_922566:
	mov_s r14,r0
L_922568:
	mov_s r13,r1
L_92256a:
	mov_s r0,r1
L_92256c:
	bl.d L_9221bc
L_922570:
	mov_s r1,0x1
L_922572:
	brne r14,0x1,L_9225bc
L_922576:
	mov_s r1,0x800f94
L_92257c:
	ldb_s r0,[r1,0x1d]
L_92257e:
	stw.as r0,[gp,-0x5f]
L_922582:
	ldb_s r0,[r1,0x1c]
L_922584:
	mov_s r1,0x8011d4
L_92258a:
	stw.as r0,[gp,-0x60]
L_92258e:
	asl_s r0,r13,0x3
L_922590:
	add3_s r0,r0,r0
L_922592:
	ldb_s r0,[r1,r0]
L_922594:
	brne_s r0,0,L_9225e8
L_922596:
	bl.d L_92c320
L_92259a:
	mov_s r0,r13
L_92259c:
	mov_s r1,r0
L_92259e:
	bl.d L_92c34c
L_9225a2:
	mov_s r0,r13
L_9225a4:
	bl.d L_92c30c
L_9225a8:
	mov_s r0,r13
L_9225aa:
	breq_s r0,0,L_9225e8
L_9225ac:
	mov_s r0,0x3
L_9225ae:
	bl.d L_928d94
L_9225b2:
	mov_s r1,r13
L_9225b4:
	bl.d L_936d50
L_9225b8:
	mov_s r0,0x1
L_9225ba:
	b_s L_9225e8
	.global L_9225bc
L_9225bc:
	breq r13,0x8,L_9225e8
L_9225c0:
	ld.as r2,[gp,-0x4]
L_9225c4:
	ldw_s r0,[gp,-0xbe]
L_9225c6:
	bset r1,r2,0x5
L_9225ca:
	asl_s r0,r0,0x8
L_9225cc:
	or_s r0,r0,r1
L_9225ce:
	/* asl_s r13,r13,0x3 */
	.byte 0x03,0xbd
L_9225d0:
	add3_s r13,r13,r13
L_9225d2:
	add_s r13,r13,0x801190
L_9225d8:
	st_s r0,[r13,0x4]
L_9225da:
	ldw.as r1,[gp,-0x60]
L_9225de:
	or r0,r2,0x30
L_9225e2:
	asl_s r1,r1,0x8
L_9225e4:
	or_s r0,r0,r1
L_9225e6:
	st_s r0,[r13,0x8]
	.global L_9225e8
L_9225e8:
	b L_920284
