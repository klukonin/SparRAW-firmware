/* __ld_r14_to_r13_ret @ 0x8c0334, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, POWER_MNGR__init, POWER_MNGR__wmi_traffic_deferral_cmd, PS_CONNECTION_MGR__psc_resp_tx_wb_cb, PS_CONNECTION__disassoc_ntf, STREAM_MGR__ready_for_modify, TX_API__alloc_tx_payload, TX_API__free_memory
 */
	.section .text.__ld_r14_to_r13_ret,"ax",@progbits
	.global __ld_r14_to_r13_ret
__ld_r14_to_r13_ret:
	.global L_8c0334
L_8c0334:
	mov_s r12,0x4
	.global L_8c0336
L_8c0336:
	mov_s r13,0x8
