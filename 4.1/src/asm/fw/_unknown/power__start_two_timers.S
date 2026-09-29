/* power__start_two_timers @ 0x8e46a0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power__enter_halt, power_deep_sleep_exit_step
 * Зовёт сам: timer__start
 */
	.section .text.power__start_two_timers,"ax",@progbits
	.global power__start_two_timers
power__start_two_timers:
	.global L_8e46a0
L_8e46a0:
	push_s blink
L_8e46a2:
	mov_s r0,0x1
L_8e46a4:
	mov_s r1,0x0
L_8e46a6:
	mov_s r2,0x1f78a40
L_8e46ac:
	bl.d L_8e4610
L_8e46b0:
	mov_s r3,0x2
L_8e46b2:
	mov_s r0,0x0
L_8e46b4:
	mov_s r1,0x0
L_8e46b6:
	mov_s r2,0xce4
L_8e46bc:
	bl.d L_8e4610
L_8e46c0:
	mov_s r3,0x1
L_8e46c2:
	pop_s blink
L_8e46c4:
	j_s [blink]
L_8e46c6:
	nop_s
