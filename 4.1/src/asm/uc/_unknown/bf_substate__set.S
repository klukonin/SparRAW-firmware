/* bf_substate__set @ 0x930dc4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate_sm__step, bi_manager__rx_flow_kind1, brp__mode_step, brp_flow_step, rx_funcs__rx_flow, txss__flow_body, txss__init_sweep, txss__init_sweep_b, txss__prepare_frames, txss_flow_step_b
 */
	.section .text.bf_substate__set,"ax",@progbits
	.global bf_substate__set
bf_substate__set:
	.global L_930dc4
L_930dc4:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_930dc6:
	add1_s r0,r0,r0
L_930dc8:
	add r2,r0,0x800ef8
L_930dd0:
	st_s r1,[r2]
L_930dd2:
	j_s [blink]
