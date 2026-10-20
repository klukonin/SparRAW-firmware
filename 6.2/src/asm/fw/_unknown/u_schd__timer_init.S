/* u_schd__timer_init @ 0x8e9508, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__run
 * Зовёт сам: field_set_0x00__8d8db8, power__start_two_timers, u_schd__hw_timer_a_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__timer_init
u_schd__timer_init:
	.global L_8e9508
L_8e9508:
	push_s blink
L_8e950a:
	add_s r0,gp,0x74
L_8e950c:
	mov_s r1,0xa5
L_8e950e:
	/* bl.d 0x008d8db8 */
	.byte 0xae,0x08,0xef,0xf7
L_8e9512:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8e9514:
	bl L_8e9530
L_8e9518:
	bl.d L_8e91a4
L_8e951c:
	mov_s r0,0x1
L_8e951e:
	pop_s blink
L_8e9520:
	j_s [blink]
L_8e9522:
	nop_s
