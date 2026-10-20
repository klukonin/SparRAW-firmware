/* approx_magnitude @ 0x8d3708, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN
 */
	.section .text.approx_magnitude,"ax",@progbits
	.global approx_magnitude
approx_magnitude:
	.global L_8d3708
L_8d3708:
	abs_s r3,r0
L_8d370a:
	abs_s r0,r1
L_8d370c:
	max r2,r0,r3
L_8d3710:
	mul64 r2,0x3f
L_8d3714:
	min r1,r0,r3
L_8d3718:
	mov_s r0,mlo
L_8d371a:
	mul64 r1,0xd
L_8d371e:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8d3720:
	add3_s r1,r1,r1
L_8d3722:
	add_s r0,r0,mlo
L_8d3724:
	mul64 r2,0x36
L_8d3728:
	lsr_s r0,r0,0x6
L_8d372a:
	add_s r1,r1,mlo
L_8d372c:
	lsr_s r1,r1,0x6
L_8d372e:
	cmp_s r1,r0
L_8d3730:
	j_s.d [blink]
L_8d3732:
	mov.hi r0,r1
L_8d3736:
	nop_s
