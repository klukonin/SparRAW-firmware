/* TX_API__send_packet @ 0x8e58a4, 388 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::send_packet FW2FW test cid:%d, channel_type:%d,  length:%d
 *   TX_API::send_packet_full packet with status FWQ_TX_MEM_POLL_ALLOC_ERR - CB if exist (0x%x) will be called through u_scheduler context
 *   TX_API::send_packet with tx_op = %d
 *   send_packet_full:add_packet() failure
 * Зовут его: tx_api__send_mgmt, tx_api__send_mgmt_with_cb, wmi_add_debug_tx_pckt
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, bits__set8_s6_w2, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, fwq_tx__add_packet, tx_api__bits_set8_s0_w6, tx_api__stamp_seq_bytes, tx_send_packet_step, u_schd__add
 * Глобалы (через gp): 0x800368
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__send_packet
TX_API__send_packet:
	.global L_8e58a4
L_8e58a4:
	push_s blink
L_8e58a6:
	bl L_8c01c0
L_8e58aa:
	sub_s sp,sp,0x8
L_8e58ac:
	mov_s r16,r0
L_8e58ae:
	mov_s r17,r1
L_8e58b0:
	mov_s r20,r2
L_8e58b2:
	mov.f r13,r3
L_8e58b6:
	mov_s r15,r4
L_8e58b8:
	mov r18,r5
L_8e58bc:
	mov r22,r6
L_8e58c0:
	mov r23,r7
L_8e58c4:
	mov_s r14,sp
L_8e58c6:
	beq_s L_8e58f2
	.global L_8e58c8
L_8e58c8:
	st_s r13,[r14,0x4]
L_8e58ca:
	sub r0,r13,0x24
L_8e58ce:
	st_s r0,[r14]
L_8e58d0:
	breq r16,0x0,L_8e5900
	.global L_8e58d4
L_8e58d4:
	ldb r19,[r16, 0x8]
L_8e58d8:
	ld_s r0,[gp,0x1e4]
L_8e58da:
	ld_s r14,[sp,0x0]
L_8e58dc:
	breq r20,0x1,L_8e590c
L_8e58e0:
	breq r20,0x2,L_8e5916
L_8e58e4:
	mov_s r0,blink
L_8e58e6:
	mov_s r1,0x1221
L_8e58ec:
	bl L_8c9b28
L_8e58f0:
	b_s L_8e5a20
	.global L_8e58f2
L_8e58f2:
	mov_s r0,blink
L_8e58f4:
	mov_s r1,0x11e9
L_8e58fa:
	bl L_8c9b28
L_8e58fe:
	b_s L_8e58c8
	.global L_8e5900
L_8e5900:
	mov_s r0,blink
L_8e5902:
	mov_s r1,0x91
L_8e5904:
	/* bl.d 0x008c9b28 */
	.byte 0x26,0x0a,0x2f,0xf2
L_8e5908:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8e590a:
	b_s L_8e58d4
	.global L_8e590c
L_8e590c:
	mov r20,0x842154
L_8e5914:
	b_s L_8e5966
	.global L_8e5916
L_8e5916:
	cmp_s r0,0x0
L_8e5918:
	mov.eq r21,r15
L_8e591c:
	beq_s L_8e595c
L_8e591e:
	mov_s r0,r13
L_8e5920:
	mov_s r1,0x0
L_8e5922:
	mov_s r20,r1
L_8e5924:
	mov_s r2,r19
L_8e5926:
	bl.d L_8c736c
L_8e592a:
	mov_s r3,0x7
L_8e592c:
	mov_s r0,0x88
L_8e592e:
	stw_s r0,[r13]
L_8e5930:
	add r21,r15,0x1a
L_8e5934:
	extw r21,r21
L_8e5938:
	add r0,r13,0x1a
L_8e593c:
	mov_s r1,0x0
L_8e593e:
	bl.d L_8c84ec
L_8e5942:
	mov_s r2,r15
L_8e5944:
	mov_s r1,0x1018450
L_8e594a:
	mov_s r0,0x27
L_8e594c:
	mov_s r2,r19
L_8e594e:
	mov_s r3,r17
L_8e5950:
	bl.d L_8dcd00
L_8e5954:
	mov r4,r21
L_8e5958:
	st.as r20,[gp,0x79]
	.global L_8e595c
