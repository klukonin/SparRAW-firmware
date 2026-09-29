/* phy_stats__accumulate_to_shared @ 0x92e544, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__check_mode_2
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_phy__uses_rgf_883800_929af4, hwd_phy__uses_rgf_883800_929b94, phy_stats__clear_counters_88395c, phy_stats__clear_counters_883960, rate_search__current_mcs
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy_stats__accumulate_to_shared
phy_stats__accumulate_to_shared:
	.global L_92e544
L_92e544:
	push_s blink
L_92e546:
	bl.d L_920234
L_92e54a:
	mov_s r0,r1
L_92e54c:
	mov_s r13,0x8576a0
L_92e552:
	bl.d L_930018
L_92e556:
	sub_s sp,sp,0x78
L_92e558:
	bl.d L_929cf8
L_92e55c:
	mov_s r14,r0
L_92e55e:
	bl.d L_929b94
L_92e562:
	mov_s r0,sp
L_92e564:
	bl.d L_929af4
L_92e568:
	add_s r0,sp,0x38
L_92e56a:
	bl L_929cec
L_92e56e:
	ld_s r1,[sp,0x0]
L_92e570:
	ld_s r0,[r13,0xc]
L_92e572:
	ld_s r2,[sp,0x3c]
L_92e574:
	add_s r0,r0,r1
L_92e576:
	st_s r0,[r13,0xc]
L_92e578:
	ld_s r0,[sp,0x4]
L_92e57a:
	ld_s r1,[r13,0x10]
L_92e57c:
	ld_s r3,[r13,0x48]
L_92e57e:
	add_s r0,r0,r1
L_92e580:
	st_s r0,[r13,0x10]
L_92e582:
	ld_s r0,[sp,0x8]
L_92e584:
	ld_s r1,[r13,0x14]
L_92e586:
	add_s r0,r0,r1
L_92e588:
	st_s r0,[r13,0x14]
L_92e58a:
	ld_s r0,[sp,0xc]
L_92e58c:
	ld_s r1,[r13,0x18]
L_92e58e:
	add_s r0,r0,r1
L_92e590:
	st_s r0,[r13,0x18]
L_92e592:
	ld_s r0,[sp,0x10]
L_92e594:
	ld_s r1,[r13,0x1c]
L_92e596:
	add_s r0,r0,r1
L_92e598:
	st_s r0,[r13,0x1c]
L_92e59a:
	ld_s r0,[sp,0x14]
L_92e59c:
	ld_s r1,[r13,0x20]
L_92e59e:
	add_s r0,r0,r1
L_92e5a0:
	st_s r0,[r13,0x20]
L_92e5a2:
	ld_s r0,[sp,0x18]
L_92e5a4:
	ld_s r1,[r13,0x24]
L_92e5a6:
	add_s r0,r0,r1
L_92e5a8:
	st_s r0,[r13,0x24]
L_92e5aa:
	ld_s r0,[sp,0x1c]
L_92e5ac:
	ld_s r1,[r13,0x28]
L_92e5ae:
	add_s r0,r0,r1
L_92e5b0:
	st_s r0,[r13,0x28]
L_92e5b2:
	ld_s r0,[sp,0x20]
L_92e5b4:
	ld_s r1,[r13,0x2c]
L_92e5b6:
	add_s r0,r0,r1
L_92e5b8:
	st_s r0,[r13,0x2c]
L_92e5ba:
	ld_s r0,[sp,0x24]
L_92e5bc:
	ld_s r1,[r13,0x30]
L_92e5be:
	add_s r0,r0,r1
L_92e5c0:
	st_s r0,[r13,0x30]
L_92e5c2:
	ld_s r0,[sp,0x28]
L_92e5c4:
	ld_s r1,[r13,0x34]
L_92e5c6:
	add_s r0,r0,r1
L_92e5c8:
	st_s r0,[r13,0x34]
L_92e5ca:
	ld_s r0,[sp,0x2c]
L_92e5cc:
	ld_s r1,[r13,0x38]
L_92e5ce:
	add_s r0,r0,r1
L_92e5d0:
	st_s r0,[r13,0x38]
L_92e5d2:
	ld_s r0,[sp,0x30]
L_92e5d4:
	ld_s r1,[r13,0x3c]
L_92e5d6:
	add_s r0,r0,r1
L_92e5d8:
	st_s r0,[r13,0x3c]
L_92e5da:
	ld_s r0,[sp,0x34]
L_92e5dc:
	ld_s r1,[r13,0x40]
L_92e5de:
	add_s r0,r0,r1
L_92e5e0:
	st_s r0,[r13,0x40]
L_92e5e2:
	ld_s r0,[sp,0x38]
L_92e5e4:
	ld_s r1,[r13,0x44]
L_92e5e6:
	add.f r0,r0,r1
L_92e5ea:
	ld_s r1,[r13,0x4c]
L_92e5ec:
	st_s r0,[r13,0x44]
L_92e5ee:
	ld_s r0,[sp,0x40]
L_92e5f0:
	adc r2,r2,r3
L_92e5f4:
	add.f r0,r0,r1
L_92e5f8:
	st_s r2,[r13,0x48]
L_92e5fa:
	ld_s r2,[sp,0x44]
L_92e5fc:
	st_s r0,[r13,0x4c]
L_92e5fe:
	ld_s r0,[sp,0x48]
L_92e600:
	ld_s r3,[r13,0x50]
L_92e602:
	ld_s r1,[r13,0x54]
L_92e604:
	adc r2,r2,r3
L_92e608:
	add.f r0,r0,r1
L_92e60c:
	st_s r2,[r13,0x50]
L_92e60e:
	ld_s r2,[sp,0x4c]
L_92e610:
	st_s r0,[r13,0x54]
L_92e612:
	ld_s r0,[sp,0x50]
L_92e614:
	ld_s r3,[r13,0x58]
L_92e616:
	ld_s r1,[r13,0x5c]
L_92e618:
	adc r2,r2,r3
L_92e61c:
	add.f r0,r0,r1
L_92e620:
	st_s r2,[r13,0x58]
L_92e622:
	ld_s r2,[sp,0x54]
L_92e624:
	st_s r0,[r13,0x5c]
L_92e626:
	ld_s r0,[sp,0x58]
L_92e628:
	ld_s r3,[r13,0x60]
L_92e62a:
	ld_s r1,[r13,0x64]
L_92e62c:
	adc r2,r2,r3
L_92e630:
	add.f r0,r0,r1
L_92e634:
	st_s r2,[r13,0x60]
L_92e636:
	ld_s r2,[sp,0x5c]
L_92e638:
	st_s r0,[r13,0x64]
L_92e63a:
	ld_s r0,[sp,0x60]
L_92e63c:
	ld_s r3,[r13,0x68]
L_92e63e:
	ld_s r1,[r13,0x6c]
L_92e640:
	adc r2,r2,r3
L_92e644:
	add.f r0,r0,r1
L_92e648:
	st_s r2,[r13,0x68]
L_92e64a:
	ld_s r2,[sp,0x64]
L_92e64c:
	st_s r0,[r13,0x6c]
L_92e64e:
	ld_s r3,[r13,0x70]
L_92e650:
	ld_s r0,[sp,0x68]
L_92e652:
	adc r2,r2,r3
L_92e656:
	ld_s r1,[r13,0x74]
L_92e658:
	st_s r2,[r13,0x70]
L_92e65a:
	add.f r0,r0,r1
L_92e65e:
	ld_s r2,[sp,0x6c]
L_92e660:
	st_s r0,[r13,0x74]
L_92e662:
	ld_s r3,[r13,0x78]
L_92e664:
	ld_s r0,[sp,0x70]
L_92e666:
	adc r2,r2,r3
L_92e66a:
	ld_s r1,[r13,0x7c]
L_92e66c:
	st_s r2,[r13,0x78]
L_92e66e:
	add.f r0,r0,r1
L_92e672:
	ld_s r2,[sp,0x74]
L_92e674:
	st_s r0,[r13,0x7c]
L_92e676:
	ld r3,[r13, 0x80]
L_92e67a:
	adc r2,r2,r3
L_92e67e:
	ld r0,[r13, 0x84]
L_92e682:
	st r2,[r13, 0x80]
L_92e686:
	cmp_s r0,r14
L_92e688:
	mov.hi r14,r0
L_92e68c:
	mov_s r0,0x802110
L_92e692:
	ldb_s r0,[r0,0x1]
L_92e694:
	st r14,[r13, 0x84]
L_92e698:
	st r0,[r13, 0x88]
L_92e69c:
	mov_s r0,0x8006b4
L_92e6a2:
	ldb_s r0,[r0,0x3]
L_92e6a4:
	norm r0,r0
L_92e6a8:
	rsub r1,r0,0x1e
L_92e6ac:
	mov_s r0,0x80141c
L_92e6b2:
	ldb_s r0,[r0,r1]
L_92e6b4:
	st r0,[r13, 0x8c]
L_92e6b8:
	b.d L_9202a4
L_92e6bc:
	add_s sp,sp,0x78
L_92e6be:
	nop_s
