/* find_main_sm__probe_req_in_search @ 0x8f78c0, 548 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm:: probe_req handle: ADDR-%04X%08X
 *   find_main_sm::probe_req_in_search() Received Probe Request contains WFA IE (P2P IE).
 *   find_main_sm::probe_req_in_search() Probe REQ with DEVICE ID attribute ADDR-%04X%08X
 *   find_main_sm::probe_req_in_search() DEVICE ID attribute is unequal to my device address
 *   find_main_sm::probe_req_in_search() Received Probe Request contains WSC IE.
 *   FIND_SM:: DO NOT reply to this Probe REQ (Host may do that !).
 *   probe_req_tx_wb_cb() status %d
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__free_memory, __ld_r15_to_r13_ret, __ld_r23_to_r13_ret, __st_r15_to_r13, __st_r23_to_r13, app_ie__walk_list, app_ies__set_buffer, app_ies__set_probe_req_ies, fw_log_emit0, fw_log_emit1, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__probe_req_in_search
find_main_sm__probe_req_in_search:
	.global L_8f78c0
L_8f78c0:
	push_s blink
L_8f78c2:
	bl L_8c01c0
L_8f78c6:
	mov_s r20,r0
L_8f78c8:
	mov_s r16,r1
L_8f78ca:
	ld_s r0,[r1,0xc]
L_8f78cc:
	mov r21,0x1
L_8f78d0:
	ld r0,[r0, 0xd0]
L_8f78d4:
	ld_s r1,[r1,0x8]
L_8f78d6:
	sub_s sp,sp,0x2c
L_8f78d8:
	ld r13,[r16, 0x30]
L_8f78dc:
	sub_s r0,r0,r1
L_8f78de:
	sub_s r13,r13,r0
L_8f78e0:
	ld r0,[r20, 0x10]
L_8f78e4:
	ld_s r0,[r0,0x48]
L_8f78e6:
	bl.d L_8cbfc8
L_8f78ea:
	ldb r1,[r16, 0x36]
L_8f78ee:
	mov.f r17,r0
L_8f78f2:
	extw_s r13,r13
L_8f78f4:
	beq_s L_8f793a
	.global L_8f78f6
L_8f78f6:
	cmp r17,0x0
L_8f78fa:
	beq_s L_8f7aa0
L_8f78fc:
	add r19,r17,0x1c
L_8f7900:
	ldw r2,[r19, 0x4]
L_8f7904:
	mov_s r1,0x1017ce0
L_8f790a:
	mov_s r0,0x2c
L_8f790c:
	bl.d L_8dcc80
L_8f7910:
	ld r3,[r19]
L_8f7914:
	mov_s r14,sp
L_8f7916:
	ld r1,[r16, 0xc]
L_8f791a:
	mov_s r0,r14
L_8f791c:
	ld r1,[r1, 0xd0]
L_8f7920:
	mov_s r2,r13
L_8f7922:
	mov_s r3,0x0
L_8f7924:
	bl.d L_8e693c
L_8f7928:
	mov_s r23,r3
L_8f792a:
	add_s r0,sp,0xc
L_8f792c:
	mov_s r18,r0
L_8f792e:
	bl.d L_8e5de8
L_8f7932:
	mov_s r1,r14
L_8f7934:
	mov r22,0x1
L_8f7938:
	b_s L_8f7a08
	.global L_8f793a
L_8f793a:
	mov_s r0,blink
L_8f793c:
	mov_s r1,0x1447
L_8f7942:
	bl L_8c9b28
L_8f7946:
	b_s L_8f78f6
	.global L_8f7948
L_8f7948:
	add_s r14,r13,0x2
L_8f794a:
	ldb_s r0,[r14]
L_8f794c:
	cmp_s r0,0x50
L_8f794e:
	bne_s L_8f7a04
L_8f7950:
	ldb_s r0,[r14,0x1]
L_8f7952:
	cmp_s r0,0x6f
L_8f7954:
	bne_s L_8f7a04
L_8f7956:
	ldb_s r0,[r14,0x2]
L_8f7958:
	cmp r0,0x9a
L_8f795c:
	bne_s L_8f7a04
L_8f795e:
	ldb_s r0,[r14,0x3]
L_8f7960:
	brne r0,0x9,L_8f7a04
L_8f7964:
	mov_s r1,0x1017d10
L_8f796a:
	bl.d L_8dcba8
L_8f796e:
	mov_s r0,0x2c
L_8f7970:
	ld r0,[r20, 0x10]
L_8f7974:
	ld_s r0,[r0,0xc]
L_8f7976:
	mov r22,0x0
L_8f797a:
	breq r0,0x0,L_8f7a04
L_8f797e:
	ldb_s r2,[r13,0x1]
L_8f7980:
	add_s r15,sp,0x18
L_8f7982:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8f7984:
	extw_s r2,r2
L_8f7986:
	mov_s r0,r15
L_8f7988:
	bl.d L_8e6908
L_8f798c:
	mov_s r1,r13
L_8f798e:
	mov_s r0,r15
L_8f7990:
	bl.d L_8cb8ec
L_8f7994:
	mov_s r1,0x3
L_8f7996:
	breq_s r0,0,L_8f7a04
L_8f7998:
	add_s r13,r0,0x3
L_8f799a:
	ld r0,[r20, 0x10]
L_8f799e:
	mov_s r1,0x1017d68
L_8f79a4:
	ld_s r15,[r0,0x48]
L_8f79a6:
	mov_s r0,0x29
L_8f79a8:
	ldw_s r2,[r13,0x4]
L_8f79aa:
	bl.d L_8dcc80
L_8f79ae:
	ld_s r3,[r13]
L_8f79b0:
	ldb_s r1,[r13]
L_8f79b2:
	ldb.a r0,[r15,0xa]
L_8f79b6:
	brne r1,r0,L_8f79da
L_8f79ba:
	ldb_s r1,[r13,0x1]
L_8f79bc:
	ldb_s r0,[r15,0x1]
L_8f79be:
	brne r1,r0,L_8f79da
L_8f79c2:
	ldb_s r1,[r13,0x2]
L_8f79c4:
	ldb_s r0,[r15,0x2]
L_8f79c6:
	brne r1,r0,L_8f79da
L_8f79ca:
	ldb_s r1,[r13,0x3]
L_8f79cc:
	ldb_s r0,[r15,0x3]
L_8f79ce:
	brne r1,r0,L_8f79da
L_8f79d2:
	ldb_s r1,[r13,0x4]
L_8f79d4:
	ldb_s r0,[r15,0x4]
L_8f79d6:
	breq r1,r0,L_8f79de
	.global L_8f79da
L_8f79da:
	mov_s r0,r22
L_8f79dc:
	b_s L_8f79e8
	.global L_8f79de
L_8f79de:
	ldb_s r1,[r13,0x5]
L_8f79e0:
	ldb_s r0,[r15,0x5]
L_8f79e2:
	brne r1,r0,L_8f79da
L_8f79e6:
	mov_s r0,0x1
	.global L_8f79e8
L_8f79e8:
	extb.f 0x0,r0
L_8f79ec:
	sub.ne r22,r22,r22
L_8f79f0:
	bne_s L_8f7a04
L_8f79f2:
	mov_s r1,0x1017dc0
L_8f79f8:
	bl.d L_8dcba8
L_8f79fc:
	mov_s r0,0x2c
L_8f79fe:
	mov_s r0,0x0
L_8f7a00:
	mov_s r22,r0
L_8f7a02:
	mov_s r21,r0
	.global L_8f7a04
L_8f7a04:
	ldb_s r0,[r14]
L_8f7a06:
	breq_s r0,0,L_8f7a72
	.global L_8f7a08
L_8f7a08:
	bl.d L_8df404
L_8f7a0c:
	mov_s r0,r18
L_8f7a0e:
	mov.f r13,r0
L_8f7a12:
	bne_s L_8f7948
L_8f7a14:
	breq r21,0x0,L_8f7a94
L_8f7a18:
	bl L_8c3414
L_8f7a1c:
	mov_s r13,r0
L_8f7a1e:
	st r23,[sp, 0x18]
L_8f7a22:
	ld r2,[r20, 0x10]
L_8f7a26:
	add_s r1,sp,0x18
L_8f7a28:
	ld_s r2,[r2,0x48]
L_8f7a2a:
	mov_s r3,r17
L_8f7a2c:
	bl.d L_8e9f74
L_8f7a30:
	mov r4,r22
L_8f7a34:
	add_s r0,r13,0x4
L_8f7a36:
	mov_s r1,r19
L_8f7a38:
	bl.d L_8c0380
L_8f7a3c:
	mov_s r2,0x6
L_8f7a3e:
	ld r0,[r20, 0x10]
L_8f7a42:
	ld_s r0,[r0,0x14]
L_8f7a44:
	breq r0,0x2,L_8f7a58
L_8f7a48:
	ld r1,[r16, 0x8]
L_8f7a4c:
	add r0,r13,0x10
L_8f7a50:
	add_s r1,r1,0x10
L_8f7a52:
	bl.d L_8c0380
L_8f7a56:
	mov_s r2,0x6
	.global L_8f7a58
L_8f7a58:
	ldw r4,[sp, 0x18]
L_8f7a5c:
	mov_s r0,r17
L_8f7a5e:
	mov_s r1,0x1
L_8f7a60:
	mov_s r2,r1
L_8f7a62:
	mov_s r3,r13
L_8f7a64:
	mov r5,0x0
L_8f7a68:
	bl.d L_8e5874
L_8f7a6c:
	mov r6,r5
L_8f7a70:
	b_s L_8f7aa0
	.global L_8f7a72
L_8f7a72:
	ldb_s r0,[r14,0x1]
L_8f7a74:
	cmp_s r0,0x50
L_8f7a76:
	bne_s L_8f7a08
L_8f7a78:
	ldb_s r0,[r14,0x2]
L_8f7a7a:
	cmp r0,0xf2
L_8f7a7e:
	bne_s L_8f7a08
L_8f7a80:
	ldb_s r0,[r14,0x3]
L_8f7a82:
	brne r0,0x4,L_8f7a08
L_8f7a86:
	mov_s r1,0x1017e18
L_8f7a8c:
	bl.d L_8dcba8
L_8f7a90:
	mov_s r0,0x2c
L_8f7a92:
	b_s L_8f7a08
	.global L_8f7a94
L_8f7a94:
	mov_s r1,0x1017e64
L_8f7a9a:
	bl.d L_8dcba8
L_8f7a9e:
	mov_s r0,0x2c
	.global L_8f7aa0
L_8f7aa0:
	b.d L_8c020c
L_8f7aa4:
	add_s sp,sp,0x2c
L_8f7aa6:
	nop_s
L_8f7aa8:
	push_s blink
L_8f7aaa:
	bl L_8c01e0
L_8f7aae:
	mov_s r13,r0
L_8f7ab0:
	mov_s r14,r1
L_8f7ab2:
	mov_s r15,r2
L_8f7ab4:
	mov_s r1,0x1016f30
L_8f7aba:
	mov_s r0,0x2c
L_8f7abc:
	bl.d L_8dcc10
L_8f7ac0:
	mov_s r2,r14
L_8f7ac2:
	cmp_s r14,0x0
L_8f7ac4:
	cmp.ne r15,0x0
L_8f7ac8:
	beq_s L_8f7ad6
L_8f7aca:
	mov_s r1,0x843158
L_8f7ad0:
	ld_s r0,[r1,0x8]
L_8f7ad2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f7ad4:
	st_s r0,[r1,0x8]
	.global L_8f7ad6
L_8f7ad6:
	cmp_s r13,0x0
L_8f7ad8:
	bl.ne.d L_8cb10c
L_8f7adc:
	mov.ne r0,r13
L_8f7ae0:
	b L_8c024c
