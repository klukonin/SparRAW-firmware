/* get_g_800384 @ 0x8ca138, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__program_sector_desc
 * Глобалы (через gp): 0x800384
 */
	.section .text.get_g_800384,"ax",@progbits
	.global get_g_800384
get_g_800384:
	.global L_8ca138
L_8ca138:
	j_s.d [blink]
L_8ca13a:
	ld_s r0,[gp,0x214]
