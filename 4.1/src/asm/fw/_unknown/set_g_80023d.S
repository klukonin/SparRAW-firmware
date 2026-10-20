/* set_g_80023d @ 0x8e1a50, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lo_power_gc_ctrl
 */
	.section .text.set_g_80023d,"ax",@progbits
	.global set_g_80023d
set_g_80023d:
	.global L_8e1a50
L_8e1a50:
	j_s.d [blink]
L_8e1a52:
	stb r0,[gp, 0xcd]
L_8e1a56:
	nop_s
