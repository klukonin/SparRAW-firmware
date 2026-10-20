/* fw_log__emit0 @ 0x8edfb0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler, CALIB_MNGR__update_pcp_ap, CALIB_MNGR__update_sys_state, FWQ_TX_AVAILABILITY__init, LMAC_IF__rs_started, MAINTAIN_SM__FBF_DELAYED, MAINTAIN_SM__OPEN, POWER_MNGR__init, POWER_MNGR__system_state_evt_handler, PS_CONNECTION_MGR__psc_req_tx_wb_cb
 * Зовёт сам: fw_log__commit
 */
	.section .text.fw_log__emit0,"ax",@progbits
	.global fw_log__emit0
fw_log__emit0:
	.global L_8edfb0
L_8edfb0:
	push_s blink
L_8edfb2:
	mov_s r3,0x843904
L_8edfb8:
	ldb_s r3,[r3,r0]
L_8edfba:
	btst r3,r1
L_8edfbe:
	sub_s.ne r3,r3,r3
L_8edfc0:
	bl.ne.d L_8ee134
L_8edfc4:
	mov.ne r4,r3
L_8edfc8:
	pop_s blink
L_8edfca:
	j_s [blink]
