/* boot__clear_object_48 @ 0x8c1848, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__clear_object_48
boot__clear_object_48:
	.global L_8c1848
L_8c1848:
	mov_s r1,0x0
L_8c184a:
	st_s r1,[r0,0x4]
L_8c184c:
	st_s r1,[r0,0x8]
L_8c184e:
	b.d L_8c1cd8
L_8c1852:
	mov_s r1,0x4
