/* periodic_service__start @ 0x8e2570, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   periodic_service.cpp
 * Зовут его: ageing_detector__start_service, ka_detector__start_service, ka_necessity_detector__start_monitoring, phy_monitor__on_system_state, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_read_timer, fw_sysassert_fatal, periodic_service__tick, timer_task__cancel
 */
	.section .text.periodic_service__start,"ax",@progbits
	.global periodic_service__start
periodic_service__start:
	.global L_8e2570
L_8e2570:
	push_s blink
L_8e2572:
	bl L_8c02c0
L_8e2576:
	mov_s r13,r0
L_8e2578:
	mov_s r14,r1
L_8e257a:
	bl.d L_8e4694
L_8e257e:
	mov_s r15,0x0
L_8e2580:
	bl.d L_8c783c
L_8e2584:
	mov_s r0,r13
L_8e2586:
	st_s r15,[r13,0x28]
L_8e2588:
	breq_s r14,0,L_8e25ac
L_8e258a:
	breq r14,0x1,L_8e25b6
L_8e258e:
	breq r14,0x2,L_8e25c0
L_8e2592:
	breq r14,0x3,L_8e25cc
L_8e2596:
	mov_s r0,blink
L_8e2598:
	mov_s r2,0x1016254
L_8e259e:
	mov_s r1,0x1439
L_8e25a4:
	bl.d L_8c82c0
L_8e25a8:
	mov_s r3,0x4a
L_8e25aa:
	b_s L_8e25d8
	.global L_8e25ac
L_8e25ac:
	ld_s r0,[r13,0x2c]
L_8e25ae:
	ld_s r1,[r0,0x10]
L_8e25b0:
	jl_s.d [r1]
L_8e25b2:
	mov_s r0,r13
L_8e25b4:
	b_s L_8e25d8
	.global L_8e25b6
L_8e25b6:
	mov_s r0,r13
L_8e25b8:
	bl.d L_8dfb6c
L_8e25bc:
	ld_s r1,[r13]
L_8e25be:
	b_s L_8e25d8
	.global L_8e25c0
L_8e25c0:
	mov_s r0,r13
L_8e25c2:
	bl.d L_8dfb6c
L_8e25c6:
	mov r1,-0x1
L_8e25ca:
	b_s L_8e25d8
	.global L_8e25cc
L_8e25cc:
	ld_s r0,[r13,0x2c]
L_8e25ce:
	ld_s r1,[r0,0x10]
L_8e25d0:
	jl_s.d [r1]
L_8e25d2:
	mov_s r0,r13
L_8e25d4:
	mov_s r0,0x1
L_8e25d6:
	st_s r0,[r13,0x28]
	.global L_8e25d8
L_8e25d8:
	b L_8c032c
