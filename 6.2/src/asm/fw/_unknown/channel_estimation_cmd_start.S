/* channel_estimation_cmd_start @ 0x8f17a0, 384 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channel_estimation_cmd_start: Enter
 *   channel_estimation_cmd_start: filter params: sta_id = 0x%x, is_omni = 0x%x
 *   reject SYSAPI CHANNEL_ESTIMATION - prev command was not completed
 *   channel_estimation_timeout_cb: !! TIMEOUT !!halt cmd
 *   l2_mgr::channel_locked_cb()  unlocking radio 0x%x
 *   [TOF] ftm_main_sm::channel_switch_cb()
 * Зовут его: hw_sysapi_channel_estimation
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, channel_est__clamp_64, channel_est__stack_args, field_set_0x00__8dbe88, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysapi_mgr__channel_estimation_cmd_complete, fw_sysapi_mgr__send_evt2host
 * Глобалы (через gp): 0x800212
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channel_estimation_cmd_start
channel_estimation_cmd_start:
	.global L_8f17a0
L_8f17a0:
	sub_s sp,sp,0x8
L_8f17a2:
	push_s blink
L_8f17a4:
	bl L_8c01dc
L_8f17a8:
	sub_s sp,sp,0x8
L_8f17aa:
	st_s r3,[sp,0x1c]
L_8f17ac:
	st r4,[sp, 0x20]
L_8f17b0:
	mov_s r13,r0
L_8f17b2:
	mov_s r14,r1
L_8f17b4:
	mov_s r16,r2
L_8f17b6:
	mov_s r1,0x101290c
L_8f17bc:
	bl.d L_8dcba8
L_8f17c0:
	mov_s r0,0x20
L_8f17c2:
	ldb_s r2,[r14]
L_8f17c4:
	mov_s r1,0x1012930
L_8f17ca:
	mov_s r0,0x20
L_8f17cc:
	bl.d L_8dcc80
L_8f17d0:
	ldb_s r3,[r14,0x4]
L_8f17d2:
	add_s r15,sp,0x1c
L_8f17d4:
	mov_s r0,r13
L_8f17d6:
	mov_s r1,0x6
L_8f17d8:
	bl.d L_8f9a20
L_8f17dc:
	mov_s r2,r15
L_8f17de:
	brne_s r0,0,L_8f17fc
L_8f17e0:
	mov_s r1,0x101297c
L_8f17e6:
	bl.d L_8dcba8
L_8f17ea:
	mov_s r0,0x20
L_8f17ec:
	mov_s r0,r13
L_8f17ee:
	mov_s r1,0x2
L_8f17f0:
	mov_s r2,0x0
L_8f17f2:
	mov_s r3,0x0
L_8f17f4:
	bl.d L_8f8948
L_8f17f8:
	mov_s r4,r15
L_8f17fa:
	b_s L_8f183c
	.global L_8f17fc
L_8f17fc:
	bl L_8d1c20
L_8f1800:
	bl L_8d1b88
L_8f1804:
	bl.d L_8d1bc0
L_8f1808:
	mov_s r0,0x1
L_8f180a:
	bl.d L_8d1b94
L_8f180e:
	mov_s r0,0x1
L_8f1810:
	mov_s r0,0x31844
L_8f1816:
	st_s r0,[r13,0x34]
L_8f1818:
	mov_s r2,0x3184c
L_8f181e:
	mov_s r0,r13
L_8f1820:
	bl.d L_8f9070
L_8f1824:
	mov_s r1,r16
L_8f1826:
	mov_s r0,sp
L_8f1828:
	mov_s r1,r14
L_8f182a:
	bl.d L_8c0380
L_8f182e:
	mov_s r2,0x8
L_8f1830:
	ld_s r1,[sp,0x0]
L_8f1832:
	mov_s r0,0x3c
L_8f1834:
	ld_s r2,[sp,0x4]
L_8f1836:
	bl.d L_8dbe54
L_8f183a:
	mov_s r3,0x0
	.global L_8f183c
L_8f183c:
	mov_s r12,0xc
L_8f183e:
	b.d L_8c0246
L_8f1842:
	add_s sp,sp,0x8
L_8f1844:
	b.d L_8f1740
L_8f1848:
	st_s r1,[r0,0x20]
L_8f184a:
	nop_s
L_8f184c:
	push_s blink
L_8f184e:
	push_s r13
L_8f1850:
	mov_s r13,r0
L_8f1852:
	ld_s r1,[r13]
L_8f1854:
	mov_s r0,0x0
L_8f1856:
	st_s r0,[r13,0x10]
L_8f1858:
	brne r1,0x6,L_8f1864
L_8f185c:
	ld_s r1,[r13,0x20]
L_8f185e:
	cmp_s r1,0x2
L_8f1860:
	mov.eq r0,0x1
	.global L_8f1864
L_8f1864:
	extb.f 0x0,r0
L_8f1868:
	beq_s L_8f187e
L_8f186a:
	mov_s r1,0x1013168
L_8f1870:
	bl.d L_8dcba8
L_8f1874:
	mov_s r0,0x20
L_8f1876:
	mov_s r0,0x3d
L_8f1878:
	bl.d L_8dbe88
L_8f187c:
	mov_s r1,0x3
	.global L_8f187e
L_8f187e:
	mov_s r0,r13
L_8f1880:
	bl.d L_8f1740
L_8f1884:
	mov_s r1,0x3
L_8f1886:
	b L_8c025c
L_8f188a:
	nop_s
L_8f188c:
	push_s blink
L_8f188e:
	bl L_8c01dc
L_8f1892:
	mov_s r16,r0
L_8f1894:
	bl.d L_8cc3dc
L_8f1898:
	ld_s r0,[gp,-0xcc]
L_8f189a:
	mov.f r13,r0
L_8f189e:
	beq_s L_8f18dc
	.global L_8f18a0
L_8f18a0:
	mov_s r0,r13
L_8f18a2:
	mov_s r1,0x805160
L_8f18a8:
	bl.d L_8c71a8
L_8f18ac:
	ldw.as r2,[gp,0x47]
L_8f18b0:
	mov_s r1,0x100f9b4
L_8f18b6:
	mov_s r0,0x2b
L_8f18b8:
	bl.d L_8dcc10
L_8f18bc:
	mov_s r2,r16
L_8f18be:
	bl.d L_8ea800
L_8f18c2:
	mov_s r0,r16
L_8f18c4:
	ldw_s r0,[gp,0x8e]
L_8f18c6:
	add3 r1,r13,0x9
L_8f18ca:
	cmp_s r0,0x1
L_8f18cc:
	mov_s r2,0x1
L_8f18ce:
	sub_s.ne r2,r2,r2
L_8f18d0:
	mov_s r0,r1
L_8f18d2:
	bl.d L_8e73a0
L_8f18d6:
	ld_s r1,[r13,0x14]
L_8f18d8:
	b L_8c0244
	.global L_8f18dc
L_8f18dc:
	mov_s r0,blink
L_8f18de:
	mov_s r1,0x16c7
L_8f18e4:
	bl L_8c9b28
L_8f18e8:
	b_s L_8f18a0
L_8f18ea:
	nop_s
L_8f18ec:
	push_s blink
L_8f18ee:
	push_s r13
L_8f18f0:
	mov_s r13,r1
L_8f18f2:
	mov_s r1,0x1019efc
L_8f18f8:
	bl.d L_8dcba8
L_8f18fc:
	mov_s r0,0x20
L_8f18fe:
	mov_s r0,r13
L_8f1900:
	mov_s r1,0x4
L_8f1902:
	mov_s r2,0x0
L_8f1904:
	mov_s r3,r2
L_8f1906:
	bl.d L_8d9b6c
L_8f190a:
	mov_s r4,r2
L_8f190c:
	b L_8c025c
L_8f1910:
	mov_s r0,r1
L_8f1912:
	mov_s r1,0x2
L_8f1914:
	mov_s r2,0x0
L_8f1916:
	mov_s r3,r2
L_8f1918:
	b.d L_8d9b6c
L_8f191c:
	mov_s r4,r2
L_8f191e:
	nop_s
