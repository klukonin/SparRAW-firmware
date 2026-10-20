/* field_set_0x04__8c1870 @ 0x8c1870, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs
 * Зовёт сам: memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x04__8c1870
field_set_0x04__8c1870:
	.global L_8c1870
L_8c1870:
	mov_s r1,0x0
L_8c1872:
	st_s r1,[r0,0x4]
L_8c1874:
	b.d L_8c1cd8
L_8c1878:
	mov_s r1,0x4
L_8c187a:
	nop_s
