/* field_set_0x00__8e6f2c @ 0x8e6f2c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_analog_select_active_rf_module
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8e6f2c
field_set_0x00__8e6f2c:
	.global L_8e6f2c
L_8e6f2c:
	add r0,r0,0x45e
L_8e6f30:
	j_s.d [blink]
L_8e6f32:
	stb_s r1,[r0]
