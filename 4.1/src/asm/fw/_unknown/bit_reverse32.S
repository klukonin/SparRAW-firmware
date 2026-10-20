/* bit_reverse32 @ 0x8da448, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bitrev_fold_field_0x10, bitrev_fold_field_0x14
 */
	.section .text.bit_reverse32,"ax",@progbits
	.global bit_reverse32
bit_reverse32:
	.global L_8da448
L_8da448:
	mov lp_count,0x20
L_8da44c:
	mov_s r0,0x0
L_8da44e:
	lp L_8da45c
L_8da452:
	asl_s r3,r0
L_8da454:
	bmsk r0,r1,0x0
L_8da458:
	or_s r0,r0,r3
L_8da45a:
	lsr_s r1,r1
	.global L_8da45c
L_8da45c:
	j_s [blink]
L_8da45e:
	nop_s
