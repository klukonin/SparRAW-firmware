/* add_discovery_bcon @ 0x8c2904, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   add_discovery_bcon: MID[%d], scan_type %d, length %d
 *   allocate_post_send_info: pool is empty; %d times; use static memory
 *   add_discovery_bcon: send_dband_bcon() failure
 * Зовут его: find_mng__add_bcon, scan_mngr__sm_ready_for_dwelling
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__send_dband_bcon, __ld_r20_to_r13_ret, __st_r20_to_r13, bcon__bits_set16_s7_w3, bcon__bits_set16_s7_w6, bcon__bits_set8_s5_w3, bits__set8_s4_w2, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global add_discovery_bcon
add_discovery_bcon:
	.global L_8c2904
L_8c2904:
	push_s blink
L_8c2906:
	bl L_8c01cc
L_8c290a:
	mov_s r13,r0
L_8c290c:
	mov_s r15,r1
L_8c290e:
	mov_s r0,0x0
L_8c2910:
	mov_s r19,r0
L_8c2912:
	bl.d L_8c3414
L_8c2916:
	push_s r0
L_8c2918:
	mov.f r17,r0
L_8c291c:
	beq_s L_8c2958
	.global L_8c291e
L_8c291e:
	mov_s r14,r13
L_8c2920:
	add r14,r14,0x14f
L_8c2924:
	ldb_s r0,[r14]
L_8c2926:
	mov_s r1,0x0
L_8c2928:
	bset_s r0,r0,0x1
L_8c292a:
	stb_s r0,[r14]
L_8c292c:
	add_s r0,r14,0x5
L_8c292e:
	bl.d L_8ed298
L_8c2932:
	mov r20,0x1
L_8c2936:
	mov_s r0,r14
L_8c2938:
	mov_s r1,0x1
L_8c293a:
	bl.d L_8ed1f0
L_8c293e:
	cmp_s r15,0x3
L_8c2940:
	add_s r0,r14,0x3
L_8c2942:
	bl L_8ed2b0
L_8c2946:
	add_s r0,r14,0x1
L_8c2948:
	mov_s r1,0x0
L_8c294a:
	bl L_8ed208
L_8c294e:
	beq_s L_8c2966
L_8c2950:
	mov r18,0x2
L_8c2954:
	mov_s r16,r1
L_8c2956:
	b_s L_8c2980
	.global L_8c2958
L_8c2958:
	mov_s r0,blink
L_8c295a:
	mov_s r1,0x1537
L_8c2960:
	bl L_8c9b28
L_8c2964:
	b_s L_8c291e
	.global L_8c2966
L_8c2966:
	ldb_s r0,[r14]
L_8c2968:
	mov_s r2,0x3
L_8c296a:
	bset_s r0,r0,0x0
L_8c296c:
	stb_s r0,[r14]
L_8c296e:
	mov_s r0,r14
L_8c2970:
	mov_s r1,r2
L_8c2972:
	bl.d L_8ed1f0
L_8c2976:
	mov_s r18,r2
L_8c2978:
	ld.as r0,[r13,0x8f]
L_8c297c:
	add2 r16,r0,0x19
	.global L_8c2980
L_8c2980:
	mov_s r1,sp
L_8c2982:
	mov_s r0,r17
L_8c2984:
	mov_s r2,r13
L_8c2986:
	bl.d L_8e9ccc
L_8c298a:
	mov_s r3,0x0
L_8c298c:
	ld r4,[sp]
L_8c2990:
	mov_s r1,0x10171a0
L_8c2996:
	ldb_s r2,[r13,0x10]
L_8c2998:
	mov_s r0,0x2c
L_8c299a:
	bl.d L_8dcd00
L_8c299e:
	mov_s r3,r15
L_8c29a0:
	mov_s r13,0x8004ec
L_8c29a6:
	ld_s r0,[r13]
L_8c29a8:
	mov_s r15,0x805a98
L_8c29ae:
	brne_s r0,0,L_8c29c4
L_8c29b0:
	st r20,[r13]
L_8c29b4:
	mov_s r1,0x8059f8
L_8c29ba:
	mov_s r0,r15
L_8c29bc:
	mov_s r2,0x14
L_8c29be:
	bl.d L_8c7cf8
L_8c29c2:
	mov_s r3,0x8
	.global L_8c29c4
L_8c29c4:
	bl.d L_8c354c
L_8c29c8:
	mov_s r0,r15
L_8c29ca:
	mov.f r20,r0
L_8c29ce:
	bne_s L_8c29e8
L_8c29d0:
	mov_s r1,0x1017104
L_8c29d6:
	mov_s r0,0x1c
L_8c29d8:
	bl.d L_8dcc10
L_8c29dc:
	ld_s r2,[r13,0x4]
L_8c29de:
	ld_s r0,[r13,0x4]
L_8c29e0:
	add r20,r15,0x14
L_8c29e4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c29e6:
	st_s r0,[r13,0x4]
	.global L_8c29e8
L_8c29e8:
	add r0,r20,0x4
L_8c29ec:
	mov_s r1,r14
L_8c29ee:
	bl.d L_8c0380
L_8c29f2:
	mov_s r2,0x6
L_8c29f4:
	st r16,[r20, 0x10]
L_8c29f8:
	st r19,[r20]
L_8c29fc:
	st r18,[r20, 0xc]
L_8c2a00:
	mov_s r3,0x470c
L_8c2a06:
	mov_s r0,r17
L_8c2a08:
	ldw r1,[sp]
L_8c2a0c:
	mov_s r2,0x0
L_8c2a0e:
	mov r4,r20
L_8c2a12:
	bl.d L_8e5284
L_8c2a16:
	mov r5,0x1
L_8c2a1a:
	brne_s r0,0,L_8c2a28
L_8c2a1c:
	mov_s r1,0x10171d8
L_8c2a22:
	bl.d L_8dcba8
L_8c2a26:
	mov_s r0,0x1c
	.global L_8c2a28
L_8c2a28:
	b.d L_8c0224
L_8c2a2c:
	add_s sp,sp,0x4
L_8c2a2e:
	nop_s
