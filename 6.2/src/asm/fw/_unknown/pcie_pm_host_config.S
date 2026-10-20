/* pcie_pm_host_config @ 0x8e033c, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   pcie_pm_host_config:: LnkCtl=0x%x usage7=0x%x
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit2, hwd_pcie__is_l1_state, hwd_pcie__toggle_882f80_bits, hwd_pcie_config_lnkctl, hwd_pcie_l1_pm_sub_ctl_get, hwd_pcie_lnkctl_set, pcie__dbi_write_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_pm_host_config
pcie_pm_host_config:
	.global L_8e033c
L_8e033c:
	push_s blink
L_8e033e:
	bl L_8c01dc
L_8e0342:
	mov_s r14,0x882500
L_8e0348:
	ld_s r0,[r14,0x54]
L_8e034a:
	sub_s sp,sp,0xc
L_8e034c:
	bset_s r0,r0,0x3
L_8e034e:
	st_s r0,[r14,0x54]
L_8e0350:
	mov_s r13,0x1e8480
	.global L_8e0356
L_8e0356:
	/* bl.d 0x008d1054 */
	.byte 0x02,0x0d,0x6f,0xf8
L_8e035a:
	/* _sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e035c:
	brne_s r0,0,L_8e0360
L_8e035e:
	brne_s r13,0,L_8e0356
	.global L_8e0360
L_8e0360:
	brne_s r0,0,L_8e0370
L_8e0362:
	mov_s r2,blink
L_8e0364:
	mov_s r1,0x10030a0
L_8e036a:
	bl.d L_8dcc10
L_8e036e:
	mov_s r0,0x0
	.global L_8e0370
L_8e0370:
	mov_s r15,sp
L_8e0372:
	bl.d L_8d17f8
L_8e0376:
	mov_s r0,r15
L_8e0378:
	add_s r0,sp,0x4
L_8e037a:
	bl.d L_8d164c
L_8e037e:
	mov_s r16,r0
L_8e0380:
	mov_s r1,0x11
L_8e0382:
	asl_s r1,r1,0x13
L_8e0384:
	ld_s r13,[r1,0x1c]
L_8e0386:
	ld_s r0,[sp,0x0]
L_8e0388:
	bbit0 r13,0x1,L_8e03fc
L_8e038c:
	lsr r1,r13,0x2
L_8e0390:
	bmsk_s r1,r1,0x0
L_8e0392:
	lsr r2,r13,0x3
L_8e0396:
	bmsk_s r2,r2,0x0
L_8e0398:
	asl_s r2,r2
L_8e039a:
	bic r0,r0,0x3
L_8e039e:
	bclr_s r1,r1,0x1
L_8e03a0:
	or_s r1,r1,r0
L_8e03a2:
	or_s r1,r1,r2
L_8e03a4:
	lsr r0,r13,0x4
L_8e03a8:
	bmsk_s r0,r0,0x0
L_8e03aa:
	asl_s r0,r0,0x8
L_8e03ac:
	bclr_s r1,r1,0x8
L_8e03ae:
	or_s r0,r0,r1
L_8e03b0:
	st_s r0,[sp,0x0]
L_8e03b2:
	bl.d L_8d1828
L_8e03b6:
	mov_s r0,r15
L_8e03b8:
	lsr r1,r13,0x8
L_8e03bc:
	bmsk_s r1,r1,0x0
L_8e03be:
	ld_s r2,[sp,0x4]
L_8e03c0:
	lsr r0,r13,0x7
L_8e03c4:
	bmsk_s r0,r0,0x0
L_8e03c6:
	asl_s r0,r0
L_8e03c8:
	bic r2,r2,0x3
L_8e03cc:
	bclr_s r1,r1,0x1
L_8e03ce:
	or_s r1,r1,r2
L_8e03d0:
	or_s r0,r0,r1
L_8e03d2:
	lsr r1,r13,0x6
L_8e03d6:
	bmsk_s r1,r1,0x0
L_8e03d8:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e03da:
	lsr r2,r13,0x5
L_8e03de:
	bmsk_s r2,r2,0x0
L_8e03e0:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_8e03e2:
	bic r0,r0,0xc
L_8e03e6:
	bclr_s r1,r1,0x3
L_8e03e8:
	or_s r0,r0,r1
L_8e03ea:
	or_s r2,r2,r0
L_8e03ec:
	st_s r2,[sp,0x4]
L_8e03ee:
	bl.d L_8d167c
L_8e03f2:
	mov_s r0,r16
L_8e03f4:
	bl.d L_8d1554
L_8e03f8:
	mov_s r0,0x1
L_8e03fa:
	b_s L_8e0454
	.global L_8e03fc
L_8e03fc:
	bmsk r3,r0,0x0
L_8e0400:
	/* asl_s r3,r3,0x2 */
	.byte 0x02,0xbb
L_8e0402:
	lsr_s r2,r0
L_8e0404:
	bmsk_s r2,r2,0x0
L_8e0406:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_8e0408:
	bic r13,r13,0xc
L_8e040c:
	bclr_s r3,r3,0x3
L_8e040e:
	or_s r3,r3,r13
L_8e0410:
	or_s r2,r2,r3
L_8e0412:
	lsr_s r0,r0,0x8
L_8e0414:
	bmsk_s r0,r0,0x0
L_8e0416:
	ld_s r3,[sp,0x4]
L_8e0418:
	asl_s r13,r0,0x4
L_8e041a:
	bmsk r0,r3,0x0
L_8e041e:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8e0420:
	bic r2,r2,0x30
L_8e0424:
	bclr_s r13,r13,0x5
L_8e0426:
	or_s r2,r2,r13
L_8e0428:
	or_s r0,r0,r2
L_8e042a:
	lsr_s r2,r3
L_8e042c:
	bmsk_s r2,r2,0x0
L_8e042e:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_8e0430:
	lsr r13,r3,0x2
L_8e0434:
	bmsk_s r13,r13,0x0
L_8e0436:
	/* asl_s r13,r13,0x7 */
	.byte 0x07,0xbd
L_8e0438:
	bic r0,r0,0xc0
L_8e043c:
	bclr_s r2,r2,0x7
L_8e043e:
	or_s r0,r0,r2
L_8e0440:
	or_s r13,r13,r0
L_8e0442:
	lsr_s r3,r3,0x3
L_8e0444:
	bmsk_s r3,r3,0x0
L_8e0446:
	asl_s r3,r3,0x8
L_8e0448:
	bclr_s r13,r13,0x8
L_8e044a:
	bclr_s r13,r13,0x1
L_8e044c:
	bclr_s r3,r3,0x1
L_8e044e:
	or_s r13,r13,r3
L_8e0450:
	bset_s r13,r13,0x1
L_8e0452:
	st_s r13,[r1,0x1c]
	.global L_8e0454
L_8e0454:
	ld_s r0,[r14,0x54]
L_8e0456:
	mov_s r1,0x10030d0
L_8e045c:
	bclr_s r0,r0,0x3
L_8e045e:
	st_s r0,[r14,0x54]
L_8e0460:
	ld_s r2,[sp,0x0]
L_8e0462:
	mov_s r0,0x2e
L_8e0464:
	bl.d L_8dcc80
L_8e0468:
	mov_s r3,r13
L_8e046a:
	b.d L_8c0244
L_8e046e:
	add_s sp,sp,0xc
