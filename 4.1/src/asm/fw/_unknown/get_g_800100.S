/* get_g_800100 @ 0x8ca1a0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rs__need_long_term
 */
	.section .text.get_g_800100,"ax",@progbits
	.global get_g_800100
get_g_800100:
	.global L_8ca1a0
L_8ca1a0:
	j_s.d [blink]
L_8ca1a2:
	ld_s r0,[gp,-0x70]
