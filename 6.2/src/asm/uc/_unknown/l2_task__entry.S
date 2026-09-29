/* l2_task__entry @ 0x92d010, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_isr_l2_task2, uc_isr_l2_task3, uc_vector_06, uc_vector_10
 * Зовёт сам: l2_handle_watchdog, l2_task__report_error_bits
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l2_task__entry
l2_task__entry:
	.global L_92d010
L_92d010:
	breq_s r0,0,L_92d022
L_92d012:
	cmp_s r0,0x1
L_92d014:
	cmp.ne r0,0x2
L_92d018:
	beq_s L_92d026
L_92d01a:
	brne r0,0x3,L_92d030
L_92d01e:
	b L_92cf90
	.global L_92d022
L_92d022:
	b L_92cdd8
	.global L_92d026
L_92d026:
	mov r32,0x21000009
L_92d02e:
	j_s [blink]
	.global L_92d030
L_92d030:
	j_s [blink]
L_92d032:
	nop_s
