/* get_g_8003b0 @ 0x8d9b08, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_get_g_8003b0
 * Глобалы (через gp): 0x8003b0
 */
	.section .text.get_g_8003b0,"ax",@progbits
	.global get_g_8003b0
get_g_8003b0:
	.global L_8d9b08
L_8d9b08:
	ld_s r0,[gp,0x240]
L_8d9b0a:
	ld r1,[r0, 0xc0]
L_8d9b0e:
	ld r0,[r0, 0xbc]
L_8d9b12:
	j_s [blink]
