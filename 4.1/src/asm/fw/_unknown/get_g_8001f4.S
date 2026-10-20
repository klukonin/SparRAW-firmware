/* get_g_8001f4 @ 0x8cabcc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed
 * Глобалы (через gp): 0x8001f4
 */
	.section .text.get_g_8001f4,"ax",@progbits
	.global get_g_8001f4
get_g_8001f4:
	.global L_8cabcc
L_8cabcc:
	j_s.d [blink]
L_8cabce:
	ldw_s r0,[gp,0x84]
