/* __st_r16_to_r13 @ 0x8c02bc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler, L2MGR__system_state_evt_handler, POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, PS_CONNECTION__assoc_ntf, RADIO_MGR__lock_secondary, SDP__sdp_drive_value, SDP__sdp_init__2, STREAM_MGR, SW_TX_MGMT_API__packet_release, TX_API__call_mem_pool_alloc_err_cb
 */
	.section .text.__st_r16_to_r13,"ax",@progbits
	.global __st_r16_to_r13
__st_r16_to_r13:
	.global L_8c02bc
L_8c02bc:
	st.a r16,[sp,-0x4]
