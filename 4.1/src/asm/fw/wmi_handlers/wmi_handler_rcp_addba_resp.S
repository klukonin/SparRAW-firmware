/* wmi_handler_rcp_addba_resp @ 0x8e7bf0, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_RCP_ADDBA_RESP_SENT_EVENTID for devid %d. WMI_FW_STATUS_FAILURE
 *   WMI ADDBA RESP send: tid %d wsize %d, token %d
 *   <<---- [HOST EVENT] WMI_RCP_ADDBA_RESP_SENT_EVENTID for devid %d. WMI_FW_STATUS_SUCCESS
 *   wmi_handlers.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r20_to_r13_ret, __st_r20_to_r13, conn_mgr__by_cid, frame__build_addba_resp, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, mac_parser__set_ba_rule, mgmt_tx__begin_frame, mid_list__by_mid, operational_if__alloc_evt
 */
	.section .text.wmi_handler_rcp_addba_resp,"ax",@progbits
	.global wmi_handler_rcp_addba_resp
wmi_handler_rcp_addba_resp:
	.global L_8e7bf0
L_8e7bf0:
	push_s blink
L_8e7bf2:
	bl L_8c02ac
L_8e7bf6:
	sub_s sp,sp,0x4
L_8e7bf8:
	mov_s r13,r0
L_8e7bfa:
	bl.d L_8c2c80
L_8e7bfe:
	mov_s r18,r1
L_8e7c00:
	mov_s r14,r0
L_8e7c02:
	ldb r16,[r13]
L_8e7c06:
	bl.d L_8c9e44
L_8e7c0a:
	bmsk r0,r16,0x3
L_8e7c0e:
	mov.f r15,r0
L_8e7c12:
	asr r17,r16,0x4
L_8e7c16:
	bne_s L_8e7c50
L_8e7c18:
	bl L_8c2b68
L_8e7c1c:
	mov_s r14,r0
L_8e7c1e:
	ldb_s r0,[r13]
L_8e7c20:
	mov_s r2,0x100702c
L_8e7c26:
	stb_s r0,[r14]
L_8e7c28:
	mov_s r0,0x1
L_8e7c2a:
	stw_s r0,[r14,0x2]
L_8e7c2c:
	mov_s r0,0xb
L_8e7c2e:
	mov_s r1,0x2
L_8e7c30:
	bl.d L_8edfcc
L_8e7c34:
	mov_s r3,r18
L_8e7c36:
	mov_s r0,r14
L_8e7c38:
	mov_s r1,0x1825
L_8e7c3e:
	mov_s r2,0x4
L_8e7c40:
	mov_s r3,r18
L_8e7c42:
	mov r4,0x0
L_8e7c46:
	bl.d L_8e0874
L_8e7c4a:
	mov r5,r4
L_8e7c4e:
	b_s L_8e7d12
	.global L_8e7c50
L_8e7c50:
	bl.d L_8ca1b0
L_8e7c54:
	mov_s r0,r18
L_8e7c56:
	mov.f r20,r0
L_8e7c5a:
	beq_s L_8e7d18
	.global L_8e7c5c
L_8e7c5c:
	mov_s r0,0x0
L_8e7c5e:
	mov_s r19,r0
L_8e7c60:
	st_s r0,[sp,0x0]
L_8e7c62:
	mov_s r1,sp
L_8e7c64:
	mov_s r0,r14
L_8e7c66:
	mov_s r2,r20
L_8e7c68:
	mov_s r3,r15
L_8e7c6a:
	bl.d L_8e4be4
L_8e7c6e:
	mov r4,0xd
L_8e7c72:
	ldw_s r0,[r13,0x4]
L_8e7c74:
	mov_s r2,0x1007084
L_8e7c7a:
	lsr r4,r0,0x6
L_8e7c7e:
	ldb r5,[r13, 0x1]
L_8e7c82:
	mov_s r0,0x3
L_8e7c84:
	mov_s r1,0x2
L_8e7c86:
	bl.d L_8ee034
L_8e7c8a:
	bmsk r3,r17,0x3
L_8e7c8e:
	ld_s r0,[sp,0x0]
L_8e7c90:
	ldw r6,[r13, 0x4]
L_8e7c94:
	add_s r0,r0,r14
L_8e7c96:
	ldw r4,[r13, 0x6]
L_8e7c9a:
	lsr r2,r6,0x6
L_8e7c9e:
	ldw r5,[r13, 0x2]
L_8e7ca2:
	bmsk r3,r17,0x3
L_8e7ca6:
	ldb_s r1,[r13,0x1]
L_8e7ca8:
	bl.d L_8ec664
L_8e7cac:
	bmsk r6,r6,0x0
L_8e7cb0:
	ld_s r1,[sp,0x0]
L_8e7cb2:
	mov_s r2,0x1
L_8e7cb4:
	add_s r0,r0,r1
L_8e7cb6:
	st_s r0,[sp,0x0]
L_8e7cb8:
	extw r4,r0
L_8e7cbc:
	mov_s r0,r15
L_8e7cbe:
	mov_s r1,r19
L_8e7cc0:
	mov_s r3,r14
L_8e7cc2:
	mov r5,r19
L_8e7cc6:
	bl.d L_8e0c44
L_8e7cca:
	mov r6,r19
L_8e7cce:
	bl L_8c2b68
L_8e7cd2:
	mov_s r14,r0
L_8e7cd4:
	ldb_s r0,[r13]
L_8e7cd6:
	stw r19,[r14, 0x2]
L_8e7cda:
	stb_s r0,[r14]
L_8e7cdc:
	mov_s r2,0x10070b4
L_8e7ce2:
	mov_s r0,0xb
L_8e7ce4:
	mov_s r1,0x2
L_8e7ce6:
	bl.d L_8edfcc
L_8e7cea:
	mov_s r3,r18
L_8e7cec:
	mov_s r0,r14
L_8e7cee:
	mov_s r1,0x1825
L_8e7cf4:
	mov_s r2,0x4
L_8e7cf6:
	mov_s r3,r18
L_8e7cf8:
	mov r4,0x0
L_8e7cfc:
	bl.d L_8e0874
L_8e7d00:
	mov r5,0x0
L_8e7d04:
	bmsk r0,r16,0x3
L_8e7d08:
	bmsk r1,r17,0x3
L_8e7d0c:
	bl.d L_8db898
L_8e7d10:
	mov_s r2,0x2
	.global L_8e7d12
L_8e7d12:
	b.d L_8c0304
L_8e7d16:
	add_s sp,sp,0x4
	.global L_8e7d18
L_8e7d18:
	mov_s r0,blink
L_8e7d1a:
	mov_s r2,0x100710c
L_8e7d20:
	mov_s r1,0x6e
L_8e7d22:
	bset_s r1,r1,0xc
L_8e7d24:
	bl.d L_8c82c0
L_8e7d28:
	mov_s r3,0x4b
L_8e7d2a:
	b_s L_8e7c5c
