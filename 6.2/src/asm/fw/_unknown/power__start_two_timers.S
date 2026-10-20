/* power__start_two_timers @ 0x8e9530, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_exit, u_schd__timer_init
 * Зовёт сам: timer__start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power__start_two_timers
power__start_two_timers:
	.global L_8e9530
L_8e9530:
	push_s blink
L_8e9532:
	mov_s r0,0x1
L_8e9534:
	mov_s r1,0x0
L_8e9536:
	mov_s r2,0x1f78a40
L_8e953c:
	bl.d L_8e94a0
L_8e9540:
	mov_s r3,0x2
L_8e9542:
	mov_s r0,0x0
L_8e9544:
	mov_s r1,0x0
L_8e9546:
	mov_s r2,0xce4
L_8e954c:
	bl.d L_8e94a0
L_8e9550:
	mov_s r3,0x1
L_8e9552:
	pop_s blink
L_8e9554:
	j_s [blink]
L_8e9556:
	nop_s
