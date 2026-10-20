/* power_halt__start_timer @ 0x8e46c8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__halt
 * Зовёт сам: timer__start
 */
	.section .text.power_halt__start_timer,"ax",@progbits
	.global power_halt__start_timer
power_halt__start_timer:
	.global L_8e46c8
L_8e46c8:
	push_s blink
L_8e46ca:
	mov_s r0,0x1
L_8e46cc:
	mov_s r1,0x0
L_8e46ce:
	mov_s r2,0x1f78a40
L_8e46d4:
	bl.d L_8e4610
L_8e46d8:
	mov_s r3,r1
L_8e46da:
	mov_s r0,0x0
L_8e46dc:
	mov_s r1,0x0
L_8e46de:
	mov_s r2,0xce4
L_8e46e4:
	bl.d L_8e4610
L_8e46e8:
	mov_s r3,r1
L_8e46ea:
	pop_s blink
L_8e46ec:
	j_s [blink]
L_8e46ee:
	nop_s
