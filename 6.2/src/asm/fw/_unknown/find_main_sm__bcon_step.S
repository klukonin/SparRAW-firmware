/* find_main_sm__bcon_step @ 0x8f8574, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__bcon, find_main_sm__first_detection, l2_mgr__lmac_new_link_evt_handler, probe_resp_ind, scan_mngr__dband_beacon_ind, scan_mngr__handle_abft_bf_result_in_scan, scan_mngr__handle_link_up_event
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__bcon_step
find_main_sm__bcon_step:
	.global L_8f8574
L_8f8574:
	push_s blink
L_8f8576:
	bl.d L_8c01e4
L_8f857a:
	mov_s r2,r0
L_8f857c:
	sub_s sp,sp,0x4
L_8f857e:
	mov_s r13,r1
L_8f8580:
	mov_s r14,sp
L_8f8582:
	mov_s r0,r14
L_8f8584:
	bl.d L_8e5df4
L_8f8588:
	mov_s r1,r2
L_8f858a:
	b_s L_8f859a
	.global L_8f858c
L_8f858c:
	bl.d L_8df438
L_8f8590:
	mov_s r0,r14
L_8f8592:
	ldb_s r2,[r13]
L_8f8594:
	ldb_s r1,[r0,0x8]
L_8f8596:
	breq r2,r1,L_8f85a6
	.global L_8f859a
L_8f859a:
	bl.d L_8cdcb8
L_8f859e:
	mov_s r0,r14
L_8f85a0:
	brne_s r0,0,L_8f858c
L_8f85a2:
	mov_s r0,0x0
L_8f85a4:
	b_s L_8f85ce
	.global L_8f85a6
L_8f85a6:
	ldb_s r2,[r13,0x1]
L_8f85a8:
	ldb_s r1,[r0,0x9]
L_8f85aa:
	brne r2,r1,L_8f859a
L_8f85ae:
	ldb_s r2,[r13,0x2]
L_8f85b0:
	ldb_s r1,[r0,0xa]
L_8f85b2:
	brne r2,r1,L_8f859a
L_8f85b6:
	ldb_s r2,[r13,0x3]
L_8f85b8:
	ldb_s r1,[r0,0xb]
L_8f85ba:
	brne r2,r1,L_8f859a
L_8f85be:
	ldb_s r2,[r13,0x4]
L_8f85c0:
	ldb_s r1,[r0,0xc]
L_8f85c2:
	brne r2,r1,L_8f859a
L_8f85c6:
	ldb_s r2,[r13,0x5]
L_8f85c8:
	ldb_s r1,[r0,0xd]
L_8f85ca:
	brne r2,r1,L_8f859a
	.global L_8f85ce
L_8f85ce:
	b.d L_8c0254
L_8f85d2:
	add_s sp,sp,0x4
