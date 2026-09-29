/* u_schd__arm_timer @ 0x8de094, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__cancel, u_schd__insert, u_schd__reschedule, u_schd__tick
 * Зовёт сам: __ld_r13_ret, fw_set_timer_alarm, tail_irq_ack_880b00, u_schd__calc_next_deadline
 * Глобалы (через gp): 0x800178
 */
	.section .text.u_schd__arm_timer,"ax",@progbits
	.global u_schd__arm_timer
u_schd__arm_timer:
	.global L_8de094
L_8de094:
	push_s blink
L_8de096:
	push_s r13
L_8de098:
	sub_s sp,sp,0x8
L_8de09a:
	mov_s r0,sp
L_8de09c:
	bl.d L_8ca2a0
L_8de0a0:
	add_s r1,sp,0x4
L_8de0a2:
	mov.f r13,r0
L_8de0a6:
	beq_s L_8de0c4
L_8de0a8:
	bl.d L_8e4670
L_8de0ac:
	ld_s r0,[sp,0x0]
L_8de0ae:
	bl.d L_8e4664
L_8de0b2:
	mov_s r0,0x1
L_8de0b4:
	bl.d L_8e4670
L_8de0b8:
	ld_s r0,[sp,0x0]
L_8de0ba:
	ld_s r0,[sp,0x0]
L_8de0bc:
	st.as r0,[gp,0x2]
L_8de0c0:
	ld_s r0,[sp,0x4]
L_8de0c2:
	b_s L_8de0cc
	.global L_8de0c4
L_8de0c4:
	bl.d L_8e4664
L_8de0c8:
	mov_s r0,0x0
L_8de0ca:
	mov_s r0,0x2
	.global L_8de0cc
L_8de0cc:
	stb r0,[gp, 0xd5]
L_8de0d0:
	mov_s r0,r13
L_8de0d2:
	b.d L_8c033c
L_8de0d6:
	add_s sp,sp,0x8
