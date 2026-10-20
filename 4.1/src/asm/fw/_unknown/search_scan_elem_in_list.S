/* search_scan_elem_in_list @ 0x8f020c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   search_scan_elem_in_list MAC:ADDR-%04X%08X
 * Зовут его: find_main_sm__bcon, find_main_sm__first_detection, l2_mgr__lmac_new_link_evt_handler, scan_mngr__dband_beacon_ind, scan_mngr__handle_abft_bf_result_in_scan, scan_mngr__handle_link_up_event, scan_mngr__probe_resp_ind
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, iter__has_more, iter__init, iter__next
 */
	.section .text.search_scan_elem_in_list,"ax",@progbits
	.global search_scan_elem_in_list
search_scan_elem_in_list:
	.global L_8f020c
L_8f020c:
	push_s blink
L_8f020e:
	bl.d L_8c02c0
L_8f0212:
	mov_s r2,r0
L_8f0214:
	sub_s sp,sp,0x4
L_8f0216:
	mov_s r14,r1
L_8f0218:
	mov_s r15,sp
L_8f021a:
	mov_s r0,r15
L_8f021c:
	bl.d L_8e1138
L_8f0220:
	mov_s r1,r2
L_8f0222:
	b_s L_8f0234
	.global L_8f0224
L_8f0224:
	bl.d L_8db188
L_8f0228:
	mov_s r0,r15
L_8f022a:
	mov_s r13,r0
L_8f022c:
	ldb_s r1,[r14]
L_8f022e:
	ldb_s r0,[r0,0x8]
L_8f0230:
	breq r1,r0,L_8f0240
	.global L_8f0234
L_8f0234:
	bl.d L_8cb674
L_8f0238:
	mov_s r0,r15
L_8f023a:
	brne_s r0,0,L_8f0224
L_8f023c:
	mov_s r13,0x0
L_8f023e:
	b_s L_8f027c
	.global L_8f0240
L_8f0240:
	ldb_s r1,[r14,0x1]
L_8f0242:
	ldb_s r0,[r13,0x9]
L_8f0244:
	brne r1,r0,L_8f0234
L_8f0248:
	ldb_s r1,[r14,0x2]
L_8f024a:
	ldb_s r0,[r13,0xa]
L_8f024c:
	brne r1,r0,L_8f0234
L_8f0250:
	ldb_s r1,[r14,0x3]
L_8f0252:
	ldb_s r0,[r13,0xb]
L_8f0254:
	brne r1,r0,L_8f0234
L_8f0258:
	ldb_s r1,[r14,0x4]
L_8f025a:
	ldb_s r0,[r13,0xc]
L_8f025c:
	brne r1,r0,L_8f0234
L_8f0260:
	ldb_s r1,[r14,0x5]
L_8f0262:
	ldb_s r0,[r13,0xd]
L_8f0264:
	brne r1,r0,L_8f0234
L_8f0268:
	mov_s r2,0x10127bc
L_8f026e:
	ld r4,[r13, 0x8]
L_8f0272:
	mov_s r0,0xc
L_8f0274:
	mov_s r1,0x2
L_8f0276:
	bl.d L_8edff8
L_8f027a:
	ldw_s r3,[r13,0xc]
	.global L_8f027c
L_8f027c:
	mov_s r0,r13
L_8f027e:
	b.d L_8c032c
L_8f0282:
	add_s sp,sp,0x4
