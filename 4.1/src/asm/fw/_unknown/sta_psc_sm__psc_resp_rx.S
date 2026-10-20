/* sta_psc_sm__psc_resp_rx @ 0x8d6c70, 392 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовут его: ps_connection__psc_rsp_ignore
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, basic_sm__inject_event, frag_8d7044, fw_log__emit0, fw_log__emit1, fw_log__emit3, sta_psc_sm__m_psc_resp_rx_wb_timeout_event
 */
	.section .text.sta_psc_sm__psc_resp_rx,"ax",@progbits
	.global sta_psc_sm__psc_resp_rx
sta_psc_sm__psc_resp_rx:
	.global L_8d6c70
L_8d6c70:
	push_s blink
L_8d6c72:
	bl L_8c02b0
L_8d6c76:
	add2 r14,r0,0x11
L_8d6c7a:
	add r15,r14,0x20
L_8d6c7e:
	ldb_s r0,[r15,0x15]
L_8d6c80:
	ldb r17,[r15, 0x14]
L_8d6c84:
	sub r18,r0,0x1
L_8d6c88:
	ldb_s r0,[r14]
L_8d6c8a:
	mov_s r13,r1
L_8d6c8c:
	extb r18,r18
L_8d6c90:
	brne_s r0,0,L_8d6cc0
L_8d6c92:
	mov_s r2,0x1002c3c
L_8d6c98:
	mov_s r0,0xe
L_8d6c9a:
	bl.d L_8edfb0
L_8d6c9e:
	mov_s r1,0x2
L_8d6ca0:
	mov_s r2,0x1002c84
L_8d6ca6:
	ldb_s r0,[r13,0x4]
L_8d6ca8:
	ldb_s r3,[r13,0x3]
L_8d6caa:
	asl_s r0,r0,0x8
L_8d6cac:
	or_s r3,r3,r0
L_8d6cae:
	ldb r4,[r13, 0x2]
L_8d6cb2:
	mov_s r0,0xe
L_8d6cb4:
	mov_s r1,0x2
L_8d6cb6:
	bl.d L_8ee034
L_8d6cba:
	mov r5,r17
L_8d6cbe:
	b_s L_8d6df4
	.global L_8d6cc0
L_8d6cc0:
	ldb_s r0,[r13,0x4]
L_8d6cc2:
	ldb_s r2,[r13,0x3]
L_8d6cc4:
	asl_s r0,r0,0x8
L_8d6cc6:
	or_s r2,r2,r0
L_8d6cc8:
	ldb_s r1,[r13,0x2]
L_8d6cca:
	mov_s r0,r14
L_8d6ccc:
	brne r2,0x0,L_8d6d5c
L_8d6cd0:
	bl L_8d7044
L_8d6cd4:
	breq_s r0,0,L_8d6d42
L_8d6cd6:
	bl.d L_8c5c0c
L_8d6cda:
	mov_s r0,r14
L_8d6cdc:
	mov_s r2,0x1002cc4
L_8d6ce2:
	mov_s r0,0xe
L_8d6ce4:
	bl.d L_8edfb0
L_8d6ce8:
	mov_s r1,0x2
L_8d6cea:
	ldb_s r0,[r13,0x8]
L_8d6cec:
	ldb_s r3,[r13,0x7]
L_8d6cee:
	asl_s r0,r0,0x8
L_8d6cf0:
	or_s r3,r3,r0
L_8d6cf2:
	ldb_s r0,[r13,0x9]
L_8d6cf4:
	mov_s r2,0x1002cec
L_8d6cfa:
	asl_s r0,r0,0x10
L_8d6cfc:
	or_s r3,r3,r0
L_8d6cfe:
	ldb_s r0,[r13,0xa]
L_8d6d00:
	ldb r4,[r13, 0xd]
L_8d6d04:
	asl_s r0,r0,0x18
L_8d6d06:
	or_s r3,r3,r0
L_8d6d08:
	ldb_s r0,[r13,0xe]
L_8d6d0a:
	ldb r5,[r13, 0xb]
L_8d6d0e:
	asl_s r0,r0,0x8
L_8d6d10:
	or r4,r4,r0
L_8d6d14:
	ldb_s r0,[r13,0xc]
L_8d6d16:
	asl_s r0,r0,0x8
L_8d6d18:
	or r5,r5,r0
L_8d6d1c:
	mov_s r0,0xe
