/* sys_state__broadcast @ 0x8e8a14, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__connect, l2_mgr__pcp_start, l2_mgr__pcp_stop, l2_mgr__scan_complete_handle, l2_mgr__wmi_cmd_handler_start_listen, l2_mgr__wmi_cmd_handler_start_search, l2_mgr__wmi_scan_cmd, l2mgr__init, l2mgr__send_data_port_open_evt, l2mgr__send_discovery_stopped
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__system_state_evt_handler, l2_mgr__chk_sys_idle, mid__state_is_2_or_3, phy_monitor__on_system_state, power_mgr_ut__dispatch, scan_mngr__system_state_evt_handler, temp_sense__on_system_state
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sys_state__broadcast
sys_state__broadcast:
	.global L_8e8a14
L_8e8a14:
	push_s blink
L_8e8a16:
	bl L_8c01dc
L_8e8a1a:
	mov_s r14,r0
L_8e8a1c:
	bl.d L_8c6508
L_8e8a20:
	mov_s r13,r1
L_8e8a22:
	mov_s r16,r0
L_8e8a24:
	bl.d L_8da488
L_8e8a28:
	mov_s r0,0x0
L_8e8a2a:
	mov_s r15,r0
L_8e8a2c:
	mov_s r0,r14
L_8e8a2e:
	mov_s r1,r16
L_8e8a30:
	bl.d L_8e890c
L_8e8a34:
	mov_s r2,r15
L_8e8a36:
	mov_s r0,r14
L_8e8a38:
	mov_s r1,r16
L_8e8a3a:
	mov_s r2,r15
L_8e8a3c:
	bl.d L_8e8774
L_8e8a40:
	mov_s r3,r13
L_8e8a42:
	mov_s r0,r14
L_8e8a44:
	bl.d L_8e8688
L_8e8a48:
	mov_s r1,r13
L_8e8a4a:
	mov_s r0,r14
L_8e8a4c:
	bl.d L_8e8954
L_8e8a50:
	mov_s r1,r13
L_8e8a52:
	mov_s r0,0x84e7e0
L_8e8a58:
	mov_s r1,r14
L_8e8a5a:
	mov_s r2,r16
L_8e8a5c:
	bl.d L_8e889c
L_8e8a60:
	mov_s r3,r15
L_8e8a62:
	mov_s r0,r14
L_8e8a64:
	bl.d L_8e89f0
L_8e8a68:
	mov_s r1,r13
L_8e8a6a:
	b L_8c0244
L_8e8a6e:
	nop_s
