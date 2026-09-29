/* bitmap__nth_set_bit @ 0x8cbac4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_block_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bitmap__nth_set_bit
bitmap__nth_set_bit:
	.global L_8cbac4
L_8cbac4:
	cmp_s r2,0x0
L_8cbac6:
	mov.eq r0,r1
L_8cbaca:
	beq_s L_8cbae2
L_8cbacc:
	mov_s r3,0x0
L_8cbace:
	mov_s r0,r3
L_8cbad0:
	b_s L_8cbad6
	.global L_8cbad2
L_8cbad2:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8cbad4
L_8cbad4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8cbad6
L_8cbad6:
	brhs r0,0x8,L_8cbae2
L_8cbada:
	bbit0 r2,r0,L_8cbad4
L_8cbade:
	brne r1,r3,L_8cbad2
	.global L_8cbae2
L_8cbae2:
	j_s [blink]
