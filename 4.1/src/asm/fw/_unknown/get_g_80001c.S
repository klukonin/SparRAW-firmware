/* get_g_80001c @ 0x8cabd8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__program_sector_desc
 */
	.section .text.get_g_80001c,"ax",@progbits
	.global get_g_80001c
get_g_80001c:
	.global L_8cabd8
L_8cabd8:
	j_s.d [blink]
L_8cabda:
	ld_s r0,[gp,-0x154]
