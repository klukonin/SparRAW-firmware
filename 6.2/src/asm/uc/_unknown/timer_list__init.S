/* timer_list__init @ 0x9209e0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global timer_list__init
timer_list__init:
L_9209e0:
	push_s blink
L_9209e2:
	push_s r13
L_9209e4:
	mov_s r1,0x8017b8
L_9209ea:
	ld_s r13,[r1]
L_9209ec:
	mov_s r0,0x0
L_9209ee:
	st_s r0,[r1]
L_9209f0:
	breq_s r13,0,L_9209fa
	.global L_9209f2
L_9209f2:
	ld_s r0,[r13,0x4]
L_9209f4:
	jl_s [r0]
L_9209f6:
	ld_s r13,[r13,0x8]
L_9209f8:
	brne_s r13,0,L_9209f2
	.global L_9209fa
L_9209fa:
	b L_9202ac
L_9209fe:
	nop_s
