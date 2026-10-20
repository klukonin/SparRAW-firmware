/* mid_list__any_in_state2 @ 0x8c307c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__validate_scan, l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74, l2_mgr__wmi_cmd_handler_set_ssid, l2_mgr__wmi_cmd_handler_start_listen_8f3374, l2_mgr__wmi_cmd_handler_start_search_8f33b8, validate_connect
 * Зовёт сам: __ld_r13_ret, iter__has_more, iter__init, iter__next
 */
	.section .text.mid_list__any_in_state2,"ax",@progbits
	.global mid_list__any_in_state2
mid_list__any_in_state2:
	.global L_8c307c
L_8c307c:
	push_s blink
L_8c307e:
	push_s r13
L_8c3080:
	sub_s sp,sp,0x4
L_8c3082:
	mov_s r13,sp
L_8c3084:
	mov_s r1,0x8058d0
L_8c308a:
	bl.d L_8e1138
L_8c308e:
	mov_s r0,r13
L_8c3090:
	b_s L_8c30a6
	.global L_8c3092
L_8c3092:
	bl.d L_8db188
L_8c3096:
	mov_s r0,r13
L_8c3098:
	ld_s r0,[r0,0x4c]
L_8c309a:
	cmp_s r0,0x2
L_8c309c:
	mov_s r0,0x1
L_8c309e:
	sub_s.ne r0,r0,r0
L_8c30a0:
	extb.f 0x0,r0
L_8c30a4:
	bne_s L_8c30b2
	.global L_8c30a6
L_8c30a6:
	bl.d L_8cb674
L_8c30aa:
	mov_s r0,r13
L_8c30ac:
	brne_s r0,0,L_8c3092
L_8c30ae:
	mov_s r0,0x0
L_8c30b0:
	b_s L_8c30b4
	.global L_8c30b2
L_8c30b2:
	mov_s r0,0x1
	.global L_8c30b4
L_8c30b4:
	b.d L_8c033c
L_8c30b8:
	add_s sp,sp,0x4
L_8c30ba:
	nop_s
