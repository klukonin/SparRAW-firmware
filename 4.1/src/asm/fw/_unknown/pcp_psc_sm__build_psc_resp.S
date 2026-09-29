/* pcp_psc_sm__build_psc_resp @ 0x8e0f5c, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending PSC RESP. Length: %d bytes.
 *   [NNL] bi_start_time: 0x%x, number_of_awake_bi: %d, sleep_cycle: %d.
 * Зовут его: pcp_psc_sm__send_psc_resp_flow
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r15_to_r13_ret, __st_r15_to_r13, frame__build_psc_resp, frame__build_psc_resp_short, fw_log__emit1, fw_log__emit3, mgmt_tx__begin_frame, tx_api__send_mgmt
 */
	.section .text.pcp_psc_sm__build_psc_resp,"ax",@progbits
	.global pcp_psc_sm__build_psc_resp
pcp_psc_sm__build_psc_resp:
	.global L_8e0f5c
L_8e0f5c:
	push_s blink
L_8e0f5e:
	bl L_8c02c0
L_8e0f62:
	sub_s sp,sp,0x4
L_8e0f64:
	bl.d L_8c2c80
L_8e0f68:
	mov_s r13,r0
L_8e0f6a:
	mov_s r15,r0
L_8e0f6c:
	mov_s r14,0x0
L_8e0f6e:
	ld_s r0,[r13,0x34]
L_8e0f70:
	st_s r14,[sp,0x0]
L_8e0f72:
	ld r3,[r0, 0x8c]
L_8e0f76:
	mov_s r1,sp
L_8e0f78:
	ld_s r2,[r3,0xc]
L_8e0f7a:
	mov_s r0,r15
L_8e0f7c:
	bl.d L_8e4be4
L_8e0f80:
	mov r4,0xd
L_8e0f84:
	ld_s r0,[sp,0x0]
L_8e0f86:
	ld_s r2,[r13,0x30]
L_8e0f88:
	add_s r0,r0,r15
L_8e0f8a:
	ld_s r3,[r13,0x38]
L_8e0f8c:
	ld r4,[r13, 0x3c]
L_8e0f90:
	cmp_s r2,0x0
L_8e0f92:
	ldb r1,[r13, 0x41]
L_8e0f96:
	mov_s r2,r14
L_8e0f98:
	bne_s L_8e0fa0
L_8e0f9a:
	bl L_8ecc40
L_8e0f9e:
	b_s L_8e0fa4
	.global L_8e0fa0
L_8e0fa0:
	bl L_8eccac
	.global L_8e0fa4
L_8e0fa4:
	ld_s r3,[sp,0x0]
L_8e0fa6:
	mov_s r2,0x10030b8
L_8e0fac:
	add_s r3,r3,r0
L_8e0fae:
	st_s r3,[sp,0x0]
L_8e0fb0:
	mov_s r0,0xe
L_8e0fb2:
	bl.d L_8edfcc
L_8e0fb6:
	mov_s r1,0x2
L_8e0fb8:
	ldw r4,[r13, 0x3e]
L_8e0fbc:
	mov_s r2,0x10030dc
L_8e0fc2:
	ldw r5,[r13, 0x3c]
L_8e0fc6:
	mov_s r0,0xe
L_8e0fc8:
	mov_s r1,0x2
L_8e0fca:
	bl.d L_8ee034
L_8e0fce:
	ld_s r3,[r13,0x38]
L_8e0fd0:
	ld_s r0,[r13,0x34]
L_8e0fd2:
	mov r5,0x1d9e8
L_8e0fda:
	ldw r4,[sp]
L_8e0fde:
	mov_s r1,0x0
L_8e0fe0:
	ld r0,[r0, 0x8c]
L_8e0fe4:
	mov_s r2,0x1
L_8e0fe6:
	mov_s r3,r15
L_8e0fe8:
	bl.d L_8e0c44
L_8e0fec:
	mov_s r6,r1
L_8e0fee:
	b.d L_8c032c
L_8e0ff2:
	add_s sp,sp,0x4
