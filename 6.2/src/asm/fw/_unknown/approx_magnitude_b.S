/* approx_magnitude_b @ 0x8dc660, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ber_test__measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global approx_magnitude_b
approx_magnitude_b:
	.global L_8dc660
L_8dc660:
	abs_s r1,r1
L_8dc662:
	abs_s r0,r2
L_8dc664:
	max r2,r0,r1
L_8dc668:
	mul64 r2,0x3f
L_8dc66c:
	min r1,r0,r1
L_8dc670:
	mov_s r0,mlo
L_8dc672:
	mul64 r1,0xd
L_8dc676:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8dc678:
	add3_s r1,r1,r1
L_8dc67a:
	add_s r0,r0,mlo
L_8dc67c:
	mul64 r2,0x36
L_8dc680:
	lsr_s r0,r0,0x6
L_8dc682:
	add_s r1,r1,mlo
L_8dc684:
	lsr_s r1,r1,0x6
L_8dc686:
	cmp_s r1,r0
L_8dc688:
	j_s.d [blink]
L_8dc68a:
	mov.hi r0,r1
L_8dc68e:
	nop_s
