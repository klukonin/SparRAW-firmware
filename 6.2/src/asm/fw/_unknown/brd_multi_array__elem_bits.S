/* brd_multi_array__elem_bits @ 0x8cbae4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__find_section
 * Зовёт сам: bit_length
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_multi_array__elem_bits
brd_multi_array__elem_bits:
	.global L_8cbae4
L_8cbae4:
	cmp_s r1,0x0
L_8cbae6:
	jeq.d [blink]
L_8cbaea:
	mov.eq r0,0x1
L_8cbaee:
	cmp_s r2,0x0
L_8cbaf0:
	bne.d L_8c7cd4
L_8cbaf4:
	mov.ne r1,r2
L_8cbaf8:
	mov_s r0,0x8
L_8cbafa:
	j_s [blink]
