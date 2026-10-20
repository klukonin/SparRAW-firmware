/* hw_sysapi_get_rx_energy_data_free_run @ 0x8cded0, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_get_rx_energy_data_free_run(): Failed to measure RSSI since PHY RX is disabled. PHY/RF RX shoud be enabled prior using this API
 *   hw_sysapi_get_rx_energy_data_free_run(): Zero rssi_adc was measured despite PHY_RX_EN=1. Bypassing ADC->ANTENNA conversion. Setting rssi_ant=0
 *   hw_sysapi_get_rx_energy_data_free_run(): | rssi_adc %d | rssi_ant %d | agc_force_en %d
 *   [NNL] | agc_row %d | zero_db_row %d | if_gain_txrx_target %d
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, abif__get_rx_table_index_force_val, fw_log_emit0, fw_log_emit3, hwd_abif__rx_table_index_force_en_get, hwd_phy__rx_is_enabled, phy__get_88312c_6bit, phy_rx__read_rssi_adc, rx_energy__calc_rssi_q4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_get_rx_energy_data_free_run
hw_sysapi_get_rx_energy_data_free_run:
	.global L_8cded0
L_8cded0:
	push_s blink
L_8cded2:
	bl L_8c01dc
L_8cded6:
	mov_s r14,r0
L_8cded8:
	bl.d L_8d21c4
L_8cdedc:
	mov_s r13,0x1
L_8cdede:
	brne_s r0,0,L_8cdef6
L_8cdee0:
	mov_s r0,0x0
L_8cdee2:
	st_s r0,[r14]
L_8cdee4:
	st_s r0,[r14,0x4]
L_8cdee6:
	mov_s r1,0x101a268
L_8cdeec:
	bl.d L_8dcba8
L_8cdef0:
	mov_s r0,0x5
L_8cdef2:
	mov_s r0,0x0
L_8cdef4:
	b_s L_8cdf6a
	.global L_8cdef6
L_8cdef6:
	bl L_8d21f8
L_8cdefa:
	st_s r0,[r14]
L_8cdefc:
	brne_s r0,0,L_8cdf12
L_8cdefe:
	mov_s r0,0x0
L_8cdf00:
	st_s r0,[r14,0x4]
L_8cdf02:
	mov_s r1,0x101a2f4
L_8cdf08:
	bl.d L_8dcba8
L_8cdf0c:
	mov_s r0,0x15
L_8cdf0e:
	mov_s r0,r13
L_8cdf10:
	b_s L_8cdf6a
	.global L_8cdf12
L_8cdf12:
	bl L_8cf59c
L_8cdf16:
	mov.f r16,r0
L_8cdf1a:
	beq_s L_8cdf24
L_8cdf1c:
	bl L_8cf5ec
L_8cdf20:
	mov_s r15,r0
L_8cdf22:
	b_s L_8cdf2a
	.global L_8cdf24
L_8cdf24:
	bl L_8d25a8
L_8cdf28:
	mov_s r15,r0
	.global L_8cdf2a
L_8cdf2a:
	mov_s r13,0x800508
L_8cdf30:
	ld_s r0,[r14]
L_8cdf32:
	mov_s r1,r15
L_8cdf34:
	ldb_s r2,[r13]
L_8cdf36:
	bl.d L_8d1b70
L_8cdf3a:
	ldb r3,[gp, 0xa3]
L_8cdf3e:
	mov_s r3,r0
L_8cdf40:
	st_s r0,[r14,0x4]
L_8cdf42:
	ld_s r2,[r14]
L_8cdf44:
	mov_s r1,0x101a384
L_8cdf4a:
	mov_s r0,0x25
L_8cdf4c:
	bl.d L_8dcd00
L_8cdf50:
	mov r4,r16
L_8cdf54:
	mov_s r1,0x101a3dc
L_8cdf5a:
	ldb r4,[gp, 0xa3]
L_8cdf5e:
	mov_s r0,0x25
L_8cdf60:
	mov_s r2,r15
L_8cdf62:
	bl.d L_8dcd00
L_8cdf66:
	ldb_s r3,[r13]
L_8cdf68:
	mov_s r0,0x1
	.global L_8cdf6a
L_8cdf6a:
	b L_8c0244
L_8cdf6e:
	nop_s
