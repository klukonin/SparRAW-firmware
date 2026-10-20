/* find_main_sm__bf_ntf @ 0x8e9e60, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::bf_ntf() status %d
 *   bf_ntf:: Pending probe resp, ignore this bf event <%d>...
 *   find_main_sm.cpp
 *   bf_ntf:: send probe_req with bcast BSSID...ssid_len= %d <%d>
 *   FIND_SM:: BF with FAIL status = %d
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, fw_log__emit2, fw_read_timer, fw_sysassert_fatal, memcpy_fw, mgmt_tx__build_probe_req, mid__copy_ssid, tx_api__send_mgmt
 */
	.section .text.find_main_sm__bf_ntf,"ax",@progbits
	.global find_main_sm__bf_ntf
find_main_sm__bf_ntf:
	.byte 0x0f
	.byte 0xeb
	.global fwlog_bf_ntf_send_probe_req_with_bcast_BSSID_s
fwlog_bf_ntf_send_probe_req_with_bcast_BSSID_s:
L_8e9e62:
	nop_s
L_8e9e64:
	push_s blink
L_8e9e66:
	bl L_8c02b0
L_8e9e6a:
	sub_s sp,sp,0x24
L_8e9e6c:
	mov_s r16,r0
L_8e9e6e:
	mov_s r13,r1
L_8e9e70:
	mov_s r14,r2
L_8e9e72:
	mov_s r2,0x1014af0
L_8e9e78:
	mov_s r0,0xc
L_8e9e7a:
	mov_s r1,0x2
L_8e9e7c:
	bl.d L_8edfcc
L_8e9e80:
	mov_s r3,r14
L_8e9e82:
	brne r14,0x0,L_8e9f54
L_8e9e86:
	ldb_s r15,[r13,0x8]
L_8e9e88:
	mov_s r0,0x0
L_8e9e8a:
	brge.d r15,0x8,L_8e9ebc
L_8e9e8e:
	st_s r0,[sp,0x20]
	.global L_8e9e90
L_8e9e90:
	add r0,r16,0x20
L_8e9e94:
	add r17,r0,r15
L_8e9e98:
	ldb r0,[r17, 0xc]
L_8e9e9c:
	breq r0,0x8,L_8e9ed4
L_8e9ea0:
	bl L_8e4694
L_8e9ea4:
	mov_s r2,0x1014b14
L_8e9eaa:
	mov_s r3,r0
L_8e9eac:
	mov_s r0,0xc
L_8e9eae:
	bl.d L_8edfcc
L_8e9eb2:
	mov_s r1,0x2
L_8e9eb4:
	mov_s r1,0x8
L_8e9eb6:
	stb r1,[r17, 0xc]
L_8e9eba:
	b_s L_8e9f64
	.global L_8e9ebc
L_8e9ebc:
	mov_s r0,blink
L_8e9ebe:
	mov_s r2,0x101478c
L_8e9ec4:
	mov_s r1,0x1474
L_8e9eca:
	bl.d L_8c82c0
L_8e9ece:
	mov r3,0x1ce
L_8e9ed2:
	b_s L_8e9e90
	.global L_8e9ed4
L_8e9ed4:
	bl.d L_8c2c80
L_8e9ed8:
	mov r19,sp
L_8e9edc:
	mov_s r14,r0
L_8e9ede:
	ld r0,[r16, 0x34]
L_8e9ee2:
	ld_s r0,[r0,0x6c]
L_8e9ee4:
	add_s r0,r0,0x48
L_8e9ee6:
	bl.d L_8ca928
L_8e9eea:
	mov_s r1,r19
L_8e9eec:
	mov_s r18,r0
L_8e9eee:
	add_s r1,sp,0x20
L_8e9ef0:
	ld r2,[r16, 0x34]
L_8e9ef4:
	mov_s r0,r14
L_8e9ef6:
	ld_s r2,[r2,0x6c]
L_8e9ef8:
	mov_s r3,r13
L_8e9efa:
	mov r4,r19
L_8e9efe:
	bl.d L_8f1e78
L_8e9f02:
	mov r5,r18
L_8e9f06:
	add r1,r13,0x10
L_8e9f0a:
	add_s r0,r14,0x4
L_8e9f0c:
	bl.d L_8c0460
L_8e9f10:
	mov_s r2,0x6
L_8e9f12:
	mov_s r0,0xff
L_8e9f14:
	stb_s r0,[r14,0x10]
L_8e9f16:
	stb_s r0,[r14,0x11]
L_8e9f18:
	stb_s r0,[r14,0x12]
L_8e9f1a:
	stb_s r0,[r14,0x13]
L_8e9f1c:
	stb_s r0,[r14,0x14]
L_8e9f1e:
	bl.d L_8e4694
L_8e9f22:
	stb_s r0,[r14,0x15]
L_8e9f24:
	mov_s r4,r0
L_8e9f26:
	mov_s r2,0x1014b50
L_8e9f2c:
	mov_s r0,0xc
L_8e9f2e:
	mov_s r1,0x2
L_8e9f30:
	bl.d L_8edff8
L_8e9f34:
	mov_s r3,r18
L_8e9f36:
	stb r15,[r17, 0xc]
L_8e9f3a:
	ldw r4,[sp, 0x20]
L_8e9f3e:
	mov_s r0,r13
L_8e9f40:
	mov_s r1,0x1
L_8e9f42:
	mov_s r2,r1
L_8e9f44:
	mov_s r3,r14
L_8e9f46:
	mov r5,0x0
L_8e9f4a:
	bl.d L_8e0c44
L_8e9f4e:
	mov r6,r5
L_8e9f52:
	b_s L_8e9f64
	.global L_8e9f54
L_8e9f54:
	mov_s r2,0x1014b90
L_8e9f5a:
	mov_s r0,0xc
L_8e9f5c:
	mov_s r1,0x2
L_8e9f5e:
	bl.d L_8edfcc
L_8e9f62:
	mov_s r3,r14
	.global L_8e9f64
L_8e9f64:
	b.d L_8c030c
