/* discovery_handle_probe_req @ 0x8eb50c, 364 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery_handle_probe_req()
 *   discovery_handle_probe_req() Disconnecting all MIDs due to special configuration
 *   discovery_handle_probe_req() Probe resp sending <ts: %d>
 *   discovery_handle_probe_req() Ignore Probe resq since from none handled CID <ts: %d>
 *   discovery_handle_probe_req() FIND:: Probe req handle
 *   discovery_handle_probe_req() Ignore Probe req from ADDR-%04X%08X while not in PCP mode
 * Зовут его: discovery__rx_pkt_handler
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, discovery__inject_probe_evt, discovery_is_ssid_approved, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_read_timer, l2mgr__wmi_disconnect_log, mid_list__find_by, set_vendor_specific_version
 */
	.section .text.discovery_handle_probe_req,"ax",@progbits
	.global discovery_handle_probe_req
discovery_handle_probe_req:
	.global L_8eb50c
L_8eb50c:
	push_s blink
L_8eb50e:
	bl L_8c02bc
L_8eb512:
	mov_s r13,r0
L_8eb514:
	mov_s r15,r1
L_8eb516:
	mov_s r2,0x1012184
L_8eb51c:
	mov_s r0,0xc
L_8eb51e:
	bl.d L_8edfb0
L_8eb522:
	mov_s r1,0x2
L_8eb524:
	ld_s r0,[r13,0x4]
L_8eb526:
	ld_s r2,[r0,0x50]
L_8eb528:
	mov_s r1,0x0
L_8eb52a:
	cmp_s r2,0x2
L_8eb52c:
	cmp.ne r2,0x3
L_8eb530:
	mov.eq r1,0x1
L_8eb534:
	extb.f 0x0,r1
L_8eb538:
	bne_s L_8eb562
L_8eb53a:
	ld_s r2,[r13,0x8]
L_8eb53c:
	ld_s r3,[r2,0x6c]
L_8eb53e:
	mov_s r1,0x0
L_8eb540:
	cmp_s r3,0x0
L_8eb542:
	cmp.ne r3,0x3
L_8eb546:
	bne_s L_8eb55c
L_8eb548:
	ldb r1,[r2, 0x8d]
L_8eb54c:
	brne r1,0x1,L_8eb556
L_8eb550:
	ld_s r1,[r2,0x78]
L_8eb552:
	breq r1,0x1,L_8eb55a
	.global L_8eb556
L_8eb556:
	mov_s r1,0x0
L_8eb558:
	b_s L_8eb55c
	.global L_8eb55a
L_8eb55a:
	mov_s r1,0x1
	.global L_8eb55c
L_8eb55c:
	extb.f 0x0,r1
L_8eb560:
	beq_s L_8eb636
	.global L_8eb562
L_8eb562:
	ld_s r1,[r15,0x8]
L_8eb564:
	bl.d L_8c9e74
L_8eb568:
	add_s r1,r1,0xa
L_8eb56a:
	mov.f r14,r0
L_8eb56e:
	beq_s L_8eb614
L_8eb570:
	mov_s r0,0x80345c
L_8eb576:
	ld_s r0,[r0,0x18]
L_8eb578:
	bbit0 r0,0xa,L_8eb59e
L_8eb57c:
	ldb r0,[r14, 0xfc]
L_8eb580:
	cmp_s r0,0x5
L_8eb582:
	cmp.ne r0,0x7
L_8eb586:
	bne_s L_8eb59e
L_8eb588:
	mov_s r2,0x10121a4
L_8eb58e:
	mov_s r0,0xc
L_8eb590:
	bl.d L_8edfb0
L_8eb594:
	mov_s r1,0x1
L_8eb596:
	bl.d L_8eb448
L_8eb59a:
	mov_s r0,0x0
L_8eb59c:
	b_s L_8eb628
	.global L_8eb59e
L_8eb59e:
	mov_s r0,r14
L_8eb5a0:
	mov_s r1,r15
L_8eb5a2:
	bl.d L_8e21d0
L_8eb5a6:
	ld_s r2,[r13,0x4]
L_8eb5a8:
	mov_s r0,r13
