/* hwm_analog__save_rfc_enabled @ 0x8e6f24, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_analog_select_active_rf_module
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm_analog__save_rfc_enabled
hwm_analog__save_rfc_enabled:
	.global L_8e6f24
L_8e6f24:
	j_s.d [blink]
L_8e6f26:
	stb r1,[gp, 0xbe]
L_8e6f2a:
	nop_s
