/* hwd_phy__rx_cal_gain_measurement_read @ 0x8d24bc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_phy_rx_sar_rssi_measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_cal_gain_measurement_read
hwd_phy__rx_cal_gain_measurement_read:
	.global L_8d24bc
L_8d24bc:
	push_s r13
L_8d24be:
	mov_s r2,0x885090
L_8d24c4:
	add3_s r2,r2,r0
L_8d24c6:
	ld_s r3,[r2]
L_8d24c8:
	mov_s r2,0x885094
L_8d24ce:
	add3_s r2,r2,r0
L_8d24d0:
	ld_s r2,[r2]
L_8d24d2:
	asl_s r2,r2,0x18
L_8d24d4:
	add_s r2,r2,r3
L_8d24d6:
	st_s r2,[r1]
L_8d24d8:
	mov_s r2,0x8850d0
L_8d24de:
	mov_s r3,0x0
L_8d24e0:
	add3_s r2,r2,r0
L_8d24e2:
	st_s r3,[r1,0x4]
L_8d24e4:
	ld_s r13,[r2]
L_8d24e6:
	mov_s r2,0x8850d4
L_8d24ec:
	add3_s r2,r2,r0
L_8d24ee:
	ld_s r0,[r2]
L_8d24f0:
	st_s r3,[r1,0xc]
L_8d24f2:
	asl_s r0,r0,0x18
L_8d24f4:
	add_s r13,r13,r0
L_8d24f6:
	st_s r13,[r1,0x8]
L_8d24f8:
	j_s.d [blink]
L_8d24fa:
	pop_s r13
