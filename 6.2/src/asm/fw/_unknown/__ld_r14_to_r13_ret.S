/* __ld_r14_to_r13_ret @ 0x8c0254, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, POWER_MNGR__wmi_traffic_deferral_cmd, PS_CONNECTION__disassoc_ntf, TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, TX_API__alloc_tx_payload, TX_API__free_memory, TX_CTRL_API__flush_connection, abif__ack_unmask_pll_unlock_irq, abif__power_up_analog
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __ld_r14_to_r13_ret
__ld_r14_to_r13_ret:
	.global L_8c0254
L_8c0254:
	mov_s r12,0x4
	.global L_8c0256
L_8c0256:
	mov_s r13,0x8
L_8c0258:
	b_s L_8c0296
L_8c025a:
	nop_s
