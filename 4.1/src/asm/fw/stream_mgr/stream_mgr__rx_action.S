/* stream_mgr__rx_action @ 0x8c1b44, 536 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   action - CID[%d] action 0x%x, category_code 0x%x
 *   stream_mgr.cpp
 *   action BA request- reject, not connected !!!!
 *   Received ADDBA_REQ after disconnect - No connection
 *   Received IEEE_80211_ACTION_INFO_RES frame
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID stream_mgr::action() category_code %d.
 * Зовут его: rx_mgmt__action_no_ack, rx_mgmt_srvs__distribute
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, ba__send_addba_resp, conn_mgr__by_cid, fw_log__emit0, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, log_hexdump, mgmt_buf__free, operational_if__send_evt, pbss_sta_list_update
 */
	.section .text.stream_mgr__rx_action,"ax",@progbits
	.global stream_mgr__rx_action
stream_mgr__rx_action:
	.global L_8c1b44
L_8c1b44:
	push_s blink
L_8c1b46:
	bl.d L_8c02b0
L_8c1b4a:
	mov_s r1,0x2
L_8c1b4c:
	mov_s r14,r0
L_8c1b4e:
	ld_s r15,[r0,0x14]
L_8c1b50:
	ldb r13,[r0, 0x36]
L_8c1b54:
	ldb.a r18,[r15,0x18]
L_8c1b58:
	ld_s r0,[r0,0x30]
L_8c1b5a:
	ldb r19,[r15, 0x1]
L_8c1b5e:
	sub r16,r0,0x18
L_8c1b62:
	mov_s r2,0x100e5c8
L_8c1b68:
	mov_s r0,0xb
L_8c1b6a:
	mov_s r3,r13
L_8c1b6c:
	mov r4,r19
L_8c1b70:
	bl.d L_8ee034
L_8c1b74:
	mov r5,r18
L_8c1b78:
	cmp r18,0xc
L_8c1b7c:
	mov r17,0x0
L_8c1b80:
	beq_s L_8c1d1c
L_8c1b82:
	bgt L_8c1be2
L_8c1b86:
	cmp r18,0xb
L_8c1b8a:
	bhi L_8c1d1c
L_8c1b8e:
	ldb r10,[0x801f10,r18]
L_8c1b96:
	add r0,pcl,0xc
L_8c1b9a:
	add1 r0,r0,r10
L_8c1b9e:
	j_s [r0]
L_8c1ba0:
	bl.d L_8c9e44
L_8c1ba4:
	mov_s r0,r13
L_8c1ba6:
	mov.f r16,r0
L_8c1baa:
	mov r18,0x3
L_8c1bae:
	mov r17,0x1
L_8c1bb2:
	beq_s L_8c1c3e
L_8c1bb4:
	ldb r0,[r16, 0xb0]
L_8c1bb8:
	brne r0,0x2,L_8c1c3e
L_8c1bbc:
	breq r19,0x0,L_8c1c1a
L_8c1bc0:
	breq r19,0x1,L_8c1c26
L_8c1bc4:
	breq r19,0x2,L_8c1c32
L_8c1bc8:
	mov_s r0,blink
L_8c1bca:
	mov_s r2,0x100e398
L_8c1bd0:
	mov_s r1,0x1298
L_8c1bd6:
	bl.d L_8c82c0
L_8c1bda:
	mov r3,0x411
L_8c1bde:
	mov_s r13,r17
L_8c1be0:
	b_s L_8c1cf4
	.global L_8c1be2
L_8c1be2:
	cmp r18,0x12
L_8c1be6:
	bge L_8c1d1c
L_8c1bea:
	sub r1,r18,0xd
L_8c1bee:
	cmp_s r1,0x4
L_8c1bf0:
	bhi L_8c1d1c
L_8c1bf4:
	ldb r1,[0x801f1c,r1]
L_8c1bfc:
	add r0,pcl,0x8
L_8c1c00:
	add1_s r0,r0,r1
L_8c1c02:
	j_s [r0]
L_8c1c04:
	mov_s r0,0x80345c
L_8c1c0a:
	ld_s r0,[r0,0xc]
L_8c1c0c:
	brne r0,0x0,L_8c1c7e
L_8c1c10:
	breq r19,0x0,L_8c1cd0
L_8c1c14:
	breq r19,0x1,L_8c1ce0
L_8c1c18:
	b_s L_8c1c94
	.global L_8c1c1a
L_8c1c1a:
	mov_s r0,r15
L_8c1c1c:
	bl.d L_8c2848
L_8c1c20:
	mov_s r1,r13
L_8c1c22:
	mov_s r13,r17
L_8c1c24:
	b_s L_8c1cf4
	.global L_8c1c26
L_8c1c26:
	mov_s r0,r15
L_8c1c28:
	bl.d L_8c2944
L_8c1c2c:
	mov_s r1,r13
L_8c1c2e:
	mov_s r13,r17
L_8c1c30:
	b_s L_8c1cf4
	.global L_8c1c32
L_8c1c32:
	mov_s r0,r15
L_8c1c34:
	bl.d L_8c75a8
L_8c1c38:
	mov_s r1,r13
L_8c1c3a:
	mov_s r13,r17
L_8c1c3c:
	b_s L_8c1cf4
	.global L_8c1c3e
L_8c1c3e:
	breq r19,0x0,L_8c1c4a
	.global L_8c1c42
L_8c1c42:
	mov_s r13,0x1
L_8c1c44:
	mov r18,0x3
