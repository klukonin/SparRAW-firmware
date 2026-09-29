/* __ld_r13_ret @ 0x8c033c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: BUILDER_push_dmg_parameters, CALIB_MNGR__update_pcp_ap, PS_ASSOC_SM__ps_schd_reenter_extend, PS_CONNECTION_MGR__psc_req_tx_wb_cb, PS_CONNECTION_MGR__psc_resp_tx_wb_cb, PS_CONNECTION__psc_complete, RADIO_MGR__lock_primary, RADIO_MGR__remove_request, RADIO_MGR__unlock, RADIO_MGR__unset_primary_channel
 */
	.section .text.__ld_r13_ret,"ax",@progbits
	.global __ld_r13_ret
__ld_r13_ret:
	.global L_8c033c
L_8c033c:
	mov_s r12,0x4
	.global L_8c033e
L_8c033e:
	mov_s r13,0x4
L_8c0340:
	/* b_s 0x008c0378 */
	.byte 0x1c,0xf0
L_8c0342:
	nop_s
