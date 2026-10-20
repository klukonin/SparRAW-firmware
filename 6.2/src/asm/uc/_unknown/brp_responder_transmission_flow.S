/* brp_responder_transmission_flow @ 0x923314, 608 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HH brp_responder_transmission_flow l_rx = %d and includes TRN-R (rx_trn_resp)= %d
 * Зовут его: brp_responder_flow_enter
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__set_u8_s0_w5_uc, brp__set_phy_884060, brp__set_tx_sector_id, direct_tx__program_cmd34, mac__program_tx_common, mac__rf_switch_cmd1f, mac__set_mode_a000, mac__set_rf_chain_state, mac_evt__enable_bit_sync_b, mac_mode__send_direct_frame
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_responder_transmission_flow
brp_responder_transmission_flow:
	.global L_923314
L_923314:
	push_s blink
L_923316:
	bl.d L_920234
L_92331a:
	mov_s r1,0x0
L_92331c:
	mov_s r0,0x800864
L_923322:
	ldb_s r13,[r0,0x18]
L_923324:
	mov_s r0,0x8006b4
L_92332a:
	bl.d L_928b8c
L_92332e:
	ldb_s r0,[r0,0x2]
L_923330:
	bl L_92a754
L_923334:
	bl.d L_92c5e4
L_923338:
	mov_s r0,0x0
L_92333a:
	mov_s r0,0x1f006000
L_923340:
	mov_s r32,r0
L_923342:
	st.ab r0,[r25,0x4]
L_923346:
	bclr r25,r25,0xa
L_92334a:
	mov_s r1,0x80110c
L_923350:
	asl_s r0,r13,0x4
L_923352:
	add2_s r0,r0,r0
L_923354:
	ld_s r14,[r1,r0]
L_923356:
	mov_s r0,0x38000300
L_92335c:
	mov_s r32,r0
L_92335e:
	st.ab r0,[r25,0x4]
L_923362:
	bclr r25,r25,0xa
L_923366:
	mov_s r0,0x3600003f
L_92336c:
	mov_s r32,r0
L_92336e:
	st.ab r0,[r25,0x4]
L_923372:
	bclr r25,r25,0xa
L_923376:
	mov_s r0,0x6000101
L_92337c:
	mov_s r32,r0
L_92337e:
	st.ab r0,[r25,0x4]
L_923382:
	bclr r25,r25,0xa
L_923386:
	mov_s r0,0x37000005
L_92338c:
	mov_s r32,r0
L_92338e:
	st.ab r0,[r25,0x4]
L_923392:
	bclr r25,r25,0xa
L_923396:
	mov_s r0,0x37000002
L_92339c:
	mov_s r32,r0
L_92339e:
	st.ab r0,[r25,0x4]
L_9233a2:
	bclr r25,r25,0xa
L_9233a6:
	or r14,r14,0x3f000000
L_9233ae:
	mov_s r32,r14
L_9233b0:
	st.ab r14,[r25,0x4]
L_9233b4:
	bclr r25,r25,0xa
L_9233b8:
	mov_s r0,0x3e
L_9233ba:
	asl_s r0,r0,0x18
L_9233bc:
	mov_s r32,r0
L_9233be:
	st.ab r0,[r25,0x4]
L_9233c2:
	bclr r25,r25,0xa
L_9233c6:
	mov_s r0,0x37000020
L_9233cc:
	mov_s r32,r0
L_9233ce:
	st.ab r0,[r25,0x4]
L_9233d2:
	bclr r25,r25,0xa
L_9233d6:
	mov_s r1,0x8022c8
L_9233dc:
	ld_s r0,[r1,0xc]
L_9233de:
	mov_s r14,0x800898
L_9233e4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9233e6:
	st_s r0,[r1,0xc]
L_9233e8:
	ld_s r0,[gp,0x178]
L_9233ea:
	mov_s r1,0x802940
L_9233f0:
	bclr_s r0,r0,0x18
L_9233f2:
	ld_s r1,[r1]
L_9233f4:
	bclr_s r0,r0,0x19
L_9233f6:
	asl_s r1,r1,0x18
L_9233f8:
	or_s r0,r0,r1
L_9233fa:
	st.as r0,[gp,0x5e]
L_9233fe:
	mov_s r1,0x889480
L_923404:
	st_s r0,[r1,0x8]
L_923406:
	mov_s r1,0x0
L_923408:
	mov_s r0,r1
L_92340a:
	stb_s r0,[r14,0x1b]
L_92340c:
	lsr_s r0,r0,0x8
L_92340e:
	stb_s r0,[r14,0x1c]
L_923410:
	lsr_s r0,r0,0x8
L_923412:
	stb_s r0,[r14,0x1d]
L_923414:
	lsr_s r0,r0,0x8
L_923416:
	stb_s r0,[r14,0x1e]
L_923418:
	st_s r1,[r14,0x20]
L_92341a:
	stw_s r1,[r14,0x24]
L_92341c:
	mov_s r0,0x886544
L_923422:
	ld_s r0,[r0]
L_923424:
	mov_s r2,0x886500
L_92342a:
	bmsk_s r0,r0,0xb
L_92342c:
	add_s r1,r0,0x1
L_92342e:
	asl_s r1,r1,0x10
L_923430:
	and r1,r1,0xfff0000
L_923438:
	bset_s r1,r1,0x1c
L_92343a:
	st_s r1,[r2,0x44]
L_92343c:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92343e:
	stw_s r0,[r14,0x16]
L_923440:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_923442:
	add2_s r13,r13,r13
L_923444:
	add_s r13,r13,0x801104
L_92344a:
	ldw_s r0,[r13,0x30]
L_92344c:
	ld_s r1,[r13,0x8]
L_92344e:
	stw_s r0,[r14,0x4]
L_923450:
	ldw_s r0,[r13,0x32]
L_923452:
	lsr_s r1,r1,0x8
L_923454:
	stw_s r0,[r14,0x6]
L_923456:
	ldw_s r0,[r13,0x34]
L_923458:
	bmsk_s r1,r1,0x5
L_92345a:
	stw_s r0,[r14,0x8]
L_92345c:
	ld_s r0,[r14,0x20]
L_92345e:
	bclr_s r0,r0,0x8
L_923460:
	st_s r0,[r14,0x20]
L_923462:
	mov_s r0,0x5
L_923464:
	stb r0,[r14, 0x20]
L_923468:
	add r0,r14,0x1b
L_92346c:
	bl L_93e33c
L_923470:
	mov_s r0,0x800824
L_923476:
	ld_s r0,[r0,0x60]
L_923478:
	bbit0 r0,0x0,L_923496
L_92347c:
	add r0,r14,0x1b
L_923480:
	mov_s r1,0x10
L_923482:
	bl L_93e348
L_923486:
	mov_s r0,0x20000400
L_92348c:
	mov_s r32,r0
L_92348e:
	st.ab r0,[r25,0x4]
L_923492:
	bclr r25,r25,0xa
	.global L_923496
L_923496:
	mov_s r0,0x800824
L_92349c:
	ld_s r0,[r0,0x64]
L_92349e:
	bbit0 r0,0x2,L_9234c0
L_9234a2:
	lsr_s r0,r0,0x4
L_9234a4:
	bmsk_s r0,r0,0x4
L_9234a6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9234a8:
	bic r0,r0,-0x1f1
L_9234ac:
	bset_s r0,r0,0xa
L_9234ae:
	bset_s r0,r0,0x1d
L_9234b0:
	mov_s r32,r0
L_9234b2:
	st.ab r0,[r25,0x4]
L_9234b6:
	bclr r25,r25,0xa
L_9234ba:
	ld_s r0,[r14,0x20]
L_9234bc:
	bset_s r0,r0,0xa
L_9234be:
	st_s r0,[r14,0x20]
	.global L_9234c0
L_9234c0:
	mov_s r1,0x1000904
L_9234c6:
	ld_s r3,[r14,0x20]
L_9234c8:
	ldb_s r2,[r14,0x1b]
L_9234ca:
	lsr_s r3,r3,0xa
L_9234cc:
	mov_s r0,0x0
L_9234ce:
	bmsk_s r2,r2,0x4
L_9234d0:
	bl.d L_92d27c
L_9234d4:
	bmsk_s r3,r3,0x0
L_9234d6:
	mov_s r0,0x18
L_9234d8:
	bl.d L_9257a8
L_9234dc:
	mov_s r1,0x26
L_9234de:
	bl L_92d990
L_9234e2:
	mov_s r0,0x2008000
L_9234e8:
	mov_s r32,r0
L_9234ea:
	st.ab r0,[r25,0x4]
L_9234ee:
	bclr r25,r25,0xa
L_9234f2:
	mov_s r0,0x19000001
L_9234f8:
	mov_s r32,r0
L_9234fa:
	st.ab r0,[r25,0x4]
L_9234fe:
	bclr r25,r25,0xa
	.global L_923502
L_923502:
	mov_s r0,r45
L_923504:
	bbit0 r0,0x1f,L_923502
L_923508:
	mov_s r0,0x18
L_92350a:
	asl_s r0,r0,0x18
L_92350c:
	mov_s r32,r0
L_92350e:
	st.ab r0,[r25,0x4]
L_923512:
	bclr r25,r25,0xa
L_923516:
	bl L_92e978
L_92351a:
	bl.d L_936544
L_92351e:
	mov_s r0,0x6
L_923520:
	mov_s r1,0x801024
L_923526:
	mov_s r0,0x1
L_923528:
	bl.d L_92f42c
L_92352c:
	ld_s r1,[r1]
L_92352e:
	mov_s r0,0x0
L_923530:
	bl.d L_9366dc
L_923534:
	bset_s r0,r0,0xf
L_923536:
	bl.d L_936588
L_92353a:
	mov_s r0,0x6
L_92353c:
	ld_s r0,[gp,0x178]
L_92353e:
	mov_s r1,0x802944
L_923544:
	bclr_s r0,r0,0x18
L_923546:
	ld_s r1,[r1]
L_923548:
	bclr_s r0,r0,0x19
L_92354a:
	asl_s r1,r1,0x18
L_92354c:
	or_s r0,r0,r1
L_92354e:
	st.as r0,[gp,0x5e]
L_923552:
	mov_s r1,0x889480
L_923558:
	st_s r0,[r1,0x8]
L_92355a:
	bl.d L_929ee0
L_92355e:
	mov_s r0,0x0
L_923560:
	mov_s r0,0x0
L_923562:
	bset_s r0,r0,0x1d
L_923564:
	mov_s r32,r0
L_923566:
	st.ab r0,[r25,0x4]
L_92356a:
	bclr r25,r25,0xa
L_92356e:
	b L_9202a4
L_923572:
	nop_s
