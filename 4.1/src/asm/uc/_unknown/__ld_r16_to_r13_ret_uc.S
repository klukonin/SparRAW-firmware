/* __ld_r16_to_r13_ret_uc @ 0x920274, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_cfg__apply, brp__program_and_measure, brp_copy_step, brp_flow_step, cf_end__send_frame, get_selected_rf_sector_index_cmd_handler, grant_detect_step, mac_counter__program_0008, nav_db__update, rate_search__pick_tx_params
 */
	.section .text.__ld_r16_to_r13_ret_uc,"ax",@progbits
	.global __ld_r16_to_r13_ret_uc
__ld_r16_to_r13_ret_uc:
	.global L_920274
L_920274:
	mov_s r12,0x4
L_920276:
	mov_s r13,0x10
L_920278:
	/* b_s 0x009202c0 */
	.byte 0x24,0xf0
L_92027a:
	nop_s
