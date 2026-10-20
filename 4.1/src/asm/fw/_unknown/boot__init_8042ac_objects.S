/* boot__init_8042ac_objects @ 0x8c18e0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, boot__clear_object_48, boot__clear_object_4_a, boot__clear_object_4_b, boot__clear_object_tail
 */
	.section .text.boot__init_8042ac_objects,"ax",@progbits
	.global boot__init_8042ac_objects
boot__init_8042ac_objects:
L_8c18e0:
	push_s blink
L_8c18e2:
	push_s r13
L_8c18e4:
	mov_s r13,0x8042ac
L_8c18ea:
	mov_s r0,r13
L_8c18ec:
	bl.d L_8c17ac
L_8c18f0:
	mov_s r1,0x0
L_8c18f2:
	mov_s r0,0x8042b8
L_8c18f8:
	bl.d L_8c17b8
L_8c18fc:
	mov_s r1,0x0
L_8c18fe:
	add3 r0,r13,0x1b
L_8c1902:
	bl.d L_8c17c8
L_8c1906:
	mov_s r1,0x0
L_8c1908:
	add3 r0,r13,0x1c
L_8c190c:
	bl.d L_8c17d4
L_8c1910:
	mov_s r1,0x0
L_8c1912:
	.byte 0x2d,0x02
