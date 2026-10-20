/* boot__clear_object_tail @ 0x8c1854, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__clear_object_tail
boot__clear_object_tail:
	.global L_8c1854
L_8c1854:
	mov_s r1,0x0
L_8c1856:
	st r1,[r0, 0xc4]
L_8c185a:
	st r1,[r0, 0xc8]
L_8c185e:
	b.d L_8c1cd8
L_8c1862:
	mov_s r1,0xc4
