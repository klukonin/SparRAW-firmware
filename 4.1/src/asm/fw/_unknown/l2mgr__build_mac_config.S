/* l2mgr__build_mac_config @ 0x8e17b4, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, l2mgr_mac_start_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_b_s1_w3, bf_b_s4_w2, bf_b_s6_w2, bf_u16_s3_w8, bf_u16_s5_w6, bf_u16_s6_w6, bf_u16_s7_w7, bf_u32_s4_w24, memcpy_fw, sta_rec__unpack_5bit_caps
 */
	.section .text.l2mgr__build_mac_config,"ax",@progbits
	.global l2mgr__build_mac_config
l2mgr__build_mac_config:
	.global L_8e17b4
L_8e17b4:
	push_s blink
L_8e17b6:
	bl.d L_8c02bc
L_8e17ba:
	mov_s r2,0x6
L_8e17bc:
	sub_s sp,sp,0x4
L_8e17be:
	mov_s r15,r0
L_8e17c0:
	mov_s r0,0x0
L_8e17c2:
	mov_s r16,r0
L_8e17c4:
	add3 r14,r15,0xc
L_8e17c8:
	stb_s r0,[r14,0x4]
L_8e17ca:
	bl.d L_8c0460
L_8e17ce:
	add1 r0,r15,0x2f
L_8e17d2:
	mov_s r0,0x80345c
L_8e17d8:
	ld_s r0,[r0,0xc]
L_8e17da:
	mov_s r1,0x1
L_8e17dc:
	cmp_s r0,0x0
L_8e17de:
	ldb_s r0,[r14,0x5]
L_8e17e0:
	sub_s.ne r1,r1,r1
L_8e17e2:
	bclr_s r0,r0,0x0
L_8e17e4:
	or_s r0,r0,r1
L_8e17e6:
	bic r0,r0,0xe
L_8e17ea:
	stb_s r0,[r14,0x5]
L_8e17ec:
	add_s r0,r14,0x5
L_8e17ee:
	mov_s r1,0x1
L_8e17f0:
	bl.d L_8e8264
L_8e17f4:
	add3 r13,r15,0x8
L_8e17f8:
	ldb_s r0,[r14,0x5]
L_8e17fa:
	mov_s r1,0x22
L_8e17fc:
	bclr_s r0,r0,0x6
L_8e17fe:
	stb_s r0,[r14,0x5]
L_8e1800:
	add r0,r13,0x25
L_8e1804:
	bl L_8e81e0
L_8e1808:
	add r0,r13,0x26
L_8e180c:
	mov_s r1,0x1f
L_8e180e:
	bl L_8e81a4
L_8e1812:
	ldb_s r0,[r14,0x7]
L_8e1814:
	mov_s r1,0x35
L_8e1816:
	bset_s r0,r0,0x4
L_8e1818:
	stb_s r0,[r14,0x7]
L_8e181a:
	add r0,r13,0x27
L_8e181e:
	bl L_8e818c
L_8e1822:
	ldb_s r0,[r14,0x8]
L_8e1824:
	st r16,[sp]
L_8e1828:
	bclr_s r0,r0,0x3
L_8e182a:
	stb_s r0,[r14,0x8]
L_8e182c:
	mov_s r1,sp
L_8e182e:
	bl.d L_8cab58
L_8e1832:
	mov_s r0,r15
L_8e1834:
	ld_s r1,[sp,0x0]
L_8e1836:
	add3 r0,r15,0xd
L_8e183a:
	bmsk_s r1,r1,0x17
L_8e183c:
	bl L_8e81ec
L_8e1840:
	ldb_s r0,[r14,0xb]
L_8e1842:
	mov_s r1,0x0
L_8e1844:
	bic r0,r0,0x30
L_8e1848:
	bic r0,r0,0xc0
L_8e184c:
	bset_s r0,r0,0x6
L_8e184e:
	stb_s r0,[r14,0xb]
L_8e1850:
	ldb_s r0,[r14,0xc]
L_8e1852:
	bclr_s r0,r0,0x0
L_8e1854:
	stb_s r0,[r14,0xc]
L_8e1856:
	add r0,r14,0xc
L_8e185a:
	bl L_8e8228
L_8e185e:
	ldb_s r2,[r14,0xc]
L_8e1860:
	bset_s r2,r2,0x4
L_8e1862:
	bclr_s r2,r2,0x5
L_8e1864:
	bl.d L_8e8288
L_8e1868:
	stb_s r2,[r14,0xc]
L_8e186a:
	ldb_s r0,[r14,0xd]
L_8e186c:
	bic r0,r0,0x7
L_8e1870:
	stb_s r0,[r14,0xd]
L_8e1872:
	ld_s r0,[r15]
L_8e1874:
	ldb_s r1,[r0,0x11]
L_8e1876:
	add r0,r13,0x2d
L_8e187a:
	bl L_8e8168
L_8e187e:
	ldb_s r0,[r14,0xe]
L_8e1880:
	mov_s r1,0x0
L_8e1882:
	bic r0,r0,0x38
L_8e1886:
	stb_s r0,[r14,0xe]
L_8e1888:
	add r0,r14,0xe
L_8e188c:
	bl L_8e8288
L_8e1890:
	b.d L_8c0324
L_8e1894:
	add_s sp,sp,0x4
L_8e1896:
	nop_s
