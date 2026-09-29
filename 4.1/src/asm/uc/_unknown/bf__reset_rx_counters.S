/* bf__reset_rx_counters @ 0x9221a4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__step_by_state
 * Зовёт сам: uc_sta_trace__push_record
 * Глобалы (через gp): 0x800604, 0x800608
 */
	.section .text.bf__reset_rx_counters,"ax",@progbits
	.global bf__reset_rx_counters
bf__reset_rx_counters:
	.global L_9221a4
L_9221a4:
	push_s blink
L_9221a6:
	bl.d L_931ef8
L_9221aa:
	mov_s r0,0x1
L_9221ac:
	mov_s r0,0x0
L_9221ae:
	st.as r0,[gp,0x37]
L_9221b2:
	st.as r0,[gp,0x38]
L_9221b6:
	pop_s blink
L_9221b8:
	j_s [blink]
L_9221ba:
	nop_s