L_8d6d1e:
	bl.d L_8ee034
L_8d6d22:
	mov_s r1,0x2
L_8d6d24:
	mov_s r2,0x1002d3c
L_8d6d2a:
	mov_s r0,0xe
L_8d6d2c:
	mov_s r1,0x2
L_8d6d2e:
	ldb_s r3,[r13,0x2]
L_8d6d30:
	mov r4,r17
L_8d6d34:
	bl.d L_8ee034
L_8d6d38:
	mov r5,r18
L_8d6d3c:
	mov_s r0,r14
L_8d6d3e:
	mov_s r1,0x2
L_8d6d40:
	b_s L_8d6db0
	.global L_8d6d42
L_8d6d42:
	mov_s r2,0x1002d68
L_8d6d48:
	mov_s r0,0xe
L_8d6d4a:
	mov_s r1,0x2
L_8d6d4c:
	ldb_s r3,[r13,0x2]
L_8d6d4e:
	mov r4,r17
L_8d6d52:
	bl.d L_8ee034
L_8d6d56:
	mov r5,r18
L_8d6d5a:
	b_s L_8d6df4
	.global L_8d6d5c
L_8d6d5c:
	bl L_8d7044
L_8d6d60:
	mov r19,0x1002c84
L_8d6d68:
	mov r16,0x1002da0
L_8d6d70:
	breq_s r0,0,L_8d6dc0
L_8d6d72:
	mov_s r2,0x1002db0
L_8d6d78:
	mov_s r0,0xe
L_8d6d7a:
	bl.d L_8edfb0
L_8d6d7e:
	mov_s r1,0x2
L_8d6d80:
	ldb_s r0,[r13,0x4]
L_8d6d82:
	ldb_s r3,[r13,0x3]
L_8d6d84:
	asl_s r0,r0,0x8
L_8d6d86:
	or_s r3,r3,r0
L_8d6d88:
	ldb r4,[r13, 0x2]
L_8d6d8c:
	mov_s r0,0xe
L_8d6d8e:
	mov_s r1,0x2
L_8d6d90:
	mov_s r2,r19
L_8d6d92:
	bl.d L_8ee034
L_8d6d96:
	mov r5,r17
L_8d6d9a:
	mov_s r0,0xe
L_8d6d9c:
	mov_s r1,0x2
L_8d6d9e:
	mov_s r2,r16
L_8d6da0:
	bl.d L_8edfcc
L_8d6da4:
	mov_s r3,r18
L_8d6da6:
	ldb_s r0,[r15,0x15]
L_8d6da8:
	cmp_s r0,0x3
L_8d6daa:
	mov_s r0,r14
L_8d6dac:
	blt_s L_8d6dbc
L_8d6dae:
	mov_s r1,0x4
	.global L_8d6db0
L_8d6db0:
	mov_s r2,0x0
L_8d6db2:
	mov_s r3,r2
L_8d6db4:
	bl.d L_8d6a1c
L_8d6db8:
	mov_s r4,r2
L_8d6dba:
	b_s L_8d6df4
	.global L_8d6dbc
L_8d6dbc:
	mov_s r1,0x3
L_8d6dbe:
	b_s L_8d6db0
	.global L_8d6dc0
L_8d6dc0:
	mov_s r2,0x1002de0
L_8d6dc6:
	mov_s r0,0xe
L_8d6dc8:
	bl.d L_8edfb0
L_8d6dcc:
	mov_s r1,0x2
L_8d6dce:
	ldb_s r0,[r13,0x4]
L_8d6dd0:
	ldb_s r3,[r13,0x3]
L_8d6dd2:
	asl_s r0,r0,0x8
L_8d6dd4:
	or_s r3,r3,r0
L_8d6dd6:
	ldb r4,[r13, 0x2]
L_8d6dda:
	mov_s r0,0xe
L_8d6ddc:
	mov_s r1,0x2
L_8d6dde:
	mov_s r2,r19
L_8d6de0:
	bl.d L_8ee034
L_8d6de4:
	mov r5,r17
L_8d6de8:
	mov_s r0,0xe
L_8d6dea:
	mov_s r1,0x2
L_8d6dec:
	mov_s r2,r16
L_8d6dee:
	bl.d L_8edfcc
L_8d6df2:
	mov_s r3,r18
	.global L_8d6df4
L_8d6df4:
	b L_8c030c
