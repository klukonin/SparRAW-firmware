/* l2_mgr__wmi_cmd_handler_start_listen_8f3374 @ 0x8f3374, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_start_listen - If connected or in GO mode do nothing on listen request.
 * Зовут его: l2_mgr__wmi_cmd_handler_start_listen
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r13_ret, find_mngr__enter_listen, fw_log__emit0, l2mgr__send_listen_started, mid_list__any_in_state2, mid_list__by_mid
 */
	.section .text.l2_mgr__wmi_cmd_handler_start_listen_8f3374,"ax",@progbits
	.global l2_mgr__wmi_cmd_handler_start_listen_8f3374
l2_mgr__wmi_cmd_handler_start_listen_8f3374:
	.global L_8f3374
L_8f3374:
	push_s blink
L_8f3376:
	bl.d L_8ca1b0
L_8f337a:
	push_s r13
L_8f337c:
	mov_s r13,r0
L_8f337e:
	ldb r0,[r0, 0x9c]
L_8f3382:
	brne_s r0,0,L_8f338a
L_8f3384:
	bl L_8c307c
L_8f3388:
	breq_s r0,0,L_8f33a2
	.global L_8f338a
L_8f338a:
	mov_s r2,0x100d08c
L_8f3390:
	mov_s r0,0xb
L_8f3392:
	bl.d L_8edfb0
L_8f3396:
	mov_s r1,0x2
L_8f3398:
	mov_s r0,0x0
L_8f339a:
	bl.d L_8f0610
L_8f339e:
	ldb_s r1,[r13,0x10]
L_8f33a0:
	b_s L_8f33b4
	.global L_8f33a2
L_8f33a2:
	mov_s r0,0xd
L_8f33a4:
	bl.d L_8e3a08
L_8f33a8:
	mov_s r1,0x0
L_8f33aa:
	mov_s r0,r13
L_8f33ac:
	bl.d L_8edbbc
L_8f33b0:
	add r0,r0,0x234
	.global L_8f33b4
L_8f33b4:
	b L_8c033c
