/* get_reg_880a7c @ 0x8d74f8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__identify_type, rf__is_present
 */
	.section .text.get_reg_880a7c,"ax",@progbits
	.global get_reg_880a7c
get_reg_880a7c:
	.global L_8d74f8
L_8d74f8:
	mov_s r0,0x880a7c
L_8d74fe:
	ldw_s r0,[r0,0x12]
L_8d7500:
	sub.f r0,r0,0x0
L_8d7504:
	j_s.d [blink]
L_8d7506:
	mov.ne r0,0x1
L_8d750a:
	nop_s
