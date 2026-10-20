/* l2_mgr__wmi_cmd_handler_set_ssid @ 0x8fbcec, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_set_ssid - If GO mode is already active don't change the SSID.
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, mid__set_ssid, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_set_ssid
l2_mgr__wmi_cmd_handler_set_ssid:
	.global L_8fbcec
L_8fbcec:
	push_s blink
L_8fbcee:
	push_s r13
L_8fbcf0:
	mov_s r13,r0
L_8fbcf2:
	bl.d L_8cc3dc
L_8fbcf6:
	mov_s r0,r1
L_8fbcf8:
	add_s r0,r0,0x48
L_8fbcfa:
	ldb r1,[r0, 0x54]
L_8fbcfe:
	breq_s r1,0,L_8fbd0e
L_8fbd00:
	mov_s r1,0x100dbb4
L_8fbd06:
	bl.d L_8dcba8
L_8fbd0a:
	mov_s r0,0x2b
L_8fbd0c:
	b_s L_8fbd16
	.global L_8fbd0e
L_8fbd0e:
	add_s r1,r13,0x4
L_8fbd10:
	bl.d L_8e70a8
L_8fbd14:
	ld_s r2,[r13]
	.global L_8fbd16
L_8fbd16:
	b L_8c025c
L_8fbd1a:
	nop_s
