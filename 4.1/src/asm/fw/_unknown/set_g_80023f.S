/* set_g_80023f @ 0x8e1a60, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lo_power_gc_ctrl
 */
	.section .text.set_g_80023f,"ax",@progbits
	.global set_g_80023f
set_g_80023f:
	.global L_8e1a60
L_8e1a60:
	j_s.d [blink]
L_8e1a62:
	stb r0,[gp, 0xcf]
L_8e1a66:
	nop_s
