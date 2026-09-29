/* conn_mgr__activate_conn @ 0x8c2460, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::activate_conn() LINKUP for CID %d starting.
 * Зовут его: mid__link_acquisition_action, pbss__alloc_sta_entry, scan_mngr__prob_done
 * Зовёт сам: __ld_r13_to_r13_ret, conn_mgr__add_to_rinking_list, conn_mgr__allocate_cid_db_element, find_sm__start_listen, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__activate_conn
conn_mgr__activate_conn:
	.global L_8c2460
L_8c2460:
	push_s blink
L_8c2462:
	push_s r13
L_8c2464:
	sub_s sp,sp,0x4
L_8c2466:
	mov_s r13,r0
L_8c2468:
	brne r1,0x1,L_8c2486
L_8c246c:
	bl.d L_8c36c0
L_8c2470:
	mov_s r1,sp
L_8c2472:
	cmp_s r0,0x0
L_8c2474:
	mov.eq r0,blink
L_8c2478:
	mov.eq r1,0x11cb
L_8c2480:
	bl.eq L_8c9b28
L_8c2484:
	b_s L_8c248a
	.global L_8c2486
L_8c2486:
	ldb_s r0,[r13,0x8]
L_8c2488:
	st_s r0,[sp,0x0]
	.global L_8c248a
L_8c248a:
	mov_s r1,0x100be30
L_8c2490:
	mov_s r0,0x2b
L_8c2492:
	bl.d L_8dcc10
L_8c2496:
	ld_s r2,[sp,0x0]
L_8c2498:
	bl.d L_8c2d78
L_8c249c:
	mov_s r0,r13
L_8c249e:
	mov_s r0,r13
L_8c24a0:
	bl.d L_8f9670
L_8c24a4:
	ld_s r1,[sp,0x0]
L_8c24a6:
	ld_s r0,[sp,0x0]
L_8c24a8:
	b.d L_8c025c
L_8c24ac:
	add_s sp,sp,0x4
L_8c24ae:
	nop_s
