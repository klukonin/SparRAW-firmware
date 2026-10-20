/* hw_rand__below_n @ 0x8e85f0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_long_term_trigger
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_rand__below_n
hw_rand__below_n:
	.global L_8e85f0
L_8e85f0:
	push_s blink
L_8e85f2:
	mov_s r1,r0
L_8e85f4:
	mov_s r0,0x880b80
L_8e85fa:
	ld_s r0,[r0,0x44]
L_8e85fc:
	brlo r1,0x2,L_8e8608
L_8e8600:
	mulu64 r0,r1
L_8e8604:
	mov r0,mhi
	.global L_8e8608
L_8e8608:
	pop_s blink
L_8e860a:
	j_s [blink]
