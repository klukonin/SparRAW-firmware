/* mac__replicate_bit_mask @ 0x92b908, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__program_886e0c_20b
 */
	.section .text.mac__replicate_bit_mask,"ax",@progbits
	.global mac__replicate_bit_mask
mac__replicate_bit_mask:
	.global L_92b908
L_92b908:
	ld_s r0,[r0,0x2c]
L_92b90a:
	lsr_s r0,r0
L_92b90c:
	bmsk_s r0,r0,0x0
L_92b90e:
	asl_s r1,r0,0x5
L_92b910:
	asl_s r2,r0,0x6
L_92b912:
	or_s r2,r2,r1
L_92b914:
	asl_s r1,r0
L_92b916:
	or_s r1,r1,r2
L_92b918:
	asl_s r2,r0,0x2
L_92b91a:
	or_s r2,r2,r1
L_92b91c:
	asl r1,r0,0x9
L_92b920:
	or_s r1,r1,r2
L_92b922:
	asl r2,r0,0xa
L_92b926:
	or_s r2,r2,r1
L_92b928:
	asl r1,r0,0xd
L_92b92c:
	or_s r1,r1,r2
L_92b92e:
	asl_s r0,r0,0xe
L_92b930:
	j_s.d [blink]
L_92b932:
	or_s r0,r0,r1
