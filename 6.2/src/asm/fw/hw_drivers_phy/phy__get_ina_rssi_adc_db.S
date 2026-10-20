/* phy__get_ina_rssi_adc_db @ 0x8d2648, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage_substep, if_gain__get_scaled, phy_stats__dump
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_ina_rssi_adc_db
phy__get_ina_rssi_adc_db:
	.global L_8d2648
L_8d2648:
	mov_s r0,0x883700
L_8d264e:
	ld_s r0,[r0]
L_8d2650:
	j_s.d [blink]
L_8d2652:
	bmsk_s r0,r0,0x5
