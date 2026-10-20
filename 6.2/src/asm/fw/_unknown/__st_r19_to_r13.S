/* __st_r19_to_r13 @ 0x8c01d0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: RADIO_MGR__set_primary_channel, STREAM_MGR__ADD, SW_TX_MGMT_API__send_packet, TX_API__send_dband_bcon, UT_HW_DRIVERS_cmd_handler, brd_if_multi_array, brd_if_multi_array__get_chunk_8cbbc4, calib_engine__on_lock_radio, calib_lo_leakage__sweep, calib_silent_rssi__step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r19_to_r13
__st_r19_to_r13:
	.global L_8c01d0
L_8c01d0:
	st.a r19,[sp,-0x4]
