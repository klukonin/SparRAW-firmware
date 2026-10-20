/* app_ie__walk_list @ 0x8df404, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: app_ie__find_by_eid, app_ie__print_ies, app_ie__remove_tlv, find_main_sm__probe_req_in_search, ies_block__merge, state_sm_8030f4__action_8f76d8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global app_ie__walk_list
app_ie__walk_list:
	.global L_8df404
L_8df404:
	push_s r13
L_8df406:
	ld_s r1,[r0,0x4]
L_8df408:
	breq_s r1,0,L_8df410
L_8df40a:
	ld_s r13,[r0]
L_8df40c:
	ldw_s r2,[r13,0x4]
L_8df40e:
	brne_s r2,0,L_8df414
	.global L_8df410
L_8df410:
	mov_s r1,0x0
L_8df412:
	b_s L_8df430
	.global L_8df414
L_8df414:
	ldb_s r3,[r1,0x1]
L_8df416:
	ldw_s r2,[r0,0x8]
L_8df418:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_8df41a:
	add_s r2,r2,r3
L_8df41c:
	extw_s r2,r2
L_8df41e:
	stw_s r2,[r0,0x8]
L_8df420:
	ldw_s r3,[r13,0x4]
L_8df422:
	cmp_s r3,r2
L_8df424:
	mov_s r2,0x0
L_8df426:
	ble_s L_8df42e
L_8df428:
	ldb_s r2,[r1,0x1]
L_8df42a:
	add_s r2,r2,r1
L_8df42c:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
	.global L_8df42e
L_8df42e:
	st_s r2,[r0,0x4]
	.global L_8df430
L_8df430:
	mov_s r0,r1
L_8df432:
	j_s.d [blink]
L_8df434:
	pop_s r13
L_8df436:
	nop_s
