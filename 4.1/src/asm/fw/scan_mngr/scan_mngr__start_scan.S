/* scan_mngr__start_scan @ 0x8f1474, 468 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::start_scan() Not supported scan type: %d, Discovery mode: %d
 *   scan_mngr.cpp
 *   scan_mngr::start_scan() send command to uCode scan_mode = TRUE. m_ucode_scan_type = %d
 *   scan_mngr::start_scan()  chan %d CHID=%d inserted to pending list
 *   scan_mngr::start_scan() IGNORED chan %d - not supported
 *   scan_mngr::start_scan() postpone_scan %d
 *   scan_mngr::start_scan() call the main state machine to start scanning: START_SCAN
 *   scan_mngr::start_scan() postpone scan on MID#%d.
 * Зовут его: l2_mgr__scan_start_log
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, basic_sm__inject_event, discovery__tsf_wa, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, llist__insert, lmac_if_discovery_mode_cfg_handler, mem_pool__allocate
 */
	.section .text.scan_mngr__start_scan,"ax",@progbits
	.global scan_mngr__start_scan
scan_mngr__start_scan:
	.global L_8f1474
L_8f1474:
	push_s blink
L_8f1476:
	bl L_8c02ac
L_8f147a:
	sub_s sp,sp,0x14
L_8f147c:
	mov_s r13,r0
L_8f147e:
	mov_s r15,r1
L_8f1480:
	mov_s r16,r2
L_8f1482:
	mov_s r0,0x805d98
L_8f1488:
	mov_s r14,0x0
L_8f148a:
	stw_s r14,[r0]
L_8f148c:
	stw_s r14,[r0,0x2]
L_8f148e:
	stw_s r14,[r0,0x4]
L_8f1490:
	stw_s r14,[r0,0x6]
L_8f1492:
	stw_s r14,[r0,0x8]
L_8f1494:
	stw_s r14,[r0,0xa]
L_8f1496:
	stw_s r14,[r0,0xc]
L_8f1498:
	add3 r19,r13,0x10
L_8f149c:
	st r14,[r19]
L_8f14a0:
	ldb_s r1,[r1,0x11]
L_8f14a2:
	add r18,r13,0x20
L_8f14a6:
	stb r1,[r18, 0x4]
L_8f14aa:
	add r0,r13,0x28
L_8f14ae:
	bl.d L_8c1a78
L_8f14b2:
	mov_s r1,0x3c
L_8f14b4:
	ldb_s r1,[r15,0x6]
L_8f14b6:
	stb r1,[r19, 0xd]
L_8f14ba:
	ldb_s r0,[r15,0x10]
L_8f14bc:
	st_s r0,[r13,0x6c]
L_8f14be:
	ldb_s r3,[r15,0x10]
L_8f14c0:
	breq_s r3,0,L_8f14f4
L_8f14c2:
	breq r3,0x2,L_8f1500
L_8f14c6:
	ldb r4,[r15, 0x6]
L_8f14ca:
	breq r3,0x3,L_8f14f4
L_8f14ce:
	mov_s r2,0x1012c38
L_8f14d4:
	mov_s r0,r14
L_8f14d6:
	mov_s r1,r14
L_8f14d8:
	bl.d L_8ee034
L_8f14dc:
	mov_s r5,r14
L_8f14de:
	mov_s r0,blink
L_8f14e0:
	mov_s r2,0x1012bb8
L_8f14e6:
	mov_s r1,0x1442
L_8f14ec:
	bl.d L_8c82c0
L_8f14f0:
	mov_s r3,0xb2
L_8f14f2:
	b_s L_8f1506
	.global L_8f14f4
L_8f14f4:
	ldb_s r0,[r15,0x6]
L_8f14f6:
	mov.f r1,r0
L_8f14fa:
	mov.ne r1,0x1
L_8f14fe:
	b_s L_8f1502
	.global L_8f1500
L_8f1500:
	mov_s r1,0x2
	.global L_8f1502
L_8f1502:
	stb r1,[r19, 0xe]
	.global L_8f1506
L_8f1506:
	mov_s r2,0x1012c80
L_8f150c:
	mov_s r0,0x9
L_8f150e:
	mov_s r1,0x2
L_8f1510:
	bl.d L_8edfcc
L_8f1514:
	ldb r3,[r19, 0xe]
L_8f1518:
	mov_s r0,0x1
L_8f151a:
	mov_s r20,r0
L_8f151c:
	bl.d L_8d84a8
L_8f1520:
	ldb r1,[r19, 0xe]
L_8f1524:
	ld_s r1,[r13,0x6c]
L_8f1526:
	mov_s r0,0x0
L_8f1528:
	cmp_s r1,0x0
L_8f152a:
	cmp.ne r1,0x3
L_8f152e:
	bne_s L_8f1544
L_8f1530:
	ldb r0,[r19, 0xd]
L_8f1534:
	brne r0,0x1,L_8f153e
L_8f1538:
	ld_s r0,[r13,0x78]
