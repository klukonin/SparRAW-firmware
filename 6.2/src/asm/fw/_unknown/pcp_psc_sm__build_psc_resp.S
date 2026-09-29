/* pcp_psc_sm__build_psc_resp @ 0x8e5c0c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending PSC RESP. Length: %d bytes.
 *   [NNL] bi_start_time: 0x%x, number_of_awake_bi: %d, sleep_cycle: %d.
 * Зовут его: pcp_psc_sm__send_psc_resp_flow
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r15_to_r13_ret, __st_r15_to_r13, frame__build_psc_resp, frame__build_psc_resp_short, fw_log_emit1, fw_log_emit3, mgmt_tx__begin_frame, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__build_psc_resp
pcp_psc_sm__build_psc_resp:
	.global L_8e5c0c
L_8e5c0c:
	push_s blink
L_8e5c0e:
	bl L_8c01e0
L_8e5c12:
	sub_s sp,sp,0x4
L_8e5c14:
	bl.d L_8c3414
L_8e5c18:
	mov_s r13,r0
L_8e5c1a:
	mov_s r15,r0
L_8e5c1c:
	mov_s r14,0x0
L_8e5c1e:
	st_s r14,[sp,0x0]
L_8e5c20:
	ld_s r0,[r13,0x10]
L_8e5c22:
	mov_s r1,sp
L_8e5c24:
	ld_s r3,[r0,0x44]
L_8e5c26:
	mov_s r0,r15
L_8e5c28:
	ld_s r2,[r3,0x18]
L_8e5c2a:
	bl.d L_8e9c7c
L_8e5c2e:
	mov r4,0xd
L_8e5c32:
	ld_s r0,[sp,0x0]
L_8e5c34:
	ld_s r2,[r13,0xc]
L_8e5c36:
	add_s r0,r0,r15
L_8e5c38:
	ldb_s r1,[r13,0x1d]
L_8e5c3a:
	ld_s r3,[r13,0x14]
L_8e5c3c:
	cmp_s r2,0x0
L_8e5c3e:
	ld r4,[r13, 0x18]
L_8e5c42:
	mov_s r2,r14
L_8e5c44:
	bne_s L_8e5c4c
L_8e5c46:
	bl L_8d8160
L_8e5c4a:
	b_s L_8e5c50
	.global L_8e5c4c
L_8e5c4c:
	bl L_8d81cc
	.global L_8e5c50
L_8e5c50:
	ld_s r2,[sp,0x0]
L_8e5c52:
	mov_s r1,0x1002c08
L_8e5c58:
	add_s r2,r2,r0
L_8e5c5a:
	st_s r2,[sp,0x0]
L_8e5c5c:
	bl.d L_8dcc10
L_8e5c60:
	mov_s r0,0x2e
L_8e5c62:
	ldw r4,[r13, 0x18]
L_8e5c66:
	mov_s r1,0x1002c2c
L_8e5c6c:
	ld_s r2,[r13,0x14]
L_8e5c6e:
	mov_s r0,0x2e
L_8e5c70:
	bl.d L_8dcd00
L_8e5c74:
	ldw_s r3,[r13,0x1a]
L_8e5c76:
	ld_s r0,[r13,0x10]
L_8e5c78:
	mov r5,0x21b38
L_8e5c80:
	ldw r4,[sp]
L_8e5c84:
	mov_s r1,0x0
L_8e5c86:
	ld_s r0,[r0,0x44]
L_8e5c88:
	mov_s r2,0x1
L_8e5c8a:
	mov_s r3,r15
L_8e5c8c:
	bl.d L_8e5874
L_8e5c90:
	mov_s r6,r1
L_8e5c92:
	b.d L_8c024c
L_8e5c96:
	add_s sp,sp,0x4
