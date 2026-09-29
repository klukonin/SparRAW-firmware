/* get_g_80035c @ 0x8ca008, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, POWER_MNGR__halt, assert__restore_hw_for_dump, deep_sleep_enter, power_deep_sleep_exit_step
 * Глобалы (через gp): 0x80035c
 */
	.section .text.get_g_80035c,"ax",@progbits
	.global get_g_80035c
get_g_80035c:
	.global L_8ca008
L_8ca008:
	j_s.d [blink]
L_8ca00a:
	ld_s r0,[gp,0x1ec]
