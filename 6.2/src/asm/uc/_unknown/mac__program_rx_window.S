/* mac__program_rx_window @ 0x92f798, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, direct_tx__send_from_desc, direct_tx_step, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, tx__cca_check_and_send, tx__send_and_await_rx_frame, tx_bcast_flow, txop__await_cts_ppdu
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_rx_window
mac__program_rx_window:
	.global L_92f798
L_92f798:
	push_s blink
L_92f79a:
	bl L_920230
L_92f79e:
	mov_s r14,r0
L_92f7a0:
	mov_s r13,r1
L_92f7a2:
	mov_s r15,r2
L_92f7a4:
	mov_s r0,0x1f006000
L_92f7aa:
	mov_s r32,r0
L_92f7ac:
	st.ab r0,[r25,0x4]
L_92f7b0:
	bclr r25,r25,0xa
L_92f7b4:
	mov_s r0,0x38000300
L_92f7ba:
	mov_s r32,r0
L_92f7bc:
	st.ab r0,[r25,0x4]
L_92f7c0:
	bclr r25,r25,0xa
L_92f7c4:
	mov_s r0,0x3600003f
L_92f7ca:
	mov_s r32,r0
L_92f7cc:
	st.ab r0,[r25,0x4]
L_92f7d0:
	bclr r25,r25,0xa
L_92f7d4:
	bset_s r14,r14,0x8
L_92f7d6:
	bset_s r14,r14,0x19
L_92f7d8:
	bset_s r14,r14,0x1a
L_92f7da:
	mov_s r32,r14
L_92f7dc:
	st.ab r14,[r25,0x4]
L_92f7e0:
	bclr r25,r25,0xa
L_92f7e4:
	mov_s r0,0x37000005
L_92f7ea:
	mov_s r32,r0
L_92f7ec:
	st.ab r0,[r25,0x4]
L_92f7f0:
	bclr r25,r25,0xa
L_92f7f4:
	mov_s r0,0x37000002
L_92f7fa:
	mov_s r32,r0
L_92f7fc:
	st.ab r0,[r25,0x4]
L_92f800:
	bclr r25,r25,0xa
L_92f804:
	or r13,r13,0x3f000000
L_92f80c:
	mov_s r32,r13
L_92f80e:
	st.ab r13,[r25,0x4]
L_92f812:
	bclr r25,r25,0xa
L_92f816:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_92f818:
	or r15,r15,0x3e000000
L_92f820:
	mov_s r32,r15
L_92f822:
	st.ab r15,[r25,0x4]
L_92f826:
	bclr r25,r25,0xa
L_92f82a:
	mov_s r0,0x37000020
L_92f830:
	mov_s r32,r0
L_92f832:
	st.ab r0,[r25,0x4]
L_92f836:
	bclr r25,r25,0xa
L_92f83a:
	mov_s r1,0x8022c8
L_92f840:
	ld_s r0,[r1,0xc]
L_92f842:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92f844:
	st_s r0,[r1,0xc]
L_92f846:
	ld_s r0,[gp,0x178]
L_92f848:
	mov_s r1,0x802940
L_92f84e:
	bclr_s r0,r0,0x18
L_92f850:
	ld_s r1,[r1]
L_92f852:
	bclr_s r0,r0,0x19
L_92f854:
	asl_s r1,r1,0x18
L_92f856:
	or_s r0,r0,r1
L_92f858:
	st.as r0,[gp,0x5e]
L_92f85c:
	mov_s r1,0x889480
L_92f862:
	st_s r0,[r1,0x8]
L_92f864:
	b L_92029c
