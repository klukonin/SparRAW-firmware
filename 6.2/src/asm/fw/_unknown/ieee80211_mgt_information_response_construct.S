/* ieee80211_mgt_information_response_construct @ 0x8d7e78, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Send Information Response to ADDR-%04X%08X
 *   ieee80211_mgt_information_response_construct() CID: %d,
 * Зовут его: stream_mgr__send_info_response
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit1, fw_log_emit2, hexdump_words, ie__push_dmg_capabilities, ie_list__first, memcpy_fw, mgmt_tx__begin_frame
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ieee80211_mgt_information_response_construct
ieee80211_mgt_information_response_construct:
	.global L_8d7e78
L_8d7e78:
	push_s blink
L_8d7e7a:
	bl.d L_8c01d0
L_8d7e7e:
	mov r4,0xd
L_8d7e82:
	mov_s r13,r0
L_8d7e84:
	add r18,r0,0x1
L_8d7e88:
	mov_s r17,r1
L_8d7e8a:
	mov_s r15,r2
L_8d7e8c:
	mov_s r19,r3
L_8d7e8e:
	mov_s r0,0x0
L_8d7e90:
	mov_s r16,r0
L_8d7e92:
	push_s r0
L_8d7e94:
	add r14,r2,0x1c
L_8d7e98:
	mov_s r1,sp
L_8d7e9a:
	mov_s r0,r13
L_8d7e9c:
	mov_s r2,r17
L_8d7e9e:
	bl.d L_8e9c7c
L_8d7ea2:
	mov_s r3,r15
L_8d7ea4:
	ldw_s r2,[r14,0x4]
L_8d7ea6:
	mov_s r1,0x1010140
L_8d7eac:
	mov_s r0,0x2b
L_8d7eae:
	bl.d L_8dcc80
L_8d7eb2:
	ld_s r3,[r14]
L_8d7eb4:
	ld_s r0,[sp,0x0]
L_8d7eb6:
	mov_s r1,0x10
L_8d7eb8:
	add_s r0,r0,r13
L_8d7eba:
	stb_s r1,[r0]
L_8d7ebc:
	mov_s r1,0x3
L_8d7ebe:
	stb_s r1,[r0,0x1]
L_8d7ec0:
	ld_s r0,[sp,0x0]
L_8d7ec2:
	mov_s r1,r19
L_8d7ec4:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8d7ec6:
	st_s r0,[sp,0x0]
L_8d7ec8:
	add_s r0,r0,r13
L_8d7eca:
	bl.d L_8c0380
L_8d7ece:
	mov_s r2,0x6
L_8d7ed0:
	ld_s r0,[sp,0x0]
L_8d7ed2:
	mov_s r1,r17
L_8d7ed4:
	/* add_s r0,0x6 */
	.byte 0x06,0xe0
L_8d7ed6:
	st_s r0,[sp,0x0]
L_8d7ed8:
	add r1,r1,0xa6
L_8d7edc:
	add_s r0,r0,r13
L_8d7ede:
	bl.d L_8e1fd4
L_8d7ee2:
	mov_s r2,r16
L_8d7ee4:
	ld_s r1,[sp,0x0]
L_8d7ee6:
	add_s r0,r0,r1
L_8d7ee8:
	st_s r0,[sp,0x0]
L_8d7eea:
	ld r0,[r17, 0x50]
L_8d7eee:
	cmp_s r0,0x2
L_8d7ef0:
	cmp.ne r0,0x3
L_8d7ef4:
	mov.ne r0,r16
L_8d7ef8:
	bne_s L_8d7efc
L_8d7efa:
	mov_s r0,0x1
	.global L_8d7efc
L_8d7efc:
	extb.f 0x0,r0
L_8d7f00:
	beq_s L_8d7f54
L_8d7f02:
	mov_s r15,0x0
L_8d7f04:
	b_s L_8d7f50
	.global L_8d7f06
L_8d7f06:
	mov_s r0,r17
L_8d7f08:
	bl.d L_8cbfc8
L_8d7f0c:
	mov_s r1,r15
L_8d7f0e:
	mov.f r14,r0
L_8d7f12:
	beq_s L_8d7f4e
L_8d7f14:
	ldb r0,[r14, 0xf0]
L_8d7f18:
	brne r0,0x2,L_8d7f4e
L_8d7f1c:
	mov_s r1,0x101016c
L_8d7f22:
	mov_s r0,0x2b
L_8d7f24:
	bl.d L_8dcc10
L_8d7f28:
	ldb_s r2,[r14,0x8]
L_8d7f2a:
	mov_s r19,r14
L_8d7f2c:
	add r19,r19,0x18f
L_8d7f30:
	mov_s r0,r19
L_8d7f32:
	bl.d L_8c9790
L_8d7f36:
	mov_s r1,0x13
L_8d7f38:
	ldb_s r2,[r14,0x8]
L_8d7f3a:
	ld_s r0,[sp,0x0]
L_8d7f3c:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8d7f3e:
	extb_s r2,r2
L_8d7f40:
	add_s r0,r0,r13
L_8d7f42:
	bl.d L_8e1fd4
L_8d7f46:
	mov_s r1,r19
L_8d7f48:
	ld_s r1,[sp,0x0]
L_8d7f4a:
	add_s r0,r0,r1
L_8d7f4c:
	st_s r0,[sp,0x0]
	.global L_8d7f4e
L_8d7f4e:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
	.global L_8d7f50
L_8d7f50:
	brlt r15,0x8,L_8d7f06
	.global L_8d7f54
L_8d7f54:
	ld_s r1,[sp,0x0]
L_8d7f56:
	mov_s r0,0xa
L_8d7f58:
	add_s r1,r1,r13
L_8d7f5a:
	stb_s r0,[r1]
L_8d7f5c:
	ld_s r0,[sp,0x0]
L_8d7f5e:
	add_s r0,r0,r18
L_8d7f60:
	stb r16,[r0]
L_8d7f64:
	ld_s r1,[sp,0x0]
L_8d7f66:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_8d7f68:
	st_s r1,[sp,0x0]
L_8d7f6a:
	bl.d L_8c9790
L_8d7f6e:
	mov_s r0,r13
L_8d7f70:
	ld_s r0,[sp,0x0]
L_8d7f72:
	b.d L_8c022c
L_8d7f76:
	add_s sp,sp,0x4
