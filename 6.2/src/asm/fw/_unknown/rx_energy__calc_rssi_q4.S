/* rx_energy__calc_rssi_q4 @ 0x8d1b70, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi_mgr__get_rssi_and_snr_statistics, hw_sysapi_get_rx_energy_data_free_run
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_energy__calc_rssi_q4
rx_energy__calc_rssi_q4:
	.global L_8d1b70
L_8d1b70:
	sub_s r2,r2,r1
L_8d1b72:
	lsr_s r3,r3
L_8d1b74:
	add_s r1,r3,0x5
L_8d1b76:
	add_s r1,r1,r2
L_8d1b78:
	sub_s r1,r1,0x11
L_8d1b7a:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d1b7c:
	sub_s r0,r0,r1
L_8d1b7e:
	sub r0,r0,0x230
L_8d1b82:
	j_s.d [blink]
L_8d1b84:
	sub r0,r0,0x260
