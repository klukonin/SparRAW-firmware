/* sta_psc_sm__IDLE @ 0x8d9da4, 348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Received PSC RESP while sta_psc_sm::IDLE therefore IGNORING PSC RESP
 *   PSC RESP status:%d, dialog_token:%d. PSC REQ dialog_token:%d
 *   Received PSC RESP After PSC REQ sent
 *   PSC RESP parameters: bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 *   PSC RESP. Token:%d, Expected:%d, Retry:%d
 *   Received wrong dialog token:%d, expected:%d, Retry:%d
 *   [NNL] Retry:%d
 *   Received PSC RESP with bad status as follows:
 * Зовут его: ps_connection__psc_rsp_rx_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, fw_log_emit3, seq__in_window, sta_psc_sm__psc_resp_rx_wb_timeout_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__IDLE
sta_psc_sm__IDLE:
	.global L_8d9da4
L_8d9da4:
	push_s blink
L_8d9da6:
	bl L_8c01d4
L_8d9daa:
	add r13,r0,0x20
L_8d9dae:
	ldb_s r0,[r13,0x11]
L_8d9db0:
	ldb r18,[r13, 0x10]
L_8d9db4:
	sub r17,r0,0x1
L_8d9db8:
	ldb_s r0,[r13]
L_8d9dba:
	mov_s r14,r1
L_8d9dbc:
	extb r17,r17
L_8d9dc0:
	brne_s r0,0,L_8d9dea
L_8d9dc2:
	mov_s r1,0x10027c4
L_8d9dc8:
	bl.d L_8dcba8
L_8d9dcc:
	mov_s r0,0x2e
L_8d9dce:
	mov_s r1,0x100280c
L_8d9dd4:
	ldb_s r0,[r14,0x4]
L_8d9dd6:
	ldb_s r2,[r14,0x3]
L_8d9dd8:
	asl_s r0,r0,0x8
L_8d9dda:
	or_s r2,r2,r0
L_8d9ddc:
	ldb_s r3,[r14,0x2]
L_8d9dde:
	mov_s r0,0x2e
L_8d9de0:
	bl.d L_8dcd00
L_8d9de4:
	mov r4,r18
L_8d9de8:
	b_s L_8d9efc
	.global L_8d9dea
L_8d9dea:
	ldb_s r1,[r14,0x4]
L_8d9dec:
	ldb_s r0,[r14,0x3]
L_8d9dee:
	asl_s r1,r1,0x8
L_8d9df0:
	or_s r0,r0,r1
L_8d9df2:
	cmp_s r0,0x0
L_8d9df4:
	ldb_s r1,[r14,0x2]
L_8d9df6:
	mov_s r0,r13
L_8d9df8:
	bne_s L_8d9e76
L_8d9dfa:
	bl L_8da120
L_8d9dfe:
	breq_s r0,0,L_8d9e60
L_8d9e00:
	bl.d L_8c69ac
L_8d9e04:
	mov_s r0,r13
L_8d9e06:
	mov_s r1,0x100284c
L_8d9e0c:
	bl.d L_8dcba8
L_8d9e10:
	mov_s r0,0x2e
L_8d9e12:
	ldb_s r0,[r14,0x8]
L_8d9e14:
	ldb_s r2,[r14,0x7]
L_8d9e16:
	asl_s r0,r0,0x8
L_8d9e18:
	or_s r2,r2,r0
L_8d9e1a:
	ldb_s r0,[r14,0x9]
L_8d9e1c:
	mov_s r1,0x1002874
L_8d9e22:
	asl_s r0,r0,0x10
L_8d9e24:
	or_s r2,r2,r0
L_8d9e26:
	ldb_s r0,[r14,0xa]
L_8d9e28:
	ldb_s r3,[r14,0xd]
L_8d9e2a:
	asl_s r0,r0,0x18
L_8d9e2c:
	ldb_s r15,[r14,0xe]
L_8d9e2e:
	or_s r2,r2,r0
L_8d9e30:
	asl_s r15,r15,0x8
L_8d9e32:
	or_s r3,r3,r15
L_8d9e34:
	ldb_s r0,[r14,0xc]
L_8d9e36:
	ldb r4,[r14, 0xb]
L_8d9e3a:
	asl_s r0,r0,0x8
L_8d9e3c:
	or r4,r4,r0
L_8d9e40:
	bl.d L_8dcd00
L_8d9e44:
	mov_s r0,0x2e
L_8d9e46:
	mov_s r1,0x10028c4
L_8d9e4c:
	mov_s r0,0x2e
L_8d9e4e:
	ldb_s r2,[r14,0x2]
L_8d9e50:
	mov_s r3,r18
L_8d9e52:
	bl.d L_8dcd00
L_8d9e56:
	mov r4,r17
L_8d9e5a:
	mov_s r0,r13
L_8d9e5c:
	mov_s r1,0x2
L_8d9e5e:
	b_s L_8d9ec0
	.global L_8d9e60
L_8d9e60:
	mov_s r1,0x10028f0
L_8d9e66:
	mov_s r0,0x2e
L_8d9e68:
	ldb_s r2,[r14,0x2]
L_8d9e6a:
	mov_s r3,r18
L_8d9e6c:
	bl.d L_8dcd00
L_8d9e70:
	mov r4,r17
L_8d9e74:
	b_s L_8d9efc
	.global L_8d9e76
L_8d9e76:
	bl L_8da120
L_8d9e7a:
	mov r16,0x100280c
L_8d9e82:
	mov_s r15,0x1002928
L_8d9e88:
	breq_s r0,0,L_8d9ed0
L_8d9e8a:
	mov_s r1,0x1002938
L_8d9e90:
	bl.d L_8dcba8
L_8d9e94:
	mov_s r0,0x2e
L_8d9e96:
	ldb_s r0,[r14,0x4]
L_8d9e98:
	ldb_s r2,[r14,0x3]
L_8d9e9a:
	asl_s r0,r0,0x8
L_8d9e9c:
	or_s r2,r2,r0
L_8d9e9e:
	ldb_s r3,[r14,0x2]
L_8d9ea0:
	mov_s r0,0x2e
L_8d9ea2:
	mov_s r1,r16
L_8d9ea4:
	bl.d L_8dcd00
L_8d9ea8:
	mov r4,r18
L_8d9eac:
	mov_s r0,0x2e
L_8d9eae:
	mov_s r1,r15
L_8d9eb0:
	bl.d L_8dcc10
L_8d9eb4:
	mov_s r2,r17
L_8d9eb6:
	ldb_s r0,[r13,0x11]
L_8d9eb8:
	cmp_s r0,0x3
L_8d9eba:
	mov_s r0,r13
L_8d9ebc:
	blt_s L_8d9ecc
L_8d9ebe:
	mov_s r1,0x4
	.global L_8d9ec0
L_8d9ec0:
	mov_s r2,0x0
L_8d9ec2:
	mov_s r3,r2
L_8d9ec4:
	bl.d L_8d9b6c
L_8d9ec8:
	mov_s r4,r2
L_8d9eca:
	b_s L_8d9efc
	.global L_8d9ecc
L_8d9ecc:
	mov_s r1,0x3
L_8d9ece:
	b_s L_8d9ec0
	.global L_8d9ed0
L_8d9ed0:
	mov_s r1,0x1002968
L_8d9ed6:
	bl.d L_8dcba8
L_8d9eda:
	mov_s r0,0x2e
L_8d9edc:
	ldb_s r0,[r14,0x4]
L_8d9ede:
	ldb_s r2,[r14,0x3]
L_8d9ee0:
	asl_s r0,r0,0x8
L_8d9ee2:
	or_s r2,r2,r0
L_8d9ee4:
	ldb_s r3,[r14,0x2]
L_8d9ee6:
	mov_s r0,0x2e
L_8d9ee8:
	mov_s r1,r16
L_8d9eea:
	bl.d L_8dcd00
L_8d9eee:
	mov r4,r18
L_8d9ef2:
	mov_s r0,0x2e
L_8d9ef4:
	mov_s r1,r15
L_8d9ef6:
	bl.d L_8dcc10
L_8d9efa:
	mov_s r2,r17
	.global L_8d9efc
L_8d9efc:
	b L_8c0234
