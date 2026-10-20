/* bit_length @ 0x8c7cd4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__chunk_offset, brd_multi_array__elem_bits
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bit_length
bit_length:
	.global L_8c7cd4
L_8c7cd4:
	push_s r13
L_8c7cd6:
	mov_s r0,0x0
L_8c7cd8:
	mov lp_count,0x20
L_8c7cdc:
	mov_s r3,r0
L_8c7cde:
	lp L_8c7cf4
L_8c7ce2:
	mov_s r2,0x0
L_8c7ce4:
	bset r2,r2,r3
L_8c7ce8:
	and_s r2,r2,r1
L_8c7cea:
	add_s r13,r0,0x1
L_8c7cec:
	cmp_s r2,0x0
L_8c7cee:
	mov.ne r0,r13
L_8c7cf2:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8c7cf4
L_8c7cf4:
	j_s.d [blink]
L_8c7cf6:
	pop_s r13