L_8c1c48:
	b_s L_8c1cf4
	.global L_8c1c4a
L_8c1c4a:
	mov_s r2,0x100e5fc
L_8c1c50:
	mov_s r0,0xb
L_8c1c52:
	bl.d L_8edfb0
L_8c1c56:
	mov_s r1,0x2
L_8c1c58:
	ld_s r0,[r14,0x14]
L_8c1c5a:
	bl.d L_8c7f90
L_8c1c5e:
	ld_s r1,[r14,0x30]
L_8c1c60:
	breq r16,0x0,L_8c1c6e
L_8c1c64:
	mov_s r0,r15
L_8c1c66:
	bl.d L_8c38dc
L_8c1c6a:
	mov_s r1,r16
L_8c1c6c:
	b_s L_8c1c42
	.global L_8c1c6e
L_8c1c6e:
	mov_s r2,0x100e62c
L_8c1c74:
	mov_s r0,0xb
L_8c1c76:
	bl.d L_8edfb0
L_8c1c7a:
	mov_s r1,0x2
L_8c1c7c:
	b_s L_8c1c42
	.global L_8c1c7e
L_8c1c7e:
	brhs r19,0x8,L_8c1cfc
L_8c1c82:
	ldb.x r19,[0x801f24,r19]
L_8c1c8a:
	add r0,pcl,0xc
L_8c1c8e:
	add1 r0,r0,r19
L_8c1c92:
	j_s [r0]
	.global L_8c1c94
L_8c1c94:
	mov_s r13,r17
L_8c1c96:
	b_s L_8c1cee
L_8c1c98:
	mov_s r0,r15
L_8c1c9a:
	mov_s r1,r16
L_8c1c9c:
	bl.d L_8d5428
L_8c1ca0:
	mov_s r2,r13
L_8c1ca2:
	b_s L_8c1ccc
L_8c1ca4:
	bl.d L_8c9e44
L_8c1ca8:
	mov_s r0,r13
L_8c1caa:
	breq_s r0,0,L_8c1ccc
L_8c1cac:
	ldb r0,[r0, 0xb0]
L_8c1cb0:
	brne r0,0x2,L_8c1ccc
L_8c1cb4:
	mov_s r2,0x100e660
L_8c1cba:
	mov_s r0,0xb
L_8c1cbc:
	bl.d L_8edfb0
L_8c1cc0:
	mov_s r1,0x2
L_8c1cc2:
	mov_s r0,r15
L_8c1cc4:
	mov_s r1,r16
L_8c1cc6:
	bl.d L_8d5560
L_8c1cca:
	mov_s r2,r13
	.global L_8c1ccc
L_8c1ccc:
	mov_s r13,0x1
L_8c1cce:
	b_s L_8c1cee
	.global L_8c1cd0
L_8c1cd0:
	mov r16,0x1
L_8c1cd4:
	mov_s r0,r13
L_8c1cd6:
	bl.d L_8dd830
L_8c1cda:
	mov_s r1,r15
L_8c1cdc:
	mov_s r13,r16
L_8c1cde:
	b_s L_8c1cee
	.global L_8c1ce0
L_8c1ce0:
	mov r16,0x1
L_8c1ce4:
	mov_s r0,r13
L_8c1ce6:
	bl.d L_8ddac8
L_8c1cea:
	mov_s r1,r15
L_8c1cec:
	mov_s r13,r16
	.global L_8c1cee
L_8c1cee:
	mov r18,0x10
L_8c1cf2:
	breq_s r13,0,L_8c1d26
	.global L_8c1cf4
L_8c1cf4:
	bl.d L_8c9538
L_8c1cf8:
	mov_s r0,r14
L_8c1cfa:
	b_s L_8c1d26
	.global L_8c1cfc
L_8c1cfc:
	ld_s r0,[r14,0x14]
L_8c1cfe:
	bl.d L_8c7f90
L_8c1d02:
	ld_s r1,[r14,0x30]
L_8c1d04:
	mov_s r0,blink
L_8c1d06:
	mov_s r2,0x100e398
L_8c1d0c:
	mov_s r1,0x12ec
L_8c1d12:
	bl.d L_8c82c0
L_8c1d16:
	mov r3,0x45f
L_8c1d1a:
	b_s L_8c1c94
	.global L_8c1d1c
L_8c1d1c:
	ld_s r0,[r14,0x14]
L_8c1d1e:
	bl.d L_8c7f90
L_8c1d22:
	ld_s r1,[r14,0x30]
L_8c1d24:
	mov_s r13,0x0
	.global L_8c1d26
L_8c1d26:
	brne_s r13,0,L_8c1d56
L_8c1d28:
	mov_s r2,0x100e68c
L_8c1d2e:
	mov_s r0,0xb
L_8c1d30:
	mov_s r1,0x2
L_8c1d32:
	bl.d L_8edfcc
L_8c1d36:
	mov_s r3,r18
L_8c1d38:
	ld_s r2,[r14,0x30]
L_8c1d3a:
	add r0,r14,0x28
L_8c1d3e:
	add_s r2,r2,0x10
L_8c1d40:
	extw_s r2,r2
L_8c1d42:
	mov_s r1,0x61
L_8c1d44:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8c1d46:
	ldb r3,[r14, 0x35]
L_8c1d4a:
	mov r4,0x1
L_8c1d4e:
	bl.d L_8e0874
L_8c1d52:
	mov r5,0x0
	.global L_8c1d56
L_8c1d56:
	b L_8c030c
L_8c1d5a:
	nop_s
