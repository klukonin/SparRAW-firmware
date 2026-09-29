/* TEMPERATURE_SERVICE__timer_exp_handler @ 0x8e9438, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TEMPERATURE_SERVICE::timer_exp_handler m_temp_enabled is FALSE
 *   timer_exp_handler: unable to schedule temp measurment - previously scheduled measurment still didn't occur.
 * Зовут его: channels_switch__check_g80017c, temp_sense__get_cached
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, radio_mgr__request, temp__store_lo_temp, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TEMPERATURE_SERVICE__timer_exp_handler
TEMPERATURE_SERVICE__timer_exp_handler:
	.global L_8e9438
L_8e9438:
	push_s blink
L_8e943a:
	push_s r13
L_8e943c:
	mov.f r13,r0
L_8e9440:
	mov_s r1,0x0
L_8e9442:
	st.as r1,[gp,-0x2]
L_8e9446:
	bne_s L_8e9454
L_8e9448:
	ld_s r0,[gp,-0x10]
L_8e944a:
	brne_s r0,0,L_8e9454
L_8e944c:
	mov_s r1,0x101214c
L_8e9452:
	b_s L_8e9494
	.global L_8e9454
L_8e9454:
	brne_s r13,0,L_8e9462
L_8e9456:
	ld_s r0,[gp,-0x34]
L_8e9458:
	brne r0,0x1,L_8e9462
L_8e945c:
	st.as r1,[gp,-0xd]
L_8e9460:
	b_s L_8e949a
	.global L_8e9462
L_8e9462:
	bl L_8e9524
L_8e9466:
	bl.d L_8e21f0
L_8e946a:
	st.as r0,[gp,-0x24]
L_8e946e:
	ld_s r0,[gp,-0x44]
L_8e9470:
	brne_s r0,0,L_8e948e
L_8e9472:
	mov_s r0,L_8e20dc-0x8c0000
L_8e9478:
	mov_s r1,r13
L_8e947a:
	mov_s r2,0x0
L_8e947c:
	mov_s r3,0xffff
L_8e9482:
	bl.d L_8dcaf4
L_8e9486:
	mov_s r4,r2
L_8e9488:
	st.as r0,[gp,-0x11]
L_8e948c:
	b_s L_8e949a
	.global L_8e948e
L_8e948e:
	mov_s r1,0x101218c
	.global L_8e9494
L_8e9494:
	bl.d L_8dcba8
L_8e9498:
	mov_s r0,0x16
	.global L_8e949a
L_8e949a:
	b L_8c025c
L_8e949e:
	nop_s
