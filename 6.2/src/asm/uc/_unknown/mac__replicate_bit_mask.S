/* mac__replicate_bit_mask @ 0x92f400, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__program_886e0c_20b
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__replicate_bit_mask
mac__replicate_bit_mask:
	.global L_92f400
L_92f400:
	ld_s r0,[r0,0x2c]
L_92f402:
	lsr_s r0,r0
L_92f404:
	bmsk_s r0,r0,0x0
L_92f406:
	asl_s r1,r0,0x5
L_92f408:
	asl_s r2,r0,0x6
L_92f40a:
	or_s r2,r2,r1
L_92f40c:
	asl_s r1,r0
L_92f40e:
	or_s r1,r1,r2
L_92f410:
	asl_s r2,r0,0x2
L_92f412:
	or_s r2,r2,r1
L_92f414:
	asl r1,r0,0x9
L_92f418:
	or_s r1,r1,r2
L_92f41a:
	asl r2,r0,0xa
L_92f41e:
	or_s r2,r2,r1
L_92f420:
	asl r1,r0,0xd
L_92f424:
	or_s r1,r1,r2
L_92f426:
	asl_s r0,r0,0xe
L_92f428:
	j_s.d [blink]
L_92f42a:
	or_s r0,r0,r1
