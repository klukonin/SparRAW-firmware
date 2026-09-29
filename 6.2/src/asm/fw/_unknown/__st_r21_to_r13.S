/* __st_r21_to_r13 @ 0x8c01c8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD, calib_lo_leakage_step, calib_lo_power_substep, calib_silent_rssi_sparrow__find_rf_gain, dbi_write, dma_mgr__configure_ring, fwq_tx__handle_completion, hwd_phy_rx_read_and_parse_brp_ram, hwd_phy_rx_sar_rssi_measure, hwd_rfc_sector_edge_phase_set
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r21_to_r13
__st_r21_to_r13:
	.global L_8c01c8
L_8c01c8:
	st.a r21,[sp,-0x4]
