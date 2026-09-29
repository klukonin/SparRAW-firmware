/* get_g_800227 @ 0x8ca80c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_get_rf_sector_params__check_inputs_valid, wmi_handler_get_rf_sector_params__on_radio_locked_cb, wmi_handler_set_rf_sector_params__set_rf_sector_params, wmi_handler_set_rf_sector_params__verify_inputs
 * Глобалы (через gp): 0x800227
 */
	.section .text.get_g_800227,"ax",@progbits
	.global get_g_800227
get_g_800227:
	.global L_8ca80c
L_8ca80c:
	j_s.d [blink]
L_8ca80e:
	ldb_s r0,[gp,0xb7]
