/* calib__setup_loopback_rx_path @ 0x8d4d90, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: hwd__args_to_regs_default, hwd_abif__caf_lpbk_mode, hwd_abif__rx_prepare_ifrx_pwdn, hwd_abif__rx_table_index_force_mode, hwd_phy__rx_agc_steps_disable, hwd_phy__rx_cal_corr_config, hwd_phy__rx_enable, hwd_phy__rx_ina_det_mode, hwd_phy__self_mode_exit, hwd_phy__self_rx_mode_entry, hwd_phy__set_rx_swap_iq, hwd_phy__tx_enable
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__setup_loopback_rx_path
calib__setup_loopback_rx_path:
	.global L_8d4d90
L_8d4d90:
	push_s blink
L_8d4d92:
	bl L_8d65e8
L_8d4d96:
	bl.d L_8d219c
L_8d4d9a:
	mov_s r0,0x0
L_8d4d9c:
	bl.d L_8d21d0
L_8d4da0:
	mov_s r0,0x0
L_8d4da2:
	bl.d L_8ce5e8
L_8d4da6:
	mov_s r0,0x0
L_8d4da8:
	bl.d L_8d7560
L_8d4dac:
	mov_s r0,0x0
L_8d4dae:
	bl L_8d2b38
L_8d4db2:
	mov_s r0,0x8042c8
L_8d4db8:
	bl L_8ccb3c
L_8d4dbc:
	bl L_8d3380
L_8d4dc0:
	bl.d L_8cee2c
L_8d4dc4:
	mov_s r0,0x7
L_8d4dc6:
	mov_s r0,0x0
L_8d4dc8:
	bset_s r0,r0,0xd
L_8d4dca:
	mov_s r1,0x1
L_8d4dcc:
	bl.d L_8d2418
L_8d4dd0:
	mov_s r2,0x0
L_8d4dd2:
	bl L_8d2ba4
L_8d4dd6:
	bl.d L_8d2260
L_8d4dda:
	mov_s r0,0x1
L_8d4ddc:
	bl.d L_8d2630
L_8d4de0:
	mov_s r0,0x0
L_8d4de2:
	bl.d L_8d7560
L_8d4de6:
	mov_s r0,0x1
L_8d4de8:
	mov_s r0,0x0
L_8d4dea:
	bl.d L_8cf5a8
L_8d4dee:
	mov_s r1,r0
L_8d4df0:
	mov_s r0,0x1
L_8d4df2:
	bl.d L_8cf5a8
L_8d4df6:
	mov_s r1,0x1
L_8d4df8:
	bl.d L_8d2c1c
L_8d4dfc:
	mov_s r0,0x0
L_8d4dfe:
	pop_s blink
L_8d4e00:
	j_s [blink]
L_8d4e02:
	nop_s
