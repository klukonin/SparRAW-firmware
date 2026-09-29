/* __st_r14_to_r13_uc @ 0x920214, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_bi_step, bcon_sweep_step_a, bf_sm__check_request_timeout, bf_sm__mark_sta_active, bf_sm__reset_slot_table, bf_sm__reset_sta_rate, bf_sm__start_request, bf_substate__txss_by_slot, bi__tsf_delta64, bi_tx__check_idle_and_start
 */
	.section .text.__st_r14_to_r13_uc,"ax",@progbits
	.global __st_r14_to_r13_uc
__st_r14_to_r13_uc:
	.global L_920214
L_920214:
	st.a r14,[sp,-0x4]
L_920218:
	j_s.d [blink]
L_92021a:
	st.a r13,[sp,-0x4]
L_92021e:
	nop_s
