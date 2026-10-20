/* softfloat_u32_to_double @ 0x920478, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw, softfloat_int_to_double
 */
	.section .text.softfloat_u32_to_double,"ax",@progbits
	.global softfloat_u32_to_double
softfloat_u32_to_double:
	.global L_920478
L_920478:
	mov.f r1,r0
L_92047c:
	mov_s r12,0x1
	.global L_92047e
L_92047e:
	jeq.d [blink]
L_920482:
	asl r12,r12,0x1e
L_920486:
	norm.f r2,r0
L_92048a:
	sub.mi r2,r2,r2
L_92048e:
	add.pl r2,r2,0x1
L_920492:
	asl r3,r0,r2
L_920496:
	rsub r2,r2,0x1f
L_92049a:
	asl r2,r2,0x14
L_92049e:
	or_s r2,r2,r12
L_9204a0:
	asl r0,r3,0x15
L_9204a4:
	asr r1,r3,0xb
L_9204a8:
	j_s.d [blink]
L_9204aa:
	add_s r1,r1,r2
