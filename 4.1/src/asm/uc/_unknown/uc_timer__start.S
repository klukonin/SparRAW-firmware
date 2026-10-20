/* uc_timer__start @ 0x9323e0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_timers__start_defaults, uc_timers__start_defaults_b
 * Зовёт сам: uc_irq_set_level
 */
	.section .text.uc_timer__start,"ax",@progbits
	.global uc_timer__start
uc_timer__start:
	.global L_9323e0
L_9323e0:
	st.a r13,[sp,-0x10]
L_9323e4:
	st blink,[sp, 0x4]
L_9323e8:
	st_s r14,[sp,0x8]
L_9323ea:
	st_s r15,[sp,0xc]
L_9323ec:
	mov_s r8,r0
L_9323ee:
	asl_s r13,r0,0x4
L_9323f0:
	add_s r13,r13,0x8006a4
L_9323f6:
	ld r7,[r13, 0x4]
L_9323fa:
	mov_s r14,r1
L_9323fc:
	sr 0x0,[r7]
L_932404:
	ld r4,[r13, 0x8]
L_932408:
	brne.d r3,0x3,L_932430
L_93240c:
	sr r2,[r4]
L_932410:
	mov_s r15,0x4
L_932412:
	st_s r15,[r13,0xc]
L_932414:
	sr r15,[r7]
L_932418:
	ld r5,[r13]
L_93241c:
	sr r14,[r5]
L_932420:
	ld blink,[sp, 0x4]
L_932424:
	ld_s r14,[sp,0x8]
L_932426:
	ld_s r15,[sp,0xc]
L_932428:
	j.d [blink]
L_93242c:
	ld.ab r13,[sp,0x10]
	.global L_932430
L_932430:
	breq_s r3,0,L_932468
L_932432:
	mov_s r15,0x3
L_932434:
	cmp_s r3,0x2
L_932436:
	mov_s r1,0x1
L_932438:
	add2 r0,0x3,r8
L_932440:
	bl.d L_9219b4
L_932444:
	sub.ne r1,r1,r1
L_932448:
	st_s r15,[r13,0xc]
L_93244a:
	ld r6,[r13, 0x4]
L_93244e:
	sr r15,[r6]
L_932452:
	ld r5,[r13]
L_932456:
	sr r14,[r5]
L_93245a:
	ld blink,[sp, 0x4]
L_93245e:
	ld_s r14,[sp,0x8]
L_932460:
	ld_s r15,[sp,0xc]
L_932462:
	j_s.d [blink]
L_932464:
	ld.ab r13,[sp,0x10]
	.global L_932468
L_932468:
	mov_s r15,0x2
L_93246a:
	st_s r15,[r13,0xc]
L_93246c:
	sr r15,[r7]
L_932470:
	ld r5,[r13]
L_932474:
	sr r14,[r5]
L_932478:
	ld blink,[sp, 0x4]
L_93247c:
	ld_s r14,[sp,0x8]
L_93247e:
	ld_s r15,[sp,0xc]
L_932480:
	j.d [blink]
L_932484:
	ld.ab r13,[sp,0x10]
