/* __st_r16_to_r13_uc @ 0x92020c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_cfg__apply, brp__program_and_measure, brp_copy_step, brp_flow_step, cf_end__send_frame, get_selected_rf_sector_index_cmd_handler, grant_detect_step, mac_counter__program_0008, nav_db__update, rate_search__pick_tx_params
 */
	.section .text.__st_r16_to_r13_uc,"ax",@progbits
	.global __st_r16_to_r13_uc
__st_r16_to_r13_uc:
	.global L_92020c
L_92020c:
	st.a r16,[sp,-0x4]
