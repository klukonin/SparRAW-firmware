/* discovery_handle_probe_req @ 0x8f2798, 436 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery_handle_probe_req()
 *   discovery_handle_probe_req() Disconnecting all MIDs due to special configuration
 *   Save Probe request DMG Capabilities len %d 0x%x 0x%x
 *   discovery_handle_probe_req() Probe resp sending <ts: %d>
 *   discovery_handle_probe_req() Ignore Probe resq since from none handled CID <ts: %d>
 *   discovery_handle_probe_req() FIND:: Probe req handle
 *   discovery_handle_probe_req() Ignore Probe req from ADDR-%04X%08X while not in PCP mode
 * Зовут его: discovery__rx_pkt_handler
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, conn__set_rf_params_from_caps, discovery__init_probe_entry, discovery__inject_probe_evt, discovery_is_ssid_approved, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, hexdump_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery_handle_probe_req
discovery_handle_probe_req:
	.global L_8f2798
L_8f2798:
	push_s blink
L_8f279a:
	bl L_8c01dc
L_8f279e:
	mov_s r15,r0
L_8f27a0:
	mov_s r14,r1
L_8f27a2:
	mov_s r1,0x10168f0
L_8f27a8:
	bl.d L_8dcba8
L_8f27ac:
	mov_s r0,0x2c
L_8f27ae:
	ld_s r0,[r15,0x4]
L_8f27b0:
	ld_s r2,[r0,0x50]
L_8f27b2:
	mov_s r1,0x0
L_8f27b4:
	cmp_s r2,0x2
L_8f27b6:
	cmp.ne r2,0x3
L_8f27ba:
	mov.eq r1,0x1
L_8f27be:
	extb.f 0x0,r1
L_8f27c2:
	bne_s L_8f27f0
L_8f27c4:
	ld_s r2,[r15,0x8]
L_8f27c6:
	ld_s r3,[r2,0x6c]
L_8f27c8:
	mov_s r1,0x0
L_8f27ca:
	cmp_s r3,0x0
L_8f27cc:
	cmp.ne r3,0x3
L_8f27d0:
	bne_s L_8f27ea
L_8f27d2:
	ldb r1,[r2,0x216]
L_8f27da:
	brne r1,0x1,L_8f27e4
L_8f27de:
	ld_s r1,[r2,0x78]
L_8f27e0:
	breq r1,0x1,L_8f27e8
	.global L_8f27e4
L_8f27e4:
	mov_s r1,0x0
L_8f27e6:
	b_s L_8f27ea
	.global L_8f27e8
L_8f27e8:
	mov_s r1,0x1
	.global L_8f27ea
L_8f27ea:
	extb.f 0x0,r1
L_8f27ee:
	beq_s L_8f2910
	.global L_8f27f0
L_8f27f0:
	ld_s r1,[r14,0x8]
L_8f27f2:
	bl.d L_8cc024
L_8f27f6:
	add_s r1,r1,0xa
L_8f27f8:
	mov.f r13,r0
L_8f27fc:
	beq_s L_8f28f0
L_8f27fe:
	mov_s r0,0x803c00
L_8f2804:
	ld_s r0,[r0,0x20]
L_8f2806:
	bbit0 r0,0xa,L_8f282e
L_8f280a:
	ldb r0,[r13,0x124]
L_8f2812:
	cmp_s r0,0x5
L_8f2814:
	cmp.ne r0,0x7
L_8f2818:
	bne_s L_8f282e
L_8f281a:
	mov_s r1,0x1016910
L_8f2820:
	bl.d L_8dcba8
L_8f2824:
	mov_s r0,0x1c
L_8f2826:
	bl.d L_8c91b8
L_8f282a:
	mov_s r0,0x0
L_8f282c:
	b_s L_8f2902
	.global L_8f282e
L_8f282e:
	mov_s r0,r13
L_8f2830:
	mov_s r1,r14
L_8f2832:
	bl.d L_8e72a4
L_8f2836:
	ld_s r2,[r15,0x4]
L_8f2838:
	mov_s r0,r13
L_8f283a:
	mov_s r1,r14
L_8f283c:
	bl.d L_8e7234
L_8f2840:
	ld_s r2,[r15,0x4]
L_8f2842:
	ld_s r2,[r14,0xc]
L_8f2844:
	ld r16,[r2, 0x74]
L_8f2848:
	breq r16,0x0,L_8f2882
L_8f284c:
	ldb r4,[r16, 0x1]
L_8f2850:
	mov_s r1,0x1016964
L_8f2856:
	ldb r2,[r2, 0x71]
L_8f285a:
	mov_s r0,0x2a
L_8f285c:
	bl.d L_8dcd00
L_8f2860:
	mov_s r3,r4
L_8f2862:
	ld_s r2,[r14,0xc]
L_8f2864:
	mov_s r0,r13
L_8f2866:
	add r0,r0,0x18f
L_8f286a:
	mov_s r1,r16
L_8f286c:
	bl.d L_8c0380
L_8f2870:
	ldb r2,[r2, 0x71]
L_8f2874:
	bl.d L_8e6e1c
L_8f2878:
	mov_s r0,r13
L_8f287a:
	mov_s r0,r16
L_8f287c:
	bl.d L_8c9790
L_8f2880:
	mov_s r1,0x11
	.global L_8f2882
L_8f2882:
	mov_s r0,r15
L_8f2884:
	bl.d L_8f2a90
L_8f2888:
	mov_s r1,r14
L_8f288a:
	breq r0,0x0,L_8f2902
L_8f288e:
	bl L_8c3414
L_8f2892:
	bl.d L_8e9524
L_8f2896:
	mov_s r16,r0
L_8f2898:
	mov_s r2,r0
L_8f289a:
	mov_s r1,0x101699c
L_8f28a0:
	bl.d L_8dcc10
L_8f28a4:
	mov_s r0,0x2c
L_8f28a6:
	ld_s r1,[r15,0x8]
L_8f28a8:
	ld_s r2,[r1,0x6c]
L_8f28aa:
	mov_s r0,0x0
L_8f28ac:
	cmp_s r2,0x0
L_8f28ae:
	cmp.ne r2,0x3
L_8f28b2:
	bne_s L_8f28cc
L_8f28b4:
	ldb r0,[r1,0x216]
L_8f28bc:
	brne r0,0x1,L_8f28c6
L_8f28c0:
	ld_s r0,[r1,0x78]
L_8f28c2:
	breq r0,0x1,L_8f28ca
	.global L_8f28c6
L_8f28c6:
	mov_s r0,0x0
L_8f28c8:
	b_s L_8f28cc
	.global L_8f28ca
L_8f28ca:
	mov_s r0,0x1
	.global L_8f28cc
L_8f28cc:
	extb.f 0x0,r0
L_8f28d0:
	ld_s r1,[r15,0x4]
L_8f28d2:
	mov r4,0x37cac
L_8f28da:
	mov_s r0,r16
L_8f28dc:
	mov_s r2,r13
L_8f28de:
	beq_s L_8f28e8
L_8f28e0:
	bl.d L_8f8c8c
L_8f28e4:
	mov_s r3,0x1
L_8f28e6:
	b_s L_8f2902
	.global L_8f28e8
L_8f28e8:
	bl.d L_8f8c8c
L_8f28ec:
	mov_s r3,0x0
L_8f28ee:
	b_s L_8f2902
	.global L_8f28f0
L_8f28f0:
	bl L_8e9524
L_8f28f4:
	mov_s r1,0x10169d8
L_8f28fa:
	mov_s r2,r0
L_8f28fc:
	bl.d L_8dcc10
L_8f2900:
	mov_s r0,0x2c
	.global L_8f2902
L_8f2902:
	mov_s r1,0x843158
L_8f2908:
	ld_s r0,[r1,0x14]
L_8f290a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f290c:
	st_s r0,[r1,0x14]
L_8f290e:
	b_s L_8f2944
	.global L_8f2910
L_8f2910:
	add_s r15,r15,0xc
L_8f2912:
	ld_s r0,[r15,0x40]
L_8f2914:
	breq_s r0,0,L_8f292c
L_8f2916:
	mov_s r1,0x1016a30
L_8f291c:
	bl.d L_8dcba8
L_8f2920:
	mov_s r0,0x2c
L_8f2922:
	mov_s r0,r15
L_8f2924:
	bl.d L_8e11b4
L_8f2928:
	mov_s r1,r14
L_8f292a:
	b_s L_8f2944
	.global L_8f292c
L_8f292c:
	ld_s r2,[r14,0x8]
L_8f292e:
	mov_s r1,0x1016a68
L_8f2934:
	ldw_s r0,[r2,0xc]
L_8f2936:
	ldw_s r3,[r2,0xa]
L_8f2938:
	asl_s r0,r0,0x10
L_8f293a:
	or_s r3,r3,r0
L_8f293c:
	mov_s r0,0x2c
L_8f293e:
	bl.d L_8dcc80
L_8f2942:
	ldw_s r2,[r2,0xe]
	.global L_8f2944
L_8f2944:
	b.d L_8c0244
L_8f2948:
	mov_s r0,0x1
L_8f294a:
	nop_s
