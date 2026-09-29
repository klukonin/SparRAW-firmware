/* tx_initiator_substep @ 0x934354, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bitstream__push, mac__prepare_txrx_window, memset0_words_uc, rx_flow__run, sxd_hal__wait_slot2_busy2, tx_flows__program_mac_tx, tx_mtp__open_window, tx_mtp_queue_gate
 * Глобалы (через gp): 0x800540, 0x8005e0, 0x800608
 */
	.section .text.tx_initiator_substep,"ax",@progbits
	.global tx_initiator_substep
tx_initiator_substep:
	.global L_934354
L_934354:
	push_s blink
L_934356:
	bl.d L_920214
L_93435a:
	mov_s r1,0x8
L_93435c:
	sub_s sp,sp,0x8
L_93435e:
	mov_s r14,r0
L_934360:
	bl.d L_92166c
L_934364:
	mov_s r0,sp
L_934366:
	mov_s r13,0x0
L_934368:
	b_s L_9343ee
	.global L_93436a
L_93436a:
	and.f 0x0,r0,0xe00
L_934372:
	bne_s L_9343aa
L_934374:
	bmsk.f 0x0,r0,0x4
L_934378:
	bne_s L_9343e6
L_93437a:
	bbit1 r0,0x7,L_9343b2
L_93437e:
	mov_s r0,0x801a18
L_934384:
	bl.d L_933568
L_934388:
	ld_s r0,[r0,0x60]
L_93438a:
	breq_s r13,0,L_9343e4
L_93438c:
	mov_s r0,sp
L_93438e:
	mov_s r3,0x8010e8
L_934394:
	ldb_s r1,[r3,0x15]
L_934396:
	mov_s r2,0x0
L_934398:
	bl.d L_93708c
L_93439c:
	ld_s r3,[r3,0x18]
L_93439e:
	mov_s r1,0x1
L_9343a0:
	mov_s r0,0x800664
L_9343a6:
	st_s r1,[r0]
L_9343a8:
	b_s L_9343e4
	.global L_9343aa
L_9343aa:
	bclr_s r0,r0,0x8
L_9343ac:
	st.as r0,[gp,0x38]
L_9343b0:
	b_s L_9343fc
	.global L_9343b2
L_9343b2:
	mov_s r0,0x8009c0
L_9343b8:
	ld_s r0,[r0,0x8]
L_9343ba:
	mov_s r3,0x8010e8
L_9343c0:
	bbit0 r0,0x9,L_9343c8
L_9343c4:
	ldb_s r1,[r3,0x17]
L_9343c6:
	b_s L_9343ca
	.global L_9343c8
L_9343c8:
	ldb_s r1,[r3,0x15]
	.global L_9343ca
L_9343ca:
	mov_s r0,sp
L_9343cc:
	mov_s r2,0x1
L_9343ce:
	bl.d L_93708c
L_9343d2:
	ld_s r3,[r3,0x18]
L_9343d4:
	breq r0,0x1,L_93442e
L_9343d8:
	bl L_93413c
L_9343dc:
	ld_s r0,[gp,0xe0]
L_9343de:
	bclr_s r0,r0,0x7
L_9343e0:
	st.as r0,[gp,0x38]
	.global L_9343e4
L_9343e4:
	mov_s r13,0x0
	.global L_9343e6
L_9343e6:
	ld_s r0,[gp,0xe0]
L_9343e8:
	bmsk.f 0x0,r0,0x4
L_9343ec:
	bne_s L_934450
	.global L_9343ee
L_9343ee:
	ld_s r0,[gp,0xe0]
L_9343f0:
	mov_s r1,r0
L_9343f2:
	bic r1,r1,-0x141
L_9343f6:
	cmp r1,0x100
L_9343fa:
	beq_s L_93436a
	.global L_9343fc
L_9343fc:
	ld_s r0,[r14]
L_9343fe:
	mov_s r1,0x857849
L_934404:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_934406:
	add2_s r0,r0,r0
L_934408:
	ldb_s r0,[r1,r0]
L_93440a:
	brne_s r0,0,L_934412
L_93440c:
	ld_s r0,[gp,0x18]
L_93440e:
	bbit0 r0,0x1,L_934428
	.global L_934412
L_934412:
	mov_s r0,0x8014dc
L_934418:
	ld_s r0,[r0,0x8]
L_93441a:
	cmp_s r0,0x0
L_93441c:
	mov.eq r0,r14
L_934420:
	bl.eq.d L_9247c0
L_934424:
	mov.eq r1,0x1
	.global L_934428
L_934428:
	b.d L_920284
L_93442c:
	add_s sp,sp,0x8
	.global L_93442e
L_93442e:
	ld_s r0,[gp,0xb8]
L_934430:
	bbit0 r0,0x3,L_934446
L_934434:
	ld_s r0,[r14]
L_934436:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_934438:
	add2_s r0,r0,r0
L_93443a:
	add_s r0,r0,0x857838
L_934440:
	ldb_s r1,[r0,0x11]
L_934442:
	bset_s r1,r1,0x3
L_934444:
	stb_s r1,[r0,0x11]
	.global L_934446
L_934446:
	mov_s r0,r14
L_934448:
	bl.d L_9247c0
L_93444c:
	mov_s r1,0x1
L_93444e:
	b_s L_9343ee
	.global L_934450
L_934450:
	mov_s r0,0x2
L_934452:
	bset_s r0,r0,0x19
L_934454:
	mov_s r32,r0
L_934456:
	st.ab r0,[r25,0x4]
L_93445a:
	bclr r25,r25,0xa
L_93445e:
	bl.d L_931dcc
L_934462:
	ldw_s r0,[gp,-0x22]
L_934464:
	breq_s r0,0,L_934476
L_934466:
	bl.d L_92ce9c
L_93446a:
	mov_s r13,0x1
L_93446c:
	mov_s r0,0x800664
L_934472:
	st_s r13,[r0,0x4]
L_934474:
	b_s L_9343ee
	.global L_934476
L_934476:
	mov_s r0,r14
L_934478:
	bl.d L_92177c
L_93447c:
	mov_s r1,0x2
L_93447e:
	mov_s r1,0x801118
L_934484:
	ld_s r0,[r1,0xc]
L_934486:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934488:
	st_s r0,[r1,0xc]
L_93448a:
	b_s L_9343ee
