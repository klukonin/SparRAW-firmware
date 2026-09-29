/* L2MGR__system_state_evt_handler @ 0x8e3a08, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   L2MGR::system_state_evt_handler %s , is idle = %s, is AP = %s
 * Зовут его: conn_main_sm__report_disc_state, l2_mgr__connect, l2_mgr__pcp_start, l2_mgr__pcp_stop, l2_mgr__scan_complete_handle, l2_mgr__wmi_cmd_handler_start_listen_8f3374, l2_mgr__wmi_cmd_handler_start_search_8f33b8, l2_mgr__wmi_scan_cmd, l2mgr__disconnect_done, l2mgr__init
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, POWER_MNGR__system_state_evt_handler, __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__system_state_evt_handler, fw_log__emit3_nonl, l2_mgr__chk_sys_idle, mid__state_is_2_or_3, phy_monitor__on_system_state, temp_sense__on_system_state
 */
	.section .text.L2MGR__system_state_evt_handler,"ax",@progbits
	.global L2MGR__system_state_evt_handler
L2MGR__system_state_evt_handler:
	.global L_8e3a08
L_8e3a08:
	push_s blink
L_8e3a0a:
	bl L_8c02bc
L_8e3a0e:
	mov_s r14,r0
L_8e3a10:
	bl.d L_8c5838
L_8e3a14:
	mov_s r16,r1
L_8e3a16:
	mov_s r13,r0
L_8e3a18:
	bl.d L_8d73c4
L_8e3a1c:
	mov_s r0,0x0
L_8e3a1e:
	mov_s r15,r0
L_8e3a20:
	mov_s r2,0x100c3cc
L_8e3a26:
	mov_s r0,0x800fbc
L_8e3a2c:
	ld.as r3,[r0,r14]
L_8e3a30:
	brne r13,0x1,L_8e3a3e
L_8e3a34:
	mov r4,0x100c40c
L_8e3a3c:
	b_s L_8e3a46
	.global L_8e3a3e
L_8e3a3e:
	mov r4,0x100c410
	.global L_8e3a46
L_8e3a46:
	brne r15,0x1,L_8e3a54
L_8e3a4a:
	mov r5,0x100c40c
L_8e3a52:
	b_s L_8e3a5c
	.global L_8e3a54
L_8e3a54:
	mov r5,0x100c410
	.global L_8e3a5c
L_8e3a5c:
	mov_s r0,0x0
L_8e3a5e:
	bl.d L_8ee0e8
L_8e3a62:
	mov_s r1,0x2
L_8e3a64:
	mov_s r0,r14
L_8e3a66:
	mov_s r1,r13
L_8e3a68:
	bl.d L_8e38fc
L_8e3a6c:
	mov_s r2,r15
L_8e3a6e:
	mov_s r0,r14
L_8e3a70:
	mov_s r1,r13
L_8e3a72:
	mov_s r2,r15
L_8e3a74:
	bl.d L_8e3714
L_8e3a78:
	mov_s r3,r16
L_8e3a7a:
	mov_s r0,r14
L_8e3a7c:
	bl.d L_8e3614
L_8e3a80:
	mov_s r1,r16
L_8e3a82:
	mov_s r0,r14
L_8e3a84:
	bl.d L_8e394c
L_8e3a88:
	mov_s r1,r16
L_8e3a8a:
	mov_s r0,0x84edf4
L_8e3a90:
	mov_s r1,r14
L_8e3a92:
	mov_s r2,r13
L_8e3a94:
	bl.d L_8e3880
L_8e3a98:
	mov_s r3,r15
L_8e3a9a:
	.byte 0x8d,0x00
