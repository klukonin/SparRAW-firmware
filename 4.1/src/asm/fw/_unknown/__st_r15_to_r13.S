/* __st_r15_to_r13 @ 0x8c02c0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile, PS_CONNECTION_MGR__psc_req_tx_wb_cb, STREAM_MGR__2, SW_TX_MGMT_API__link_up_evt, TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, TEMPERATURE_SERVICE__radio_locked_cb, TX_API__callback_and_release, app_ie__print_ies, app_ies__set_probe_req_ies, awake_peers__log
 */
	.section .text.__st_r15_to_r13,"ax",@progbits
	.global __st_r15_to_r13
__st_r15_to_r13:
	.global L_8c02c0
L_8c02c0:
	st.a r15,[sp,-0x4]
