/* __ld_r19_to_r13_ret @ 0x8c022c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: RADIO_MGR__set_primary_channel, STREAM_MGR__ADD, SW_TX_MGMT_API__send_packet, TX_API__send_dband_bcon, UT_HW_DRIVERS_cmd_handler, brd_if_multi_array, brd_if_multi_array__get_chunk_8cbbc4, calib_engine__on_lock_radio, calib_lo_leakage__sweep, calib_silent_rssi__step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __ld_r19_to_r13_ret
__ld_r19_to_r13_ret:
	.global L_8c022c
L_8c022c:
	mov_s r12,0x4
	.global L_8c022e
L_8c022e:
	mov_s r13,0x1c
L_8c0230:
	b_s L_8c0284
L_8c0232:
	nop_s
