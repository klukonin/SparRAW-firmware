/* vring__clear_pair_words @ 0x8c984c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__set_pair_mode
 * Зовёт сам: memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__clear_pair_words
vring__clear_pair_words:
	.global L_8c984c
L_8c984c:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c984e:
	b.d L_8c1cd8
L_8c9852:
	mov_s r1,0x8
