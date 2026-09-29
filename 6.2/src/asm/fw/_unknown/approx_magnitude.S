/* approx_magnitude @ 0x8d6490, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global approx_magnitude
approx_magnitude:
	.global L_8d6490
L_8d6490:
	abs_s r3,r0
L_8d6492:
	abs_s r0,r1
L_8d6494:
	max r2,r0,r3
L_8d6498:
	mul64 r2,0x3f
L_8d649c:
	min r1,r0,r3
L_8d64a0:
	mov_s r0,mlo
L_8d64a2:
	mul64 r1,0xd
L_8d64a6:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8d64a8:
	add3_s r1,r1,r1
L_8d64aa:
	add_s r0,r0,mlo
L_8d64ac:
	mul64 r2,0x36
L_8d64b0:
	lsr_s r0,r0,0x6
L_8d64b2:
	add_s r1,r1,mlo
L_8d64b4:
	lsr_s r1,r1,0x6
L_8d64b6:
	cmp_s r1,r0
L_8d64b8:
	j_s.d [blink]
L_8d64ba:
	mov.hi r0,r1
L_8d64be:
	nop_s