L_8e595c:
	mov r20,0x842274
L_8e5964:
	mov_s r15,r21
	.global L_8e5966
L_8e5966:
	ldb_s r0,[r14,0x11]
L_8e5968:
	cmp r0,0xfd
L_8e596c:
	ld_s r13,[sp,0x3c]
L_8e596e:
	bne_s L_8e5994
L_8e5970:
	mov_s r1,0x1018494
L_8e5976:
	mov_s r0,0x27
L_8e5978:
	bl.d L_8dcc10
L_8e597c:
	mov_s r2,r13
L_8e597e:
	breq r13,0x0,L_8e5a20
L_8e5982:
	mov_s r0,L_8c5a34-0x8c0000
L_8e5988:
	mov_s r1,r13
L_8e598a:
	mov_s r2,r16
L_8e598c:
	bl.d L_8c3248
L_8e5990:
	mov_s r3,0x1
L_8e5992:
	b_s L_8e5a20
	.global L_8e5994
L_8e5994:
	stw_s r15,[r14,0x8]
L_8e5996:
	st_s r13,[r14,0x20]
L_8e5998:
	mov_s r2,0x0
L_8e599a:
	st_s r2,[r14,0x18]
L_8e599c:
	st_s r2,[r14,0x1c]
L_8e599e:
	ldb_s r1,[sp,0x38]
L_8e59a0:
	stb r18,[r14, 0x10]
L_8e59a4:
	bmsk_s r1,r1,0x5
L_8e59a6:
	add r0,r14,0xb
L_8e59aa:
	bl.d L_8ed250
L_8e59ae:
	stb r19,[r14, 0xa]
L_8e59b2:
	bmsk r1,r17,0x1
L_8e59b6:
	bl L_8ed2bc
L_8e59ba:
	st_s r2,[r14,0x14]
L_8e59bc:
	stb r22,[r14, 0x13]
L_8e59c0:
	ld_s r13,[sp,0x40]
L_8e59c2:
	st_s r2,[r14,0x4]
L_8e59c4:
	stb r23,[r14, 0x12]
L_8e59c8:
	stw_s r2,[r14,0xc]
L_8e59ca:
	breq_s r13,0,L_8e59da
L_8e59cc:
	mov_s r1,0x101851c
L_8e59d2:
	mov_s r0,0x27
L_8e59d4:
	bl.d L_8dcc10
L_8e59d8:
	mov_s r2,r13
	.global L_8e59da
L_8e59da:
	brhs r13,0x5,L_8e5a08
L_8e59de:
	ldb.x r13,[0x8031c0,r13]
L_8e59e6:
	add r0,pcl,0xa
L_8e59ea:
	add1_s r0,r0,r13
L_8e59ec:
	j_s [r0]
L_8e59ee:
	ld_s r0,[r14,0xc]
L_8e59f0:
	bset_s r0,r0,0x0
L_8e59f2:
	b_s L_8e5a06
L_8e59f4:
	ld_s r0,[r14,0xc]
L_8e59f6:
	bset_s r0,r0,0x1
L_8e59f8:
	st_s r0,[r14,0xc]
L_8e59fa:
	b_s L_8e5a04
L_8e59fc:
	ld_s r0,[r14,0xc]
L_8e59fe:
	bset_s r0,r0,0x2
L_8e5a00:
	b_s L_8e5a06
L_8e5a02:
	ld_s r0,[r14,0xc]
	.global L_8e5a04
L_8e5a04:
	bset_s r0,r0,0x3
	.global L_8e5a06
L_8e5a06:
	st_s r0,[r14,0xc]
	.global L_8e5a08
L_8e5a08:
	mov_s r0,r20
L_8e5a0a:
	mov_s r1,r14
L_8e5a0c:
	bl.d L_8c2af4
L_8e5a10:
	mov_s r2,r17
L_8e5a12:
	brne_s r0,0,L_8e5a20
L_8e5a14:
	mov_s r1,0x1018540
L_8e5a1a:
	bl.d L_8dcba8
L_8e5a1e:
	mov_s r0,0x17
	.global L_8e5a20
L_8e5a20:
	b.d L_8c020c
L_8e5a24:
	add_s sp,sp,0x8
L_8e5a26:
	nop_s
