/* fw_sysapi_mgr__stop_sysapi_cmd @ 0x8f9bd0, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_sysapi_mgr::stop_sysapi_cmd: Failed, sysapi id = %d is not pennding
 * Зовут его: field_rw_0x20__8f3538, fw_sysapi_mgr__channel_estimation_cmd_complete, fw_sysapi_mgr__phy_rx_statistics_cmd_start, get_rx_pkt_phy_data_cmd_complete, l2_mgr__high_false_alarm_secondary_lock_cb, mac_ampdu_statistics_timeout_cb, scan_mngr__dwelling_done
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_req__is_claimable, fw_log_emit1, mac_read_tsf64, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__stop_sysapi_cmd
fw_sysapi_mgr__stop_sysapi_cmd:
	.global L_8f9bd0
L_8f9bd0:
	push_s blink
L_8f9bd2:
	bl.d L_8c01e4
L_8f9bd6:
	mov_s r4,r1
L_8f9bd8:
	bl.d L_8f5cac
L_8f9bdc:
	mov_s r14,r0
L_8f9bde:
	breq_s r0,0,L_8f9be6
L_8f9be0:
	ld_s r0,[r14,0x20]
L_8f9be2:
	brne r0,0x2,L_8f9bf8
	.global L_8f9be6
L_8f9be6:
	mov_s r1,0x1012a64
L_8f9bec:
	mov_s r0,0x10
L_8f9bee:
	bl.d L_8dcc10
L_8f9bf2:
	mov_s r2,r4
L_8f9bf4:
	mov_s r0,0x0
L_8f9bf6:
	b_s L_8f9c16
	.global L_8f9bf8
L_8f9bf8:
	ld_s r0,[r14,0x10]
L_8f9bfa:
	mov_s r13,0x0
L_8f9bfc:
	breq_s r0,0,L_8f9c04
L_8f9bfe:
	bl L_8c8de0
L_8f9c02:
	st_s r13,[r14,0x10]
	.global L_8f9c04
L_8f9c04:
	mov_s r13,0x1
L_8f9c06:
	st_s r13,[r14,0x1c]
L_8f9c08:
	add r1,r14,0x2c
L_8f9c0c:
	mov_s r0,0x0
L_8f9c0e:
	bl.d L_8e9900
L_8f9c12:
	mov_s r2,r0
L_8f9c14:
	mov_s r0,r13
	.global L_8f9c16
L_8f9c16:
	b L_8c0254
L_8f9c1a:
	nop_s
