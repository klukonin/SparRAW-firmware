/* l2_mgr__wmi_cmd_handler_start_search_8f33b8 @ 0x8f33b8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_start_search - If connected or in GO mode it's prohibit to run the search flow.
 * Зовут его: l2_mgr__wmi_cmd_handler_start_search
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r13_ret, find_mngr__enter_search, fw_log__emit0, l2mgr__send_search_started, mid_list__any_in_state2, mid_list__by_mid
 */
	.section .text.l2_mgr__wmi_cmd_handler_start_search_8f33b8,"ax",@progbits
	.global l2_mgr__wmi_cmd_handler_start_search_8f33b8
l2_mgr__wmi_cmd_handler_start_search_8f33b8:
	.global L_8f33b8
L_8f33b8:
	push_s blink
L_8f33ba:
	bl.d L_8ca1b0
L_8f33be:
	push_s r13
L_8f33c0:
	mov_s r13,r0
L_8f33c2:
	ldb r0,[r0, 0x9c]
L_8f33c6:
	brne_s r0,0,L_8f33ce
L_8f33c8:
	bl L_8c307c
L_8f33cc:
	breq_s r0,0,L_8f33e6
	.global L_8f33ce
L_8f33ce:
	mov_s r2,0x100d138
L_8f33d4:
	mov_s r0,0xb
L_8f33d6:
	bl.d L_8edfb0
L_8f33da:
	mov_s r1,0x1
L_8f33dc:
	mov_s r0,0x1
L_8f33de:
	bl.d L_8f0a4c
L_8f33e2:
	ldb_s r1,[r13,0x10]
L_8f33e4:
	b_s L_8f33f8
	.global L_8f33e6
L_8f33e6:
	mov_s r0,0xe
L_8f33e8:
	bl.d L_8e3a08
L_8f33ec:
	mov_s r1,0x0
L_8f33ee:
	mov_s r0,r13
L_8f33f0:
	bl.d L_8f01ac
L_8f33f4:
	add r0,r0,0x234
	.global L_8f33f8
L_8f33f8:
	b L_8c033c
