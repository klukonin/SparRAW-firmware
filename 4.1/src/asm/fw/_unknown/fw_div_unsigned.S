/* fw_div_unsigned @ 0x8c03b4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__chunk_offset, brd_if_multi_array__get_block_info, calib_bb_gain_dc__vga_dc_fine, conn__metric_average, div_round_up, link_lost_diag_part2, link_stats__calc_goodput, link_stats__calc_throughput_mbps, map_tx_sectors, mem_pool__allocate
 * Зовёт сам: fw_divmod_signed
 */
	.section .text.fw_div_unsigned,"ax",@progbits
	.global fw_div_unsigned
fw_div_unsigned:
	.global L_8c03b4
L_8c03b4:
	b.d L_8c03d0
L_8c03b8:
	mov r8,0x0
