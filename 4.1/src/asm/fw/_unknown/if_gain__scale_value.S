/* if_gain__scale_value @ 0x8d406c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib__delta_80161c, if_gain__load_gain_table
 */
	.section .text.if_gain__scale_value,"ax",@progbits
	.global if_gain__scale_value
if_gain__scale_value:
	.global L_8d406c
L_8d406c:
	cmp_s r0,0x0
L_8d406e:
	mov_s r2,0x1
L_8d4070:
	mov.ne r2,r0
L_8d4074:
	rsub r0,r1,0x1f
L_8d4078:
	sexb_s r0,r0
L_8d407a:
	b_s L_8d4082
	.global L_8d407c
L_8d407c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d407e:
	sexb_s r0,r0
L_8d4080:
	asl_s r2,r2
	.global L_8d4082
L_8d4082:
	lsr.f 0x0,r2,0x1f
L_8d4086:
	beq_s L_8d407c
L_8d4088:
	/* mul64 r0,0x60546 */
	.byte 0x04,0x28,0x80,0x0f,0x06,0x00,0x46,0x05
L_8d4090:
	mov_s r0,mlo
L_8d4092:
	add r1,r2,0x800000
L_8d409a:
	lsr_s r1,r1,0x18
L_8d409c:
	sub r1,r1,0x80
L_8d40a0:
	cmp_s r1,0x0
L_8d40a2:
	mov_s r2,0x0
L_8d40a4:
	mov.hi r2,r1
L_8d40a8:
	mov_s r1,0x7f
L_8d40aa:
	cmp_s r2,0x7f
L_8d40ac:
	mov.cs r1,r2
L_8d40b0:
	extb_s r1,r1
L_8d40b2:
	mov_s r2,0x80161c
L_8d40b8:
	ldw.as r1,[r2,r1]
L_8d40bc:
	j_s.d [blink]
L_8d40be:
	add3_s r0,r0,r1
