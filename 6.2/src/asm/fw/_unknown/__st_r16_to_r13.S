/* __st_r16_to_r13 @ 0x8c01dc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler, FWQ_TX_AVAILABILITY__remove_packet, POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, SDP__sdp_drive_value, SDP__sdp_init__2, STREAM_MGR, STREAM_MGR__2, STREAM_MGR__ADD, STREAM_MGR__ready_for_modify, SW_TX_MGMT_API__packet_release
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r16_to_r13
__st_r16_to_r13:
	.global L_8c01dc
L_8c01dc:
	st.a r16,[sp,-0x4]
