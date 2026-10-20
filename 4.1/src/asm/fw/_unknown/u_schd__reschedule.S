/* u_schd__reschedule @ 0x8e435c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__handle_rx_frame
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__arm_timer, u_schd__invoke_callback, u_schd__run_expired
 * Глобалы (через gp): 0x800245
 */
	.section .text.u_schd__reschedule,"ax",@progbits
	.global u_schd__reschedule
u_schd__reschedule:
	.global L_8e435c
L_8e435c:
	push_s blink
L_8e435e:
	bl L_8c02c4
L_8e4362:
	mov_s r14,r0
L_8e4364:
	mov_s r0,0x8034a8
L_8e436a:
	bl.d L_8c5804
L_8e436e:
	ld.as r0,[r0,r14]
L_8e4372:
	breq_s r0,0,L_8e43c4
L_8e4374:
	lr r13,[0xa]
L_8e4378:
	bclr r0,r13,0x1
L_8e437c:
	flag r0
L_8e4380:
	b_s L_8e438a
	.global L_8e4382
L_8e4382:
	bl.d L_8c55c4
L_8e4386:
	mov_s r0,r14
L_8e4388:
	breq_s r0,0,L_8e43a8
	.global L_8e438a
L_8e438a:
	mov_s r0,0x8034a8
L_8e4390:
	ld.as r0,[r0,r14]
L_8e4394:
	ld_s r0,[r0]
L_8e4396:
	sub.f r0,r0,0x0
L_8e439a:
	mov.ne r0,0x1
L_8e439e:
	extb.f 0x0,r0
L_8e43a2:
	bne_s L_8e4382
L_8e43a4:
	mov_s r1,0x1
L_8e43a6:
	b_s L_8e43aa
	.global L_8e43a8
L_8e43a8:
	mov_s r1,0x0
	.global L_8e43aa
L_8e43aa:
	ldb_s r0,[gp,0xd5]
L_8e43ac:
	cmp_s r14,r0
L_8e43ae:
	cmp.ne r1,0x0
L_8e43b2:
	bl.eq L_8de094
L_8e43b6:
	lr r0,[0xa]
L_8e43ba:
	bic r13,r13,-0x3
L_8e43be:
	or_s r13,r13,r0
L_8e43c0:
	flag r13
	.global L_8e43c4
L_8e43c4:
	b L_8c0334
