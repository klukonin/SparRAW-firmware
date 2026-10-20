/* set_g_80023e @ 0x8e1a58, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lo_power_gc_ctrl
 */
	.section .text.set_g_80023e,"ax",@progbits
	.global set_g_80023e
set_g_80023e:
	.global L_8e1a58
L_8e1a58:
	j_s.d [blink]
L_8e1a5a:
	stb r0,[gp, 0xce]
L_8e1a5e:
	nop_s
