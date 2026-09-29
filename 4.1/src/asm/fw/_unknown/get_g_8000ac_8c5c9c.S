/* get_g_8000ac_8c5c9c @ 0x8c5c9c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__send_pcp_start_status_evt, l2mgr__send_disconnect_evt, l2mgr__send_host_event, l2mgr__send_pcp_stopped, l2mgr__send_scan_complete_evt, tx_probe__send_scan_complete
 */
	.section .text.get_g_8000ac_8c5c9c,"ax",@progbits
	.global get_g_8000ac_8c5c9c
get_g_8000ac_8c5c9c:
	.global L_8c5c9c
L_8c5c9c:
	ld.as r1,[gp,-0x31]
L_8c5ca0:
	bclr r1,r1,r0
L_8c5ca4:
	j_s.d [blink]
L_8c5ca6:
	st.as r1,[gp,-0x31]
L_8c5caa:
	nop_s
