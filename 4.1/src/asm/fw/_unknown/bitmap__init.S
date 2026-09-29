/* bitmap__init @ 0x8e1140, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frag_8f1908, fwq_tx__handle_completion, l2_mgr__chk_sys_idle, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, scan_mngr__dband_beacon_ind, wmi_handler_get_rf_sector_params__on_radio_locked_cb, wmi_handler_set_rf_sector_params__set_rf_sector_params
 */
	.section .text.bitmap__init,"ax",@progbits
	.global bitmap__init
bitmap__init:
	.global L_8e1140
L_8e1140:
	j_s.d [blink]
L_8e1142:
	st_s r1,[r0]
