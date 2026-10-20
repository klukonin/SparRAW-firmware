/* tsf__wrap_by_bi @ 0x8c97e0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: parse_ese
 */
	.section .text.tsf__wrap_by_bi,"ax",@progbits
	.global tsf__wrap_by_bi
tsf__wrap_by_bi:
	.global L_8c97e0
L_8c97e0:
	mov_s r0,0x886d00
L_8c97e6:
	ld_s r0,[r0,0x64]
L_8c97e8:
	extw_s r0,r0
L_8c97ea:
	asl r3,r0,0xa
L_8c97ee:
	b_s L_8c97f2
	.global L_8c97f0
L_8c97f0:
	sub_s r1,r1,r3
	.global L_8c97f2
L_8c97f2:
	sub r0,r1,r2
L_8c97f6:
	brlo r3,r0,L_8c97f0
L_8c97fa:
	j_s [blink]
