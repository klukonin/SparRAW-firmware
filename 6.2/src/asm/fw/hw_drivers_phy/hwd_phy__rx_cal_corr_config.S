/* hwd_phy__rx_cal_corr_config @ 0x8d2418, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, calib_battery_phy_step, calib_corr__estimate_and_apply_rx_gain, calib_lo_leakage_step, calib_silent_rssi_sparrow__correction_alg, hwf_vga_dc__measure
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_divmod_signed, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_cal_corr_config
hwd_phy__rx_cal_corr_config:
	.global L_8d2418
L_8d2418:
	push_s blink
L_8d241a:
	bl L_8c01dc
L_8d241e:
	mov_s r16,r0
L_8d2420:
	mov_s r15,r1
L_8d2422:
	asl r0,r2,0x10
L_8d2426:
	mov r1,0x528
L_8d242a:
	cmp_s r2,0x0
L_8d242c:
	add.gt r0,r0,r1
L_8d2430:
	sub.le r0,r0,r1
L_8d2434:
	mov_s r1,0xa5
L_8d2436:
	/* bl.d 0x008c02dc */
	.byte 0xaa,0x0e,0xef,0xf6
L_8d243a:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d243c:
	mov_s r14,0x883000
L_8d2442:
	st r16,[r14, 0x58]
L_8d2446:
	bclr.f 0x0,r15,0x0
L_8d244a:
	mov_s r13,r0
L_8d244c:
	bne_s L_8d246a
	.global L_8d244e
L_8d244e:
	ld_s r0,[r14,0x54]
L_8d2450:
	extw_s r13,r13
L_8d2452:
	bclr_s r0,r0,0x1
L_8d2454:
	asl_s r15,r15
L_8d2456:
	or_s r0,r0,r15
L_8d2458:
	and r0,r0,0xfffc0003
L_8d2460:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8d2462:
	or_s r13,r13,r0
L_8d2464:
	st_s r13,[r14,0x54]
L_8d2466:
	b L_8c0244
	.global L_8d246a
L_8d246a:
	mov_s r0,blink
L_8d246c:
	bl.d L_8c9b28
L_8d2470:
	mov_s r1,0xad
L_8d2472:
	b_s L_8d244e
