/* field_set_0x04__8c1864 @ 0x8c1864, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs
 * Зовёт сам: memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x04__8c1864
field_set_0x04__8c1864:
	.global L_8c1864
L_8c1864:
	mov_s r1,0x0
L_8c1866:
	st_s r1,[r0,0x4]
L_8c1868:
	b.d L_8c1cd8
L_8c186c:
	mov_s r1,0x4
L_8c186e:
	nop_s
