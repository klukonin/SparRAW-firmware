/* hwd_abif__rx_table_index_force_en_get @ 0x8cf59c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_sysapi_get_rx_energy_data_free_run, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_table_index_force_en_get
hwd_abif__rx_table_index_force_en_get:
	.global L_8cf59c
L_8cf59c:
	mov_s r0,0x88a200
L_8cf5a2:
	ld_s r0,[r0,0x4]
L_8cf5a4:
	j_s.d [blink]
L_8cf5a6:
	bmsk_s r0,r0,0x0
