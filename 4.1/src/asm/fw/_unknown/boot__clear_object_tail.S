/* boot__clear_object_tail @ 0x8c17b8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_8042ac_objects
 * Зовёт сам: memset0_words
 */
	.section .text.boot__clear_object_tail,"ax",@progbits
	.global boot__clear_object_tail
boot__clear_object_tail:
	.global L_8c17b8
L_8c17b8:
	mov_s r1,0x0
L_8c17ba:
	st r1,[r0, 0xc4]
L_8c17be:
	st r1,[r0, 0xc8]
L_8c17c2:
	b.d L_8c1a78
L_8c17c6:
	mov_s r1,0xc4
