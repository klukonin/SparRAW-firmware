/* set_reg_88024c @ 0x8e42c0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_set_reg_88024c
 */
	.section .text.set_reg_88024c,"ax",@progbits
	.global set_reg_88024c
set_reg_88024c:
	.global L_8e42c0
L_8e42c0:
	mov_s r1,0x880200
L_8e42c6:
	st_s r0,[r1,0x4c]
L_8e42c8:
	j_s [blink]
L_8e42ca:
	nop_s
