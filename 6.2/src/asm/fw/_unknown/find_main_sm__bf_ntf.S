/* find_main_sm__bf_ntf @ 0x8f1500, 492 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::bf_ntf() status %d
 *   bf_ntf:: Pending probe resp, ignore this bf event <%d>...
 *   bf_ntf:: send probe_req with bcast BSSID...ssid_len= %d <%d>
 *   FIND_SM:: BF with FAIL status = %d
 *   DA ADDR-%04X%08X
 *   SA ADDR-%04X%08X
 *   BSSID ADDR-%04X%08X
 *   ------------------ HDRs len %d ----------------
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r19_to_r13_ret, __ld_r20_to_r13_ret, __st_r19_to_r13, __st_r20_to_r13, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, hexdump_words, llc_snap__write_header, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__bf_ntf
find_main_sm__bf_ntf:
	.global L_8f1500
L_8f1500:
	push_s blink
L_8f1502:
	bl L_8c01d0
L_8f1506:
	sub_s sp,sp,0x24
L_8f1508:
	mov_s r16,r0
L_8f150a:
	mov_s r13,r1
L_8f150c:
	mov_s r14,r2
L_8f150e:
	mov_s r1,0x1017fd0
L_8f1514:
	bl.d L_8dcc10
L_8f1518:
	mov_s r0,0x2c
L_8f151a:
	brne r14,0x0,L_8f15d8
L_8f151e:
	mov_s r0,0x0
L_8f1520:
	st_s r0,[sp,0x20]
L_8f1522:
	ldb r17,[r13, 0x8]
L_8f1526:
	brge r17,0x8,L_8f154c
	.global L_8f152a
L_8f152a:
	add r15,r16,r17
L_8f152e:
	ldb_s r0,[r15,0x8]
L_8f1530:
	breq r0,0x8,L_8f155a
L_8f1534:
	bl L_8e9524
L_8f1538:
	mov_s r1,0x1017ff4
L_8f153e:
	mov_s r2,r0
L_8f1540:
	bl.d L_8dcc10
L_8f1544:
	mov_s r0,0x2c
L_8f1546:
	mov_s r0,0x8
L_8f1548:
	stb_s r0,[r15,0x8]
L_8f154a:
	b_s L_8f15e6
	.global L_8f154c
L_8f154c:
	mov_s r0,blink
L_8f154e:
	mov_s r1,0x1474
L_8f1554:
	bl L_8c9b28
L_8f1558:
	b_s L_8f152a
	.global L_8f155a
L_8f155a:
	bl.d L_8c3414
L_8f155e:
	mov r19,sp
L_8f1562:
	mov_s r14,r0
L_8f1564:
	ld r0,[r16, 0x10]
L_8f1568:
	ld_s r0,[r0,0x48]
L_8f156a:
	add_s r0,r0,0x48
L_8f156c:
	bl.d L_8ccc98
L_8f1570:
	mov_s r1,r19
L_8f1572:
	mov_s r18,r0
L_8f1574:
	add_s r1,sp,0x20
L_8f1576:
	ld r2,[r16, 0x10]
L_8f157a:
	mov_s r0,r14
L_8f157c:
	ld_s r2,[r2,0x48]
L_8f157e:
	mov_s r3,r13
L_8f1580:
	mov r4,r19
L_8f1584:
	bl.d L_8e9ebc
L_8f1588:
	mov r5,r18
L_8f158c:
	add r1,r13,0x1c
L_8f1590:
	add_s r0,r14,0x4
L_8f1592:
	bl.d L_8c0380
L_8f1596:
	mov_s r2,0x6
L_8f1598:
	mov_s r0,0xff
L_8f159a:
	stb_s r0,[r14,0x10]
L_8f159c:
	stb_s r0,[r14,0x11]
L_8f159e:
	stb_s r0,[r14,0x12]
L_8f15a0:
	stb_s r0,[r14,0x13]
L_8f15a2:
	stb_s r0,[r14,0x14]
L_8f15a4:
	bl.d L_8e9524
L_8f15a8:
	stb_s r0,[r14,0x15]
L_8f15aa:
	mov_s r3,r0
L_8f15ac:
	mov_s r1,0x1018030
L_8f15b2:
	mov_s r0,0x2c
L_8f15b4:
	bl.d L_8dcc80
L_8f15b8:
	mov_s r2,r18
L_8f15ba:
	stb r17,[r15, 0x8]
L_8f15be:
	ldw r4,[sp, 0x20]
L_8f15c2:
	mov_s r0,r13
L_8f15c4:
	mov_s r1,0x1
L_8f15c6:
	mov_s r2,r1
L_8f15c8:
	mov_s r3,r14
L_8f15ca:
	mov r5,0x0
L_8f15ce:
	bl.d L_8e5874
L_8f15d2:
	mov r6,r5
L_8f15d6:
	b_s L_8f15e6
	.global L_8f15d8
L_8f15d8:
	mov_s r1,0x1018070
L_8f15de:
	mov_s r0,0x2c
L_8f15e0:
	bl.d L_8dcc10
L_8f15e4:
	mov_s r2,r14
	.global L_8f15e6
L_8f15e6:
	b.d L_8c022c
L_8f15ea:
	add_s sp,sp,0x24
L_8f15ec:
	push_s blink
L_8f15ee:
	bl L_8c01cc
L_8f15f2:
	mov_s r14,r1
L_8f15f4:
	mov_s r17,r2
L_8f15f6:
	mov_s r15,r3
L_8f15f8:
	mov_s r1,0x0
L_8f15fa:
	st_s r1,[r2]
L_8f15fc:
	ld r18,[r3, 0x18]
L_8f1600:
	mov r16,r5
L_8f1604:
	mov r20,r4
L_8f1608:
	mov r19,r6
L_8f160c:
	breq r18,0x0,L_8f16dc
	.global L_8f1610
L_8f1610:
	mov_s r0,r14
L_8f1612:
	bl.d L_8c1cd8
L_8f1616:
	mov_s r1,0xc4
L_8f1618:
	add_s r15,r15,0x1c
L_8f161a:
	add r13,r18,0xa
L_8f161e:
	add r18,r18,0x54
L_8f1622:
	ldw_s r2,[r15,0x4]
L_8f1624:
	mov_s r1,0x10141a4
L_8f162a:
	mov_s r0,0x2d
L_8f162c:
	bl.d L_8dcc80
L_8f1630:
	ld_s r3,[r15]
L_8f1632:
	mov_s r1,0x10141b8
L_8f1638:
	ldw_s r2,[r13,0x4]
L_8f163a:
	mov_s r0,0x2d
L_8f163c:
	bl.d L_8dcc80
L_8f1640:
	ld_s r3,[r13]
L_8f1642:
	mov_s r1,0x10141cc
L_8f1648:
	ldw r2,[r18, 0x4]
L_8f164c:
	mov_s r0,0x2d
L_8f164e:
	bl.d L_8dcc80
L_8f1652:
	ld r3,[r18]
L_8f1656:
	mov_s r0,r14
L_8f1658:
	mov_s r1,0x8
L_8f165a:
	mov_s r2,r15
L_8f165c:
	mov_s r3,r13
L_8f165e:
	mov r4,r18
L_8f1662:
	mov r5,r20
L_8f1666:
	bl.d L_8d7cec
L_8f166a:
	mov r6,0x7
L_8f166e:
	extw_s r0,r0
L_8f1670:
	mov_s r13,r0
L_8f1672:
	extw_s r13,r13
L_8f1674:
	add_s r15,r14,r0
L_8f1676:
	mov_s r1,0x888e
L_8f167c:
	bl.d L_8d7d90
L_8f1680:
	mov_s r0,r15
L_8f1682:
	extw_s r0,r0
L_8f1684:
	add_s r13,r13,r0
L_8f1686:
	extw_s r13,r13
L_8f1688:
	add_s r15,r15,r0
L_8f168a:
	mov_s r1,0x10141e0
L_8f1690:
	mov_s r0,0x2d
L_8f1692:
	bl.d L_8dcc10
L_8f1696:
	mov_s r2,r13
L_8f1698:
	mov_s r0,r14
L_8f169a:
	bl.d L_8c9790
L_8f169e:
	mov_s r1,r13
L_8f16a0:
	mov_s r0,r15
L_8f16a2:
	mov_s r1,r16
L_8f16a4:
	bl.d L_8c0380
L_8f16a8:
	mov_s r2,r19
L_8f16aa:
	add r2,r13,r19
L_8f16ae:
	extw_s r2,r2
L_8f16b0:
	st r2,[r17]
L_8f16b4:
	mov_s r1,0x1014210
L_8f16ba:
	bl.d L_8dcc10
L_8f16be:
	mov_s r0,0x2d
L_8f16c0:
	mov_s r0,r14
L_8f16c2:
	bl.d L_8c9790
L_8f16c6:
	ld r1,[r17]
L_8f16ca:
	mov_s r1,0x1014240
L_8f16d0:
	bl.d L_8dcba8
L_8f16d4:
	mov_s r0,0x2d
L_8f16d6:
	b.d L_8c0224
L_8f16da:
	mov_s r0,0x0
	.global L_8f16dc
L_8f16dc:
	mov_s r0,blink
L_8f16de:
	mov_s r1,0x1184
L_8f16e4:
	bl L_8c9b28
L_8f16e8:
	b_s L_8f1610
L_8f16ea:
	nop_s
