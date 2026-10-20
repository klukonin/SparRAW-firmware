/* l2mgr__pending_op_clear @ 0x8c6a30, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__send_pcp_start_status_evt, l2mgr__send_disconnect_evt, l2mgr__send_host_event, l2mgr__send_pcp_stopped, l2mgr__send_scan_complete_evt, pcp_psc_sm__send_usol_psc_resp_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__pending_op_clear
l2mgr__pending_op_clear:
	.global L_8c6a30
L_8c6a30:
	ld.as r1,[gp,-0x35]
L_8c6a34:
	bclr r1,r1,r0
L_8c6a38:
	j_s.d [blink]
L_8c6a3a:
	st.as r1,[gp,-0x35]
L_8c6a3e:
	nop_s
