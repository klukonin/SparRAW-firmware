/* approx_magnitude_b @ 0x8d8f50, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, ber_test__measure
 */
	.section .text.approx_magnitude_b,"ax",@progbits
	.global approx_magnitude_b
approx_magnitude_b:
	.global L_8d8f50
L_8d8f50:
	abs_s r1,r1
L_8d8f52:
	abs_s r0,r2
L_8d8f54:
	max r2,r0,r1
L_8d8f58:
	mul64 r2,0x3f
L_8d8f5c:
	min r1,r0,r1
L_8d8f60:
	mov_s r0,mlo
L_8d8f62:
	mul64 r1,0xd
L_8d8f66:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8d8f68:
	add3_s r1,r1,r1
L_8d8f6a:
	add_s r0,r0,mlo
L_8d8f6c:
	mul64 r2,0x36
L_8d8f70:
	lsr_s r0,r0,0x6
L_8d8f72:
	add_s r1,r1,mlo
L_8d8f74:
	lsr_s r1,r1,0x6
L_8d8f76:
	cmp_s r1,r0
L_8d8f78:
	j_s.d [blink]
L_8d8f7a:
	mov.hi r0,r1
L_8d8f7e:
	nop_s
