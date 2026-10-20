/* power_halt__start_timer @ 0x8e9558, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__halt
 * Зовёт сам: timer__start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_halt__start_timer
power_halt__start_timer:
	.global L_8e9558
L_8e9558:
	push_s blink
L_8e955a:
	mov_s r0,0x1
L_8e955c:
	mov_s r1,0x0
L_8e955e:
	mov_s r2,0x1f78a40
L_8e9564:
	bl.d L_8e94a0
L_8e9568:
	mov_s r3,r1
L_8e956a:
	mov_s r0,0x0
L_8e956c:
	mov_s r1,0x0
L_8e956e:
	mov_s r2,0xce4
L_8e9574:
	bl.d L_8e94a0
L_8e9578:
	mov_s r3,r1
L_8e957a:
	pop_s blink
L_8e957c:
	j_s [blink]
L_8e957e:
	nop_s
