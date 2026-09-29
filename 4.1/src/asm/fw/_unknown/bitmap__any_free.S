/* bitmap__any_free @ 0x8cb680, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bitmap__alloc_bit, frag_8f1908, fwq_tx__handle_completion, l2_mgr__chk_sys_idle, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, scan_mngr__dband_beacon_ind, wmi_handler_get_rf_sector_params__on_radio_locked_cb, wmi_handler_set_rf_sector_params__set_rf_sector_params
 */
	.section .text.bitmap__any_free,"ax",@progbits
	.global bitmap__any_free
bitmap__any_free:
	.global L_8cb680
L_8cb680:
	ld_s r0,[r0]
L_8cb682:
	sub.f r0,r0,0x0
L_8cb686:
	j_s.d [blink]
L_8cb688:
	mov.ne r0,0x1
