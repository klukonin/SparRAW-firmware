/* set_g_8001f6_x2 @ 0x8e159c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lo_power_gc_ctrl
 * Глобалы (через gp): 0x8001f6, 0x8001f8
 */
	.section .text.set_g_8001f6_x2,"ax",@progbits
	.global set_g_8001f6_x2
set_g_8001f6_x2:
	.global L_8e159c
L_8e159c:
	stw.as r0,[gp,0x43]
L_8e15a0:
	j_s.d [blink]
L_8e15a2:
	stw.as r1,[gp,0x44]
L_8e15a6:
	nop_s
