/* get_reg_880b80 @ 0x8e3580, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_long_term_trigger
 */
	.section .text.get_reg_880b80,"ax",@progbits
	.global get_reg_880b80
get_reg_880b80:
	.global L_8e3580
L_8e3580:
	push_s blink
L_8e3582:
	mov_s r1,r0
L_8e3584:
	mov_s r0,0x880b80
L_8e358a:
	ld_s r0,[r0,0x44]
L_8e358c:
	brlo r1,0x2,L_8e3598
L_8e3590:
	mulu64 r0,r1
L_8e3594:
	mov r0,mhi
	.global L_8e3598
L_8e3598:
	pop_s blink
L_8e359a:
	j_s [blink]
