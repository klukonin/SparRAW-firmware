/* add_bcon @ 0x8c2778, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   allocate_post_send_info: pool is empty; %d times; use static memory
 *   add_bcon: send_dband_bcon() failure
 * Зовут его: ba_sm__lookup_stream, fixed_sched__start, mid__update_aw_ie, pcp_restart, pcp_start, schedule_scheme_builder__build_allocations, schedule_scheme_builder__build_allocations_8c68a0
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__send_dband_bcon, __ld_r18_to_r13_ret, __st_r18_to_r13, bcon__bits_set16_s7_w3, bcon_tx_build_step, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, mem_pool__allocate, mem_pool__init, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global add_bcon
add_bcon:
	.global L_8c2778
L_8c2778:
	push_s blink
L_8c277a:
	bl L_8c01d4
L_8c277e:
	mov_s r14,r0
L_8c2780:
	add3 r13,r0,0x9
L_8c2784:
	mov_s r0,0x0
L_8c2786:
	mov_s r17,r0
L_8c2788:
	bl.d L_8c3414
L_8c278c:
	push_s r0
L_8c278e:
	mov.f r16,r0
L_8c2792:
	beq_s L_8c2860
	.global L_8c2794
L_8c2794:
	mov_s r0,r13
L_8c2796:
	bl.d L_8c4c20
L_8c279a:
	mov_s r1,0x0
L_8c279c:
	mov_s r1,sp
L_8c279e:
	mov_s r0,r16
L_8c27a0:
	mov_s r2,r14
L_8c27a2:
	bl.d L_8e9ccc
L_8c27a6:
	mov_s r3,0x0
L_8c27a8:
	mov_s r14,0x8004ec
L_8c27ae:
	ld_s r0,[r14]
L_8c27b0:
	mov_s r15,0x805a98
L_8c27b6:
	brne_s r0,0,L_8c27cc
L_8c27b8:
	mov_s r0,0x1
L_8c27ba:
	st_s r0,[r14]
L_8c27bc:
	mov_s r1,0x8059f8
L_8c27c2:
	mov_s r0,r15
L_8c27c4:
	mov_s r2,0x14
L_8c27c6:
	bl.d L_8c7cf8
L_8c27ca:
	mov_s r3,0x8
	.global L_8c27cc
L_8c27cc:
	bl.d L_8c354c
L_8c27d0:
	mov_s r0,r15
L_8c27d2:
	mov.f r18,r0
L_8c27d6:
	bne_s L_8c27f0
L_8c27d8:
	mov_s r1,0x1017104
L_8c27de:
	mov_s r0,0x1c
L_8c27e0:
	bl.d L_8dcc10
L_8c27e4:
	ld_s r2,[r14,0x4]
L_8c27e6:
	ld_s r0,[r14,0x4]
L_8c27e8:
	add r18,r15,0x14
L_8c27ec:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c27ee:
	st_s r0,[r14,0x4]
	.global L_8c27f0
L_8c27f0:
	mov_s r2,r13
L_8c27f2:
	ldb r1,[r13, 0x55]
L_8c27f6:
	add r2,r2,0x107
L_8c27fa:
	bmsk_s r1,r1,0x2
L_8c27fc:
	mov_s r0,r2
L_8c27fe:
	bl L_8ed1f0
L_8c2802:
	ldb_s r0,[r2]
L_8c2804:
	mov_s r1,r2
L_8c2806:
	bclr_s r0,r0,0x1
L_8c2808:
	stb_s r0,[r2]
L_8c280a:
	add r0,r18,0x4
L_8c280e:
	bl.d L_8c0380
L_8c2812:
	mov_s r2,0x6
L_8c2814:
	st r17,[r18, 0x10]
L_8c2818:
	ld_s r0,[r13,0x4]
L_8c281a:
	mov_s r2,L_8f6fec-0x8c0000
L_8c2820:
	cmp_s r0,0x2
L_8c2822:
	mov_s r0,0x1
L_8c2824:
	sub_s.ne r0,r0,r0
L_8c2826:
	asl_s r0,r0
L_8c2828:
	st r0,[r18]
L_8c282c:
	mov_s r0,0x1
L_8c282e:
	st r0,[r18, 0xc]
L_8c2832:
	mov_s r3,0x470c
L_8c2838:
	mov_s r0,r16
L_8c283a:
	ldw r1,[sp]
L_8c283e:
	mov r4,r18
L_8c2842:
	bl.d L_8e5284
L_8c2846:
	mov r5,0x0
L_8c284a:
	brne_s r0,0,L_8c2858
L_8c284c:
	mov_s r1,0x101717c
L_8c2852:
	bl.d L_8dcba8
L_8c2856:
	mov_s r0,0x1c
	.global L_8c2858
L_8c2858:
	mov_s r0,0x0
L_8c285a:
	b.d L_8c0234
L_8c285e:
	add_s sp,sp,0x4
	.global L_8c2860
L_8c2860:
	mov_s r0,blink
L_8c2862:
	mov_s r1,0x124f
L_8c2868:
	bl L_8c9b28
L_8c286c:
	b_s L_8c2794
L_8c286e:
	nop_s
