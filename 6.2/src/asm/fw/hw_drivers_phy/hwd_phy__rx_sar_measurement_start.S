/* hwd_phy__rx_sar_measurement_start @ 0x8d2958, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step2, hwd_phy_rx_sar_rssi_measure, hwf_calib_sar_alg
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_sar_measurement_start
hwd_phy__rx_sar_measurement_start:
	.global L_8d2958
L_8d2958:
	mov_s r1,0x885000
L_8d295e:
	ld_s r0,[r1]
L_8d2960:
	bset_s r0,r0,0x6
L_8d2962:
	st_s r0,[r1]
L_8d2964:
	j_s [blink]
L_8d2966:
	nop_s
