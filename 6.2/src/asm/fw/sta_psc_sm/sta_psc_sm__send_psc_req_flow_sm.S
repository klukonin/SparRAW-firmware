/* sta_psc_sm__send_psc_req_flow_sm @ 0x8e5bc0, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::send_psc_req_flow_sm. retry count: %d
 * Зовут его: sta_psc_sm__psc_req_tx_complete_8e19c0, sta_psc_sm__psc_start_flow
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_sysassert_fatal, sta_psc_sm__build_psc_req, u_schd__schedule
 * Глобалы (через gp): 0x800430
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__send_psc_req_flow_sm
sta_psc_sm__send_psc_req_flow_sm:
	.global L_8e5bc0
L_8e5bc0:
	push_s blink
L_8e5bc2:
	push_s r13
L_8e5bc4:
	mov_s r13,r0
L_8e5bc6:
	mov_s r1,0x1002ce0
L_8e5bcc:
	mov_s r0,0x2e
L_8e5bce:
	bl.d L_8dcc10
L_8e5bd2:
	ldb_s r2,[r13,0x11]
L_8e5bd4:
	bl.d L_8e5b14
L_8e5bd8:
	mov_s r0,r13
L_8e5bda:
	ld_s r0,[r13,0x8]
L_8e5bdc:
	brne_s r0,0,L_8e5bfc
	.global L_8e5bde
L_8e5bde:
	mov_s r0,0x21ac0
L_8e5be4:
	ld.as r4,[gp,0xab]
L_8e5be8:
	mov_s r1,r13
L_8e5bea:
	mov_s r2,0x0
L_8e5bec:
	mov_s r3,r2
L_8e5bee:
	mov_s r5,r2
L_8e5bf0:
	bl.d L_8e0c0c
L_8e5bf4:
	mov_s r6,r2
L_8e5bf6:
	b.d L_8c025c
L_8e5bfa:
	st_s r0,[r13,0x8]
	.global L_8e5bfc
L_8e5bfc:
	mov_s r0,blink
L_8e5bfe:
	mov_s r1,0x12a4
L_8e5c04:
	bl L_8c9b28
L_8e5c08:
	b_s L_8e5bde
L_8e5c0a:
	nop_s
