/* timer_task__cancel @ 0x8c8e74, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: detector__arm_timer, periodic_service__start, periodic_service__tick
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__cancel, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global timer_task__cancel
timer_task__cancel:
	.global L_8c8e74
L_8c8e74:
	push_s blink
L_8c8e76:
	push_s r13
L_8c8e78:
	bl.d L_8e9524
L_8c8e7c:
	mov_s r13,r0
L_8c8e7e:
	ld_s r0,[r13,0x10]
L_8c8e80:
	breq_s r0,0,L_8c8e8a
L_8c8e82:
	bl L_8c8de0
L_8c8e86:
	mov_s r0,0x0
L_8c8e88:
	st_s r0,[r13,0x10]
	.global L_8c8e8a
L_8c8e8a:
	b L_8c025c
L_8c8e8e:
	nop_s
