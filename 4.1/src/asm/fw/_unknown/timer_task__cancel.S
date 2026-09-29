/* timer_task__cancel @ 0x8c783c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: detector__arm_timer, periodic_service__start, periodic_service__tick
 * Зовёт сам: __ld_r13_ret, fw_read_timer, u_schd__cancel
 */
	.section .text.timer_task__cancel,"ax",@progbits
	.global timer_task__cancel
timer_task__cancel:
	.global L_8c783c
L_8c783c:
	push_s blink
L_8c783e:
	push_s r13
L_8c7840:
	bl.d L_8e4694
L_8c7844:
	mov_s r13,r0
L_8c7846:
	ld_s r0,[r13,0x10]
L_8c7848:
	breq_s r0,0,L_8c7852
L_8c784a:
	bl L_8c7794
L_8c784e:
	mov_s r0,0x0
L_8c7850:
	st_s r0,[r13,0x10]
	.global L_8c7852
L_8c7852:
	b L_8c033c
L_8c7856:
	nop_s
