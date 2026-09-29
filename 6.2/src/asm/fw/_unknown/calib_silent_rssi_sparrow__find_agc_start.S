/* calib_silent_rssi_sparrow__find_agc_start @ 0x8ca5e8, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_silent_rssi_sparrow::find_agc_start(): agc_start_index=%d is smaller than %d (MIN index). Clipping to MIN
 *   calib_silent_rssi_sparrow::find_agc_start(): agc_start_index=%d is greater than %d (MAX index). Clipping to MAX
 *   calib_silent_rssi_sparrow::find_agc_start(): final_agc_start=%d, initial_agc_start=%d, target_rssi=%d,
 *   [NNL] final_measured_rssi=%d, final_error=%d, measured_rssi_before_correction=%d
 *   calib_silent_rssi_sparrow::find_agc_start(): Silent RSSI calib did not converge (error_tolerance=%d). Setting value to edge %d.
 *   calib_silent_rssi_sparrow::find_agc_start(): Silent RSSI calib did not converge (error_tolerance=%d). Setting value to initial_agc_start=%d.
 * Зовут его: calibrate_baseband_gain
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, fw_log_emit2, fw_log_emit3, rf__check_state, silent_rssi__hist_window_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_silent_rssi_sparrow__find_agc_start
calib_silent_rssi_sparrow__find_agc_start:
	.global L_8ca5e8
L_8ca5e8:
	push_s blink
L_8ca5ea:
	bl L_8c01c0
L_8ca5ee:
	mov_s r15,r0
L_8ca5f0:
	mov_s r21,r1
L_8ca5f2:
	mov_s r17,r2
L_8ca5f4:
	mov_s r16,r3
L_8ca5f6:
	mov_s r0,0x883100
L_8ca5fc:
	ld_s r0,[r0,0x38]
L_8ca5fe:
	mov r20,r4
L_8ca602:
	bmsk r18,r0,0x5
L_8ca606:
	mov_s r0,r15
L_8ca608:
	bl.d L_8dde0c
L_8ca60c:
	mov_s r1,r2
L_8ca60e:
	mov_s r14,r0
L_8ca610:
	st_s r0,[r15,0x48]
L_8ca612:
	sub r19,r0,r21
L_8ca616:
	sexb r19,r19
L_8ca61a:
	mov r22,0x0
L_8ca61e:
	mov_s r13,r17
L_8ca620:
	b_s L_8ca64a
	.global L_8ca622
L_8ca622:
	mov_s r1,0x1009cd4
L_8ca628:
	mov_s r0,0x16
L_8ca62a:
	bl.d L_8dcc80
L_8ca62e:
	mov_s r2,r13
L_8ca630:
	ldb r13,[r23, 0x1d]
	.global L_8ca634
L_8ca634:
	mov_s r0,r15
L_8ca636:
	bl.d L_8dde0c
L_8ca63a:
	mov_s r1,r13
L_8ca63c:
	mov_s r14,r0
L_8ca63e:
	sub r19,r0,r21
L_8ca642:
	sexb r19,r19
L_8ca646:
	add r22,r22,0x1
	.global L_8ca64a
L_8ca64a:
	add3 r23,r15,0x14
L_8ca64e:
	ldb r2,[r23, 0x1f]
L_8ca652:
	abs r1,r19
L_8ca656:
	cmp_s r2,r22
L_8ca658:
	cmp.hi r1,r16
L_8ca65c:
	bls_s L_8ca680
L_8ca65e:
	ldb r3,[r23, 0x1d]
L_8ca662:
	add_s r13,r13,r19
L_8ca664:
	brlt r13,r3,L_8ca622
L_8ca668:
	brhs r18,r13,L_8ca634
L_8ca66c:
	mov_s r1,0x1009d44
L_8ca672:
	mov_s r0,0x16
L_8ca674:
	mov_s r2,r13
L_8ca676:
	mov_s r3,r18
L_8ca678:
	bl.d L_8dcc80
L_8ca67c:
	mov_s r13,r18
L_8ca67e:
	b_s L_8ca634
	.global L_8ca680
L_8ca680:
	brlo.d r16,r1,L_8ca6ba
L_8ca684:
	mov_s r0,0x1
	.global L_8ca686
L_8ca686:
	mov_s r16,r0
L_8ca688:
	st r13,[r20]
L_8ca68c:
	mov_s r1,0x1009db4
L_8ca692:
	mov_s r0,0x26
L_8ca694:
	mov_s r2,r13
L_8ca696:
	mov_s r3,r17
L_8ca698:
	bl.d L_8dcd00
L_8ca69c:
	mov r4,r21
L_8ca6a0:
	mov_s r1,0x1009c80
L_8ca6a6:
	ld r4,[r15, 0x48]
L_8ca6aa:
	mov_s r0,0x26
L_8ca6ac:
	mov_s r2,r14
L_8ca6ae:
	bl.d L_8dcd00
L_8ca6b2:
	mov_s r3,r19
L_8ca6b4:
	b.d L_8c020c
L_8ca6b8:
	mov_s r0,r16
	.global L_8ca6ba
L_8ca6ba:
	ldb r0,[r23, 0x1d]
L_8ca6be:
	cmp_s r13,r0
L_8ca6c0:
	cmp.ne r13,r18
L_8ca6c4:
	bne_s L_8ca6d0
L_8ca6c6:
	mov_s r1,0x1009e1c
L_8ca6cc:
	mov_s r0,0x16
L_8ca6ce:
	b_s L_8ca6ea
	.global L_8ca6d0
L_8ca6d0:
	mov_s r0,r15
L_8ca6d2:
	bl.d L_8dde0c
L_8ca6d6:
	mov_s r1,r13
L_8ca6d8:
	mov_s r14,r0
L_8ca6da:
	sub r19,r0,r21
L_8ca6de:
	sexb r19,r19
L_8ca6e2:
	mov_s r1,0x1009e9c
L_8ca6e8:
	mov_s r0,0x6
	.global L_8ca6ea
L_8ca6ea:
	mov_s r2,r16
L_8ca6ec:
	bl.d L_8dcc80
L_8ca6f0:
	mov_s r3,r13
L_8ca6f2:
	bl.d L_8c74b4
L_8ca6f6:
	mov_s r0,r15
L_8ca6f8:
	mov_s r0,0x2
L_8ca6fa:
	b_s L_8ca686
