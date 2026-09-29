/* phy_rx__read_rssi_adc_locked @ 0x8d2208, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi_mgr__get_rssi_and_snr_statistics
 * Зовёт сам: bits__sign_extend_n
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy_rx__read_rssi_adc_locked
phy_rx__read_rssi_adc_locked:
	.global L_8d2208
L_8d2208:
	mov_s r0,0x883b80
L_8d220e:
	ld_s r0,[r0,0x6c]
L_8d2210:
	bmsk_s r0,r0,0x9
L_8d2212:
	b.d L_8ea8c0
L_8d2216:
	mov_s r1,0xa
