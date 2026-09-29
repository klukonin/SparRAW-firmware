/* boot__clear_object_4_a @ 0x8c17c8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_8042ac_objects
 * Зовёт сам: memset0_words
 */
	.section .text.boot__clear_object_4_a,"ax",@progbits
	.global boot__clear_object_4_a
boot__clear_object_4_a:
	.global L_8c17c8
L_8c17c8:
	mov_s r1,0x0
L_8c17ca:
	st_s r1,[r0,0x4]
L_8c17cc:
	b.d L_8c1a78
L_8c17d0:
	mov_s r1,0x4
L_8c17d2:
	nop_s
