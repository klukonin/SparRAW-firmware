/* hwd_phy_rx_read_and_parse_brp_ram @ 0x8d27f4, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_rx_read_and_parse_brp_ram(): size=%d
 *   hwd_phy_rx_read_and_parse_brp_ram(): reg=0x%x, byte_offset=%d
 * Зовут его: fw_sysapi_mgr__channel_estimation_cmd_complete
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, hwd_phy__dbg_clk_enable_get, hwd_phy_dbg_clk_enable, phy__get_885178_3bit, phy__set_885178_3bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_rx_read_and_parse_brp_ram
hwd_phy_rx_read_and_parse_brp_ram:
	.global L_8d27f4
L_8d27f4:
	push_s blink
L_8d27f6:
	bl.d L_8c01c8
L_8d27fa:
	mov_s r0,0x20
L_8d27fc:
	mov_s r16,r1
L_8d27fe:
	mov_s r17,r2
L_8d2800:
	mov_s r18,r3
L_8d2802:
	mov_s r1,0x101db60
L_8d2808:
	bl.d L_8dcc10
L_8d280c:
	mov_s r2,r3
L_8d280e:
	bl L_8d1c20
L_8d2812:
	bl L_8d1b88
L_8d2816:
	mov_s r21,r0
L_8d2818:
	bl.d L_8d1bc0
L_8d281c:
	mov_s r0,0x1
L_8d281e:
	bl.d L_8d1b94
L_8d2822:
	mov_s r0,0x3
L_8d2824:
	mov_s r1,0x883f00
L_8d282a:
	ld_s r0,[r1,0x40]
L_8d282c:
	bclr_s r0,r0,0x2
L_8d282e:
	st_s r0,[r1,0x40]
L_8d2830:
	ld_s r0,[r1,0x40]
L_8d2832:
	bset_s r0,r0,0x0
L_8d2834:
	st_s r0,[r1,0x40]
L_8d2836:
	mov_s r0,0x0
L_8d2838:
	b_s L_8d2842
	.global L_8d283a
L_8d283a:
	sub r18,r18,0x20
L_8d283e:
	add r0,r19,0x1
	.global L_8d2842
L_8d2842:
	brge.d r0,0x8,L_8d28da
L_8d2846:
	mov_s r19,r0
L_8d2848:
	brlo r18,0x20,L_8d28da
L_8d284c:
	add3 r13,r19,r16
L_8d2850:
	mov r14,-0x100
L_8d2854:
	tst_s r13,r14
L_8d2856:
	bne_s L_8d28d0
	.global L_8d2858
L_8d2858:
	mov_s r1,0x883f80
L_8d285e:
	ld_s r0,[r1,0x4]
L_8d2860:
	mov_s r15,0x8
L_8d2862:
	and_s r0,r0,r14
L_8d2864:
	or_s r13,r13,r0
L_8d2866:
	st_s r13,[r1,0x4]
L_8d2868:
	ld_s r0,[r1,0x4]
L_8d286a:
	mov_s r13,0x0
L_8d286c:
	bset_s r0,r0,0x8
L_8d286e:
	st_s r0,[r1,0x4]
	.global L_8d2870
L_8d2870:
	mov_s r0,0x883f64
L_8d2876:
	ld.as r14,[r0,r13]
L_8d287a:
	asr_s r0,r13
L_8d287c:
	lsr_s r0,r0,0x1e
L_8d287e:
	add_s r0,r0,r13
L_8d2880:
	sub_s r1,r13,0x4
L_8d2882:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_8d2884:
	mul64_s r0,r1
L_8d2886:
	rsub r2,r0,0x1
L_8d288a:
	mov_s r1,mlo
L_8d288c:
	mul64_s r2,r13
L_8d288e:
	asl r2,r19,0x5
L_8d2892:
	add_s r1,r1,mlo
L_8d2894:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_8d2896:
	add_s r1,r1,r2
L_8d2898:
	add r20,r1,r0
L_8d289c:
	mov_s r1,0x101db90
L_8d28a2:
	mov_s r0,0x20
L_8d28a4:
	mov_s r2,r14
L_8d28a6:
	extb r20,r20
L_8d28aa:
	bl.d L_8dcc80
L_8d28ae:
	mov_s r3,r20
L_8d28b0:
	add r0,r17,r20
L_8d28b4:
	stb_s r14,[r0]
L_8d28b6:
	lsr r1,r14,0x8
L_8d28ba:
	stb_s r1,[r0,0x2]
L_8d28bc:
	lsr r1,r14,0x10
L_8d28c0:
	stb_s r1,[r0,0x4]
L_8d28c2:
	lsr_s r14,r14,0x18
L_8d28c4:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d28c6:
	stb_s r14,[r0,0x6]
L_8d28c8:
	/* brhs.d r15,0x1,0x008d2870 */
	.byte 0xa9,0x0f,0x75,0x90
L_8d28cc:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d28ce:
	b_s L_8d283a
	.global L_8d28d0
L_8d28d0:
	mov_s r0,blink
L_8d28d2:
	bl.d L_8c9b28
L_8d28d6:
	mov_s r1,0xac
L_8d28d8:
	b_s L_8d2858
	.global L_8d28da
L_8d28da:
	bl.d L_8d1bc0
L_8d28de:
	mov_s r0,0x0
L_8d28e0:
	bl.d L_8d1b94
L_8d28e4:
	mov_s r0,r21
L_8d28e6:
	b L_8c021c
L_8d28ea:
	nop_s
