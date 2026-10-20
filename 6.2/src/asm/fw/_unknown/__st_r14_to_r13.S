/* __st_r14_to_r13 @ 0x8c01e4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, POWER_MNGR__wmi_traffic_deferral_cmd, PS_CONNECTION__disassoc_ntf, TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, TX_API__alloc_tx_payload, TX_API__free_memory, TX_CTRL_API__flush_connection, abif__ack_unmask_pll_unlock_irq, abif__power_up_analog
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r14_to_r13
__st_r14_to_r13:
	.global L_8c01e4
L_8c01e4:
	st.a r14,[sp,-0x4]
