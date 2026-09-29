/* u_schd__arm_timer @ 0x8e249c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__cancel, u_schd__expire_timers, u_schd__insert_timer, u_schd__reschedule
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__calc_next_deadline, u_schd__irq_ack_thunk, u_schd__program_hw_timer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__arm_timer
u_schd__arm_timer:
	.global L_8e249c
L_8e249c:
	push_s blink
L_8e249e:
	push_s r13
L_8e24a0:
	sub_s sp,sp,0x8
L_8e24a2:
	mov_s r0,sp
L_8e24a4:
	bl.d L_8cc4c8
L_8e24a8:
	add_s r1,sp,0x4
L_8e24aa:
	mov.f r13,r0
L_8e24ae:
	beq_s L_8e24cc
L_8e24b0:
	bl.d L_8e9500
L_8e24b4:
	ld_s r0,[sp,0x0]
L_8e24b6:
	bl.d L_8e94f4
L_8e24ba:
	mov_s r0,0x1
L_8e24bc:
	bl.d L_8e9500
L_8e24c0:
	ld_s r0,[sp,0x0]
L_8e24c2:
	ld_s r0,[sp,0x0]
L_8e24c4:
	st.as r0,[gp,-0x1]
L_8e24c8:
	ld_s r0,[sp,0x4]
L_8e24ca:
	b_s L_8e24d4
	.global L_8e24cc
L_8e24cc:
	bl.d L_8e94f4
L_8e24d0:
	mov_s r0,0x0
L_8e24d2:
	mov_s r0,0x2
	.global L_8e24d4
L_8e24d4:
	stb r0,[gp, 0xd8]
L_8e24d8:
	mov_s r0,r13
L_8e24da:
	b.d L_8c025c
L_8e24de:
	add_s sp,sp,0x8
