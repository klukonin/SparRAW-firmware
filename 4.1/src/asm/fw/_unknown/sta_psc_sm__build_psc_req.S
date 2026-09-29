/* sta_psc_sm__build_psc_req @ 0x8e0e3c, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending PSC REQ. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 *   Sending PSC REQ. Token:%d
 *   Sending PSC REQ. TSF:0x%08x %08x
 * Зовут его: sta_psc_sm__send_psc_req_flow_sm
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r17_to_r13_ret, __st_r17_to_r13, frame__build_psc_req, fw_log__emit1, fw_log__emit2, fw_log__emit3, mac_read_tsf64, mgmt_tx__begin_frame, tx_api__send_mgmt
 */
	.section .text.sta_psc_sm__build_psc_req,"ax",@progbits
	.global sta_psc_sm__build_psc_req
sta_psc_sm__build_psc_req:
	.global L_8e0e3c
L_8e0e3c:
	push_s blink
L_8e0e3e:
	bl L_8c02b8
L_8e0e42:
	sub_s sp,sp,0xc
L_8e0e44:
	bl.d L_8c2c80
L_8e0e48:
	mov_s r13,r0
L_8e0e4a:
	mov_s r15,r0
L_8e0e4c:
	mov_s r0,0x0
L_8e0e4e:
	mov_s r16,r0
L_8e0e50:
	st_s r0,[sp,0x0]
L_8e0e52:
	ld_s r0,[r13,0x38]
L_8e0e54:
	mov_s r1,sp
L_8e0e56:
	ld r3,[r0, 0x8c]
L_8e0e5a:
	mov_s r0,r15
L_8e0e5c:
	ld_s r2,[r3,0xc]
L_8e0e5e:
	bl.d L_8e4be4
L_8e0e62:
	mov r4,0xd
L_8e0e66:
	ld_s r0,[sp,0x0]
L_8e0e68:
	add r14,r13,0x20
L_8e0e6c:
	ldb_s r1,[r14,0x14]
L_8e0e6e:
	add_s r0,r0,r15
L_8e0e70:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e0e72:
	extb_s r1,r1
L_8e0e74:
	add3 r17,r13,0x8
L_8e0e78:
	ld r4,[r13, 0x40]
L_8e0e7c:
	stb_s r1,[r14,0x14]
L_8e0e7e:
	ldb r2,[r17, 0x4]
L_8e0e82:
	bl.d L_8ecbd4
L_8e0e86:
	ld_s r3,[r13,0x3c]
L_8e0e88:
	ld_s r1,[sp,0x0]
L_8e0e8a:
	mov_s r2,0x1002e84
L_8e0e90:
	add_s r0,r0,r1
L_8e0e92:
	st_s r0,[sp,0x0]
L_8e0e94:
	ldw r4,[r17, 0x2]
L_8e0e98:
	mov_s r0,0xe
L_8e0e9a:
	ldw r5,[r17]
L_8e0e9e:
	mov_s r1,0x2
L_8e0ea0:
	bl.d L_8ee034
L_8e0ea4:
	ld_s r3,[r13,0x3c]
L_8e0ea6:
	mov_s r2,0x1002ed0
L_8e0eac:
	mov_s r0,0xe
L_8e0eae:
	mov_s r1,0x2
L_8e0eb0:
	bl.d L_8edfcc
L_8e0eb4:
	ldb_s r3,[r14,0x14]
L_8e0eb6:
	add_s r1,sp,0x4
L_8e0eb8:
	mov_s r0,r16
L_8e0eba:
	bl.d L_8e4840
L_8e0ebe:
	mov_s r2,r16
L_8e0ec0:
	mov_s r2,0x1002eec
L_8e0ec6:
	ld r4,[sp, 0x4]
L_8e0eca:
	mov_s r0,0xe
L_8e0ecc:
	mov_s r1,0x2
L_8e0ece:
	bl.d L_8edff8
L_8e0ed2:
	ld_s r3,[sp,0x8]
L_8e0ed4:
	ld_s r0,[r13,0x38]
L_8e0ed6:
	mov r5,0x1d8ac
L_8e0ede:
	ldw r4,[sp]
L_8e0ee2:
	mov_s r1,r16
L_8e0ee4:
	ld r0,[r0, 0x8c]
L_8e0ee8:
	mov_s r2,0x1
L_8e0eea:
	mov_s r3,r15
L_8e0eec:
	bl.d L_8e0c44
L_8e0ef0:
	mov r6,0x0
L_8e0ef4:
	ldb_s r0,[r14,0x15]
L_8e0ef6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e0ef8:
	extb_s r0,r0
L_8e0efa:
	stb_s r0,[r14,0x15]
L_8e0efc:
	b.d L_8c031c
L_8e0f00:
	add_s sp,sp,0xc
L_8e0f02:
	nop_s
