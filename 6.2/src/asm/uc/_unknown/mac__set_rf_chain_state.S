/* mac__set_rf_chain_state @ 0x92f42c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window, brp_init__tx_request, brp_responder_transmission_flow, direct_tx__send_from_desc, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, mac__set_rf_chain_state__with_sta_sector, rx__program_mac_and_wait, rx_resp__finish_restore_rx
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_rf_chain_state
mac__set_rf_chain_state:
	.global L_92f42c
L_92f42c:
	push_s blink
L_92f42e:
	bl L_920234
L_92f432:
	mov_s r14,r0
L_92f434:
	mov_s r13,r1
L_92f436:
	mov_s r0,0x1f003000
L_92f43c:
	mov_s r32,r0
L_92f43e:
	st.ab r0,[r25,0x4]
L_92f442:
	bclr r25,r25,0xa
L_92f446:
	mov_s r0,0x3c000300
L_92f44c:
	mov_s r32,r0
L_92f44e:
	st.ab r0,[r25,0x4]
L_92f452:
	bclr r25,r25,0xa
L_92f456:
	mov_s r0,0x3a00000f
L_92f45c:
	mov_s r32,r0
L_92f45e:
	st.ab r0,[r25,0x4]
L_92f462:
	bclr r25,r25,0xa
L_92f466:
	asl_s r0,r14,0x4
L_92f468:
	bset_s r0,r0,0x9
L_92f46a:
	bset_s r0,r0,0x19
L_92f46c:
	bset_s r0,r0,0x1a
L_92f46e:
	mov_s r32,r0
L_92f470:
	st.ab r0,[r25,0x4]
L_92f474:
	bclr r25,r25,0xa
L_92f478:
	mov_s r0,0x3b000001
L_92f47e:
	mov_s r32,r0
L_92f480:
	st.ab r0,[r25,0x4]
L_92f484:
	bclr r25,r25,0xa
L_92f488:
	mov_s r0,0x3b000006
L_92f48e:
	mov_s r32,r0
L_92f490:
	st.ab r0,[r25,0x4]
L_92f494:
	bclr r25,r25,0xa
L_92f498:
	bset r0,r13,0x1e
L_92f49c:
	mov_s r32,r0
L_92f49e:
	st.ab r0,[r25,0x4]
L_92f4a2:
	bclr r25,r25,0xa
L_92f4a6:
	b.d L_9202a4
L_92f4aa:
	st.as r13,[gp,-0xb]
L_92f4ae:
	nop_s
