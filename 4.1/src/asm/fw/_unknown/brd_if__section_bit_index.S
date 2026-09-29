/* brd_if__section_bit_index @ 0x8c9a6c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__find_section
 * Зовёт сам: bit_length
 */
	.section .text.brd_if__section_bit_index,"ax",@progbits
	.global brd_if__section_bit_index
brd_if__section_bit_index:
	.global L_8c9a6c
L_8c9a6c:
	push_s blink
L_8c9a6e:
	cmp_s r1,0x0
L_8c9a70:
	cmp.ne r2,0x0
L_8c9a74:
	beq_s L_8c9a7e
L_8c9a76:
	bl.d L_8c6c38
L_8c9a7a:
	mov_s r1,r2
L_8c9a7c:
	b_s L_8c9a80
	.global L_8c9a7e
L_8c9a7e:
	mov_s r0,0x1
	.global L_8c9a80
L_8c9a80:
	pop_s blink
L_8c9a82:
	j_s [blink]
