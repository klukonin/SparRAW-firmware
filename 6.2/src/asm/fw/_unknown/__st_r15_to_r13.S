/* __st_r15_to_r13 @ 0x8c01e0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: BUILDER_push_dmg_parameters, PS_CFG_SCHEME__switch_active_ps_profile, PS_CONNECTION__assoc_ntf, PS_CONNECTION__awake_peer_ntf, STREAM_MGR__2, SW_TX_MGMT_API__link_up_evt, TX_API__callback_and_release, UT_HW_MODES_cmd_handler, WBE_DRIVER__link_down_notif, app_ie__print_ies
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r15_to_r13
__st_r15_to_r13:
	.global L_8c01e0
L_8c01e0:
	st.a r15,[sp,-0x4]
