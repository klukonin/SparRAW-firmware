/* sls__rx_ssw_frame @ 0x928520, 560 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_mode__switch_core_and_rf, phy_params__snapshot, rx__handle_brp_frame, rx__mac_prepare, rx__parse_ssw_field, rx_funcs__record_level_8020f8_8020fc__922168, sls__send_ssw_ack, sta__set_tx_sector, uc_sysassert
 * Глобалы (через gp): 0x8005be, 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sls__rx_ssw_frame
sls__rx_ssw_frame:
	.global L_928520
L_928520:
	push_s blink
L_928522:
	bl.d L_920234
L_928526:
	mov_s r1,0x1
L_928528:
	sub_s sp,sp,0xc
L_92852a:
	ld_s r0,[gp,0xcc]
L_92852c:
	mov_s r3,0x80401a
L_928532:
	and r13,r0,0x8
L_928536:
	mov_s r0,0x0
L_928538:
	or.f 0x0,r13,r0
L_92853c:
	st.as r1,[gp,-0x10]
L_928540:
	ld.as r2,[gp,0x34]
L_928544:
	bne_s L_92855a
L_928546:
	mov_s r3,0x8022c8
L_92854c:
	ld_s r0,[r3,0x6c]
L_92854e:
	bset_s r2,r2,0xa
L_928550:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_928552:
	st_s r0,[r3,0x6c]
L_928554:
	st.as r2,[gp,0x34]
L_928558:
	b_s L_92857a
	.global L_92855a
L_92855a:
	mov_s r2,0x801ffc
L_928560:
	ld r0,[r2, 0xb4]
L_928564:
	mov_s r13,0x80212c
L_92856a:
	breq_s r0,0,L_9285a2
L_92856c:
	mov_s r13,0x80216c
L_928572:
	ldw_s r14,[r3]
L_928574:
	ldw_s r0,[r13,0x1c]
L_928576:
	breq r14,r0,L_92857e
	.global L_92857a
L_92857a:
	mov_s r0,r1
L_92857c:
	b_s L_928748
	.global L_92857e
L_92857e:
	ldw_s r14,[r3,0x2]
L_928580:
	ldw_s r0,[r13,0x1e]
L_928582:
	brne r14,r0,L_92857a
L_928586:
	ldw_s r3,[r3,0x4]
L_928588:
	ldw_s r0,[r13,0x20]
L_92858a:
	brne r3,r0,L_92857a
L_92858e:
	mov_s r0,0x802288
L_928594:
	ld_s r0,[r0]
L_928596:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_928598:
	add2_s r0,r0,r0
L_92859a:
	ld_s r0,[r2,r0]
L_92859c:
	brne r0,0x11,L_928602
L_9285a0:
	b_s L_92857a
	.global L_9285a2
L_9285a2:
	mov_s r0,0x8014a4
L_9285a8:
	ld_s r0,[r0,0x1c]
L_9285aa:
	mov_s r1,0x8006e4
L_9285b0:
	brne_s r0,0,L_9285ea
L_9285b2:
	ldb r0,[r13, 0x68]
L_9285b6:
	breq_s r0,0,L_9285ea
L_9285b8:
	norm r0,r0
L_9285bc:
	rsub r2,r0,0x1e
L_9285c0:
	asl_s r0,r2,0x4
L_9285c2:
	add2_s r0,r0,r0
L_9285c4:
	add_s r0,r0,0x801104
L_9285ca:
	ldw_s r13,[r0,0x30]
L_9285cc:
	ldw_s r2,[r3]
L_9285ce:
	brne r13,r2,L_9285e2
L_9285d2:
	ldw_s r13,[r0,0x32]
L_9285d4:
	ldw_s r2,[r3,0x2]
L_9285d6:
	brne r13,r2,L_9285e2
L_9285da:
	ldw_s r2,[r0,0x34]
L_9285dc:
	ldw_s r0,[r3,0x4]
L_9285de:
	breq r0,r2,L_9285ea
	.global L_9285e2
L_9285e2:
	ld_s r0,[r1,0x4]
L_9285e4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9285e6:
	st_s r0,[r1,0x4]
L_9285e8:
	b_s L_928742
	.global L_9285ea
L_9285ea:
	ld_s r0,[r1]
L_9285ec:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9285ee:
	st_s r0,[r1]
L_9285f0:
	ldw_s r0,[r3]
L_9285f2:
	mov_s r1,0x80216c
L_9285f8:
	stw_s r0,[r1,0x1c]
L_9285fa:
	ldw_s r0,[r3,0x2]
L_9285fc:
	stw_s r0,[r1,0x1e]
L_9285fe:
	ldw_s r0,[r3,0x4]
L_928600:
	stw_s r0,[r1,0x20]
	.global L_928602
L_928602:
	mov_s r0,r36
L_928604:
	btst_s r0,0x6
L_928606:
	beq_s L_92871e
L_928608:
	mov_s r0,r37
L_92860a:
	bbit0 r0,0x18,L_92869a
L_92860e:
	mov_s r1,0x802968
L_928614:
	ldw_s r0,[gp,0x96]
L_928616:
	ldw_s r1,[r1,0xc]
L_928618:
	breq r0,r1,L_928644
L_92861c:
	stw.as r1,[gp,0x4b]
L_928620:
	or r1,r1,0x1730000
L_928628:
	mov_s r0,0x886d00
L_92862e:
	st_s r1,[r0]
L_928630:
	sync
L_928634:
	mov_s r0,0x38000200
L_92863a:
	mov_s r32,r0
L_92863c:
	st.ab r0,[r25,0x4]
L_928640:
	bclr r25,r25,0xa
	.global L_928644
L_928644:
	mov_s r0,0x804010
L_92864a:
	ldw_s r0,[r0,0x10]
L_92864c:
	btst_s r0,0x0
L_92864e:
	bne_s L_928742
L_928650:
	mov_s r1,0x8021e0
L_928656:
	ld_s r0,[r1]
L_928658:
	bset_s r0,r0,0x0
L_92865a:
	st_s r0,[r1]
L_92865c:
	mov_s r0,sp
L_92865e:
	add_s r1,sp,0x4
L_928660:
	bl.d L_93cedc
L_928664:
	mov_s r2,0x0
L_928666:
	mov_s r0,r39
L_928668:
	bbit0 r0,0xf,L_928742
L_92866c:
	bl L_92f2bc
L_928670:
	mov_s r0,0x802288
L_928676:
	ld_s r1,[r0]
L_928678:
	mov_s r0,0x802aec
L_92867e:
	bl.d L_92e0e4
L_928682:
	ld.as r0,[r0,r1]
L_928686:
	mov_s r1,0x8021e0
L_92868c:
	ld_s r0,[r1]
L_92868e:
	bset_s r0,r0,0x1
L_928690:
	st_s r0,[r1]
L_928692:
	mov_s r0,0x1
L_928694:
	st.as r0,[gp,-0x21]
L_928698:
	b_s L_928746
	.global L_92869a
L_92869a:
	mov_s r0,r37
L_92869c:
	bbit0 r0,0x19,L_9286ee
L_9286a0:
	mov_s r13,0x802288
L_9286a6:
	mov_s r0,0x80218c
L_9286ac:
	ld_s r1,[r13]
L_9286ae:
	ldb_s r0,[r0,0x6]
L_9286b0:
	btst r0,r1
L_9286b4:
	mov_s r0,0x1
L_9286b6:
	beq_s L_9286e0
L_9286b8:
	mov_s r0,sp
L_9286ba:
	add_s r1,sp,0x4
L_9286bc:
	bl.d L_927d0c
L_9286c0:
	add_s r2,sp,0x8
L_9286c2:
	bl.d L_922168
L_9286c6:
	ldb.x r0,[sp, 0x8]
L_9286ca:
	ld_s r0,[r13]
L_9286cc:
	ld_s r1,[sp,0x0]
L_9286ce:
	ld_s r2,[sp,0x4]
L_9286d0:
	bl.d L_93d180
L_9286d4:
	mov_s r3,0x1
L_9286d6:
	ld_s r0,[r13]
L_9286d8:
	bl.d L_934424
L_9286dc:
	mov_s r1,0x1
L_9286de:
	mov_s r0,0x0
	.global L_9286e0
L_9286e0:
	mov_s r2,0x8021e0
L_9286e6:
	ld_s r1,[r2]
L_9286e8:
	bset_s r1,r1,0x2
L_9286ea:
	st_s r1,[r2]
L_9286ec:
	b_s L_928748
	.global L_9286ee
L_9286ee:
	mov_s r0,r37
L_9286f0:
	bbit0 r0,0x1a,L_928714
L_9286f4:
	mov_s r0,sp
L_9286f6:
	add_s r1,sp,0x4
L_9286f8:
	bl.d L_927d0c
L_9286fc:
	add_s r2,sp,0x8
L_9286fe:
	bl.d L_922168
L_928702:
	ldb.x r0,[sp, 0x8]
L_928706:
	mov_s r1,0x8021e0
L_92870c:
	ld_s r0,[r1]
L_92870e:
	bset_s r0,r0,0x3
L_928710:
	st_s r0,[r1]
L_928712:
	b_s L_928742
	.global L_928714
L_928714:
	mov_s r0,blink
L_928716:
	bl.d L_926618
L_92871a:
	mov_s r1,0x11
L_92871c:
	b_s L_928742
	.global L_92871e
L_92871e:
	mov_s r0,0x802288
L_928724:
	ld_s r1,[r0]
L_928726:
	mov_s r0,0x80218c
L_92872c:
	ldb_s r0,[r0,0x8]
L_92872e:
	bbit0 r0,r1,L_928742
L_928732:
	bl L_92e16c
L_928736:
	mov_s r0,0x8021e0
L_92873c:
	ld_s r0,[r0]
L_92873e:
	bbit1 r0,0x5,L_928746
	.global L_928742
L_928742:
	mov_s r0,0x1
L_928744:
	b_s L_928748
	.global L_928746
L_928746:
	mov_s r0,0x0
	.global L_928748
L_928748:
	b.d L_9202a4
L_92874c:
	add_s sp,sp,0xc
L_92874e:
	nop_s
