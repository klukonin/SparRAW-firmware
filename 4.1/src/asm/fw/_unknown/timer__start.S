/* timer__start @ 0x8e4610, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power__start_two_timers, power_halt__start_timer
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, irq_set_level
 */
	.section .text.timer__start,"ax",@progbits
	.global timer__start
timer__start:
	.global L_8e4610
L_8e4610:
	push_s blink
L_8e4612:
	bl.d L_8c02c0
L_8e4616:
	mov_s r4,r0
L_8e4618:
	asl_s r13,r0,0x4
L_8e461a:
	add_s r13,r13,0x800888
L_8e4620:
	ld_s r0,[r13,0x4]
L_8e4622:
	mov_s r14,r1
L_8e4624:
	sr 0x0,[r0]
L_8e462c:
	ld_s r0,[r13,0x8]
L_8e462e:
	cmp_s r3,0x3
L_8e4630:
	sr r2,[r0]
L_8e4634:
	mov.eq r15,0x4
L_8e4638:
	beq_s L_8e4650
L_8e463a:
	mov_s r15,0x2
L_8e463c:
	breq_s r3,0,L_8e4650
L_8e463e:
	mov_s r15,0x3
L_8e4640:
	cmp_s r3,0x2
L_8e4642:
	mov_s r1,0x1
L_8e4644:
	sub_s.ne r1,r1,r1
L_8e4646:
	asl r0,r4,0x2
L_8e464a:
	/* bl.d 0x008c31f8 */
	.byte 0xb2,0x0b,0x6f,0xef
L_8e464e:
	/* _add_s r0,0x3 */
	.byte 0x03,0xe0
	.global L_8e4650
L_8e4650:
	st_s r15,[r13,0xc]
L_8e4652:
	ld_s r0,[r13,0x4]
L_8e4654:
	sr r15,[r0]
L_8e4658:
	ld_s r0,[r13]
L_8e465a:
	b.d L_8c032c
L_8e465e:
	sr r14,[r0]
L_8e4662:
	nop_s
