/* fw_divmod64_signed @ 0x8c047c, 376 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi__send_measure_evt, hwd_phy_rx_sar_rssi_measure, link_stats__report, lmac_if__update_pct_stats, power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_divmod64_signed
fw_divmod64_signed:
	.global L_8c047c
L_8c047c:
	b.d L_8c04ae
L_8c0480:
	mov r4,0x0
L_8c0484:
	xor r4,r1,r3
L_8c0488:
	asl.f 0x0,r1
L_8c048c:
	mov r5,0x0
L_8c0490:
	bcc.d L_8c04a0
L_8c0494:
	rrc r4,r4
L_8c0498:
	rsub.f r0,r0,r5
L_8c049c:
	sbc r1,r5,r1
	.global L_8c04a0
L_8c04a0:
	cmp_s r3,0x0
L_8c04a2:
	bpl L_8c04ae
L_8c04a6:
	rsub.f r2,r2,r5
L_8c04aa:
	sbc r3,r5,r3
	.global L_8c04ae
L_8c04ae:
	or.f r5,r3,r2
L_8c04b2:
	beq L_8c05e0
L_8c04b6:
	mov_s r11,r3
L_8c04b8:
	mov_s r12,r2
L_8c04ba:
	mov_s r2,r0
L_8c04bc:
	mov_s r3,r1
L_8c04be:
	mov.f r5,r11
L_8c04c2:
	mov r10,0x0
L_8c04c6:
	bmi L_8c04de
L_8c04ca:
	add.eq r10,r10,0x20
L_8c04ce:
	mov.eq.f r5,r12
L_8c04d2:
	norm r7,r5
L_8c04d6:
	add.pl r10,r10,0x1
L_8c04da:
	add.pl r10,r10,r7
	.global L_8c04de
L_8c04de:
	mov r7,0x0
L_8c04e2:
	mov.f r5,r3
L_8c04e6:
	add.eq r7,r7,0x20
L_8c04ea:
	bmi L_8c04fe
L_8c04ee:
	mov.eq.f r5,r2
L_8c04f2:
	norm r0,r5
L_8c04f6:
	add.pl r7,r7,0x1
L_8c04fa:
	add.pl r7,r7,r0
	.global L_8c04fe
L_8c04fe:
	rsub.f r7,r7,r10
L_8c0502:
	mov.mi r7,0x0
L_8c0506:
	add r7,r7,0x1
L_8c050a:
	mov r5,r7
L_8c050e:
	cmp r7,0x20
L_8c0512:
	mov_s r1,0x0
L_8c0514:
	bmi.d L_8c0524
L_8c0518:
	mov_s r0,0x0
L_8c051a:
	mov_s r1,r2
L_8c051c:
	mov_s r2,r3
L_8c051e:
	mov_s r3,0x0
L_8c0520:
	sub.f r7,r7,0x20
	.global L_8c0524
L_8c0524:
	mov lp_count,r5
L_8c0528:
	beq L_8c0550
L_8c052c:
	rsub.f r10,r7,0x20
L_8c0530:
	beq L_8c05ae
L_8c0534:
	asl r0,r1,r10
L_8c0538:
	lsr r1,r1,r7
L_8c053c:
	asl r5,r2,r10
L_8c0540:
	add_s r1,r1,r5
L_8c0542:
	lsr r2,r2,r7
L_8c0546:
	asl r5,r3,r10
L_8c054a:
	lsr r3,r3,r7
L_8c054e:
	add_s r2,r2,r5
	.global L_8c0550
L_8c0550:
	cmp r10,0x20
L_8c0554:
	bgt L_8c05be
L_8c0558:
	lp L_8c0584
L_8c055c:
	add.f r0,r0,r0
L_8c0560:
	adc.f r1,r1,r1
L_8c0564:
	adc.f r2,r2,r2
L_8c0568:
	adc r3,r3,r3
L_8c056c:
	sub.f r2,r2,r12
L_8c0570:
	sbc.f r3,r3,r11
L_8c0574:
	bcc L_8c0580
L_8c0578:
	add.f r2,r2,r12
L_8c057c:
	adc.f r3,r3,r11
	.global L_8c0580
L_8c0580:
	add.cc r0,r0,0x1
	.global L_8c0584
L_8c0584:
	sub.f 0x0,r4,0x0
L_8c0588:
	mov r5,0x0
L_8c058c:
	beq L_8c05ac
L_8c0590:
	bge L_8c059c
L_8c0594:
	rsub.f r2,r2,r5
L_8c0598:
	sbc r3,r5,r3
	.global L_8c059c
L_8c059c:
	asl.f r4,r4
L_8c05a0:
	bpl L_8c05ac
L_8c05a4:
	rsub.f r0,r0,r5
L_8c05a8:
	sbc r1,r5,r1
	.global L_8c05ac
L_8c05ac:
	j_s [blink]
	.global L_8c05ae
L_8c05ae:
	mov_s r0,r1
L_8c05b0:
	mov_s r1,r2
L_8c05b2:
	mov_s r2,r3
L_8c05b4:
	mov_s r3,0x0
L_8c05b6:
	/* j 0x00000550 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x50,0x05
	.global L_8c05be
L_8c05be:
	lp L_8c05d8
L_8c05c2:
	add.f r0,r0,r0
L_8c05c6:
	adc.f r1,r1,r1
L_8c05ca:
	adc.f r2,r2,r2
L_8c05ce:
	cmp_s r2,r12
L_8c05d0:
	sub.cc r2,r2,r12
L_8c05d4:
	or.cc r0,r0,0x1
	.global L_8c05d8
L_8c05d8:
	/* j 0x00000584 */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0x84,0x05
	.global L_8c05e0
L_8c05e0:
	mov_s r2,0x0
L_8c05e2:
	sub_s r0,r2,0x1
L_8c05e4:
	mov_s r3,0x0
L_8c05e6:
	lsr r1,r0
L_8c05ea:
	/* j 0x000005ac */
	.byte 0x20,0x20,0x80,0x0f,0x00,0x00,0xac,0x05
L_8c05f2:
	nop_s
