/* timer_exp_handler @ 0x8e45b0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   timer_exp_handler: m_temp_enabled is FALSE
 *   timer_exp_handler: unable to schedule temp measurment - previously scheduled measurment still didn't occur.
 * Зовут его: temp_sense__get_cached, temp_sense__reschedule_timer
 * Зовёт сам: RADIO_MGR__lock_secondary, __ld_r13_ret, fw_log__emit0, fw_read_timer, rf_lo__refresh_periodic
 * Глобалы (через gp): 0x800174
 */
	.section .text.timer_exp_handler,"ax",@progbits
	.global timer_exp_handler
timer_exp_handler:
	.global L_8e45b0
L_8e45b0:
	push_s blink
L_8e45b2:
	push_s r13
L_8e45b4:
	ld_s r0,[gp,-0x4]
L_8e45b6:
	brne_s r0,0,L_8e45c0
L_8e45b8:
	mov_s r2,0x100fb18
L_8e45be:
	b_s L_8e4604
	.global L_8e45c0
L_8e45c0:
	ld_s r0,[gp,-0x24]
L_8e45c2:
	mov_s r13,0x0
L_8e45c4:
	st.as r13,[gp,0x1]
L_8e45c8:
	brne r0,0x1,L_8e45d2
L_8e45cc:
	st.as r13,[gp,-0x9]
L_8e45d0:
	b_s L_8e460c
	.global L_8e45d2
L_8e45d2:
	bl L_8e4694
L_8e45d6:
	bl.d L_8ddd7c
L_8e45da:
	st.as r0,[gp,-0x1f]
L_8e45de:
	ld_s r0,[gp,-0x38]
L_8e45e0:
	brne_s r0,0,L_8e45fe
L_8e45e2:
	mov_s r0,0x1dc7c
L_8e45e8:
	mov_s r1,r13
L_8e45ea:
	mov_s r2,r13
L_8e45ec:
	mov_s r3,0xffff
L_8e45f2:
	bl.d L_8d938c
L_8e45f6:
	mov_s r4,r13
L_8e45f8:
	st.as r0,[gp,-0xe]
L_8e45fc:
	b_s L_8e460c
	.global L_8e45fe
L_8e45fe:
	mov_s r2,0x100fb44
	.global L_8e4604
L_8e4604:
	mov_s r0,0x6
L_8e4606:
	bl.d L_8edfb0
L_8e460a:
	mov_s r1,0x1
	.global L_8e460c
L_8e460c:
	b L_8c033c
