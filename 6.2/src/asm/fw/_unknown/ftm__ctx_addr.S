/* ftm__ctx_addr @ 0x8ccf04, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down_notif, aoa__validate_request, ftm_main_sm__action_abort_session, l2_mgr__tof_config_responder, l2_mgr__tof_get_capabilities, lmac_if_aoa_meas_evt_handler, state_sm_8034c0__action_8f0a24
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm__ctx_addr
ftm__ctx_addr:
	.global L_8ccf04
L_8ccf04:
	mov_s r0,0x806650
L_8ccf0a:
	j_s [blink]
