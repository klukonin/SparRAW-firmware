/* get_reg_880254 @ 0x8e42cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_get_reg_880254
 */
	.section .text.get_reg_880254,"ax",@progbits
	.global get_reg_880254
get_reg_880254:
	.global L_8e42cc
L_8e42cc:
	mov_s r0,0x880200
L_8e42d2:
	ld_s r0,[r0,0x54]
L_8e42d4:
	j_s [blink]
L_8e42d6:
	nop_s
