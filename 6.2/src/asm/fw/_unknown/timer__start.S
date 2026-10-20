/* timer__start @ 0x8e94a0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power__start_two_timers, power_halt__start_timer
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, irq_set_level
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global timer__start
timer__start:
	.global L_8e94a0
L_8e94a0:
	push_s blink
L_8e94a2:
	bl.d L_8c01e0
L_8e94a6:
	mov_s r4,r0
L_8e94a8:
	asl_s r13,r0,0x4
L_8e94aa:
	add_s r13,r13,0x800948
L_8e94b0:
	ld_s r0,[r13,0x4]
L_8e94b2:
	mov_s r14,r1
L_8e94b4:
	sr 0x0,[r0]
L_8e94bc:
	ld_s r0,[r13,0x8]
L_8e94be:
	cmp_s r3,0x3
L_8e94c0:
	sr r2,[r0]
L_8e94c4:
	mov.eq r15,0x4
L_8e94c8:
	beq_s L_8e94e0
L_8e94ca:
	mov_s r15,0x2
L_8e94cc:
	breq_s r3,0,L_8e94e0
L_8e94ce:
	mov_s r15,0x3
L_8e94d0:
	cmp_s r3,0x2
L_8e94d2:
	mov_s r1,0x1
L_8e94d4:
	sub_s.ne r1,r1,r1
L_8e94d6:
	asl r0,r4,0x2
L_8e94da:
	bl.d L_8c3bd8
L_8e94de:
	/* _add_s r0,0x3 */
	.byte 0x03,0xe0
	.global L_8e94e0
L_8e94e0:
	st_s r15,[r13,0xc]
L_8e94e2:
	ld_s r0,[r13,0x4]
L_8e94e4:
	sr r15,[r0]
L_8e94e8:
	ld_s r0,[r13]
L_8e94ea:
	b.d L_8c024c
L_8e94ee:
	sr r14,[r0]
L_8e94f2:
	nop_s
