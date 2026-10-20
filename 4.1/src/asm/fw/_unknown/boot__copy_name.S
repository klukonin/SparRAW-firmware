/* boot__copy_name @ 0x8ea9c0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_named_object
 * Зовёт сам: memcpy_fw
 */
	.section .text.boot__copy_name,"ax",@progbits
	.global boot__copy_name
boot__copy_name:
	.global L_8ea9c0
L_8ea9c0:
	add_s r1,r1,r2
L_8ea9c2:
	mov_s r0,r3
L_8ea9c4:
	b.d L_8c0460
