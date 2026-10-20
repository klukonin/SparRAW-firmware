/* phy_stats__dump @ 0x8e8ac0, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HEADER_CRC_ERROR_COUNTER_CP %d | HEADER_CRC_ERROR_COUNTER_SC %d
 *   BER_LAST_NON_ZERO_COUNTER_CP %d | BER_LAST_NON_ZERO_COUNTER_SC %d
 *   SIGNAL_GAIN_ADC_DB %d | SIGNAL_GAIN_ADC_DB_SFD_LOCKED %d
 *   INA_RSSI_ADC_DB %d | INA_RSSI_ADC_DB_SFD_LOCKED %d
 *   agc_start_val_omni:%d agc_start_val_direct:%d g_zero_db_row.row_number:%d
 *   agc_gain_array_val_omni 0x%x | agc_gain_array_val_direct 0x%x
 *   rf_rx_gain_idx[%d] %d
 *   rf_tx_gain_idx[%d] %d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, agc__get_table_pair, calib_obj4__reset_d4, fw_log_emit2, fw_log_emit3, hwd_phy__rx_statistics_clear, hwd_phy__rx_statistics_lock, mac_read_tsf64, phy__get_ina_rssi_adc_db, phy__get_ina_rssi_adc_db_sfd_locked, phy__get_signal_gain_adc_db
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy_stats__dump
phy_stats__dump:
	.global L_8e8ac0
L_8e8ac0:
	push_s blink
L_8e8ac2:
	bl L_8c01e0
L_8e8ac6:
	mov_s r13,r0
L_8e8ac8:
	ld_s r0,[r0,0x38]
L_8e8aca:
	cmp_s r0,0x0
L_8e8acc:
	sub_s sp,sp,0x50
L_8e8ace:
	bne_s L_8e8bf6
L_8e8ad0:
	bl L_8e9524
L_8e8ad4:
	bl L_8d25c0
L_8e8ad8:
	ld_s r0,[r13,0x34]
L_8e8ada:
	cmp_s r0,0x0
L_8e8adc:
	bl.ne L_8d2b00
L_8e8ae0:
	bl.d L_8d25e8
L_8e8ae4:
	mov_s r0,sp
L_8e8ae6:
	ld_s r0,[r13,0x34]
L_8e8ae8:
	cmp_s r0,0x0
L_8e8aea:
	bl.ne L_8d2ae4
L_8e8aee:
	add_s r1,sp,0x38
L_8e8af0:
	mov_s r13,0x0
L_8e8af2:
	mov_s r0,r13
L_8e8af4:
	bl.d L_8e9900
L_8e8af8:
	mov_s r2,r13
L_8e8afa:
	ld_s r2,[sp,0x2c]
L_8e8afc:
	mov_s r1,0x10195e0
L_8e8b02:
	mov_s r0,0x24
L_8e8b04:
	bl.d L_8dcc80
L_8e8b08:
	ld_s r3,[sp,0x10]
L_8e8b0a:
	mov_s r1,0x1019620
L_8e8b10:
	ld_s r2,[sp,0x34]
L_8e8b12:
	mov_s r0,0x24
L_8e8b14:
	bl.d L_8dcc80
L_8e8b18:
	ld_s r3,[sp,0x18]
L_8e8b1a:
	bl L_8d25cc
L_8e8b1e:
	bl.d L_8d25d8
L_8e8b22:
	mov_s r15,r0
L_8e8b24:
	mov_s r3,r0
L_8e8b26:
	mov_s r1,0x1019664
L_8e8b2c:
	mov_s r0,0x24
L_8e8b2e:
	bl.d L_8dcc80
L_8e8b32:
	mov_s r2,r15
L_8e8b34:
	bl L_8d2648
L_8e8b38:
	bl.d L_8d2654
L_8e8b3c:
	mov_s r15,r0
L_8e8b3e:
	mov_s r3,r0
L_8e8b40:
	mov_s r1,0x10196a0
L_8e8b46:
	mov_s r0,0x24
L_8e8b48:
	bl.d L_8dcc80
L_8e8b4c:
	mov_s r2,r15
L_8e8b4e:
	st_s r13,[sp,0x40]
L_8e8b50:
	st_s r13,[sp,0x44]
L_8e8b52:
	st_s r13,[sp,0x48]
L_8e8b54:
	bl.d L_8cbb90
L_8e8b58:
	st_s r13,[sp,0x4c]
L_8e8b5a:
	mov_s r15,r0
L_8e8b5c:
	add_s r2,sp,0x40
L_8e8b5e:
	add_s r3,sp,0x44
L_8e8b60:
	bl.d L_8cb804
L_8e8b64:
	mov_s r1,0x1
L_8e8b66:
	add_s r2,sp,0x48
L_8e8b68:
	add_s r3,sp,0x4c
L_8e8b6a:
	mov_s r0,r15
L_8e8b6c:
	bl.d L_8cb804
L_8e8b70:
	mov_s r1,r13
L_8e8b72:
	mov_s r0,0x800508
L_8e8b78:
	ldb r4,[r0]
L_8e8b7c:
	mov_s r1,0x10196d4
L_8e8b82:
	ld_s r2,[sp,0x40]
L_8e8b84:
	mov_s r0,0x24
L_8e8b86:
	bl.d L_8dcd00
L_8e8b8a:
	ld_s r3,[sp,0x48]
L_8e8b8c:
	mov_s r1,0x1019720
L_8e8b92:
	ld_s r2,[sp,0x44]
L_8e8b94:
	mov_s r0,0x24
L_8e8b96:
	bl.d L_8dcc80
L_8e8b9a:
	ld_s r3,[sp,0x4c]
L_8e8b9c:
	b_s L_8e8be0
	.global L_8e8b9e
L_8e8b9e:
	mov_s r0,0x8042c8
L_8e8ba4:
	bl L_8ccb3c
L_8e8ba8:
	bbit0 r0,r13,L_8e8bde
L_8e8bac:
	extb_s r14,r13
L_8e8bae:
	mov_s r0,r15
L_8e8bb0:
	bl.d L_8cca84
L_8e8bb4:
	mov_s r1,r14
L_8e8bb6:
	mov_s r3,r0
L_8e8bb8:
	mov_s r1,0x1019760
L_8e8bbe:
	mov_s r0,0x24
L_8e8bc0:
	bl.d L_8dcc80
L_8e8bc4:
	mov_s r2,r13
L_8e8bc6:
	mov_s r0,r15
L_8e8bc8:
	bl.d L_8ccb18
L_8e8bcc:
	mov_s r1,r14
L_8e8bce:
	mov_s r3,r0
L_8e8bd0:
	mov_s r1,0x1019778
L_8e8bd6:
	mov_s r0,0x24
L_8e8bd8:
	bl.d L_8dcc80
L_8e8bdc:
	mov_s r2,r13
	.global L_8e8bde
L_8e8bde:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8e8be0
L_8e8be0:
	brlo r13,0x8,L_8e8b9e
L_8e8be4:
	mov_s r13,0x8
	.global L_8e8be6
L_8e8be6:
	mov_s r0,0x8042c8
L_8e8bec:
	/* bl.d 0x008ccb3c */
	.byte 0x52,0x0f,0xef,0xf1
L_8e8bf0:
	/* _sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e8bf2:
	brhs r13,0x1,L_8e8be6
	.global L_8e8bf6
L_8e8bf6:
	b.d L_8c024c
L_8e8bfa:
	add_s sp,sp,0x50
