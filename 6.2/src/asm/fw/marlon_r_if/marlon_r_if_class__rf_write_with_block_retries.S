/* marlon_r_if_class__rf_write_with_block_retries @ 0x8e3418, 548 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   rf_write_with_block_retries: read failed. Calling hwd_abif_rfc_divider_restart
 *   marlon_r_if_class::rf_write_with_block_retries: RF block write retry %d for starting address=0x%x
 *   marlon_r_if_class::rf_write_with_block_retries: RF block write failed. starting address [0x%x], crc_cnt [%d], num_cur_block_values [%d]
 * Зовут его: handle_omni_sector_info, marlon_r_if_class__load_brd_rf_cfg_section, silent_rssi__set_rf_gain_index, update_rf_xx_gains_tables
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, hwd_abif__rfc_divider_restart, hwd_rfc_write_core_fw, marlon_r_if_class__rf_hw_write_buffer
 * Глобалы (через gp): 0x8003e0, 0x8003e4, 0x8003e8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global marlon_r_if_class__rf_write_with_block_retries
marlon_r_if_class__rf_write_with_block_retries:
	.global L_8e3418
L_8e3418:
	push_s blink
L_8e341a:
	bl L_8c01b8
L_8e341e:
	push_s r0
L_8e3420:
	mov_s r22,r1
L_8e3422:
	mov_s r17,r2
L_8e3424:
	mov_s r24,r3
L_8e3426:
	mov r19,r4
L_8e342a:
	mov r23,r5
L_8e342e:
	mov r25,r6
L_8e3432:
	extb r16,r1
L_8e3436:
	mov_s r0,r16
L_8e3438:
	mov_s r1,0x4
L_8e343a:
	mov r2,0x428
L_8e343e:
	bl.d L_8d415c
L_8e3442:
	mov_s r3,0x0
L_8e3444:
	mov lp_count,0x7d0
L_8e3448:
	mov_s r14,0x889080
L_8e344e:
	lp L_8e345a
L_8e3452:
	ld_s r0,[r14,0x4c]
L_8e3454:
	btst_s r0,0x1d
L_8e3456:
	beq_s L_8e345a
L_8e3458:
	nop_s
	.global L_8e345a
L_8e345a:
	ld_s r0,[r14,0x4c]
L_8e345c:
	bbit0 r0,0x1d,L_8e346e
L_8e3460:
	mov_s r2,blink
L_8e3462:
	mov_s r1,0x1004fbc
L_8e3468:
	bl.d L_8dcc10
L_8e346c:
	mov_s r0,0x0
	.global L_8e346e
L_8e346e:
	mov lp_count,0x30d40
L_8e3476:
	nop_s
L_8e3478:
	lp L_8e3484
L_8e347c:
	ld_s r0,[r14,0x4c]
L_8e347e:
	btst_s r0,0x1d
L_8e3480:
	beq_s L_8e3484
L_8e3482:
	nop_s
	.global L_8e3484
L_8e3484:
	ld_s r0,[r14,0x4c]
L_8e3486:
	bbit0 r0,0x1d,L_8e34a2
L_8e348a:
	mov_s r1,0x1004f9c
L_8e3490:
	bl.d L_8dcba8
L_8e3494:
	mov_s r0,0x0
L_8e3496:
	mov_s r0,blink
L_8e3498:
	mov_s r1,0x1349
L_8e349e:
	bl L_8c9b28
	.global L_8e34a2
L_8e34a2:
	ld_s r1,[r14,0x58]
L_8e34a4:
	mov r18,0x0
L_8e34a8:
	b_s L_8e34ae
	.global L_8e34aa
L_8e34aa:
	add r18,r18,r19
	.global L_8e34ae
L_8e34ae:
	cmp r24,r18
L_8e34b2:
	bls L_8e3632
L_8e34b6:
	add3 r21,r17,r18
L_8e34ba:
	sub r0,r24,r18
L_8e34be:
	cmp r19,r0
L_8e34c2:
	mov.cc r20,r0
L_8e34c6:
	mov.cs r20,r19
L_8e34ca:
	mov_s r13,0x0
L_8e34cc:
	b_s L_8e34d0
	.global L_8e34ce
L_8e34ce:
	mov_s r13,r0
	.global L_8e34d0
L_8e34d0:
	cmp_s r13,0x0
L_8e34d2:
	mov.eq r15,r1
L_8e34d6:
	beq_s L_8e3566
L_8e34d8:
	mov_s r1,0x1005538
L_8e34de:
	bl.d L_8dcba8
L_8e34e2:
	mov_s r0,0x10
L_8e34e4:
	bl.d L_8ceda4
L_8e34e8:
	mov_s r0,0x1
L_8e34ea:
	mov_s r0,r16
L_8e34ec:
	mov_s r1,0x4
L_8e34ee:
	mov r2,0x428
L_8e34f2:
	bl.d L_8d415c
L_8e34f6:
	mov_s r3,0x0
L_8e34f8:
	mov lp_count,0x7d0
L_8e34fc:
	nop_s
L_8e34fe:
	lp L_8e350a
L_8e3502:
	ld_s r0,[r14,0x4c]
L_8e3504:
	btst_s r0,0x1d
L_8e3506:
	beq_s L_8e350a
L_8e3508:
	nop_s
	.global L_8e350a
L_8e350a:
	ld_s r0,[r14,0x4c]
L_8e350c:
	bbit0 r0,0x1d,L_8e351e
L_8e3510:
	mov_s r2,blink
L_8e3512:
	mov_s r1,0x1004fbc
L_8e3518:
	bl.d L_8dcc10
L_8e351c:
	mov_s r0,0x0
	.global L_8e351e
L_8e351e:
	mov lp_count,0x30d40
L_8e3526:
	nop_s
L_8e3528:
	lp L_8e3534
L_8e352c:
	ld_s r0,[r14,0x4c]
L_8e352e:
	btst_s r0,0x1d
L_8e3530:
	beq_s L_8e3534
L_8e3532:
	nop_s
	.global L_8e3534
L_8e3534:
	ld_s r0,[r14,0x4c]
L_8e3536:
	bbit0 r0,0x1d,L_8e3552
L_8e353a:
	mov_s r1,0x1004f9c
L_8e3540:
	bl.d L_8dcba8
L_8e3544:
	mov_s r0,0x0
L_8e3546:
	mov_s r0,blink
L_8e3548:
	mov_s r1,0x1349
L_8e354e:
	bl L_8c9b28
	.global L_8e3552
L_8e3552:
	ld_s r15,[r14,0x58]
L_8e3554:
	mov_s r1,0x1005588
L_8e355a:
	mov_s r0,0x10
L_8e355c:
	mov_s r2,r13
L_8e355e:
	bl.d L_8dcc80
L_8e3562:
	ld r3,[r17]
	.global L_8e3566
L_8e3566:
	ld_s r0,[sp,0x0]
L_8e3568:
	mov_s r1,r22
L_8e356a:
	mov_s r2,r21
L_8e356c:
	bl.d L_8e33d8
L_8e3570:
	mov_s r3,r20
L_8e3572:
	mov_s r0,r16
L_8e3574:
	mov_s r1,0x4
L_8e3576:
	mov r2,0x428
L_8e357a:
	bl.d L_8d415c
L_8e357e:
	mov_s r3,0x0
L_8e3580:
	mov lp_count,0x7d0
L_8e3584:
	nop_s
L_8e3586:
	lp L_8e3592
L_8e358a:
	ld_s r0,[r14,0x4c]
L_8e358c:
	btst_s r0,0x1d
L_8e358e:
	beq_s L_8e3592
L_8e3590:
	nop_s
	.global L_8e3592
L_8e3592:
	ld_s r0,[r14,0x4c]
L_8e3594:
	bbit0 r0,0x1d,L_8e35a6
L_8e3598:
	mov_s r2,blink
L_8e359a:
	mov_s r1,0x1004fbc
L_8e35a0:
	bl.d L_8dcc10
L_8e35a4:
	mov_s r0,0x0
	.global L_8e35a6
L_8e35a6:
	mov lp_count,0x30d40
L_8e35ae:
	nop_s
L_8e35b0:
	lp L_8e35bc
L_8e35b4:
	ld_s r0,[r14,0x4c]
L_8e35b6:
	btst_s r0,0x1d
L_8e35b8:
	beq_s L_8e35bc
L_8e35ba:
	nop_s
	.global L_8e35bc
L_8e35bc:
	ld_s r0,[r14,0x4c]
L_8e35be:
	bbit0 r0,0x1d,L_8e35da
L_8e35c2:
	mov_s r1,0x1004f9c
L_8e35c8:
	bl.d L_8dcba8
L_8e35cc:
	mov_s r0,0x0
L_8e35ce:
	mov_s r0,blink
L_8e35d0:
	mov_s r1,0x1349
L_8e35d6:
	bl L_8c9b28
	.global L_8e35da
L_8e35da:
	ld_s r1,[r14,0x58]
L_8e35dc:
	sub r3,r1,r15
L_8e35e0:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8e35e2:
	add_s r0,r13,0x1
L_8e35e4:
	breq r3,r20,L_8e35ee
L_8e35e8:
	cmp_s r0,r23
L_8e35ea:
	bcs L_8e34ce
	.global L_8e35ee
L_8e35ee:
	ld_s r0,[gp,0x264]
L_8e35f0:
	cmp_s r3,r20
L_8e35f2:
	add_s r0,r0,r13
L_8e35f4:
	st.as r0,[gp,0x99]
L_8e35f8:
	beq_s L_8e34aa
L_8e35fa:
	ld_s r0,[gp,0x260]
L_8e35fc:
	mov_s r1,0x10055ec
L_8e3602:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e3604:
	st.as r0,[gp,0x98]
L_8e3608:
	ld r2,[r21]
L_8e360c:
	mov_s r0,0x0
L_8e360e:
	st.as r2,[gp,0x97]
L_8e3612:
	bl.d L_8dcd00
L_8e3616:
	mov r4,r20
L_8e361a:
	cmp r25,0x0
L_8e361e:
	mov.ne r0,blink
L_8e3622:
	mov.ne r1,0x1344
L_8e362a:
	bl.ne L_8c9b28
L_8e362e:
	mov_s r0,0x0
L_8e3630:
	b_s L_8e3634
	.global L_8e3632
L_8e3632:
	mov_s r0,0x1
	.global L_8e3634
L_8e3634:
	b.d L_8c01fc
L_8e3638:
	add_s sp,sp,0x4
L_8e363a:
	nop_s
