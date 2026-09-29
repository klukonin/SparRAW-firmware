/* PS_CONNECTION__psc_complete_8e1794 @ 0x8e1794, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION::psc_complete (is_local=%d) (success=%d) (dpm=%d)
 *   PS_CONNECTION::psc_complete WS: (start_time=0x%x) %d:%d
 *   ps_connection::psc_complete: psc agreement was rejected, curr state %d. inject ABORT
 * Зовут его: PS_CONNECTION__psc_complete
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r18_to_r13_ret, __st_r18_to_r13, basic_sm__handle_event, brd_if_multi_array__get_block_info, evt_ring__push_1c, fw_log_emit1, fw_log_emit3, lmac_if_send_cmd_0x22, psc__set_two_flags, psc_if__start_psc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_CONNECTION__psc_complete_8e1794
PS_CONNECTION__psc_complete_8e1794:
	.global L_8e1794
L_8e1794:
	push_s blink
L_8e1796:
	push_s r13
L_8e1798:
	sub_s sp,sp,0xc
L_8e179a:
	mov_s r13,r0
L_8e179c:
	mov_s r1,sp
L_8e179e:
	bl.d L_8cd098
L_8e17a2:
	ldw_s r0,[r0,0xc]
L_8e17a4:
	mov_s r0,r13
L_8e17a6:
	bl.d L_8cb940
L_8e17aa:
	mov_s r1,0x0
L_8e17ac:
	mov_s r2,r0
L_8e17ae:
	ldb r0,[sp, 0x1]
L_8e17b2:
	mov_s r1,0x1
L_8e17b4:
	stw r0,[sp, 0x8]
L_8e17b8:
	ldb_s r0,[sp,0x0]
L_8e17ba:
	stw r0,[sp, 0xa]
L_8e17be:
	ld_s r0,[r13,0x8]
L_8e17c0:
	bl.d L_8d9cc8
L_8e17c4:
	ld_s r3,[sp,0x8]
L_8e17c6:
	b.d L_8c025c
L_8e17ca:
	add_s sp,sp,0xc
	.global L_8e17cc
L_8e17cc:
	push_s blink
L_8e17ce:
	bl L_8c01d4
L_8e17d2:
	mov_s r14,r0
L_8e17d4:
	mov.f r15,r1
L_8e17d8:
	mov_s r16,r2
L_8e17da:
	mov_s r18,r3
L_8e17dc:
	mov_s r13,r4
L_8e17de:
	mov_s r0,0xff
L_8e17e0:
	bne_s L_8e17e6
L_8e17e2:
	ld_s r0,[r14,0x34]
L_8e17e4:
	ldb_s r0,[r0,0x8]
	.global L_8e17e6
L_8e17e6:
	mov_s r17,r0
L_8e17e8:
	mov_s r1,0x1002604
L_8e17ee:
	mov_s r0,0x2e
L_8e17f0:
	mov_s r2,r15
L_8e17f2:
	mov_s r3,r16
L_8e17f4:
	bl.d L_8dcd00
L_8e17f8:
	mov r4,r18
L_8e17fc:
	ldw r4,[r13, 0x4]
L_8e1800:
	mov_s r1,0x1002644
L_8e1806:
	ld_s r2,[r13]
L_8e1808:
	mov_s r0,0x2e
L_8e180a:
	bl.d L_8dcd00
L_8e180e:
	ldw_s r3,[r13,0x6]
L_8e1810:
	breq r16,0x0,L_8e1856
L_8e1814:
	breq_s r15,0,L_8e1824
L_8e1816:
	st r18,[r14, 0x18]
L_8e181a:
	ld_s r1,[r13]
L_8e181c:
	ld_s r0,[r13,0x4]
L_8e181e:
	st_s r1,[r14,0x1c]
L_8e1820:
	st_s r0,[r14,0x20]
L_8e1822:
	b_s L_8e1830
	.global L_8e1824
L_8e1824:
	st r18,[r14, 0x28]
L_8e1828:
	ld_s r1,[r13]
L_8e182a:
	ld_s r0,[r13,0x4]
L_8e182c:
	st_s r1,[r14,0x2c]
L_8e182e:
	st_s r0,[r14,0x30]
	.global L_8e1830
L_8e1830:
	mov_s r0,r17
L_8e1832:
	mov_s r1,r18
L_8e1834:
	bl.d L_8dc474
L_8e1838:
	mov_s r2,r13
L_8e183a:
	ldw_s r1,[r13,0x6]
L_8e183c:
	mov_s r0,0x886e80
L_8e1842:
	ldw_s r2,[r13,0x4]
L_8e1844:
	add_s r1,r1,r1
L_8e1846:
	add2_s r1,r1,r1
L_8e1848:
	add_s r1,r1,r2
L_8e184a:
	cmp_s r2,0x1
L_8e184c:
	ld_s r2,[r0,0x38]
L_8e184e:
	mov_s r0,0x11
L_8e1850:
	mov.le r0,0xe
L_8e1854:
	b_s L_8e1862
	.global L_8e1856
L_8e1856:
	mov_s r0,0x886e80
L_8e185c:
	ld_s r2,[r0,0x38]
L_8e185e:
	mov_s r0,0xf
L_8e1860:
	mov_s r1,0x0
	.global L_8e1862
L_8e1862:
	bl L_8e0b2c
L_8e1866:
	breq r15,0x0,L_8e190c
L_8e186a:
	add_s r15,r14,0x4
L_8e186c:
	ldb r18,[r15]
L_8e1870:
	breq r16,0x0,L_8e1880
L_8e1874:
	mov_s r2,0x0
L_8e1876:
	stb r2,[r14, 0x24]
L_8e187a:
	mov_s r0,r15
L_8e187c:
	mov_s r1,0x2
L_8e187e:
	b_s L_8e18a0
	.global L_8e1880
L_8e1880:
	cmp r18,0x6
L_8e1884:
	cmp.ne r18,0x7
L_8e1888:
	cmp.ne r18,0x1
L_8e188c:
	bne_s L_8e189a
L_8e188e:
	ldb r0,[r14, 0x24]
L_8e1892:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e1894:
	extb_s r0,r0
L_8e1896:
	stb r0,[r14, 0x24]
	.global L_8e189a
L_8e189a:
	mov_s r0,r15
L_8e189c:
	mov_s r1,0x3
L_8e189e:
	mov_s r2,0x0
	.global L_8e18a0
L_8e18a0:
	mov_s r16,r2
L_8e18a2:
	mov_s r2,0x0
L_8e18a4:
	mov_s r3,r2
L_8e18a6:
	bl.d L_8d9b6c
L_8e18aa:
	mov_s r4,r2
L_8e18ac:
	ldb r0,[r14, 0x24]
L_8e18b0:
	brlt r0,0xa,L_8e18e8
L_8e18b4:
	mov_s r1,0x100267c
L_8e18ba:
	mov_s r0,0xe
L_8e18bc:
	bl.d L_8dcc10
L_8e18c0:
	mov_s r2,r18
L_8e18c2:
	mov_s r0,r15
L_8e18c4:
	mov_s r1,0x4
L_8e18c6:
	mov_s r2,0x0
L_8e18c8:
	mov_s r3,r2
L_8e18ca:
	bl.d L_8d9b6c
L_8e18ce:
	mov_s r4,r2
L_8e18d0:
	st r16,[r13]
L_8e18d4:
	stw r16,[r13, 0x6]
L_8e18d8:
	stw r16,[r13, 0x4]
L_8e18dc:
	mov_s r0,r17
L_8e18de:
	mov_s r1,0x0
L_8e18e0:
	bl.d L_8dc474
L_8e18e4:
	mov_s r2,r13
L_8e18e6:
	b_s L_8e190c
	.global L_8e18e8
L_8e18e8:
	ld_s r0,[r14]
L_8e18ea:
	ldb_s r1,[r15]
L_8e18ec:
	breq_s r0,0,L_8e18fa
L_8e18ee:
	cmp_s r1,0x0
L_8e18f0:
	mov.eq r0,r15
L_8e18f4:
	mov.eq r1,0x0
L_8e18f8:
	beq_s L_8e1902
	.global L_8e18fa
L_8e18fa:
	brne_s r0,0,L_8e190c
L_8e18fc:
	breq_s r1,0,L_8e190c
L_8e18fe:
	mov_s r0,r15
L_8e1900:
	mov_s r1,0x5
	.global L_8e1902
L_8e1902:
	mov_s r2,0x0
L_8e1904:
	mov_s r3,r2
L_8e1906:
	bl.d L_8d9b6c
L_8e190a:
	mov_s r4,r2
	.global L_8e190c
L_8e190c:
	b L_8c0234
