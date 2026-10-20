/* hwm_calib__set_loopback_mode @ 0x8d7560, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw, init_rf_hw
 * Зовёт сам: hwd_abif__caf_lpbk_mode, hwd_abif__lpbk_mode_switches_config, hwd_mac__sxd_mode_neutral, hwd_mac__sxd_rx_mode_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm_calib__set_loopback_mode
hwm_calib__set_loopback_mode:
	.global L_8d7560
L_8d7560:
	push_s blink
L_8d7562:
	breq_s r0,0,L_8d757a
L_8d7564:
	bl.d L_8ce5e8
L_8d7568:
	mov_s r0,0x0
L_8d756a:
	mov_s r0,0x3
L_8d756c:
	mov_s r1,0x2
L_8d756e:
	bl.d L_8ceb2c
L_8d7572:
	mov_s r2,0x0
L_8d7574:
	bl L_8d0ff8
L_8d7578:
	b_s L_8d757e
	.global L_8d757a
L_8d757a:
	bl L_8d0fe0
	.global L_8d757e
L_8d757e:
	pop_s blink
L_8d7580:
	j_s [blink]
L_8d7582:
	nop_s
