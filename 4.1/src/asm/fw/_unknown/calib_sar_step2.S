/* calib_sar_step2 @ 0x8d1734, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_calib_sar_alg
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, hwd_abif__adjust_5bit_pair, hwd_abif__get_88af10, hwd_phy__read_sar_sample, hwd_phy__rgf_885000_8cfc0c, phy__wait_sar_done, sar64_fw
 */
	.section .text.calib_sar_step2,"ax",@progbits
	.global calib_sar_step2
calib_sar_step2:
	.global L_8d1734
L_8d1734:
	push_s blink
L_8d1736:
	bl L_8c02a4
L_8d173a:
	mov_s r2,0x802f00
L_8d1740:
	ldw_s r1,[r2,0x10]
L_8d1742:
	sub r21,r0,0x2
L_8d1746:
	stw.a r1,[sp,-0x14]
L_8d174a:
	ldw_s r1,[r2,0x12]
L_8d174c:
	mov_s r14,0x8
L_8d174e:
	stw r1,[sp, 0x2]
L_8d1752:
	mov_s r1,0x0
L_8d1754:
	mov_s r20,r1
L_8d1756:
	mov_s r18,r1
L_8d1758:
	bl.d L_8cfc0c
L_8d175c:
	extb r21,r21
L_8d1760:
	bl.d L_8cfbc8
L_8d1764:
	mov_s r13,r20
L_8d1766:
	mov r16,r20
L_8d176a:
	mov r17,r20
	.global L_8d176e
L_8d176e:
	extb_s r0,r13
L_8d1770:
	bl.d L_8cf7b4
L_8d1774:
	add_s r1,sp,0x4
L_8d1776:
	ld_s r1,[sp,0x8]
L_8d1778:
	ld_s r0,[sp,0x4]
L_8d177a:
	bl.d L_8c06e0
L_8d177e:
	mov_s r2,0x3
L_8d1780:
	add.f r16,r16,r0
L_8d1784:
	ld_s r0,[sp,0xc]
L_8d1786:
	adc r17,r17,r1
L_8d178a:
	ld_s r1,[sp,0x10]
L_8d178c:
	bl.d L_8c06e0
L_8d1790:
	mov_s r2,0x3
L_8d1792:
	add.f r20,r20,r0
L_8d1796:
	adc r18,r18,r1
L_8d179a:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8d179c:
	/* brhs.d r14,0x1,0x008d176e */
	.byte 0xd3,0x0e,0x75,0x90
L_8d17a0:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d17a2:
	mov_s r0,0x0
L_8d17a4:
	b_s L_8d17aa
	.global L_8d17a6
L_8d17a6:
	add r0,r22,0x1
	.global L_8d17aa
L_8d17aa:
	brhs.d r0,0x8,L_8d17f8
L_8d17ae:
	mov_s r22,r0
L_8d17b0:
	mov_s r14,0x0
L_8d17b2:
	mov_s r13,0x2
	.global L_8d17b4
L_8d17b4:
	extb r15,r22
L_8d17b8:
	mov_s r0,r15
L_8d17ba:
	mov_s r1,r14
L_8d17bc:
	bl.d L_8cbf5c
L_8d17c0:
	mov_s r2,0x0
L_8d17c2:
	mov_s r19,r0
L_8d17c4:
	mov_s r0,r15
L_8d17c6:
	mov_s r1,r14
L_8d17c8:
	bl.d L_8cbf5c
L_8d17cc:
	mov_s r2,0x1
L_8d17ce:
	sub r2,r19,r0
L_8d17d2:
	add r0,sp,r14
L_8d17d6:
	ldb.x r1,[r0]
L_8d17da:
	sexb_s r2,r2
L_8d17dc:
	max r1,r1,r2
L_8d17e0:
	stb_s r1,[r0]
L_8d17e2:
	ldb.x r1,[r0, 0x2]
L_8d17e6:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d17e8:
	min r2,r1,r2
L_8d17ec:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d17ee:
	stb_s r2,[r0,0x2]
L_8d17f0:
	brhs.d r13,0x1,L_8d17b4
L_8d17f4:
	extb_s r14,r14
L_8d17f6:
	b_s L_8d17a6
	.global L_8d17f8
L_8d17f8:
	mov_s r0,r16
L_8d17fa:
	mov_s r1,r17
L_8d17fc:
	bl.d L_8c06e0
L_8d1800:
	mov_s r2,r21
L_8d1802:
	rsub r13,r0,0x0
L_8d1806:
	sexb_s r13,r13
L_8d1808:
	mov_s r0,r20
L_8d180a:
	mov_s r1,r18
L_8d180c:
	bl.d L_8c06e0
L_8d1810:
	mov_s r2,r21
L_8d1812:
	rsub r2,r0,0x0
L_8d1816:
	ldb.x r0,[sp]
L_8d181a:
	sexb_s r2,r2
L_8d181c:
	rsub r3,r0,0x1f
L_8d1820:
	ldb.x r0,[sp, 0x2]
L_8d1824:
	sexb_s r3,r3
L_8d1826:
	add_s r0,r0,0x1f
L_8d1828:
	neg_s r0,r0
L_8d182a:
	ldb.x r15,[sp, 0x1]
L_8d182e:
	sexb_s r14,r0
L_8d1830:
	rsub r0,r15,0x1f
L_8d1834:
	ldb.x r15,[sp, 0x3]
L_8d1838:
	sexb_s r0,r0
L_8d183a:
	add_s r15,r15,0x1f
L_8d183c:
	neg_s r15,r15
L_8d183e:
	brlt.d r13,0x1,L_8d184e
L_8d1842:
	sexb_s r15,r15
L_8d1844:
	min r3,r3,r13
L_8d1848:
	sexb r16,r3
L_8d184c:
	b_s L_8d1856
	.global L_8d184e
L_8d184e:
	max r13,r14,r13
L_8d1852:
	sexb r16,r13
	.global L_8d1856
L_8d1856:
	brlt r2,0x1,L_8d1864
L_8d185a:
	min r0,r0,r2
L_8d185e:
	sexb r17,r0
L_8d1862:
	b_s L_8d186c
	.global L_8d1864
L_8d1864:
	max r2,r15,r2
L_8d1868:
	sexb r17,r2
	.global L_8d186c
L_8d186c:
	mov_s r15,0x0
L_8d186e:
	mov_s r13,0x8
	.global L_8d1870
L_8d1870:
	extb_s r14,r15
L_8d1872:
	mov_s r0,r14
L_8d1874:
	mov_s r1,0x0
L_8d1876:
	bl.d L_8cbf98
L_8d187a:
	mov_s r2,r16
L_8d187c:
	mov_s r0,r14
L_8d187e:
	mov_s r1,0x1
L_8d1880:
	bl.d L_8cbf98
L_8d1884:
	mov_s r2,r17
L_8d1886:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d1888:
	/* brhs.d r13,0x1,0x008d1870 */
	.byte 0xe9,0x0d,0x75,0x90
L_8d188c:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d188e:
	b.d L_8c02f4
L_8d1892:
	add_s sp,sp,0x14
