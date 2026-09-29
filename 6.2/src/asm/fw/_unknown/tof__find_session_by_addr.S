/* tof__find_session_by_addr @ 0x8e1df8, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] FTM Session for: ADDR-%04X%08X
 * Зовут его: tof_mgr__ftm_req_handle, tof_mgr__ftm_req_handle_8cb350
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, ftm__session_step, ftm_mngr, fw_log_emit2, radio_mgr__get_current_channel, tof__alloc_session
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof__find_session_by_addr
tof__find_session_by_addr:
	.global L_8e1df8
L_8e1df8:
	push_s blink
L_8e1dfa:
	bl L_8c01d4
L_8e1dfe:
	sub_s sp,sp,0x4
L_8e1e00:
	mov_s r14,r0
L_8e1e02:
	mov_s r17,r1
L_8e1e04:
	mov_s r16,r2
L_8e1e06:
	bl.d L_8cc130
L_8e1e0a:
	mov_s r0,sp
L_8e1e0c:
	mov r18,0x0
L_8e1e10:
	b_s L_8e1e16
	.global L_8e1e12
L_8e1e12:
	add r18,r18,0x1
	.global L_8e1e16
L_8e1e16:
	brhs r18,0x4,L_8e1e92
L_8e1e1a:
	ldw r0,[r17, 0x6]
L_8e1e1e:
	brlt.d r0,0x1,L_8e1e12
L_8e1e22:
	mov_s r15,0x0
	.global L_8e1e24
L_8e1e24:
	asl_s r13,r15,0x4
L_8e1e26:
	ldb.a r0,[r13,r16]
L_8e1e2a:
	brne r0,r18,L_8e1e86
L_8e1e2e:
	mov_s r1,0x10197e8
L_8e1e34:
	ldw_s r0,[r13,0xa]
L_8e1e36:
	ldw_s r3,[r13,0x8]
L_8e1e38:
	asl_s r0,r0,0x10
L_8e1e3a:
	or_s r3,r3,r0
L_8e1e3c:
	mov_s r0,0x29
L_8e1e3e:
	bl.d L_8dcc80
L_8e1e42:
	ldw_s r2,[r13,0xc]
L_8e1e44:
	mov_s r0,r14
L_8e1e46:
	mov_s r1,r14
L_8e1e48:
	bl.d L_8e4bc8
L_8e1e4c:
	add r2,r13,0x8
L_8e1e50:
	brne_s r0,0,L_8e1e60
L_8e1e52:
	add r1,r14,0xc
L_8e1e56:
	mov_s r0,r14
L_8e1e58:
	bl.d L_8e4bc8
L_8e1e5c:
	add r2,r13,0x8
	.global L_8e1e60
L_8e1e60:
	brne_s r0,0,L_8e1e86
L_8e1e62:
	bl.d L_8c3340
L_8e1e66:
	mov_s r0,r14
L_8e1e68:
	mov_s r2,r0
L_8e1e6a:
	ld r0,[r17]
L_8e1e6e:
	asl_s r3,r15,0x4
L_8e1e70:
	stb_s r0,[r2,0x1c]
L_8e1e72:
	ldb r0,[r17, 0x5]
L_8e1e76:
	add_s r3,r3,r16
L_8e1e78:
	st_s r0,[r2,0x18]
L_8e1e7a:
	mov_s r0,r14
L_8e1e7c:
	bl.d L_8c2a30
L_8e1e80:
	mov_s r1,r14
L_8e1e82:
	mov_s r0,0x4
L_8e1e84:
	stb_s r0,[r13]
	.global L_8e1e86
L_8e1e86:
	ldw r0,[r17, 0x6]
L_8e1e8a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8e1e8c:
	brlt r15,r0,L_8e1e24
L_8e1e90:
	b_s L_8e1e12
	.global L_8e1e92
L_8e1e92:
	b.d L_8c0234
L_8e1e96:
	add_s sp,sp,0x4
