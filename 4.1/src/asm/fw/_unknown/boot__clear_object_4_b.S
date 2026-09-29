/* boot__clear_object_4_b @ 0x8c17d4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_8042ac_objects
 * Зовёт сам: memset0_words
 */
	.section .text.boot__clear_object_4_b,"ax",@progbits
	.global boot__clear_object_4_b
boot__clear_object_4_b:
	.global L_8c17d4
L_8c17d4:
	mov_s r1,0x0
L_8c17d6:
	st_s r1,[r0,0x4]
L_8c17d8:
	b.d L_8c1a78
L_8c17dc:
	mov_s r1,0x4
L_8c17de:
	nop_s
