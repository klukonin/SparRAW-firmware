/* l2_mgr__wmi_cmd_handler_start_listen @ 0x8fbd3c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_start_listen - If connected or in GO mode do nothing on listen request.
 * Зовут его: wmi__start_listen_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, find_mngr__enter_listen, fw_log_emit0, fw_sysassert_fatal, l2mgr__send_listen_started, mid_list__any_in_state2_fw, mid_list__by_mid_fw, sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_start_listen
l2_mgr__wmi_cmd_handler_start_listen:
	.global L_8fbd3c
L_8fbd3c:
	push_s blink
L_8fbd3e:
	bl.d L_8cc3dc
L_8fbd42:
	push_s r13
L_8fbd44:
	mov.f r13,r0
L_8fbd48:
	beq_s L_8fbd6c
	.global L_8fbd4a
L_8fbd4a:
	ldb r0,[r13, 0x9c]
L_8fbd4e:
	brne_s r0,0,L_8fbd56
L_8fbd50:
	bl L_8c37ac
L_8fbd54:
	breq_s r0,0,L_8fbd7a
	.global L_8fbd56
L_8fbd56:
	mov_s r1,0x100e128
L_8fbd5c:
	bl.d L_8dcba8
L_8fbd60:
	mov_s r0,0x2b
L_8fbd62:
	mov_s r0,0x0
L_8fbd64:
	bl.d L_8f89a4
L_8fbd68:
	ldb_s r1,[r13,0x10]
L_8fbd6a:
	b_s L_8fbd8c
	.global L_8fbd6c
L_8fbd6c:
	mov_s r0,blink
L_8fbd6e:
	mov_s r1,0x16c2
L_8fbd74:
	bl L_8c9b28
L_8fbd78:
	b_s L_8fbd4a
	.global L_8fbd7a
L_8fbd7a:
	mov_s r0,0xd
L_8fbd7c:
	bl.d L_8e8a14
L_8fbd80:
	mov_s r1,0x0
L_8fbd82:
	mov_s r0,r13
L_8fbd84:
	bl.d L_8f5f14
L_8fbd88:
	add r0,r0,0x234
	.global L_8fbd8c
L_8fbd8c:
	b L_8c025c
