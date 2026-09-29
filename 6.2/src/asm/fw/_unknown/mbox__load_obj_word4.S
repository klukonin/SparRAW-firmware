/* mbox__load_obj_word4 @ 0x8cca38, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mbox__consume_one
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mbox__load_obj_word4
mbox__load_obj_word4:
	.global L_8cca38
L_8cca38:
	ld_s r0,[r0]
L_8cca3a:
	j_s.d [blink]
L_8cca3c:
	ld_s r0,[r0,0x4]
L_8cca3e:
	nop_s
