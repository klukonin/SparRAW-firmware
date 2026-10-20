/* hwd_phy__rx_sar_measurement_completed @ 0x8d2920, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step2, hwd_phy_rx_sar_rssi_measure, hwf_calib_sar_alg
 * Зовёт сам: fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_sar_measurement_completed
hwd_phy__rx_sar_measurement_completed:
	.global L_8d2920
L_8d2920:
	push_s blink
L_8d2922:
	mov_s r1,0x0
L_8d2924:
	bset_s r1,r1,0x18
	.global L_8d2926
L_8d2926:
	mov_s r0,0x885000
L_8d292c:
	ld_s r0,[r0,0x4]
L_8d292e:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8d2930:
	bbit1 r0,0xd,L_8d2936
L_8d2934:
	brne_s r1,0,L_8d2926
	.global L_8d2936
L_8d2936:
	bbit1 r0,0xd,L_8d2952
L_8d293a:
	mov_s r1,0x101d828
L_8d2940:
	bl.d L_8dcba8
L_8d2944:
	mov_s r0,0x0
L_8d2946:
	mov_s r0,blink
L_8d2948:
	mov_s r1,0x1333
L_8d294e:
	bl L_8c9b28
	.global L_8d2952
L_8d2952:
	pop_s blink
L_8d2954:
	j_s [blink]
L_8d2956:
	nop_s
