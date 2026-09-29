/* __st_r14_to_r13 @ 0x920234, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_bi_step, bf__reset_sta_slot, bf_clear_all_sta, bf_sm__run_sta, bf_sm__set_sta_state, bf_sm__txss_init_result, bi__tsf_delta64, bi_tx__check_idle_and_start_uc, brp__parse_request_fields, brp__read_rf_id
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global __st_r14_to_r13
__st_r14_to_r13:
	.global L_920234
L_920234:
	st.a r14,[sp,-0x4]
