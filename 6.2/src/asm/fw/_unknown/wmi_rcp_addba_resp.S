/* wmi_rcp_addba_resp @ 0x8ecbe8, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_RCP_ADDBA_RESP_SENT_EVENTID for devid %d. WMI_FW_STATUS_FAILURE
 *   WMI ADDBA RESP send: tid %d wsize %d, token %d
 *   <<---- [HOST EVENT] WMI_RCP_ADDBA_RESP_SENT_EVENTID for devid %d. WMI_FW_STATUS_SUCCESS
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r20_to_r13_ret, __st_r20_to_r13, conn_mgr__by_cid, frame__build_addba_resp, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, host_if__send_pair, install_key__parse_flags, low_sme__send_evt2sw, mgmt_tx__begin_frame
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_rcp_addba_resp
wmi_rcp_addba_resp:
	.global L_8ecbe8
L_8ecbe8:
	push_s blink
L_8ecbea:
	bl L_8c01cc
L_8ecbee:
	sub_s sp,sp,0x4
L_8ecbf0:
	mov_s r13,r0
L_8ecbf2:
	bl.d L_8c3414
L_8ecbf6:
	mov_s r18,r1
L_8ecbf8:
	mov_s r14,r0
L_8ecbfa:
	ldb r16,[r13]
L_8ecbfe:
	bl.d L_8cbffc
L_8ecc02:
	bmsk r0,r16,0x3
L_8ecc06:
	mov.f r15,r0
L_8ecc0a:
	asr r17,r16,0x4
L_8ecc0e:
	bne_s L_8ecc4a
L_8ecc10:
	bl L_8c32d8
L_8ecc14:
	mov_s r14,r0
L_8ecc16:
	ldb_s r0,[r13]
L_8ecc18:
	mov_s r1,0x1007a24
L_8ecc1e:
	stb_s r0,[r14]
L_8ecc20:
	mov_s r0,0x1
L_8ecc22:
	stw_s r0,[r14,0x2]
L_8ecc24:
	mov_s r0,0x2b
L_8ecc26:
	bl.d L_8dcc10
L_8ecc2a:
	mov_s r2,r18
L_8ecc2c:
	mov_s r0,r14
L_8ecc2e:
	mov_s r1,0x1825
L_8ecc34:
	mov_s r2,0x4
L_8ecc36:
	mov_s r3,r18
L_8ecc38:
	mov r4,0x0
L_8ecc3c:
	mov r5,r4
L_8ecc40:
	bl.d L_8e5474
L_8ecc44:
	mov r6,r4
L_8ecc48:
	b_s L_8ecd0a
	.global L_8ecc4a
L_8ecc4a:
	bl.d L_8cc3dc
L_8ecc4e:
	mov_s r0,r18
L_8ecc50:
	mov.f r20,r0
L_8ecc54:
	beq_s L_8ecd10
	.global L_8ecc56
L_8ecc56:
	mov_s r0,0x0
L_8ecc58:
	mov_s r19,r0
L_8ecc5a:
	st_s r0,[sp,0x0]
L_8ecc5c:
	mov_s r1,sp
L_8ecc5e:
	mov_s r0,r14
L_8ecc60:
	mov_s r2,r20
L_8ecc62:
	mov_s r3,r15
L_8ecc64:
	bl.d L_8e9c7c
L_8ecc68:
	mov r4,0xd
L_8ecc6c:
	ldw_s r3,[r13,0x4]
L_8ecc6e:
	mov_s r1,0x1007a7c
L_8ecc74:
	lsr_s r3,r3,0x6
L_8ecc76:
	ldb r4,[r13, 0x1]
L_8ecc7a:
	mov_s r0,0x23
L_8ecc7c:
	bl.d L_8dcd00
L_8ecc80:
	bmsk r2,r17,0x3
L_8ecc84:
	ld_s r0,[sp,0x0]
L_8ecc86:
	ldw r6,[r13, 0x4]
L_8ecc8a:
	add_s r0,r0,r14
L_8ecc8c:
	ldw r4,[r13, 0x6]
L_8ecc90:
	lsr r2,r6,0x6
L_8ecc94:
	ldw r5,[r13, 0x2]
L_8ecc98:
	bmsk r3,r17,0x3
L_8ecc9c:
	ldb_s r1,[r13,0x1]
L_8ecc9e:
	bl.d L_8f4e30
L_8ecca2:
	bmsk r6,r6,0x0
L_8ecca6:
	ld_s r1,[sp,0x0]
L_8ecca8:
	mov_s r2,0x1
L_8eccaa:
	add_s r0,r0,r1
L_8eccac:
	st_s r0,[sp,0x0]
L_8eccae:
	extw r4,r0
L_8eccb2:
	mov_s r0,r15
L_8eccb4:
	mov_s r1,r19
L_8eccb6:
	mov_s r3,r14
L_8eccb8:
	mov r5,r19
L_8eccbc:
	bl.d L_8e5874
L_8eccc0:
	mov r6,r19
L_8eccc4:
	bl L_8c32d8
L_8eccc8:
	mov_s r14,r0
L_8eccca:
	ldb_s r0,[r13]
L_8ecccc:
	stw r19,[r14, 0x2]
L_8eccd0:
	stb_s r0,[r14]
L_8eccd2:
	mov_s r1,0x1007aac
L_8eccd8:
	mov_s r0,0x2b
L_8eccda:
	bl.d L_8dcc10
L_8eccde:
	mov_s r2,r18
L_8ecce0:
	mov_s r0,r14
L_8ecce2:
	mov_s r1,0x1825
L_8ecce8:
	mov_s r2,0x4
L_8eccea:
	mov_s r3,r18
L_8eccec:
	mov r4,0x0
L_8eccf0:
	mov r5,0x0
L_8eccf4:
	bl.d L_8e5474
L_8eccf8:
	mov r6,0x0
L_8eccfc:
	bmsk r0,r16,0x3
L_8ecd00:
	bmsk r1,r17,0x3
L_8ecd04:
	bl.d L_8df9a4
L_8ecd08:
	mov_s r2,0x2
	.global L_8ecd0a
L_8ecd0a:
	b.d L_8c0224
L_8ecd0e:
	add_s sp,sp,0x4
	.global L_8ecd10
L_8ecd10:
	mov_s r0,blink
L_8ecd12:
	mov_s r1,0x6e
L_8ecd14:
	bl.d L_8c9b28
L_8ecd18:
	bset_s r1,r1,0xc
L_8ecd1a:
	b_s L_8ecc56
