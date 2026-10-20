/* boot__clear_object_48 @ 0x8c17ac, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_8042ac_objects
 * Зовёт сам: memset0_words
 */
	.section .text.boot__clear_object_48,"ax",@progbits
	.global boot__clear_object_48
boot__clear_object_48:
	.global L_8c17ac
L_8c17ac:
	mov_s r1,0x0
L_8c17ae:
	st_s r1,[r0,0x4]
L_8c17b0:
	st_s r1,[r0,0x8]
L_8c17b2:
	b.d L_8c1a78
L_8c17b6:
	mov_s r1,0x4
