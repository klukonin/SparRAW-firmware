/* wmi_sw_tx_req @ 0x8fbe18, 356 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW failed TX MGMT: too big packet.
 *   HOST SW TX: Sending [type = %d, sub_type = %d]
 *   [NNL] [GO = %d, is_probe_resp = %d ]
 *   HOST SW TX: splitmac handle [type = %d, sub_type = %d]
 *   HOST SW TX: DST MAC: ADDR-%04X%08X
 *   SW TX PROBE RESP IGNORED: FW handle this presp !.
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: SW_TX_MGMT_API__send_packet, TX_API__alloc_tx_payload, TX_API__free_memory, __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_log_emit2, handle_packet_splitmac, l2mgr__send_sw_tx_complete, memcpy_fw, mid_list__by_mid_fw, send_sw_packet
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_sw_tx_req
wmi_sw_tx_req:
	.global L_8fbe18
L_8fbe18:
	push_s blink
L_8fbe1a:
	bl L_8c01d4
L_8fbe1e:
	mov_s r14,r0
L_8fbe20:
	ldw_s r0,[r0,0x6]
L_8fbe22:
	cmp r0,0x500
L_8fbe26:
	mov_s r18,r1
L_8fbe28:
	ble_s L_8fbe40
L_8fbe2a:
	mov_s r1,0x100dd84
L_8fbe30:
	bl.d L_8dcba8
L_8fbe34:
	mov_s r0,0x1b
L_8fbe36:
	mov_s r0,0x1
L_8fbe38:
	bl.d L_8f8e50
L_8fbe3c:
	mov_s r1,r18
L_8fbe3e:
	b_s L_8fbf76
	.global L_8fbe40
L_8fbe40:
	bl.d L_8c3414
L_8fbe44:
	mov r17,0x1
L_8fbe48:
	mov_s r13,r0
L_8fbe4a:
	add r1,r14,0x8
L_8fbe4e:
	bl.d L_8c0380
L_8fbe52:
	ldw_s r2,[r14,0x6]
L_8fbe54:
	bl.d L_8cc3dc
L_8fbe58:
	mov_s r0,r18
L_8fbe5a:
	mov_s r16,r0
L_8fbe5c:
	ldw_s r2,[r13]
L_8fbe5e:
	ldb r15,[r0, 0x9c]
L_8fbe62:
	lsr r3,r2,0x4
L_8fbe66:
	bmsk_s r3,r3,0x3
L_8fbe68:
	cmp_s r3,0x5
L_8fbe6a:
	sub.ne r17,r17,r17
L_8fbe6e:
	mov_s r1,0x100dda8
L_8fbe74:
	lsr_s r2,r2,0x2
L_8fbe76:
	mov_s r0,0x2b
L_8fbe78:
	bl.d L_8dcc80
L_8fbe7c:
	bmsk_s r2,r2,0x1
L_8fbe7e:
	mov_s r1,0x100ddd8
L_8fbe84:
	mov_s r0,0x2b
L_8fbe86:
	mov_s r2,r15
L_8fbe88:
	bl.d L_8dcc80
L_8fbe8c:
	mov_s r3,r17
L_8fbe8e:
	mov_s r0,r16
L_8fbe90:
	add r0,r0,0x234
L_8fbe94:
	ld_s r2,[r0,0x8]
L_8fbe96:
	ld_s r3,[r2,0x78]
L_8fbe98:
	mov_s r1,0x0
L_8fbe9a:
	brne_s r3,0,L_8fbecc
L_8fbe9c:
	ld_s r3,[r2,0x6c]
L_8fbe9e:
	cmp_s r3,0x0
L_8fbea0:
	cmp.ne r3,0x3
L_8fbea4:
	bne_s L_8fbebe
L_8fbea6:
	ldb r1,[r2,0x216]
L_8fbeae:
	brne r1,0x1,L_8fbeb8
L_8fbeb2:
	ld_s r1,[r2,0x78]
L_8fbeb4:
	breq r1,0x1,L_8fbebc
	.global L_8fbeb8
L_8fbeb8:
	mov_s r1,0x0
L_8fbeba:
	b_s L_8fbebe
	.global L_8fbebc
L_8fbebc:
	mov_s r1,0x1
	.global L_8fbebe
L_8fbebe:
	extb.f 0x0,r1
L_8fbec2:
	bne_s L_8fbecc
L_8fbec4:
	ld_s r1,[r0,0x4c]
L_8fbec6:
	cmp_s r1,0x0
L_8fbec8:
	mov_s r1,0x0
L_8fbeca:
	beq_s L_8fbece
	.global L_8fbecc
L_8fbecc:
	mov_s r1,0x1
	.global L_8fbece
L_8fbece:
	extb.f 0x0,r1
L_8fbed2:
	bne_s L_8fbedc
L_8fbed4:
	cmp_s r15,0x0
L_8fbed6:
	cmp.ne r17,0x0
L_8fbeda:
	beq_s L_8fbeec
	.global L_8fbedc
L_8fbedc:
	ldw_s r3,[r14,0x6]
L_8fbede:
	mov_s r1,r14
L_8fbee0:
	mov_s r2,r13
L_8fbee2:
	bl.d L_8f8dbc
L_8fbee6:
	mov r4,r18
L_8fbeea:
	b_s L_8fbf76
	.global L_8fbeec
L_8fbeec:
	mov_s r0,0x803c20
L_8fbef2:
	ldb_s r0,[r0,0x8]
L_8fbef4:
	brne r0,0x1,L_8fbf26
L_8fbef8:
	ldw_s r2,[r13]
L_8fbefa:
	lsr r3,r2,0x4
L_8fbefe:
	bmsk_s r3,r3,0x3
L_8fbf00:
	cmp_s r3,0x1
L_8fbf02:
	cmp.ne r3,0xa
L_8fbf06:
	bne_s L_8fbf26
L_8fbf08:
	mov_s r1,0x100de00
L_8fbf0e:
	lsr_s r2,r2,0x2
L_8fbf10:
	mov_s r0,0x2b
L_8fbf12:
	bl.d L_8dcc80
L_8fbf16:
	bmsk_s r2,r2,0x1
L_8fbf18:
	ldw_s r2,[r14,0x6]
L_8fbf1a:
	mov_s r0,r14
L_8fbf1c:
	mov_s r1,r13
L_8fbf1e:
	bl.d L_8f3ba4
L_8fbf22:
	mov_s r3,r18
L_8fbf24:
	b_s L_8fbf76
	.global L_8fbf26
L_8fbf26:
	mov_s r1,0x100dd38
L_8fbf2c:
	ldw_s r0,[r14,0x2]
L_8fbf2e:
	ldw_s r3,[r14]
L_8fbf30:
	asl_s r0,r0,0x10
L_8fbf32:
	or_s r3,r3,r0
L_8fbf34:
	mov_s r0,0x1b
L_8fbf36:
	bl.d L_8dcc80
L_8fbf3a:
	ldw_s r2,[r14,0x4]
L_8fbf3c:
	ldw_s r0,[r13]
L_8fbf3e:
	lsr_s r0,r0,0x4
L_8fbf40:
	bmsk_s r0,r0,0x3
L_8fbf42:
	breq r0,0x5,L_8fbf5c
L_8fbf46:
	mov r4,0x38e50
L_8fbf4e:
	mov_s r0,r14
L_8fbf50:
	mov_s r1,r18
L_8fbf52:
	mov_s r2,r13
L_8fbf54:
	bl.d L_8e577c
L_8fbf58:
	ldw_s r3,[r14,0x6]
L_8fbf5a:
	b_s L_8fbf76
	.global L_8fbf5c
L_8fbf5c:
	mov_s r1,0x100de38
L_8fbf62:
	bl.d L_8dcba8
L_8fbf66:
	mov_s r0,0x17
L_8fbf68:
	mov_s r0,0x0
L_8fbf6a:
	bl.d L_8f8e50
L_8fbf6e:
	mov_s r1,r18
L_8fbf70:
	bl.d L_8cb10c
L_8fbf74:
	mov_s r0,r13
	.global L_8fbf76
L_8fbf76:
	b L_8c0234
L_8fbf7a:
	nop_s