L_8f153a:
	breq r0,0x1,L_8f1542
	.global L_8f153e
L_8f153e:
	mov_s r0,0x0
L_8f1540:
	b_s L_8f1544
	.global L_8f1542
L_8f1542:
	mov_s r0,0x1
	.global L_8f1544
L_8f1544:
	extb.f 0x0,r0
L_8f1548:
	beq_s L_8f155c
L_8f154a:
	ld_s r3,[r13,0x7c]
L_8f154c:
	mov_s r1,0x1
L_8f154e:
	mov_s r0,r3
L_8f1550:
	add r0,r0,0x234
L_8f1554:
	mov_s r2,0x47
L_8f1556:
	bl.d L_8f1a9c
L_8f155a:
	ldb_s r3,[r3,0x10]
	.global L_8f155c
L_8f155c:
	add2 r0,r13,0x19
L_8f1560:
	mov_s r1,r15
L_8f1562:
	bl.d L_8c0460
L_8f1566:
	mov_s r2,0x6
L_8f1568:
	ldw_s r0,[r15,0xa]
L_8f156a:
	ldw_s r1,[r15,0x8]
L_8f156c:
	asl_s r0,r0,0x10
L_8f156e:
	or_s r1,r1,r0
L_8f1570:
	bl.d L_8ea5a4
L_8f1574:
	mov_s r0,r13
L_8f1576:
	mov_s r1,sp
L_8f1578:
	bl.d L_8f0e04
L_8f157c:
	mov_s r0,r15
L_8f157e:
	ldb r0,[r18, 0x4]
L_8f1582:
	brlo r0,0x1,L_8f15f8
	.global L_8f1586
L_8f1586:
	brhs r14,0x3,L_8f15da
L_8f158a:
	mov_s r0,0x842ed4
L_8f1590:
	bl L_8c2dc8
L_8f1594:
	mov.f r17,r0
L_8f1598:
	beq_s L_8f15c4
	.global L_8f159a
L_8f159a:
	add2 r0,sp,r14
L_8f159e:
	ld_s r1,[r0]
L_8f15a0:
	add r0,r13,0x18
L_8f15a4:
	st r1,[r17, 0x8]
L_8f15a8:
	bl.d L_8c1fc4
L_8f15ac:
	mov_s r1,r17
L_8f15ae:
	mov_s r2,0x1012cd8
L_8f15b4:
	ld r4,[r17, 0x8]
L_8f15b8:
	mov_s r0,0x9
L_8f15ba:
	mov_s r1,0x2
L_8f15bc:
	bl.d L_8edff8
L_8f15c0:
	mov_s r3,r14
L_8f15c2:
	b_s L_8f15ee
	.global L_8f15c4
L_8f15c4:
	mov_s r0,blink
L_8f15c6:
	mov_s r2,0x1012bb8
L_8f15cc:
	mov_s r1,0x1248
L_8f15d2:
	bl.d L_8c82c0
L_8f15d6:
	mov_s r3,0xcb
L_8f15d8:
	b_s L_8f159a
	.global L_8f15da
L_8f15da:
	mov_s r2,0x1012d1c
L_8f15e0:
	add1 r3,r15,r14
L_8f15e4:
	mov_s r0,0x9
L_8f15e6:
	mov_s r1,0x2
L_8f15e8:
	bl.d L_8edfcc
L_8f15ec:
	ldb_s r3,[r3,0x12]
	.global L_8f15ee
L_8f15ee:
	ldb r0,[r18, 0x4]
L_8f15f2:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8f15f4:
	brlo r14,r0,L_8f1586
	.global L_8f15f8
L_8f15f8:
	mov_s r2,0x1012d58
L_8f15fe:
	mov_s r0,0x9
L_8f1600:
	mov_s r1,0x2
L_8f1602:
	bl.d L_8edfcc
L_8f1606:
	mov_s r3,r16
L_8f1608:
	brne r16,0x0,L_8f162c
L_8f160c:
	mov_s r2,0x1012d84
L_8f1612:
	mov_s r0,0x9
L_8f1614:
	bl.d L_8edfb0
L_8f1618:
	mov_s r1,0x2
L_8f161a:
	ld r0,[r19, 0x4]
L_8f161e:
	mov_s r1,0x0
L_8f1620:
	mov_s r2,r1
L_8f1622:
	mov_s r3,r1
L_8f1624:
	bl.d L_8d6a1c
L_8f1628:
	mov_s r4,r1
L_8f162a:
	b_s L_8f163e
	.global L_8f162c
L_8f162c:
	ld_s r3,[r13,0x7c]
L_8f162e:
	mov_s r2,0x1012dd8
L_8f1634:
	mov_s r0,0x9
L_8f1636:
	mov_s r1,0x2
L_8f1638:
	bl.d L_8edfcc
L_8f163c:
	ldb_s r3,[r3,0x10]
	.global L_8f163e
L_8f163e:
	st r20,[r13, 0x78]
L_8f1642:
	b.d L_8c0304
L_8f1646:
	add_s sp,sp,0x14
