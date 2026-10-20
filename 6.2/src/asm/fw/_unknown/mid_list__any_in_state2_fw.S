/* mid_list__any_in_state2_fw @ 0x8c37ac, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__validate_scan, l2_mgr__wmi_cmd_handler_p2p_cfg, l2_mgr__wmi_cmd_handler_start_listen, l2_mgr__wmi_cmd_handler_start_search, l2_mgr__wmi_scan_cmd, validate_connect
 * Зовёт сам: __ld_r13_to_r13_ret, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__any_in_state2_fw
mid_list__any_in_state2_fw:
	.global L_8c37ac
L_8c37ac:
	push_s blink
L_8c37ae:
	push_s r13
L_8c37b0:
	sub_s sp,sp,0x4
L_8c37b2:
	mov_s r13,sp
L_8c37b4:
	mov_s r1,0x804e70
L_8c37ba:
	bl.d L_8e5df4
L_8c37be:
	mov_s r0,r13
L_8c37c0:
	b_s L_8c37d6
	.global L_8c37c2
L_8c37c2:
	bl.d L_8df438
L_8c37c6:
	mov_s r0,r13
L_8c37c8:
	ld_s r0,[r0,0x4c]
L_8c37ca:
	cmp_s r0,0x2
L_8c37cc:
	mov_s r0,0x1
L_8c37ce:
	sub_s.ne r0,r0,r0
L_8c37d0:
	extb.f 0x0,r0
L_8c37d4:
	bne_s L_8c37e2
	.global L_8c37d6
L_8c37d6:
	bl.d L_8cdcb8
L_8c37da:
	mov_s r0,r13
L_8c37dc:
	brne_s r0,0,L_8c37c2
L_8c37de:
	mov_s r0,0x0
L_8c37e0:
	b_s L_8c37e4
	.global L_8c37e2
L_8c37e2:
	mov_s r0,0x1
	.global L_8c37e4
L_8c37e4:
	b.d L_8c025c
L_8c37e8:
	add_s sp,sp,0x4
L_8c37ea:
	nop_s
