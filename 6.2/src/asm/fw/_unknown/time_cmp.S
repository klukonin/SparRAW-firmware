/* time_cmp @ 0x8e91bc, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__calc_next_deadline, u_schd__pop_expired
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global time_cmp
time_cmp:
	.global L_8e91bc
L_8e91bc:
	sub.f r1,r1,r0
L_8e91c0:
	beq_s L_8e91ce
L_8e91c2:
	cmp_s r1,0x80000000
L_8e91c8:
	mov r0,-0x1
L_8e91cc:
	blo_s L_8e91d0
	.global L_8e91ce
L_8e91ce:
	mov_s r0,0x1
	.global L_8e91d0
L_8e91d0:
	j_s [blink]
L_8e91d2:
	nop_s
