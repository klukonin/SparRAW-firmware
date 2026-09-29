/* fw_log__emit1 @ 0x8edfcc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, POWER_MNGR__wmi_traffic_deferral_cmd, PS_ASSOC_SM__ps_cancel_schd_reenter, PS_ASSOC_SM__ps_schd_reenter_extend, PS_CFG_SCHEME__switch_active_ps_profile, PS_CONNECTION_MGR__psc_req_tx_wb_cb, PS_CONNECTION_MGR__psc_resp_tx_wb_cb, PS_CONNECTION__disassoc_ntf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__commit
 */
	.section .text.fw_log__emit1,"ax",@progbits
	.global fw_log__emit1
fw_log__emit1:
	.global L_8edfcc
L_8edfcc:
	push_s blink
L_8edfce:
	bl L_8c02c4
L_8edfd2:
	mov_s r13,0x843900
L_8edfd8:
	add_s r14,r13,0x4
L_8edfda:
	ldb_s r14,[r14,r0]
L_8edfdc:
	bbit0 r14,r1,L_8edff4
L_8edfe0:
	ld_s r14,[r13]
L_8edfe2:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8edfe4:
	bmsk_s r14,r14,0x9
L_8edfe6:
	add2_s r13,r13,r14
L_8edfe8:
	st_s r3,[r13,0x14]
L_8edfea:
	mov_s r3,0x1
L_8edfec:
	bl.d L_8ee134
L_8edff0:
	mov r4,0x0
	.global L_8edff4
L_8edff4:
	b L_8c0334
