/* get_g_8003bc @ 0x8ca198, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__setup
 * Глобалы (через gp): 0x8003bc
 */
	.section .text.get_g_8003bc,"ax",@progbits
	.global get_g_8003bc
get_g_8003bc:
	.global L_8ca198
L_8ca198:
	j_s.d [blink]
L_8ca19a:
	ld_s r0,[gp,0x24c]
