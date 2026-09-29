/* __ld_r16_to_r13_ret @ 0x8c0324, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler, L2MGR__system_state_evt_handler, POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, PS_CONNECTION__assoc_ntf, RADIO_MGR__lock_secondary, SDP__sdp_drive_value, SDP__sdp_init__2, STREAM_MGR, SW_TX_MGMT_API__packet_release, TX_API__call_mem_pool_alloc_err_cb
 */
	.section .text.__ld_r16_to_r13_ret,"ax",@progbits
	.global __ld_r16_to_r13_ret
__ld_r16_to_r13_ret:
	.global L_8c0324
L_8c0324:
	mov_s r12,0x4
	.global L_8c0326
L_8c0326:
	mov_s r13,0x10
L_8c0328:
	/* b_s 0x008c0370 */
	.byte 0x24,0xf0
L_8c032a:
	nop_s
