/* stream_mgr__action @ 0x8c1e08, 528 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   action BA request- reject, not connected !!!!
 *   Received ADDBA_REQ after disconnect - No connection
 *   not FTM
 *   Received IEEE_80211_ACTION_INFO_RES frame
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID stream_mgr::action() category_code %d.
 * Зовут его: rx_mgmt__action_no_ack, rx_mgmt_srvs__distribute
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, ba_sm__setup_result, conn_mgr__by_cid, ftm__responder_rx_req, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, hexdump_words, low_sme__send_evt2sw, mem_pool__free_thunk, pbss_sta_list_update
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__action
stream_mgr__action:
	.global L_8c1e08
L_8c1e08:
	push_s blink
L_8c1e0a:
	bl L_8c01d0
L_8c1e0e:
	mov_s r17,r0
L_8c1e10:
	ldb r15,[r0, 0x36]
L_8c1e14:
	ld_s r0,[r0,0x14]
L_8c1e16:
	mov r19,0x0
L_8c1e1a:
	add r14,r0,0x18
L_8c1e1e:
	ldb_s r13,[r14]
L_8c1e20:
	ldb r18,[r14, 0x1]
L_8c1e24:
	cmp_s r13,0xc
L_8c1e26:
	ld r1,[r17, 0x30]
L_8c1e2a:
	beq.d L_8c1fd8
L_8c1e2e:
	sub r16,r1,0x18
L_8c1e32:
	bgt_s L_8c1e4c
L_8c1e34:
	cmp_s r13,0xb
L_8c1e36:
	bhi L_8c1fd8
L_8c1e3a:
	ldb r10,[0x80242c,r13]
L_8c1e42:
	add r2,pcl,0xc
L_8c1e46:
	add1 r2,r2,r10
L_8c1e4a:
	j_s [r2]
	.global L_8c1e4c
L_8c1e4c:
	cmp_s r13,0x12
L_8c1e4e:
	bge L_8c1fd8
L_8c1e52:
	sub r3,r13,0xd
L_8c1e56:
	cmp_s r3,0x4
L_8c1e58:
	bhi L_8c1fd8
L_8c1e5c:
	ldb r3,[0x802438,r3]
L_8c1e64:
	add r2,pcl,0x8
L_8c1e68:
	add1_s r2,r2,r3
L_8c1e6a:
	j_s [r2]
L_8c1e6c:
	mov_s r2,0x803c00
L_8c1e72:
	ld_s r2,[r2,0xc]
L_8c1e74:
	cmp_s r2,0x0
L_8c1e76:
	mov_s r13,0x10
L_8c1e78:
	bne_s L_8c1f58
L_8c1e7a:
	cmp r18,0x0
L_8c1e7e:
	beq_s L_8c1fa8
L_8c1e80:
	cmp r18,0x1
L_8c1e84:
	beq_s L_8c1fba
L_8c1e86:
	b_s L_8c1f6e
L_8c1e88:
	bl.d L_8cbffc
L_8c1e8c:
	mov_s r0,r15
L_8c1e8e:
	mov.f r13,r0
L_8c1e92:
	mov r16,0x3
L_8c1e96:
	mov r19,0x1
L_8c1e9a:
	beq_s L_8c1ee0
L_8c1e9c:
	ldb r0,[r13, 0xf0]
L_8c1ea0:
	brne r0,0x2,L_8c1ee0
L_8c1ea4:
	breq r18,0x0,L_8c1ebe
L_8c1ea8:
	breq r18,0x1,L_8c1ec8
L_8c1eac:
	breq r18,0x2,L_8c1ed6
L_8c1eb0:
	mov_s r0,blink
L_8c1eb2:
	mov_s r1,0x1298
L_8c1eb8:
	bl L_8c9b28
L_8c1ebc:
	b_s L_8c1ed0
	.global L_8c1ebe
L_8c1ebe:
	mov_s r0,r14
L_8c1ec0:
	bl.d L_8c3028
L_8c1ec4:
	mov_s r1,r15
L_8c1ec6:
	b_s L_8c1ed0
	.global L_8c1ec8
L_8c1ec8:
	mov_s r0,r14
L_8c1eca:
	bl.d L_8c3124
L_8c1ece:
	mov_s r1,r15
	.global L_8c1ed0
L_8c1ed0:
	mov_s r14,r19
L_8c1ed2:
	mov_s r13,r16
L_8c1ed4:
	b_s L_8c1f50
	.global L_8c1ed6
L_8c1ed6:
	mov_s r0,r14
L_8c1ed8:
	bl.d L_8c8c18
L_8c1edc:
	mov_s r1,r15
L_8c1ede:
	b_s L_8c1ed0
	.global L_8c1ee0
L_8c1ee0:
	breq r18,0x0,L_8c1eea
	.global L_8c1ee4
L_8c1ee4:
	mov_s r14,0x1
L_8c1ee6:
	mov_s r13,0x3
L_8c1ee8:
	b_s L_8c1f50
	.global L_8c1eea
L_8c1eea:
	mov_s r1,0x101079c
L_8c1ef0:
	bl.d L_8dcba8
L_8c1ef4:
	mov_s r0,0x2b
L_8c1ef6:
	ld r0,[r17, 0x14]
L_8c1efa:
	bl.d L_8c9790
L_8c1efe:
	ld r1,[r17, 0x30]
L_8c1f02:
	breq_s r13,0,L_8c1f0e
L_8c1f04:
	mov_s r0,r14
L_8c1f06:
	bl.d L_8c42a4
L_8c1f0a:
	mov_s r1,r13
L_8c1f0c:
	b_s L_8c1ee4
	.global L_8c1f0e
L_8c1f0e:
	mov_s r1,0x10107cc
L_8c1f14:
	bl.d L_8dcba8
L_8c1f18:
	mov_s r0,0x2b
L_8c1f1a:
	b_s L_8c1ee4
L_8c1f1c:
	mov_s r13,0x4
L_8c1f1e:
	breq r18,0x20,L_8c1f34
L_8c1f22:
	breq r18,0x21,L_8c1f42
L_8c1f26:
	mov_s r1,0x1010800
L_8c1f2c:
	bl.d L_8dcba8
L_8c1f30:
	mov_s r0,0x2b
L_8c1f32:
	b_s L_8c1f6e
	.global L_8c1f34
L_8c1f34:
	ld_s r0,[gp,-0x74]
L_8c1f36:
	mov_s r1,r14
L_8c1f38:
	mov_s r2,r16
L_8c1f3a:
	bl.d L_8cb3bc
L_8c1f3e:
	mov_s r3,r15
L_8c1f40:
	b_s L_8c1fa4
	.global L_8c1f42
L_8c1f42:
	ld_s r0,[gp,-0x74]
L_8c1f44:
	mov_s r1,r14
L_8c1f46:
	mov_s r2,r16
L_8c1f48:
	bl.d L_8cb288
L_8c1f4c:
	mov_s r3,r15
L_8c1f4e:
	b_s L_8c1fa4
	.global L_8c1f50
L_8c1f50:
	bl.d L_8cb15c
L_8c1f54:
	mov_s r0,r17
L_8c1f56:
	b_s L_8c1fde
	.global L_8c1f58
L_8c1f58:
	brhs r18,0x8,L_8c1fc6
L_8c1f5c:
	mov_s r0,r18
L_8c1f5e:
	ldb.x r0,[0x802440,r0]
L_8c1f66:
	add r1,pcl,0xa
L_8c1f6a:
	add1_s r1,r1,r0
L_8c1f6c:
	j_s [r1]
	.global L_8c1f6e
L_8c1f6e:
	mov_s r14,r19
L_8c1f70:
	b_s L_8c1fb6
L_8c1f72:
	mov_s r0,r14
L_8c1f74:
	mov_s r1,r16
L_8c1f76:
	bl.d L_8d87a0
L_8c1f7a:
	mov_s r2,r15
L_8c1f7c:
	b_s L_8c1fa4
L_8c1f7e:
	bl.d L_8cbffc
L_8c1f82:
	mov_s r0,r15
L_8c1f84:
	breq_s r0,0,L_8c1fa4
L_8c1f86:
	ldb r0,[r0, 0xf0]
L_8c1f8a:
	brne r0,0x2,L_8c1fa4
L_8c1f8e:
	mov_s r1,0x1010808
L_8c1f94:
	bl.d L_8dcba8
L_8c1f98:
	mov_s r0,0x2b
L_8c1f9a:
	mov_s r0,r14
L_8c1f9c:
	mov_s r1,r16
L_8c1f9e:
	bl.d L_8d88c4
L_8c1fa2:
	mov_s r2,r15
	.global L_8c1fa4
L_8c1fa4:
	mov_s r14,0x1
L_8c1fa6:
	b_s L_8c1fb6
	.global L_8c1fa8
L_8c1fa8:
	mov_s r13,0x1
L_8c1faa:
	mov_s r0,r15
L_8c1fac:
	bl.d L_8e19b0
L_8c1fb0:
	mov_s r1,r14
	.global L_8c1fb2
L_8c1fb2:
	mov_s r14,r13
L_8c1fb4:
	mov_s r13,0x10
	.global L_8c1fb6
L_8c1fb6:
	breq_s r14,0,L_8c1fde
L_8c1fb8:
	b_s L_8c1f50
	.global L_8c1fba
L_8c1fba:
	mov_s r0,r15
L_8c1fbc:
	bl.d L_8e1c04
L_8c1fc0:
	mov_s r1,r14
L_8c1fc2:
	mov_s r13,0x1
L_8c1fc4:
	b_s L_8c1fb2
	.global L_8c1fc6
L_8c1fc6:
	bl L_8c9790
L_8c1fca:
	mov_s r0,blink
L_8c1fcc:
	mov_s r1,0x1506
L_8c1fd2:
	bl L_8c9b28
L_8c1fd6:
	b_s L_8c1f6e
	.global L_8c1fd8
L_8c1fd8:
	bl.d L_8c9790
L_8c1fdc:
	mov_s r14,0x0
	.global L_8c1fde
L_8c1fde:
	brne_s r14,0,L_8c2012
L_8c1fe0:
	mov_s r1,0x1010834
L_8c1fe6:
	mov_s r0,0x2b
L_8c1fe8:
	bl.d L_8dcc10
L_8c1fec:
	mov_s r2,r13
L_8c1fee:
	ld r2,[r17, 0x30]
L_8c1ff2:
	add r0,r17,0x28
L_8c1ff6:
	add_s r2,r2,0x10
L_8c1ff8:
	extw_s r2,r2
L_8c1ffa:
	mov_s r1,0x61
L_8c1ffc:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8c1ffe:
	ldb r3,[r17, 0x35]
L_8c2002:
	mov r4,0x1
L_8c2006:
	mov r5,0x0
L_8c200a:
	bl.d L_8e5474
L_8c200e:
	mov r6,r5
	.global L_8c2012
L_8c2012:
	b L_8c022c
L_8c2016:
	nop_s
