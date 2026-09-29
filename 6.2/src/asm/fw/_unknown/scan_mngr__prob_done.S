/* scan_mngr__prob_done @ 0x8f74c4, 428 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::prob_done()
 *   scan_mngr::prob_done() BSSID in the pending list
 *   scan_mngr::prob_done() delete pending event for: ADDR-%04X%08X
 *   scan_mngr::prob_done() delete pending event for prob_resp_timeout_event_id: %d
 *   scan_mngr::prob_done() move from pending list to scanned list BSSID ADDR-%04X%08X
 *   scan_mngr::prob_done() FREE DBAND INFO ELEMENT (probe failed reason = 0x%x)
 *   scan_mngr::prob_done() SCAN CID:%d LINK_ACQ_FAILURE reason: %d m_curr_conn_ptr:0x%X
 *   scan_mngr::prob_done() SCAN CID:%d LINK_BF_FAILURE reason: %d m_curr_conn_ptr:0x%X
 * Зовут его: probe_resp_ind, scan_mngr__connect, scan_mngr__handle_link_up_event, scan_mngr__prob_resp_timeout_cb
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, channels_switch_sm__action_abort_dwelling, conn__abort, conn_mgr__activate_conn, conn_mgr__link_down_evt, connection__init, free_dband_info, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3
 * Глобалы (через gp): 0x800231
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__prob_done
scan_mngr__prob_done:
	.global L_8f74c4
L_8f74c4:
	push_s blink
L_8f74c6:
	bl L_8c01dc
L_8f74ca:
	mov_s r15,r0
L_8f74cc:
	mov_s r13,r1
L_8f74ce:
	mov_s r14,r2
L_8f74d0:
	mov_s r1,0x1015c14
L_8f74d6:
	bl.d L_8dcba8
L_8f74da:
	mov_s r0,0x29
L_8f74dc:
	cmp_s r14,0x0
L_8f74de:
	beq_s L_8f766c
L_8f74e0:
	mov_s r1,0x1015c2c
L_8f74e6:
	bl.d L_8dcba8
L_8f74ea:
	mov_s r0,0x29
L_8f74ec:
	mov_s r0,0x4
L_8f74ee:
	stb r0,[r14, 0x41]
L_8f74f2:
	ld_s r0,[r14,0x48]
L_8f74f4:
	breq_s r0,0,L_8f751e
L_8f74f6:
	ldw_s r2,[r14,0xc]
L_8f74f8:
	mov_s r1,0x1015c60
L_8f74fe:
	mov_s r0,0x29
L_8f7500:
	bl.d L_8dcc80
L_8f7504:
	ld_s r3,[r14,0x8]
L_8f7506:
	mov_s r1,0x1015ca0
L_8f750c:
	mov_s r0,0x29
L_8f750e:
	bl.d L_8dcc10
L_8f7512:
	ld_s r2,[r14,0x48]
L_8f7514:
	bl.d L_8c8de0
L_8f7518:
	ld_s r0,[r14,0x48]
L_8f751a:
	mov_s r0,0x0
L_8f751c:
	st_s r0,[r14,0x48]
	.global L_8f751e
L_8f751e:
	ld r16,[r14, 0x44]
L_8f7522:
	brne_s r13,0,L_8f7556
L_8f7524:
	ldw_s r2,[r14,0xc]
L_8f7526:
	mov_s r1,0x1015cf0
L_8f752c:
	mov_s r0,0x29
L_8f752e:
	bl.d L_8dcc80
L_8f7532:
	ld_s r3,[r14,0x8]
L_8f7534:
	mov_s r0,r15
L_8f7536:
	bl.d L_8e2884
L_8f753a:
	mov_s r1,r14
L_8f753c:
	ldb_s r0,[gp,0xad]
L_8f753e:
	brlt r0,0x2,L_8f754a
L_8f7542:
	bl.d L_8f31a0
L_8f7546:
	mov_s r0,r14
L_8f7548:
	b_s L_8f757e
	.global L_8f754a
L_8f754a:
	add r0,r15,0xc
L_8f754e:
	bl.d L_8c25f4
L_8f7552:
	mov_s r1,r14
L_8f7554:
	b_s L_8f757e
	.global L_8f7556
L_8f7556:
	mov_s r1,0x1015d44
L_8f755c:
	mov_s r0,0x29
L_8f755e:
	bl.d L_8dcc10
L_8f7562:
	mov_s r2,r13
L_8f7564:
	brne r13,0x3,L_8f756e
L_8f7568:
	ldb r0,[r14, 0x42]
L_8f756c:
	breq_s r0,0,L_8f757e
	.global L_8f756e
L_8f756e:
	mov_s r0,r15
L_8f7570:
	bl.d L_8e2884
L_8f7574:
	mov_s r1,r14
L_8f7576:
	bl.d L_8f31a0
L_8f757a:
	mov_s r0,r14
L_8f757c:
	mov_s r14,0x0
	.global L_8f757e
L_8f757e:
	breq r16,0x0,L_8f764c
L_8f7582:
	ldb r0,[r16, 0xf0]
L_8f7586:
	breq r0,0x2,L_8f764c
L_8f758a:
	brne r13,0x1,L_8f75a6
L_8f758e:
	mov_s r1,0x1015d90
L_8f7594:
	mov_s r0,0x19
L_8f7596:
	ldb r2,[r16, 0x8]
L_8f759a:
	mov_s r3,r13
L_8f759c:
	bl.d L_8dcd00
L_8f75a0:
	mov r4,r16
L_8f75a4:
	b_s L_8f764c
	.global L_8f75a6
L_8f75a6:
	brne r13,0x2,L_8f75b6
L_8f75aa:
	mov_s r1,0x1015de4
L_8f75b0:
	ldb r2,[r16, 0x8]
L_8f75b4:
	b_s L_8f763a
	.global L_8f75b6
L_8f75b6:
	brne r13,0x3,L_8f7614
L_8f75ba:
	breq_s r14,0,L_8f7614
L_8f75bc:
	mov_s r1,0x1015e38
L_8f75c2:
	add_s r14,r14,0x40
L_8f75c4:
	mov_s r0,0x29
L_8f75c6:
	bl.d L_8dcc10
L_8f75ca:
	ldb_s r2,[r14,0x2]
L_8f75cc:
	mov_s r1,0x1015e64
L_8f75d2:
	mov_s r0,0x29
L_8f75d4:
	ldb r2,[r16, 0x8]
L_8f75d8:
	mov_s r3,r13
L_8f75da:
	bl.d L_8dcd00
L_8f75de:
	mov r4,r16
L_8f75e2:
	ldb_s r0,[r14,0x2]
L_8f75e4:
	mov_s r1,0x1
L_8f75e6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f75e8:
	extb_s r0,r0
L_8f75ea:
	stb_s r0,[r14,0x2]
L_8f75ec:
	mov_s r0,0x3
L_8f75ee:
	stb_s r0,[r14]
L_8f75f0:
	stb_s r1,[r14,0x1]
L_8f75f2:
	bl.d L_8f0444
L_8f75f6:
	mov_s r0,r16
L_8f75f8:
	add r1,r16,0x1c
L_8f75fc:
	mov_s r0,r16
L_8f75fe:
	bl.d L_8f54a4
L_8f7602:
	ld r2,[r16, 0x18]
L_8f7606:
	mov_s r1,0x0
L_8f7608:
	st r1,[r16, 0x2c]
L_8f760c:
	bl.d L_8c2460
L_8f7610:
	mov_s r0,r16
L_8f7612:
	b_s L_8f764c
	.global L_8f7614
L_8f7614:
	ld r0,[r16, 0x18]
L_8f7618:
	ld_s r0,[r0,0x50]
L_8f761a:
	cmp_s r0,0x1
L_8f761c:
	mov_s r0,0x1
L_8f761e:
	sub_s.ne r0,r0,r0
L_8f7620:
	extb.f 0x0,r0
L_8f7624:
	bne_s L_8f7630
L_8f7626:
	mov_s r0,0x803c00
L_8f762c:
	ld_s r0,[r0,0xc]
L_8f762e:
	breq_s r0,0,L_8f764c
	.global L_8f7630
L_8f7630:
	ldb r2,[r16, 0x8]
L_8f7634:
	mov_s r1,0x1015f08
	.global L_8f763a
L_8f763a:
	mov_s r0,0x29
L_8f763c:
	mov_s r3,r13
L_8f763e:
	bl.d L_8dcd00
L_8f7642:
	mov r4,r16
L_8f7646:
	bl.d L_8daae8
L_8f764a:
	mov_s r0,r16
	.global L_8f764c
L_8f764c:
	ld_s r0,[r15,0x6c]
L_8f764e:
	brne r0,0x3,L_8f766c
L_8f7652:
	mov_s r1,0x1015f5c
L_8f7658:
	bl.d L_8dcba8
L_8f765c:
	mov_s r0,0x29
L_8f765e:
	ld r0,[r15, 0x80]
L_8f7662:
	mov_s r1,0x0
L_8f7664:
	mov_s r2,r1
L_8f7666:
	bl.d L_8c203c
L_8f766a:
	mov_s r3,r1
	.global L_8f766c
L_8f766c:
	b L_8c0244
