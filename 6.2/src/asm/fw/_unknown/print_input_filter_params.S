/* print_input_filter_params @ 0x8f7490, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   print_input_filter_params: filter params: sta_id = 0x%x, qid = 0x%x,  is_cp = 0x%x
 *   print_input_filter_params: filter params:mcs = 0x%x, is_omni = 0x%x, timeout_usec = 0x%x
 * Зовут его: fw_sysapi_mgr__mac_ampdu_statistics_cmd_start, fw_sysapi_mgr__phy_rx_statistics_cmd_start, fw_sysapi_mgr__start_energy_statistics, fw_sysapi_mgr__start_plcp_header, get_rx_pkt_phy_data_cmd_start
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global print_input_filter_params
print_input_filter_params:
	.global L_8f7490
L_8f7490:
	push_s blink
L_8f7492:
	bl.d L_8c01e4
L_8f7496:
	mov_s r0,0x20
L_8f7498:
	mov_s r13,r1
L_8f749a:
	mov_s r14,r2
L_8f749c:
	ldb r4,[r13, 0x2]
L_8f74a0:
	mov_s r1,0x1012394
L_8f74a6:
	ldb_s r2,[r13]
L_8f74a8:
	bl.d L_8dcd00
L_8f74ac:
	ldb_s r3,[r13,0x1]
L_8f74ae:
	mov_s r1,0x10123e8
L_8f74b4:
	ldb_s r2,[r13,0x3]
L_8f74b6:
	mov_s r0,0x20
L_8f74b8:
	ldb_s r3,[r13,0x4]
L_8f74ba:
	bl.d L_8dcd00
L_8f74be:
	mov_s r4,r14
L_8f74c0:
	b L_8c0254
