/* TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters @ 0x8e2274, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TEMPERATURE_SERVICE::read_sensor_calibration_parameters() RF not calibrated!
 *   TEMPERATURE_SERVICE::read_rf_sensor_calibration_parameters() RF temperature param could not be read from OTP!
 *   TEMPERATURE_SERVICE::read_rf_sensor_calibration_parameters() ambient param could not be read from sensor!
 *   TEMPERATURE_SERVICE::read_rf_sensor_calibration_parameters() Calibration values - Tamb=%d, Initial Temp=%d, Delta(mult10)=%d
 * Зовут его: perform_first_measurement_operations
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit3, hwd_abif__dvs_rfca_cmd_enable, hwf_rf_xpm_read_block_8f4b70, rf_cfg__get_rf_mask_45e, rfca__get_rf_mask
 * Глобалы (через gp): 0x800454
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters
TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters:
	.global L_8e2274
L_8e2274:
	push_s blink
L_8e2276:
	bl L_8c01dc
L_8e227a:
	bl.d L_8ce9c4
L_8e227e:
	sub_s sp,sp,0x8
L_8e2280:
	mov_s r16,r0
L_8e2282:
	mov_s r0,0x8042c8
L_8e2288:
	bl.d L_8ccb3c
L_8e228c:
	mov_s r14,0x0
L_8e228e:
	mov_s r15,r0
L_8e2290:
	b_s L_8e22a2
	.global L_8e2292
L_8e2292:
	mov_s r1,0x1011fa0
L_8e2298:
	bl.d L_8dcba8
L_8e229c:
	mov_s r0,0x16
	.global L_8e229e
L_8e229e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e22a0:
	extb_s r14,r14
	.global L_8e22a2
L_8e22a2:
	brhs r14,0x8,L_8e2338
L_8e22a6:
	mov_s r13,0x0
L_8e22a8:
	bset r13,r13,r14
L_8e22ac:
	tst_s r13,r15
L_8e22ae:
	beq_s L_8e229e
L_8e22b0:
	extb_s r0,r13
L_8e22b2:
	bl.d L_8ce910
L_8e22b6:
	mov_s r1,0x0
L_8e22b8:
	mov_s r3,sp
L_8e22ba:
	mov_s r0,r14
L_8e22bc:
	mov r1,0x2f0
L_8e22c0:
	bl.d L_8f4b70
L_8e22c4:
	mov_s r2,0x2
L_8e22c6:
	brne_s r0,0,L_8e22d6
L_8e22c8:
	mov_s r1,0x1011ff0
	.global L_8e22ce
L_8e22ce:
	bl.d L_8dcba8
L_8e22d2:
	mov_s r0,0x6
L_8e22d4:
	b_s L_8e229e
	.global L_8e22d6
L_8e22d6:
	add r3,sp,0x2
L_8e22da:
	mov_s r0,r14
L_8e22dc:
	mov r1,0x300
L_8e22e0:
	bl.d L_8f4b70
L_8e22e4:
	mov_s r2,0x2
L_8e22e6:
	brne_s r0,0,L_8e22f0
L_8e22e8:
	mov_s r1,0x1012060
L_8e22ee:
	b_s L_8e22ce
	.global L_8e22f0
L_8e22f0:
	ldw.x r2,[sp, 0x2]
L_8e22f4:
	brne_s r2,0,L_8e2304
L_8e22f6:
	mov_s r2,0xbb8
L_8e22fc:
	stw 0xbb8,[sp, 0x2]
	.global L_8e2304
L_8e2304:
	ldw.x r3,[sp]
L_8e2308:
	breq_s r3,0,L_8e2292
L_8e230a:
	sub r0,r2,r3
L_8e230e:
	add r4,r0,r0
L_8e2312:
	add2 r4,r4,r4
L_8e2316:
	mov_s r0,0x8019ec
L_8e231c:
	add2_s r0,r0,r14
L_8e231e:
	st r4,[r0]
L_8e2322:
	ld_s r0,[gp,0x2d0]
L_8e2324:
	mov_s r1,0x10120cc
L_8e232a:
	or_s r0,r0,r13
L_8e232c:
	st.as r0,[gp,0xb4]
L_8e2330:
	bl.d L_8dcd00
L_8e2334:
	mov_s r0,0x26
L_8e2336:
	b_s L_8e229e
	.global L_8e2338
L_8e2338:
	mov_s r0,r16
L_8e233a:
	bl.d L_8ce910
L_8e233e:
	mov_s r1,0x0
L_8e2340:
	b.d L_8c0244
L_8e2344:
	add_s sp,sp,0x8
L_8e2346:
	nop_s
