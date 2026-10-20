/* get_g_8000ac_8e15e0 @ 0x8e15e0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect, l2_mgr__pcp_start, l2_mgr__pcp_stop, l2_mgr__wmi_scan_cmd, l2mgr__disconnect_sta, wmi_handler_disconnect_log
 */
	.section .text.get_g_8000ac_8e15e0,"ax",@progbits
	.global get_g_8000ac_8e15e0
get_g_8000ac_8e15e0:
	.global L_8e15e0
L_8e15e0:
	ld.as r1,[gp,-0x31]
L_8e15e4:
	bset r1,r1,r0
L_8e15e8:
	j_s.d [blink]
L_8e15ea:
	st.as r1,[gp,-0x31]
L_8e15ee:
	nop_s
