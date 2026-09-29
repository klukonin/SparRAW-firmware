/* mid_list__find_by_kind @ 0x8cc424, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__get_status_hal, l2_mgr__pcp_stop, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, mid_list__remove_entry, mlme_sm__disconnect_ev_handle, scan_mngr__dband_beacon_ind
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__find_by_kind
mid_list__find_by_kind:
	.global L_8cc424
L_8cc424:
	push_s blink
L_8cc426:
	bl L_8c01e4
L_8cc42a:
	sub_s sp,sp,0x4
L_8cc42c:
	mov_s r13,r1
L_8cc42e:
	mov_s r14,sp
L_8cc430:
	add r1,r0,0x18
L_8cc434:
	bl.d L_8e5df4
L_8cc438:
	mov_s r0,r14
L_8cc43a:
	b_s L_8cc472
	.global L_8cc43c
L_8cc43c:
	bl.d L_8df438
L_8cc440:
	mov_s r0,r14
L_8cc442:
	breq_s r13,0,L_8cc460
L_8cc444:
	breq r13,0x1,L_8cc46a
L_8cc448:
	brne r13,0x2,L_8cc45c
L_8cc44c:
	add3 r2,r0,0x1e
L_8cc450:
	ld_s r1,[r2,0xc]
L_8cc452:
	brne_s r1,0,L_8cc47c
L_8cc454:
	ldb_s r1,[r2]
L_8cc456:
	brne r1,0x2,L_8cc472
L_8cc45a:
	b_s L_8cc47c
	.global L_8cc45c
L_8cc45c:
	mov_s r0,0x0
L_8cc45e:
	b_s L_8cc47c
	.global L_8cc460
L_8cc460:
	ldb r1,[r0, 0xf0]
L_8cc464:
	brne r1,0x1,L_8cc472
L_8cc468:
	b_s L_8cc47c
	.global L_8cc46a
L_8cc46a:
	ldb r1,[r0, 0xf0]
L_8cc46e:
	breq r1,0x2,L_8cc47c
	.global L_8cc472
L_8cc472:
	bl.d L_8cdcb8
L_8cc476:
	mov_s r0,r14
L_8cc478:
	brne_s r0,0,L_8cc43c
L_8cc47a:
	b_s L_8cc45c
	.global L_8cc47c
L_8cc47c:
	b.d L_8c0254
L_8cc480:
	add_s sp,sp,0x4
L_8cc482:
	nop_s
