/* l2_task__entry @ 0x929ec4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_isr_l2_task0, uc_isr_l2_task1__body, uc_isr_l2_task2, uc_isr_l2_task3
 * Зовёт сам: l2_task__report_error_bits, l2_task__run
 */
	.section .text.l2_task__entry,"ax",@progbits
	.global l2_task__entry
l2_task__entry:
	.global L_929ec4
L_929ec4:
	breq_s r0,0,L_929ed6
L_929ec6:
	cmp_s r0,0x1
L_929ec8:
	cmp.ne r0,0x2
L_929ecc:
	beq_s L_929eda
L_929ece:
	brne r0,0x3,L_929ee4
L_929ed2:
	b L_929bfc
	.global L_929ed6
L_929ed6:
	b L_929974
	.global L_929eda
L_929eda:
	mov r32,0x21000009
L_929ee2:
	j_s [blink]
	.global L_929ee4
L_929ee4:
	j_s [blink]
L_929ee6:
	nop_s
