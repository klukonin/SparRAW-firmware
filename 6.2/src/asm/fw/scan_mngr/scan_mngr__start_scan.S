/* scan_mngr__start_scan @ 0x8f9780, 416 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::start_scan() - scan_type: %d, discovery_mode: %d
 *   [NNL] postopne_scan: %d, is_connected: %d
 *   scan_mngr::start_scan() Not supported scan type: %d, Discovery mode: %d
 *   scan_mngr::start_scan() send command to uCode scan_mode = TRUE. m_ucode_scan_type = %d
 *   scan_mngr::start_scan() postpone_scan %d
 *   scan_mngr::start_scan() postpone scan on MID#%d.
 * Зовут его: find_sm__start_search, scan_mngr__dwelling_done
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, discovery__tsf_wa, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, list__find_entry_d, lmac_if_discovery_mode_cfg_handler, mac_read_tsf64, mem_pool__allocate, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__start_scan
scan_mngr__start_scan:
	.global L_8f9780
L_8f9780:
	push_s blink
L_8f9782:
	bl L_8c01cc
L_8f9786:
	mov_s r13,r0
L_8f9788:
	mov_s r14,r1
L_8f978a:
	mov_s r17,r2
L_8f978c:
	mov_s r16,r3
L_8f978e:
	ldb_s r2,[r14,0x10]
L_8f9790:
	mov_s r1,0x10151fc
L_8f9796:
	mov_s r0,0x29
L_8f9798:
	bl.d L_8dcc80
L_8f979c:
	ldb_s r3,[r14,0x6]
L_8f979e:
	mov_s r1,0x1015238
L_8f97a4:
	mov_s r0,0x29
L_8f97a6:
	mov_s r2,r17
L_8f97a8:
	bl.d L_8dcc80
L_8f97ac:
	mov_s r3,r16
L_8f97ae:
	mov_s r0,0x805514
L_8f97b4:
	mov_s r1,0x0
L_8f97b6:
	stw_s r1,[r0]
L_8f97b8:
	stw_s r1,[r0,0x2]
L_8f97ba:
	stw_s r1,[r0,0x4]
L_8f97bc:
	stw_s r1,[r0,0x6]
L_8f97be:
	stw_s r1,[r0,0x8]
L_8f97c0:
	stw_s r1,[r0,0xa]
L_8f97c2:
	stw_s r1,[r0,0xc]
L_8f97c4:
	add3 r18,r13,0x30
L_8f97c8:
	st r1,[r18, 0x48]
L_8f97cc:
	mov_s r15,r13
L_8f97ce:
	add r15,r15,0x200
L_8f97d2:
	st r16,[r15, 0x24]
L_8f97d6:
	ldb_s r1,[r14,0x11]
L_8f97d8:
	add r16,r13,0x20
L_8f97dc:
	stb r1,[r16, 0x4]
L_8f97e0:
	add r0,r13,0x28
L_8f97e4:
	bl.d L_8c1cd8
L_8f97e8:
	mov_s r1,0x3c
L_8f97ea:
	ldb_s r0,[r14,0x6]
L_8f97ec:
	stb_s r0,[r15,0x16]
L_8f97ee:
	ldb_s r0,[r14,0x10]
L_8f97f0:
	st_s r0,[r13,0x6c]
L_8f97f2:
	bl.d L_8f8f44
L_8f97f6:
	mov_s r0,r13
L_8f97f8:
	ldb_s r2,[r14,0x10]
L_8f97fa:
	add2 r20,r18,0x19
L_8f97fe:
	breq_s r2,0,L_8f9826
L_8f9800:
	breq r2,0x2,L_8f9830
L_8f9804:
	ldb_s r3,[r14,0x6]
L_8f9806:
	breq r2,0x3,L_8f9826
L_8f980a:
	mov_s r1,0x1015264
L_8f9810:
	mov_s r0,0x0
L_8f9812:
	bl.d L_8dcd00
L_8f9816:
	mov_s r4,r0
L_8f9818:
	mov_s r0,blink
L_8f981a:
	mov_s r1,0x1442
L_8f9820:
	bl L_8c9b28
L_8f9824:
	b_s L_8f9834
	.global L_8f9826
L_8f9826:
	ldb_s r0,[r14,0x6]
L_8f9828:
	cmp_s r0,0x0
L_8f982a:
	mov.ne r0,0x1
L_8f982e:
	b_s L_8f9832
	.global L_8f9830
L_8f9830:
	mov_s r0,0x2
	.global L_8f9832
L_8f9832:
	stb_s r0,[r15,0x17]
	.global L_8f9834
L_8f9834:
	mov_s r1,r13
L_8f9836:
	add r1,r1,0x21c
L_8f983a:
	mov_s r0,0x0
L_8f983c:
	bl.d L_8e9900
L_8f9840:
	mov_s r2,r0
L_8f9842:
	mov_s r1,0x10152ac
L_8f9848:
	mov_s r0,0x29
L_8f984a:
	bl.d L_8dcc10
L_8f984e:
	ldb_s r2,[r15,0x17]
L_8f9850:
	mov_s r0,0x1
L_8f9852:
	mov_s r19,r0
L_8f9854:
	bl.d L_8db724
L_8f9858:
	ldb_s r1,[r15,0x17]
L_8f985a:
	ld_s r0,[r13,0x6c]
L_8f985c:
	cmp_s r0,0x0
L_8f985e:
	cmp.ne r0,0x3
L_8f9862:
	bne_s L_8f986a
L_8f9864:
	ldb_s r0,[r15,0x16]
L_8f9866:
	breq r0,0x1,L_8f986e
	.global L_8f986a
L_8f986a:
	mov_s r0,0x0
L_8f986c:
	b_s L_8f9876
	.global L_8f986e
L_8f986e:
	ld_s r0,[r13,0x78]
L_8f9870:
	brne r0,0x1,L_8f986a
L_8f9874:
	mov_s r0,0x1
	.global L_8f9876
L_8f9876:
	extb.f 0x0,r0
L_8f987a:
	beq_s L_8f988e
L_8f987c:
	ld_s r3,[r13,0x7c]
L_8f987e:
	mov_s r1,0x1
L_8f9880:
	mov_s r0,r3
L_8f9882:
	add r0,r0,0x234
L_8f9886:
	mov_s r2,0x47
L_8f9888:
	bl.d L_8f9cfc
L_8f988c:
	ldb_s r3,[r3,0x10]
	.global L_8f988e
L_8f988e:
	add2 r0,r13,0x19
L_8f9892:
	mov_s r1,r14
L_8f9894:
	bl.d L_8c0380
L_8f9898:
	mov_s r2,0x6
L_8f989a:
	ldw_s r0,[r14,0xa]
L_8f989c:
	ldw_s r1,[r14,0x8]
L_8f989e:
	asl_s r0,r0,0x10
L_8f98a0:
	or_s r1,r1,r0
L_8f98a2:
	bl.d L_8f1d14
L_8f98a6:
	mov_s r0,r13
L_8f98a8:
	ldb r0,[r16, 0x4]
L_8f98ac:
	brlo.d r0,0x1,L_8f98dc
L_8f98b0:
	mov_s r14,0x0
	.global L_8f98b2
L_8f98b2:
	mov_s r0,0x842c74
L_8f98b8:
	bl L_8c354c
L_8f98bc:
	mov.f r15,r0
L_8f98c0:
	beq_s L_8f98f6
	.global L_8f98c2
L_8f98c2:
	ld.as r0,[r20,r14]
L_8f98c6:
	st_s r0,[r15,0x8]
L_8f98c8:
	add r0,r13,0x18
L_8f98cc:
	bl.d L_8c25f4
L_8f98d0:
	mov_s r1,r15
L_8f98d2:
	ldb r0,[r16, 0x4]
L_8f98d6:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8f98d8:
	brlo r14,r0,L_8f98b2
	.global L_8f98dc
L_8f98dc:
	mov_s r1,0x1015304
L_8f98e2:
	mov_s r0,0x29
L_8f98e4:
	bl.d L_8dcc10
L_8f98e8:
	mov_s r2,r17
L_8f98ea:
	brne r17,0x0,L_8f9904
L_8f98ee:
	bl.d L_8f5d1c
L_8f98f2:
	mov_s r0,r13
L_8f98f4:
	b_s L_8f9918
	.global L_8f98f6
L_8f98f6:
	mov_s r0,blink
L_8f98f8:
	mov_s r1,0x1248
L_8f98fe:
	bl L_8c9b28
L_8f9902:
	b_s L_8f98c2
	.global L_8f9904
L_8f9904:
	ld_s r2,[r13,0x7c]
L_8f9906:
	mov_s r1,0x1015330
L_8f990c:
	mov_s r0,0x29
L_8f990e:
	bl.d L_8dcc10
L_8f9912:
	ldb_s r2,[r2,0x10]
L_8f9914:
	st r19,[r18, 0x4c]
	.global L_8f9918
L_8f9918:
	b.d L_8c0224
L_8f991c:
	st r19,[r13, 0x78]
