/* brd_if__pick_block @ 0x8c9a4c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_block_info
 */
	.section .text.brd_if__pick_block,"ax",@progbits
	.global brd_if__pick_block
brd_if__pick_block:
	.global L_8c9a4c
L_8c9a4c:
	cmp_s r2,0x0
L_8c9a4e:
	mov.eq r0,r1
L_8c9a52:
	beq_s L_8c9a68
L_8c9a54:
	mov_s r3,0x0
L_8c9a56:
	mov_s r0,r3
L_8c9a58:
	b_s L_8c9a5e
	.global L_8c9a5a
L_8c9a5a:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8c9a5c
L_8c9a5c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8c9a5e
L_8c9a5e:
	brne_s r0,0,L_8c9a68
L_8c9a60:
	bbit0 r2,r0,L_8c9a5c
L_8c9a64:
	brne r1,r3,L_8c9a5a
	.global L_8c9a68
L_8c9a68:
	j_s [blink]
L_8c9a6a:
	nop_s
