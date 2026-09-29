/* hwd_phy__tx_singen_transmit @ 0x8d3100, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, calib_silent_rssi_sparrow__correction_alg
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_singen_transmit
hwd_phy__tx_singen_transmit:
	.global L_8d3100
L_8d3100:
	mov_s r1,0x884000
L_8d3106:
	st_s r0,[r1,0x64]
L_8d3108:
	j_s [blink]
L_8d310a:
	nop_s
