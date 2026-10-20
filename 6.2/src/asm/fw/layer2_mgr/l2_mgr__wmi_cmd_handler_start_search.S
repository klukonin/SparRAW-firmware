/* l2_mgr__wmi_cmd_handler_start_search @ 0x8fbd90, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_start_search - If connected or in GO mode it's prohibit to run the search flow.
 * Зовут его: wmi__start_search_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, find_mngr__enter_search, fw_log_emit0, fw_sysassert_fatal, l2mgr__send_search_started, mid_list__any_in_state2_fw, mid_list__by_mid_fw, sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_start_search
l2_mgr__wmi_cmd_handler_start_search:
	.global L_8fbd90
L_8fbd90:
	push_s blink
L_8fbd92:
	bl.d L_8cc3dc
L_8fbd96:
	push_s r13
L_8fbd98:
	mov.f r13,r0
L_8fbd9c:
	beq_s L_8fbdc0
	.global L_8fbd9e
L_8fbd9e:
	ldb r0,[r13, 0x9c]
L_8fbda2:
	brne_s r0,0,L_8fbdaa
L_8fbda4:
	bl L_8c37ac
L_8fbda8:
	breq_s r0,0,L_8fbdce
	.global L_8fbdaa
L_8fbdaa:
	mov_s r1,0x100e1d4
L_8fbdb0:
	bl.d L_8dcba8
L_8fbdb4:
	mov_s r0,0x1b
L_8fbdb6:
	mov_s r0,0x1
L_8fbdb8:
	bl.d L_8f8d74
L_8fbdbc:
	ldb_s r1,[r13,0x10]
L_8fbdbe:
	b_s L_8fbde0
	.global L_8fbdc0
L_8fbdc0:
	mov_s r0,blink
L_8fbdc2:
	mov_s r1,0x16c3
L_8fbdc8:
	bl L_8c9b28
L_8fbdcc:
	b_s L_8fbd9e
	.global L_8fbdce
L_8fbdce:
	mov_s r0,0xe
L_8fbdd0:
	bl.d L_8e8a14
L_8fbdd4:
	mov_s r1,0x0
L_8fbdd6:
	mov_s r0,r13
L_8fbdd8:
	bl.d L_8f852c
L_8fbddc:
	add r0,r0,0x234
	.global L_8fbde0
L_8fbde0:
	b L_8c025c
