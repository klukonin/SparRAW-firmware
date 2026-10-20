/* basic_sm__inject_event @ 0x8d6a1c, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Inject %s event to %s. Next state: %s
 *   basic_sm.cpp
 * Зовут его: MAINTAIN_SM__OPEN, PS_CONNECTION_MGR__psc_req_tx_wb_cb, PS_CONNECTION_MGR__psc_resp_tx_wb_cb, PS_CONNECTION__assoc_ntf, PS_CONNECTION__disassoc_ntf, PS_CONNECTION__psc_complete, PS_NONASSOC_SM__ps_reenter_done, addba_rsp_handler, ba__retry_flow, ba_setup_sm__abort
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__store_pending_event, fw_log__emit3_nonl, fw_sysassert_fatal
 */
	.section .text.basic_sm__inject_event,"ax",@progbits
	.global basic_sm__inject_event
basic_sm__inject_event:
	.global L_8d6a1c
L_8d6a1c:
	push_s blink
L_8d6a1e:
	bl L_8c02c0
L_8d6a22:
	bl.d L_8e20c0
L_8d6a26:
	mov_s r14,r0
L_8d6a28:
	mov_s r15,0x0
L_8d6a2a:
	b_s L_8d6a9e
	.global L_8d6a2c
L_8d6a2c:
	mov_s r0,0x0
L_8d6a2e:
	st_s r0,[r14,0x4]
L_8d6a30:
	ld_s r1,[r14,0x8]
L_8d6a32:
	ldb_s r0,[r14,0x2]
L_8d6a34:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d6a36:
	ldb_s r13,[r14]
L_8d6a38:
	mulu64 r0,r1
L_8d6a3c:
	ld_s r0,[r14,0x18]
L_8d6a3e:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8d6a40:
	add_s r13,r13,mlo
L_8d6a42:
	add2 r2,r13,r13
L_8d6a46:
	ldb_s r0,[r0,r2]
L_8d6a48:
	ld_s r2,[r14,0x28]
L_8d6a4a:
	stb_s r0,[r14]
L_8d6a4c:
	breq_s r2,0,L_8d6a6c
L_8d6a4e:
	ld_s r3,[r14,0x20]
L_8d6a50:
	mov_s r2,0x10027ac
L_8d6a56:
	ld.as r3,[r3,r1]
L_8d6a5a:
	ld_s r1,[r14,0x1c]
L_8d6a5c:
	ld r4,[r14, 0x24]
L_8d6a60:
	ld.as r5,[r1,r0]
L_8d6a64:
	mov_s r0,0x5
L_8d6a66:
	bl.d L_8ee0e8
L_8d6a6a:
	mov_s r1,0x2
	.global L_8d6a6c
L_8d6a6c:
	ld_s r1,[r14,0x18]
L_8d6a6e:
	add2 r0,r13,r13
L_8d6a72:
	add r10,r1,r0
L_8d6a76:
	ldb r2,[r10, 0x1]
L_8d6a7a:
	ldb_s r13,[r1,r0]
L_8d6a7c:
	asl_s r2,r2,0x8
L_8d6a7e:
	or_s r13,r13,r2
L_8d6a80:
	ldb r2,[r10, 0x2]
L_8d6a84:
	mov_s r0,r14
L_8d6a86:
	asl_s r2,r2,0x10
L_8d6a88:
	or_s r13,r13,r2
L_8d6a8a:
	ldb r2,[r10, 0x3]
L_8d6a8e:
	ld_s r1,[r14,0xc]
L_8d6a90:
	asl_s r2,r2,0x18
L_8d6a92:
	or_s r13,r13,r2
L_8d6a94:
	ld_s r2,[r14,0x10]
L_8d6a96:
	jl_s.d [r13]
L_8d6a98:
	ld_s r3,[r14,0x14]
L_8d6a9a:
	brhs r15,0x14,L_8d6aa8
	.global L_8d6a9e
L_8d6a9e:
	ld_s r0,[r14,0x4]
L_8d6aa0:
	breq r0,0x1,L_8d6a2c
L_8d6aa4:
	b L_8c032c
	.global L_8d6aa8
L_8d6aa8:
	mov_s r0,blink
L_8d6aaa:
	mov_s r2,0x100279c
L_8d6ab0:
	mov_s r1,0x31
L_8d6ab2:
	bset_s r1,r1,0xc
L_8d6ab4:
	bl.d L_8c82c0
L_8d6ab8:
	mov_s r3,0x2a
L_8d6aba:
	b_s L_8d6a9e
