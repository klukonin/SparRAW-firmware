/* abif__get_rx_table_index_force_val @ 0x8cf5ec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_leakage__sweep, calib_lo_leakage_step, calib_lo_leakage_substep, hw_sysapi_get_rx_energy_data_free_run, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__get_rx_table_index_force_val
abif__get_rx_table_index_force_val:
	.global L_8cf5ec
L_8cf5ec:
	mov_s r0,0x88a200
L_8cf5f2:
	ld_s r0,[r0,0x4]
L_8cf5f4:
	lsr_s r0,r0
L_8cf5f6:
	j_s.d [blink]
L_8cf5f8:
	bmsk_s r0,r0,0x5
L_8cf5fa:
	nop_s
