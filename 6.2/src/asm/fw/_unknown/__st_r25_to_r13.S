/* __st_r25_to_r13 @ 0x8c01b8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, boot_fill_addr_tables, calib_sar_step, handle_rf_sets_info, hwf_calib_bb_gain_rows, marlon_r_if_class__load_brd_parameters_section, marlon_r_if_class__rf_write_with_block_retries
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r25_to_r13
__st_r25_to_r13:
	.global L_8c01b8
L_8c01b8:
	st.a r25,[sp,-0x4]
