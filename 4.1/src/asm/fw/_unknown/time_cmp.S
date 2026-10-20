/* time_cmp @ 0x8e431c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__calc_next_deadline, u_schd__run_expired
 */
	.section .text.time_cmp,"ax",@progbits
	.global time_cmp
time_cmp:
	.global L_8e431c
L_8e431c:
	sub.f r1,r1,r0
L_8e4320:
	beq_s L_8e432e
L_8e4322:
	cmp_s r1,0x80000000
L_8e4328:
	mov r0,-0x1
L_8e432c:
	blo_s L_8e4330
	.global L_8e432e
L_8e432e:
	mov_s r0,0x1
	.global L_8e4330
L_8e4330:
	j_s [blink]
L_8e4332:
	nop_s
