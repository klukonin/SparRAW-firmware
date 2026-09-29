/* __st_r14_to_r13 @ 0x8c02c4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, POWER_MNGR__init, POWER_MNGR__wmi_traffic_deferral_cmd, PS_CONNECTION_MGR__psc_resp_tx_wb_cb, PS_CONNECTION__disassoc_ntf, STREAM_MGR__ready_for_modify, TX_API__alloc_tx_payload, TX_API__free_memory
 */
	.section .text.__st_r14_to_r13,"ax",@progbits
	.global __st_r14_to_r13
__st_r14_to_r13:
	.global L_8c02c4
L_8c02c4:
	st.a r14,[sp,-0x4]
L_8c02c8:
	j_s.d [blink]
L_8c02ca:
	st.a r13,[sp,-0x4]
L_8c02ce:
	nop_s
L_8c02d0:
	j_s [blink]
L_8c02d2:
	nop_s
