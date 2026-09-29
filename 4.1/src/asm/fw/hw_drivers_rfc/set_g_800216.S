/* set_g_800216 @ 0x8d0e38, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc__select_chain_and_write
 */
	.section .text.set_g_800216,"ax",@progbits
	.global set_g_800216
set_g_800216:
	.global L_8d0e38
L_8d0e38:
	j_s.d [blink]
L_8d0e3a:
	stb r0,[gp, 0xa6]
L_8d0e3e:
	nop_s