L_8eb5aa:
	bl.d L_8eb76c
L_8eb5ae:
	mov_s r1,r15
L_8eb5b0:
	breq r0,0x0,L_8eb628
L_8eb5b4:
	bl L_8c2c80
L_8eb5b8:
	bl.d L_8e4694
L_8eb5bc:
	mov_s r16,r0
L_8eb5be:
	mov_s r3,r0
L_8eb5c0:
	mov_s r2,0x10121f8
L_8eb5c6:
	mov_s r0,0xc
L_8eb5c8:
	bl.d L_8edfcc
L_8eb5cc:
	mov_s r1,0x2
L_8eb5ce:
	ld_s r1,[r13,0x8]
L_8eb5d0:
	ld_s r2,[r1,0x6c]
L_8eb5d2:
	mov_s r0,0x0
L_8eb5d4:
	cmp_s r2,0x0
L_8eb5d6:
	cmp.ne r2,0x3
L_8eb5da:
	bne_s L_8eb5f0
L_8eb5dc:
	ldb r0,[r1, 0x8d]
L_8eb5e0:
	brne r0,0x1,L_8eb5ea
L_8eb5e4:
	ld_s r0,[r1,0x78]
L_8eb5e6:
	breq r0,0x1,L_8eb5ee
	.global L_8eb5ea
L_8eb5ea:
	mov_s r0,0x0
L_8eb5ec:
	b_s L_8eb5f0
	.global L_8eb5ee
L_8eb5ee:
	mov_s r0,0x1
	.global L_8eb5f0
L_8eb5f0:
	extb.f 0x0,r0
L_8eb5f4:
	ld_s r1,[r13,0x4]
L_8eb5f6:
	mov r4,0x2f704
L_8eb5fe:
	mov_s r0,r16
L_8eb600:
	mov_s r2,r14
L_8eb602:
	beq_s L_8eb60c
L_8eb604:
	bl.d L_8f0908
L_8eb608:
	mov_s r3,0x1
L_8eb60a:
	b_s L_8eb628
	.global L_8eb60c
L_8eb60c:
	bl.d L_8f0908
L_8eb610:
	mov_s r3,0x0
L_8eb612:
	b_s L_8eb628
	.global L_8eb614
L_8eb614:
	bl L_8e4694
L_8eb618:
	mov_s r2,0x1012234
L_8eb61e:
	mov_s r3,r0
L_8eb620:
	mov_s r0,0xc
L_8eb622:
	bl.d L_8edfcc
L_8eb626:
	mov_s r1,0x2
	.global L_8eb628
L_8eb628:
	mov_s r1,0x843104
L_8eb62e:
	ld_s r0,[r1,0x14]
L_8eb630:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eb632:
	st_s r0,[r1,0x14]
L_8eb634:
	b_s L_8eb672
	.global L_8eb636
L_8eb636:
	add_s r13,r13,0xc
L_8eb638:
	ld_s r0,[r13,0x64]
L_8eb63a:
	breq_s r0,0,L_8eb654
L_8eb63c:
	mov_s r2,0x101228c
L_8eb642:
	mov_s r0,0xc
L_8eb644:
	bl.d L_8edfb0
L_8eb648:
	mov_s r1,0x2
L_8eb64a:
	mov_s r0,r13
L_8eb64c:
	bl.d L_8dd040
L_8eb650:
	mov_s r1,r15
L_8eb652:
	b_s L_8eb672
	.global L_8eb654
L_8eb654:
	ld_s r3,[r15,0x8]
L_8eb656:
	mov_s r2,0x10122c4
L_8eb65c:
	ldw_s r0,[r3,0xc]
L_8eb65e:
	ldw r4,[r3, 0xa]
L_8eb662:
	asl_s r0,r0,0x10
L_8eb664:
	or r4,r4,r0
L_8eb668:
	mov_s r0,0xc
L_8eb66a:
	mov_s r1,0x2
L_8eb66c:
	bl.d L_8edff8
L_8eb670:
	ldw_s r3,[r3,0xe]
	.global L_8eb672
L_8eb672:
	b.d L_8c0324
L_8eb676:
	mov_s r0,0x1
