/* TX_API__send_packet @ 0x8e0c74, 404 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_api.cpp
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   TX_API::send_packet FW2FW test cid:%d, channel_type:%d,  length:%d
 *   TX_API::send_packet_full packet with status FWQ_TX_MEM_POLL_ALLOC_ERR - CB if exist (0x%x) will be called through u_scheduler context
 *   TX_API::send_packet with tx_op = %d
 * Зовут его: tx_api__send_mgmt, tx_api__send_mgmt_with_cb, wmi_handler_add_debug_tx_pckt
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, bf_b_s0_w6, bf_b_s6_w2, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, fwq_tx__enqueue, tx_api__stamp_seq_bytes, tx_send_packet_step, u_schd__add
 * Глобалы (через gp): 0x800344
 */
	.section .text.TX_API__send_packet,"ax",@progbits
	.global TX_API__send_packet
TX_API__send_packet:
	.global L_8e0c74
L_8e0c74:
	push_s blink
L_8e0c76:
	bl L_8c02a0
L_8e0c7a:
	sub_s sp,sp,0x8
L_8e0c7c:
	mov_s r16,r0
L_8e0c7e:
	mov_s r21,r1
L_8e0c80:
	mov_s r19,r2
L_8e0c82:
	mov.f r14,r3
L_8e0c86:
	mov_s r15,r4
L_8e0c88:
	mov r17,r5
L_8e0c8c:
	mov r22,r6
L_8e0c90:
	mov r23,r7
L_8e0c94:
	mov_s r13,sp
L_8e0c96:
	beq_s L_8e0ccc
	.global L_8e0c98
L_8e0c98:
	st_s r14,[r13,0x4]
L_8e0c9a:
	sub r0,r14,0x1c
L_8e0c9e:
	st_s r0,[r13]
L_8e0ca0:
	breq r16,0x0,L_8e0ce2
	.global L_8e0ca4
L_8e0ca4:
	ldb r18,[r16, 0x8]
L_8e0ca8:
	ld_s r0,[gp,0x1d4]
L_8e0caa:
	ld_s r13,[sp,0x0]
L_8e0cac:
	breq r19,0x1,L_8e0cf8
L_8e0cb0:
	breq r19,0x2,L_8e0d02
L_8e0cb4:
	mov_s r0,blink
L_8e0cb6:
	mov_s r2,0x1014cd4
L_8e0cbc:
	mov_s r1,0x1221
L_8e0cc2:
	bl.d L_8c82c0
L_8e0cc6:
	mov r3,0x19e
L_8e0cca:
	b_s L_8e0e02
	.global L_8e0ccc
L_8e0ccc:
	mov_s r0,blink
L_8e0cce:
	mov_s r2,0x1014d54
L_8e0cd4:
	mov_s r1,0x11e9
L_8e0cda:
	bl.d L_8c82c0
L_8e0cde:
	mov_s r3,0xab
L_8e0ce0:
	b_s L_8e0c98
	.global L_8e0ce2
L_8e0ce2:
	mov_s r0,blink
L_8e0ce4:
	mov_s r2,0x1014cd4
L_8e0cea:
	mov_s r1,0x91
L_8e0cec:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8e0cee:
	bl.d L_8c82c0
L_8e0cf2:
	mov r3,0x174
L_8e0cf6:
	b_s L_8e0ca4
	.global L_8e0cf8
L_8e0cf8:
	mov r19,0x842410
L_8e0d00:
	b_s L_8e0d56
	.global L_8e0d02
L_8e0d02:
	cmp_s r0,0x0
L_8e0d04:
	mov.eq r20,r15
L_8e0d08:
	beq_s L_8e0d4c
L_8e0d0a:
	mov_s r0,r14
L_8e0d0c:
	mov_s r1,0x0
L_8e0d0e:
	mov_s r19,r1
L_8e0d10:
	mov_s r2,r18
L_8e0d12:
	bl.d L_8c63e0
L_8e0d16:
	mov_s r3,0x7
L_8e0d18:
	mov_s r0,0x88
L_8e0d1a:
	stw_s r0,[r14]
L_8e0d1c:
	add r20,r15,0x1a
L_8e0d20:
	extw r20,r20
L_8e0d24:
	add r0,r14,0x1a
L_8e0d28:
	mov_s r1,0x0
L_8e0d2a:
	bl.d L_8c7110
L_8e0d2e:
	mov_s r2,r15
L_8e0d30:
	mov_s r2,0x10150b0
