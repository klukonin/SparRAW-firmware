/* phy_rx__read_rssi_adc @ 0x8d21f8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi_mgr__get_rssi_and_snr_statistics, hw_sysapi_get_rx_energy_data_free_run
 * Зовёт сам: bits__sign_extend_n
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy_rx__read_rssi_adc
phy_rx__read_rssi_adc:
	.global L_8d21f8
L_8d21f8:
	mov_s r0,0x883b80
L_8d21fe:
	ld_s r0,[r0,0x64]
L_8d2200:
	bmsk_s r0,r0,0x9
L_8d2202:
	b.d L_8ea8c0
L_8d2206:
	mov_s r1,0xa
