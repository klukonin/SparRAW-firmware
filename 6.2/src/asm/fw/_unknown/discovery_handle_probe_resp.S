/* discovery_handle_probe_resp @ 0x8f294c, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery_handle_probe_resp()
 *   [NNL] length %d send pkt to host (channel ID = %d) <ts: %d>
 *   [NNL] rssi_raw_value %d (0x%X), snr %d
 *   discovery_handle_probe_resp() Probe resp contain Wilocity Vendor Specific [[ PBC mode = %d ]]
 *   Save Probe response DMG Capabilities len %d 0x%x 0x%x
 * Зовут его: discovery__rx_pkt_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, conn__set_rf_params_from_caps, discovery__init_probe_entry, fw_log_emit0, fw_log_emit1, fw_log_emit3, hexdump_words, hwd_phy__get_883b80, memcpy_fw, mid_list__find_by, parse_wilocity_vs__get_flag3
 * Глобалы (через gp): 0x800428
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery_handle_probe_resp
discovery_handle_probe_resp:
	.global L_8f294c
L_8f294c:
	push_s blink
L_8f294e:
	bl L_8c01d4
L_8f2952:
	mov_s r15,r0
L_8f2954:
	mov_s r14,r1
L_8f2956:
	mov_s r1,0x1016ac0
L_8f295c:
	bl.d L_8dcba8
L_8f2960:
	mov_s r0,0x2c
L_8f2962:
	ld_s r1,[r14,0x8]
L_8f2964:
	mov r18,0x0
L_8f2968:
	add_s r1,r1,0xa
L_8f296a:
	bl.d L_8cc024
L_8f296e:
	ld_s r0,[r15,0x4]
L_8f2970:
	mov.f r16,r0
L_8f2974:
	mov.eq r13,r18
L_8f2978:
	beq_s L_8f2a8a
L_8f297a:
	bl.d L_8e9524
L_8f297e:
	add r13,r14,0x20
L_8f2982:
	mov_s r4,r0
L_8f2984:
	ld_s r2,[r14,0x30]
L_8f2986:
	mov_s r1,0x1016ae0
L_8f298c:
	mov_s r0,0x2c
L_8f298e:
	bl.d L_8dcd00
L_8f2992:
	ldb_s r3,[r13,0x17]
L_8f2994:
	bl.d L_8d2cf4
L_8f2998:
	add3 r17,r16,0x30
L_8f299c:
	st.as r0,[gp,0xa9]
L_8f29a0:
	mov_s r0,0x5
L_8f29a2:
	stw_s r0,[r14,0x2c]
L_8f29a4:
	stb r18,[r13, 0xa]
L_8f29a8:
	ld_s r0,[gp,0x2a4]
L_8f29aa:
	mov_s r1,0x1016b1c
L_8f29b0:
	/* asr_s r0,r0,0x4 */
	.byte 0x44,0xb8
L_8f29b2:
	sub3 r4,r0,0x9
L_8f29b6:
	sexb r4,r4
L_8f29ba:
	stb r4,[r13, 0x9]
L_8f29be:
	ldb r0,[r17, 0xd]
L_8f29c2:
	stb_s r0,[r13,0xb]
L_8f29c4:
	ld.as r2,[gp,0xa9]
L_8f29c8:
	mov_s r0,0x2c
L_8f29ca:
	bl.d L_8dcd00
L_8f29ce:
	mov_s r3,r2
L_8f29d0:
	ld_s r0,[r15,0x8]
L_8f29d2:
	ld_s r1,[r0,0x78]
L_8f29d4:
	breq r1,0x0,L_8f2a6c
L_8f29d8:
	ld_s r2,[r14,0x8]
L_8f29da:
	ld_s r3,[r14,0xc]
L_8f29dc:
	add_s r1,r2,0x4
L_8f29de:
	ld r3,[r3, 0xbc]
L_8f29e2:
	add_s r2,r2,0x10
L_8f29e4:
	ldw r4,[r3]
L_8f29e8:
	ldb.x r5,[r13, 0x9]
L_8f29ec:
	bl.d L_8f7ae4
L_8f29f0:
	ldb_s r3,[r13,0x17]
L_8f29f2:
	mov.f r13,r0
L_8f29f6:
	ld_s r1,[r14,0xc]
L_8f29f8:
	beq_s L_8f2a78
L_8f29fa:
	ld r0,[r1, 0xa4]
L_8f29fe:
	breq r0,0x0,L_8f2a78
L_8f2a02:
	add r1,r1,0xa0
L_8f2a06:
	ld_s r0,[r15,0x4]
L_8f2a08:
	bl.d L_8df8ec
L_8f2a0c:
	add_s r0,r0,0x48
L_8f2a0e:
	mov_s r2,r0
L_8f2a10:
	mov_s r1,0x1016b44
L_8f2a16:
	bl.d L_8dcc10
L_8f2a1a:
	mov_s r0,0x2c
L_8f2a1c:
	mov_s r0,r16
L_8f2a1e:
	mov_s r1,r14
L_8f2a20:
	bl.d L_8e72a4
L_8f2a24:
	ld_s r2,[r15,0x4]
L_8f2a26:
	mov_s r0,r16
L_8f2a28:
	mov_s r1,r14
L_8f2a2a:
	bl.d L_8e7234
L_8f2a2e:
	ld_s r2,[r15,0x4]
L_8f2a30:
	ld_s r2,[r14,0xc]
L_8f2a32:
	ld_s r15,[r2,0x74]
L_8f2a34:
	breq_s r15,0,L_8f2a78
L_8f2a36:
	ldb r4,[r15, 0x1]
L_8f2a3a:
	mov_s r1,0x1016ba4
L_8f2a40:
	ldb r2,[r2, 0x71]
L_8f2a44:
	mov_s r0,0x2a
L_8f2a46:
	bl.d L_8dcd00
L_8f2a4a:
	mov_s r3,r4
L_8f2a4c:
	ld_s r2,[r14,0xc]
L_8f2a4e:
	add r0,r17,0xf
L_8f2a52:
	mov_s r1,r15
L_8f2a54:
	bl.d L_8c0380
L_8f2a58:
	ldb r2,[r2, 0x71]
L_8f2a5c:
	bl.d L_8e6e1c
L_8f2a60:
	mov_s r0,r16
L_8f2a62:
	mov_s r0,r15
L_8f2a64:
	bl.d L_8c9790
L_8f2a68:
	mov_s r1,0x11
L_8f2a6a:
	b_s L_8f2a78
	.global L_8f2a6c
L_8f2a6c:
	ld_s r0,[r15,0x4c]
L_8f2a6e:
	cmp_s r0,0x0
L_8f2a70:
	mov.eq r13,r18
L_8f2a74:
	mov.ne r13,0x1
	.global L_8f2a78
L_8f2a78:
	ld_s r0,[r14,0xc]
L_8f2a7a:
	ld_s r0,[r0,0x1c]
L_8f2a7c:
	breq_s r0,0,L_8f2a8a
L_8f2a7e:
	ldb_s r1,[r0]
L_8f2a80:
	ldb_s r0,[r0,0x1]
L_8f2a82:
	asl_s r1,r1,0x8
L_8f2a84:
	bl.d L_8e63e0
L_8f2a88:
	or_s r0,r0,r1
	.global L_8f2a8a
L_8f2a8a:
	b.d L_8c0234
L_8f2a8e:
	mov_s r0,r13
