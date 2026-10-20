/* temp_sense__reschedule_timer @ 0x8dfc98, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__radio_locked_cb, temp_sense__sample_if_due
 * Зовёт сам: __ld_r13_ret, timer_exp_handler, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x800174
 */
	.section .text.temp_sense__reschedule_timer,"ax",@progbits
	.global temp_sense__reschedule_timer
temp_sense__reschedule_timer:
	.global L_8dfc98
L_8dfc98:
	push_s blink
L_8dfc9a:
	push_s r13
L_8dfc9c:
	mov_s r13,r0
L_8dfc9e:
	ld_s r0,[gp,0x4]
L_8dfca0:
	breq_s r0,0,L_8dfcac
L_8dfca2:
	bl L_8c7794
L_8dfca6:
	mov_s r0,0x0
L_8dfca8:
	st.as r0,[gp,0x1]
	.global L_8dfcac
L_8dfcac:
	breq_s r13,0,L_8dfcca
L_8dfcae:
	mov_s r0,0x245b0
L_8dfcb4:
	mov_s r1,0x0
L_8dfcb6:
	mov_s r2,r1
L_8dfcb8:
	mov_s r3,0x1
L_8dfcba:
	mov_s r4,r13
L_8dfcbc:
	mov_s r5,r1
L_8dfcbe:
	bl.d L_8dc92c
L_8dfcc2:
	mov_s r6,r1
L_8dfcc4:
	st.as r0,[gp,0x1]
L_8dfcc8:
	b_s L_8dfcce
	.global L_8dfcca
L_8dfcca:
	bl L_8e45b0
	.global L_8dfcce
L_8dfcce:
	b L_8c033c
L_8dfcd2:
	nop_s
