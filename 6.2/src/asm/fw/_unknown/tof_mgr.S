/* tof_mgr @ 0x8c382c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tof_mgr::aoa_req_done()
 *   tof_mgr::ftm_req_done() ftm_obj not in active list
 *   lmac_if_rxss_ctrl to FALSE
 *   get_connection_by_dst_addr returned NULL
 * Зовут его: lmac_if_aoa_meas_evt_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, basic_sm__handle_event, discovery__rx_stop, free_ftm_session, ftm__session_step, fw_log_emit0, lmac_if_send_cmd_0x0f, mid_list__by_mid_fw, mid_list__find_by, radio_mgr__call_method_10, tof__next_request
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr
tof_mgr:
	.global L_8c382c
L_8c382c:
	push_s blink
L_8c382e:
	bl L_8c01dc
L_8c3832:
	mov_s r13,r0
L_8c3834:
	mov_s r16,r1
L_8c3836:
	mov_s r1,0x1019900
L_8c383c:
	bl.d L_8dcba8
L_8c3840:
	mov_s r0,0x20
L_8c3842:
	add r15,r13,0xc
L_8c3846:
	mov_s r0,r13
L_8c3848:
	mov_s r1,r15
L_8c384a:
	bl.d L_8e4bc8
L_8c384e:
	mov_s r2,r16
L_8c3850:
	mov.f r14,r0
L_8c3854:
	bne_s L_8c3864
L_8c3856:
	mov_s r1,0x10198cc
L_8c385c:
	bl.d L_8dcba8
L_8c3860:
	mov_s r0,0xb
L_8c3862:
	b_s L_8c38e4
	.global L_8c3864
L_8c3864:
	mov_s r0,r15
L_8c3866:
	bl.d L_8e2884
L_8c386a:
	mov_s r1,r14
L_8c386c:
	bl.d L_8e0b58
L_8c3870:
	mov_s r0,r13
L_8c3872:
	mov_s r15,0x0
L_8c3874:
	brne_s r0,0,L_8c3890
L_8c3876:
	mov_s r0,r13
L_8c3878:
	bl.d L_8cb380
L_8c387c:
	ldb_s r1,[r14,0x1c]
L_8c387e:
	mov_s r0,0x806518
L_8c3884:
	mov_s r1,0x7
L_8c3886:
	mov_s r2,r15
L_8c3888:
	mov_s r3,r15
L_8c388a:
	bl.d L_8d9b6c
L_8c388e:
	mov_s r4,r15
	.global L_8c3890
L_8c3890:
	mov_s r0,r13
L_8c3892:
	bl.d L_8cb05c
L_8c3896:
	mov_s r1,r14
L_8c3898:
	bl.d L_8cc3dc
L_8c389c:
	mov_s r0,0x0
L_8c389e:
	ld_s r1,[r0,0x4c]
L_8c38a0:
	cmp_s r1,0x2
L_8c38a2:
	mov_s r1,0x1
L_8c38a4:
	sub_s.ne r1,r1,r1
L_8c38a6:
	extb.f 0x0,r1
L_8c38aa:
	bne_s L_8c38e4
L_8c38ac:
	bl.d L_8cc024
L_8c38b0:
	mov_s r1,r16
L_8c38b2:
	breq_s r0,0,L_8c38c6
L_8c38b4:
	ldb_s r0,[r0,0x8]
L_8c38b6:
	bl.d L_8dbd74
L_8c38ba:
	mov_s r1,0x0
L_8c38bc:
	mov_s r1,0x1019918
L_8c38c2:
	mov_s r0,0x2b
L_8c38c4:
	b_s L_8c38ce
	.global L_8c38c6
L_8c38c6:
	mov_s r1,0x1019934
L_8c38cc:
	mov_s r0,0xb
	.global L_8c38ce
L_8c38ce:
	bl L_8dcba8
L_8c38d2:
	mov_s r13,0x806518
L_8c38d8:
	bl.d L_8ea800
L_8c38dc:
	ld_s r0,[r13,0x8]
L_8c38de:
	bl L_8f80ec
L_8c38e2:
	st_s r15,[r13,0x8]
	.global L_8c38e4
L_8c38e4:
	b L_8c0244
