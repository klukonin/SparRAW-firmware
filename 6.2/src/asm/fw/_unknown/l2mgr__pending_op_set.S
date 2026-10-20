/* l2mgr__pending_op_set @ 0x8e6358, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__action_step, l2_mgr__connect, l2_mgr__pcp_start, l2_mgr__pcp_stop, l2_mgr__wmi_cmd_handler_del_sta, l2_mgr__wmi_scan_cmd, l2mgr__disconnect_sta
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__pending_op_set
l2mgr__pending_op_set:
	.global L_8e6358
L_8e6358:
	ld.as r1,[gp,-0x35]
L_8e635c:
	bset r1,r1,r0
L_8e6360:
	j_s.d [blink]
L_8e6362:
	st.as r1,[gp,-0x35]
L_8e6366:
	nop_s
