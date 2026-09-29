/* u_schd__expire_timers @ 0x8da674, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__expire_timers_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__arm_timer, u_schd__pop_expired
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__expire_timers
u_schd__expire_timers:
	.global L_8da674
L_8da674:
	push_s blink
L_8da676:
	push_s r13
L_8da678:
	mov_s r13,0x0
L_8da67a:
	b_s L_8da67e
	.global L_8da67c
L_8da67c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8da67e
L_8da67e:
	brge r13,0x2,L_8da6a6
	.global L_8da682
L_8da682:
	mov_s r0,0x803c54
L_8da688:
	ld.as r0,[r0,r13]
L_8da68c:
	ld_s r0,[r0]
L_8da68e:
	sub.f r0,r0,0x0
L_8da692:
	mov.ne r0,0x1
L_8da696:
	extb.f 0x0,r0
L_8da69a:
	beq_s L_8da67c
L_8da69c:
	bl.d L_8c62c8
L_8da6a0:
	mov_s r0,r13
L_8da6a2:
	brne_s r0,0,L_8da682
L_8da6a4:
	b_s L_8da67c
	.global L_8da6a6
L_8da6a6:
	bl L_8e249c
L_8da6aa:
	b L_8c025c
L_8da6ae:
	nop_s
