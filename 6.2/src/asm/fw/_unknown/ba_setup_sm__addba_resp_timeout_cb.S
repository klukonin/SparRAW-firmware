/* ba_setup_sm__addba_resp_timeout_cb @ 0x8f0b60, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ADDBA RESP - status %d, w-size %d. timeout %d
 *   ADDBA RESP  - a_msdu %d,  bapolicy %d
 *   ADDBA RESP- reduce window size to %d (asked for %d
 *   ba_setup_sm::addba_resp_timeout_cb()
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, ba_setup_sm__close_addba_resp_timeout, ba_setup_sm__close_ba_setup_global_timeout, basic_sm__handle_event, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__addba_resp_timeout_cb
ba_setup_sm__addba_resp_timeout_cb:
	.global L_8f0b60
L_8f0b60:
	push_s blink
L_8f0b62:
	bl L_8c01e4
L_8f0b66:
	mov_s r13,r0
L_8f0b68:
	bl.d L_8f1bd8
L_8f0b6c:
	mov_s r14,r1
L_8f0b6e:
	mov_s r1,0x1013734
L_8f0b74:
	ldb_s r0,[r14,0x4]
L_8f0b76:
	ldb_s r2,[r14,0x3]
L_8f0b78:
	asl_s r0,r0,0x8
L_8f0b7a:
	or_s r2,r2,r0
L_8f0b7c:
	ldb_s r0,[r14,0x6]
L_8f0b7e:
	ldb_s r3,[r14,0x5]
L_8f0b80:
	asl_s r0,r0,0x8
L_8f0b82:
	or_s r3,r3,r0
L_8f0b84:
	lsr_s r3,r3,0x6
L_8f0b86:
	bmsk_s r3,r3,0x9
L_8f0b88:
	ldb_s r0,[r14,0x8]
L_8f0b8a:
	ldb r4,[r14, 0x7]
L_8f0b8e:
	asl_s r0,r0,0x8
L_8f0b90:
	or r4,r4,r0
L_8f0b94:
	bl.d L_8dcd00
L_8f0b98:
	mov_s r0,0x27
L_8f0b9a:
	ldb_s r1,[r13,0x9]
L_8f0b9c:
	ldb_s r0,[r14,0x2]
L_8f0b9e:
	brne r1,r0,L_8f0c16
L_8f0ba2:
	ldb_s r2,[r14,0x5]
L_8f0ba4:
	mov_s r1,0x1013764
L_8f0baa:
	lsr_s r3,r2
L_8f0bac:
	mov_s r0,0x27
L_8f0bae:
	bmsk_s r2,r2,0x0
L_8f0bb0:
	bl.d L_8dcc80
L_8f0bb4:
	bmsk_s r3,r3,0x0
L_8f0bb6:
	ldb_s r0,[r14,0x6]
L_8f0bb8:
	ldb_s r2,[r14,0x5]
L_8f0bba:
	asl_s r0,r0,0x8
L_8f0bbc:
	or_s r2,r2,r0
L_8f0bbe:
	lsr_s r2,r2,0x6
L_8f0bc0:
	ldb_s r3,[r13,0x18]
L_8f0bc2:
	bmsk_s r2,r2,0x9
L_8f0bc4:
	brge r2,r3,L_8f0bd4
L_8f0bc8:
	mov_s r1,0x101378c
L_8f0bce:
	bl.d L_8dcc80
L_8f0bd2:
	mov_s r0,0x27
	.global L_8f0bd4
L_8f0bd4:
	ldb_s r1,[r14,0x6]
L_8f0bd6:
	ldb_s r0,[r14,0x5]
L_8f0bd8:
	asl_s r1,r1,0x8
L_8f0bda:
	or_s r0,r0,r1
L_8f0bdc:
	lsr_s r0,r0,0x6
L_8f0bde:
	bmsk_s r0,r0,0x9
L_8f0be0:
	stb_s r0,[r13,0x19]
L_8f0be2:
	ldb_s r0,[r14,0x8]
L_8f0be4:
	ldb_s r1,[r14,0x7]
L_8f0be6:
	asl_s r0,r0,0x8
L_8f0be8:
	or_s r1,r1,r0
L_8f0bea:
	stw_s r1,[r13,0x1e]
L_8f0bec:
	ldb_s r0,[r14,0x5]
L_8f0bee:
	bmsk_s r0,r0,0x0
L_8f0bf0:
	stb_s r0,[r13,0x1b]
L_8f0bf2:
	ldb_s r0,[r14,0x4]
L_8f0bf4:
	ldb_s r1,[r14,0x3]
L_8f0bf6:
	asl_s r0,r0,0x8
L_8f0bf8:
	or_s r1,r1,r0
L_8f0bfa:
	cmp_s r1,0x0
L_8f0bfc:
	mov_s r0,r13
L_8f0bfe:
	mov.ne r1,0x9
L_8f0c02:
	bne_s L_8f0c0c
L_8f0c04:
	bl L_8f1bfc
L_8f0c08:
	mov_s r0,r13
L_8f0c0a:
	mov_s r1,0x8
	.global L_8f0c0c
L_8f0c0c:
	mov_s r2,0x0
L_8f0c0e:
	mov_s r3,r2
L_8f0c10:
	bl.d L_8d9b6c
L_8f0c14:
	mov_s r4,r2
	.global L_8f0c16
L_8f0c16:
	b L_8c0254
L_8f0c1a:
	nop_s
L_8f0c1c:
	push_s blink
L_8f0c1e:
	push_s r13
L_8f0c20:
	mov_s r13,r0
L_8f0c22:
	mov_s r1,0x1013834
L_8f0c28:
	bl.d L_8dcba8
L_8f0c2c:
	mov_s r0,0x25
L_8f0c2e:
	breq_s r13,0,L_8f0c44
	.global L_8f0c30
L_8f0c30:
	mov_s r2,0x0
L_8f0c32:
	st_s r2,[r13,0xc]
L_8f0c34:
	mov_s r0,r13
L_8f0c36:
	mov_s r1,0x6
L_8f0c38:
	mov_s r3,r2
L_8f0c3a:
	bl.d L_8d9b6c
L_8f0c3e:
	mov_s r4,r2
L_8f0c40:
	b L_8c025c
	.global L_8f0c44
L_8f0c44:
	mov_s r0,blink
L_8f0c46:
	mov_s r1,0x1539
L_8f0c4c:
	bl L_8c9b28
L_8f0c50:
	b_s L_8f0c30
L_8f0c52:
	nop_s
