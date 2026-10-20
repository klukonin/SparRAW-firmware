/* hwd_phy__rx_sar_cal_measurement_config @ 0x8d28ec, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib_sar__enable_path, hwd_phy_rx_sar_rssi_measure
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_sar_cal_measurement_config
hwd_phy__rx_sar_cal_measurement_config:
	.global L_8d28ec
L_8d28ec:
	push_s blink
L_8d28ee:
	bl L_8c01e0
L_8d28f2:
	mov_s r14,r4
L_8d28f4:
	mov_s r15,0x885000
L_8d28fa:
	mov_s r13,r5
L_8d28fc:
	brne_s r0,0,L_8d2904
L_8d28fe:
	ld_s r0,[r15]
L_8d2900:
	bclr_s r0,r0,0x0
L_8d2902:
	b_s L_8d2918
	.global L_8d2904
L_8d2904:
	st_s r14,[r15,0x8]
L_8d2906:
	st_s r13,[r15,0xc]
L_8d2908:
	asl_s r1,r1
L_8d290a:
	add_s r0,r1,0x1
L_8d290c:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8d290e:
	add_s r0,r0,r2
L_8d2910:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8d2912:
	add_s r0,r0,r3
L_8d2914:
	add r0,r0,0x80
	.global L_8d2918
L_8d2918:
	st_s r0,[r15]
L_8d291a:
	b L_8c024c
L_8d291e:
	nop_s
