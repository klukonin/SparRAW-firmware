/* __st_r15_to_r13_uc @ 0x920210, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bap_q_avail__check, bcon_sweep__next_sector, bf__abort_unexpected, bf_clear_all_sta, bf_sm__clear_sta, bf_sm__pop_request_fifo, bf_sm__step_by_state, bf_sm__trigger, bf_sm_step, bf_substate__dispatch_by_state
 */
	.section .text.__st_r15_to_r13_uc,"ax",@progbits
	.global __st_r15_to_r13_uc
__st_r15_to_r13_uc:
	.global L_920210
L_920210:
	st.a r15,[sp,-0x4]
