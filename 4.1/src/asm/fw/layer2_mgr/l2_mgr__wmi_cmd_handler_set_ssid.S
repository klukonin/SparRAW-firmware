/* l2_mgr__wmi_cmd_handler_set_ssid @ 0x8f3318, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_set_ssid - If connected or in GO mode don't change the SSID.
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, mid__set_ssid, mid_list__any_in_state2, mid_list__by_mid
 */
	.section .text.l2_mgr__wmi_cmd_handler_set_ssid,"ax",@progbits
	.global l2_mgr__wmi_cmd_handler_set_ssid
l2_mgr__wmi_cmd_handler_set_ssid:
	.global L_8f3318
L_8f3318:
	push_s blink
L_8f331a:
	bl L_8c02c4
L_8f331e:
	mov_s r14,r0
L_8f3320:
	bl.d L_8ca1b0
L_8f3324:
	mov_s r0,r1
L_8f3326:
	add3 r13,r0,0x9
L_8f332a:
	ldb r0,[r13, 0x54]
L_8f332e:
	brne_s r0,0,L_8f3336
L_8f3330:
	bl L_8c307c
L_8f3334:
	breq_s r0,0,L_8f3346
	.global L_8f3336
L_8f3336:
	mov_s r2,0x100cc24
L_8f333c:
	mov_s r0,0xb
L_8f333e:
	bl.d L_8edfb0
L_8f3342:
	mov_s r1,0x2
L_8f3344:
	b_s L_8f3350
	.global L_8f3346
L_8f3346:
	add_s r1,r14,0x4
L_8f3348:
	mov_s r0,r13
L_8f334a:
	bl.d L_8e2100
L_8f334e:
	ld_s r2,[r14]
	.global L_8f3350
L_8f3350:
	b L_8c0334
