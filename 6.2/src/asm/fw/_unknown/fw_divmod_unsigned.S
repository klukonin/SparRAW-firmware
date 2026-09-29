/* fw_divmod_unsigned @ 0x8c02d4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__build_tx_sector_list, brd_if__chunk_offset, brd_if_multi_array__get_block_info, calib_silent_rssi_sparrow__correction_alg, connection__bf_id_at_6c, div_round_up, dmg_bcon__rx_handler, hwd_phy_rx_sar_rssi_measure, l2_mgr__connect_multi_omni, link_stats__calc_goodput
 * Зовёт сам: fw_divmod_signed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_divmod_unsigned
fw_divmod_unsigned:
	.global L_8c02d4
L_8c02d4:
	b.d L_8c02f0
L_8c02d8:
	mov r8,0x0
