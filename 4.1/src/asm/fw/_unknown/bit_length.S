/* bit_length @ 0x8c6c38, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if__chunk_offset, brd_if__section_bit_index
 */
	.section .text.bit_length,"ax",@progbits
	.global bit_length
bit_length:
	.global L_8c6c38
L_8c6c38:
	push_s r13
L_8c6c3a:
	mov_s r0,0x0
L_8c6c3c:
	mov lp_count,0x20
L_8c6c40:
	mov_s r3,r0
L_8c6c42:
	lp L_8c6c58
L_8c6c46:
	mov_s r2,0x0
L_8c6c48:
	bset r2,r2,r3
L_8c6c4c:
	and_s r2,r2,r1
L_8c6c4e:
	add_s r13,r0,0x1
L_8c6c50:
	cmp_s r2,0x0
L_8c6c52:
	mov.ne r0,r13
L_8c6c56:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8c6c58
L_8c6c58:
	j_s.d [blink]
L_8c6c5a:
	pop_s r13
