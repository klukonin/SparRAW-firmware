/* rf__get_connected_mask @ 0x8ccb38, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_exit, hw_sysapi_rfc_fetch_rgf_util, hwm_analog_select_active_rf_module, link_lost_diag_part2, rf__restore_if_needed, rfc__collect_rx_crc_stats, rfc__probe_modules
 * Глобалы (через gp): 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__get_connected_mask
rf__get_connected_mask:
	.global L_8ccb38
L_8ccb38:
	j_s.d [blink]
L_8ccb3a:
	ldb_s r0,[gp,0xbf]
