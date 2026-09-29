/* hwd__program_rf_regs_seq @ 0x8d4338, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_silent_rssi__flag_step, wmi_handler_set_rf_sector_params__set_rf_sector_params
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, rfc_field_write, ut_hw_drivers_cmd_0x508
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__program_rf_regs_seq
hwd__program_rf_regs_seq:
	.global L_8d4338
L_8d4338:
	push_s blink
L_8d433a:
	bl.d L_8c01cc
L_8d433e:
	mov_s r8,r3
L_8d4340:
	mov_s r19,r0
L_8d4342:
	mov_s r15,r1
L_8d4344:
	mov r18,r4
L_8d4348:
	mov r20,r5
L_8d434c:
	mov r16,r6
L_8d4350:
	mov r17,r7
L_8d4354:
	ldb_s r14,[sp,0x28]
L_8d4356:
	asl_s r13,r1,0x6
L_8d4358:
	add1_s r13,r13,r13
L_8d435a:
	breq r2,0x0,L_8d43f2
L_8d435e:
	add r0,r13,0x8000
L_8d4366:
	lsr_s r0,r0,0x3
L_8d4368:
	bic r1,r0,0x3
L_8d436c:
	mov_s r0,r19
L_8d436e:
	bl.d L_8d4308
L_8d4372:
	mov_s r2,r8
L_8d4374:
	add r0,r13,0x8020
L_8d437c:
	lsr_s r0,r0,0x3
L_8d437e:
	bic r1,r0,0x3
L_8d4382:
	mov_s r0,r19
L_8d4384:
	bl.d L_8d4308
L_8d4388:
	mov_s r2,r18
L_8d438a:
	add r0,r13,0x8060
L_8d4392:
	lsr_s r0,r0,0x3
L_8d4394:
	bic r1,r0,0x3
L_8d4398:
	mov_s r0,r19
L_8d439a:
	bl.d L_8d4308
L_8d439e:
	mov_s r2,r20
L_8d43a0:
	add r0,r13,0x8040
L_8d43a8:
	lsr_s r0,r0,0x3
L_8d43aa:
	bic r1,r0,0x3
L_8d43ae:
	mov_s r0,r19
L_8d43b0:
	bl.d L_8d4308
L_8d43b4:
	mov_s r2,r16
L_8d43b6:
	add r0,r13,0x80a0
L_8d43be:
	lsr_s r0,r0,0x3
L_8d43c0:
	bic r1,r0,0x3
L_8d43c4:
	mov_s r0,r19
L_8d43c6:
	bl.d L_8d4308
L_8d43ca:
	mov_s r2,r17
L_8d43cc:
	add_s r13,r13,0x8080
	.global L_8d43d2
L_8d43d2:
	lsr_s r13,r13,0x3
L_8d43d4:
	bic r1,r13,0x3
L_8d43d8:
	mov_s r0,r19
L_8d43da:
	bl.d L_8d4308
L_8d43de:
	ld_s r2,[sp,0x24]
L_8d43e0:
	brge r14,0x10,L_8d43ee
L_8d43e4:
	extb_s r1,r15
L_8d43e6:
	mov_s r0,r19
L_8d43e8:
	bl.d L_8d4104
L_8d43ec:
	mov_s r2,r14
	.global L_8d43ee
L_8d43ee:
	b L_8c0224
	.global L_8d43f2
L_8d43f2:
	add r0,r13,0x10000
L_8d43fa:
	lsr_s r0,r0,0x3
L_8d43fc:
	bic r1,r0,0x3
L_8d4400:
	mov_s r0,r19
L_8d4402:
	bl.d L_8d4308
L_8d4406:
	mov_s r2,r8
L_8d4408:
	add r0,r13,0x10020
L_8d4410:
	lsr_s r0,r0,0x3
L_8d4412:
	bic r1,r0,0x3
L_8d4416:
	mov_s r0,r19
L_8d4418:
	bl.d L_8d4308
L_8d441c:
	mov_s r2,r18
L_8d441e:
	add r0,r13,0x10060
L_8d4426:
	lsr_s r0,r0,0x3
L_8d4428:
	bic r1,r0,0x3
L_8d442c:
	mov_s r0,r19
L_8d442e:
	bl.d L_8d4308
L_8d4432:
	mov_s r2,r20
L_8d4434:
	add r0,r13,0x10040
L_8d443c:
	lsr_s r0,r0,0x3
L_8d443e:
	bic r1,r0,0x3
L_8d4442:
	mov_s r0,r19
L_8d4444:
	bl.d L_8d4308
L_8d4448:
	mov_s r2,r16
L_8d444a:
	add r0,r13,0x100a0
L_8d4452:
	lsr_s r0,r0,0x3
L_8d4454:
	bic r1,r0,0x3
L_8d4458:
	mov_s r0,r19
L_8d445a:
	bl.d L_8d4308
L_8d445e:
	mov_s r2,r17
L_8d4460:
	add_s r13,r13,0x10080
L_8d4466:
	b_s L_8d43d2