L_8e0d36:
	mov_s r0,0x7
L_8e0d38:
	mov_s r1,0x2
L_8e0d3a:
	mov_s r3,r18
L_8e0d3c:
	mov r4,r21
L_8e0d40:
	bl.d L_8ee034
L_8e0d44:
	mov r5,r20
L_8e0d48:
	st.as r19,[gp,0x75]
	.global L_8e0d4c
L_8e0d4c:
	mov r19,0x842530
L_8e0d54:
	mov_s r15,r20
	.global L_8e0d56
L_8e0d56:
	ldb_s r0,[r13,0x11]
L_8e0d58:
	cmp r0,0xfd
L_8e0d5c:
	ld_s r14,[sp,0x3c]
L_8e0d5e:
	bne_s L_8e0d86
L_8e0d60:
	mov_s r2,0x10150f4
L_8e0d66:
	mov_s r0,0x7
L_8e0d68:
	mov_s r1,0x2
L_8e0d6a:
	bl.d L_8edfcc
L_8e0d6e:
	mov_s r3,r14
L_8e0d70:
	breq r14,0x0,L_8e0e02
L_8e0d74:
	mov_s r0,0x4c44
L_8e0d7a:
	mov_s r1,r14
L_8e0d7c:
	mov_s r2,r16
L_8e0d7e:
	bl.d L_8c2ac8
L_8e0d82:
	mov_s r3,0x1
L_8e0d84:
	b_s L_8e0e02
	.global L_8e0d86
L_8e0d86:
	stw_s r15,[r13,0x8]
L_8e0d88:
	st_s r14,[r13,0x18]
L_8e0d8a:
	ldb_s r1,[sp,0x38]
L_8e0d8c:
	stb r17,[r13, 0x10]
L_8e0d90:
	bmsk_s r1,r1,0x5
L_8e0d92:
	add r0,r13,0xb
L_8e0d96:
	bl.d L_8e821c
L_8e0d9a:
	stb r18,[r13, 0xa]
L_8e0d9e:
	bmsk r1,r21,0x1
L_8e0da2:
	bl L_8e8288
L_8e0da6:
	mov_s r1,0x0
L_8e0da8:
	st_s r1,[r13,0x14]
L_8e0daa:
	stb r22,[r13, 0x13]
L_8e0dae:
	ld_s r14,[sp,0x40]
L_8e0db0:
	st_s r1,[r13,0x4]
L_8e0db2:
	stb r23,[r13, 0x12]
L_8e0db6:
	stw_s r1,[r13,0xc]
L_8e0db8:
	breq_s r14,0,L_8e0dca
L_8e0dba:
	mov_s r2,0x101517c
L_8e0dc0:
	mov_s r0,0x7
L_8e0dc2:
	mov_s r1,0x2
L_8e0dc4:
	bl.d L_8edfcc
L_8e0dc8:
	mov_s r3,r14
	.global L_8e0dca
L_8e0dca:
	brhs r14,0x5,L_8e0df8
L_8e0dce:
	ldb.x r14,[0x802b14,r14]
L_8e0dd6:
	add r0,pcl,0xa
L_8e0dda:
	add1_s r0,r0,r14
L_8e0ddc:
	j_s [r0]
L_8e0dde:
	ld_s r0,[r13,0xc]
L_8e0de0:
	bset_s r0,r0,0x0
L_8e0de2:
	b_s L_8e0df6
L_8e0de4:
	ld_s r0,[r13,0xc]
L_8e0de6:
	bset_s r0,r0,0x1
L_8e0de8:
	st_s r0,[r13,0xc]
L_8e0dea:
	b_s L_8e0df4
L_8e0dec:
	ld_s r0,[r13,0xc]
L_8e0dee:
	bset_s r0,r0,0x2
L_8e0df0:
	b_s L_8e0df6
L_8e0df2:
	ld_s r0,[r13,0xc]
	.global L_8e0df4
L_8e0df4:
	bset_s r0,r0,0x3
	.global L_8e0df6
L_8e0df6:
	st_s r0,[r13,0xc]
	.global L_8e0df8
L_8e0df8:
	mov_s r0,r19
L_8e0dfa:
	mov_s r1,r13
L_8e0dfc:
	bl.d L_8c2460
L_8e0e00:
	mov_s r2,r21
	.global L_8e0e02
L_8e0e02:
	b.d L_8c02ec
L_8e0e06:
	add_s sp,sp,0x8
