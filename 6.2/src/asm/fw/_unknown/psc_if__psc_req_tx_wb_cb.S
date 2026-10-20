/* psc_if__psc_req_tx_wb_cb @ 0x8e1a58, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_if::psc_req_tx_wb_cb. received WB after disconnect
 *   psc_if::psc_req_tx_wb_cb, success:%d
 * Зовут его: ps_conn_mgr__psc_req_tx_wb_cb
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, sta_psc_sm__m_psc_req_tx_wb_timeout_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global psc_if__psc_req_tx_wb_cb
psc_if__psc_req_tx_wb_cb:
	.global L_8e1a58
L_8e1a58:
	push_s blink
L_8e1a5a:
	bl L_8c01e0
L_8e1a5e:
	mov_s r14,r0
L_8e1a60:
	cmp_s r2,0x0
L_8e1a62:
	mov_s r15,0x1
L_8e1a64:
	sub_s.ne r15,r15,r15
L_8e1a66:
	add r13,r0,0x20
L_8e1a6a:
	bl.d L_8c6a0c
L_8e1a6e:
	mov_s r0,r13
L_8e1a70:
	ld_s r0,[r14,0x44]
L_8e1a72:
	brne_s r0,0,L_8e1a82
L_8e1a74:
	mov_s r1,0x10029b0
L_8e1a7a:
	bl.d L_8dcba8
L_8e1a7e:
	mov_s r0,0x2e
L_8e1a80:
	b_s L_8e1aa8
	.global L_8e1a82
L_8e1a82:
	mov_s r1,0x10029e8
L_8e1a88:
	mov_s r0,0x2e
L_8e1a8a:
	bl.d L_8dcc10
L_8e1a8e:
	mov_s r2,r15
L_8e1a90:
	breq_s r15,0,L_8e1ab0
L_8e1a92:
	ldb r0,[r13, 0x20]
L_8e1a96:
	cmp_s r0,0x0
L_8e1a98:
	mov_s r0,r13
L_8e1a9a:
	beq_s L_8e1aac
L_8e1a9c:
	mov_s r1,0x1
L_8e1a9e:
	mov_s r2,r1
	.global L_8e1aa0
L_8e1aa0:
	mov_s r3,0x0
L_8e1aa2:
	bl.d L_8d9b6c
L_8e1aa6:
	mov_s r4,r3
	.global L_8e1aa8
L_8e1aa8:
	b L_8c024c
	.global L_8e1aac
L_8e1aac:
	mov_s r1,0x2
L_8e1aae:
	b_s L_8e1abc
	.global L_8e1ab0
L_8e1ab0:
	ldb_s r0,[r13,0x11]
L_8e1ab2:
	cmp_s r0,0x3
L_8e1ab4:
	mov_s r0,r13
L_8e1ab6:
	mov_s r1,0x4
L_8e1ab8:
	mov.lt r1,0x1
	.global L_8e1abc
L_8e1abc:
	mov_s r2,0x0
L_8e1abe:
	b_s L_8e1aa0
L_8e1ac0:
	push_s blink
L_8e1ac2:
	push_s r13
L_8e1ac4:
	mov.f r13,r0
L_8e1ac8:
	beq_s L_8e1ada
	.global L_8e1aca
L_8e1aca:
	mov_s r0,0x0
L_8e1acc:
	st_s r0,[r13,0x8]
L_8e1ace:
	ldb_s r0,[r13,0x11]
L_8e1ad0:
	cmp_s r0,0x3
L_8e1ad2:
	mov_s r0,r13
L_8e1ad4:
	blt_s L_8e1ae8
L_8e1ad6:
	mov_s r1,0x4
L_8e1ad8:
	b_s L_8e1aea
	.global L_8e1ada
L_8e1ada:
	mov_s r0,blink
L_8e1adc:
	mov_s r1,0x1421
L_8e1ae2:
	bl L_8c9b28
L_8e1ae6:
	b_s L_8e1aca
	.global L_8e1ae8
L_8e1ae8:
	mov_s r1,0x3
	.global L_8e1aea
L_8e1aea:
	mov_s r2,0x0
L_8e1aec:
	mov_s r3,r2
L_8e1aee:
	bl.d L_8d9b6c
L_8e1af2:
	mov_s r4,r2
L_8e1af4:
	b L_8c025c
