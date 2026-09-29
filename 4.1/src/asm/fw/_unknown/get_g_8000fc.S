/* get_g_8000fc @ 0x8d8f44, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_deep_sleep_exit_step
 * Зовёт сам: rfc__write_field_484
 */
	.section .text.get_g_8000fc,"ax",@progbits
	.global get_g_8000fc
get_g_8000fc:
	.global L_8d8f44
L_8d8f44:
	mov_s r0,0x0
L_8d8f46:
	b.d L_8d0e40
L_8d8f4a:
	ld.as r1,[gp,-0x1d]
L_8d8f4e:
	nop_s
