/* sta_psc_sm__build_psc_req @ 0x8e5b14, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending PSC REQ. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 *   Sending PSC REQ. Token:%d
 *   Sending PSC REQ. TSF:0x%08x %08x
 * Зовут его: sta_psc_sm__send_psc_req_flow_sm
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r15_to_r13_ret, __st_r15_to_r13, frame__build_psc_req, fw_log_emit1, fw_log_emit2, fw_log_emit3, mac_read_tsf64, mgmt_tx__begin_frame, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__build_psc_req
sta_psc_sm__build_psc_req:
	.global L_8e5b14
L_8e5b14:
	push_s blink
L_8e5b16:
	bl L_8c01e0
L_8e5b1a:
	sub_s sp,sp,0xc
L_8e5b1c:
	bl.d L_8c3414
L_8e5b20:
	mov_s r14,r0
L_8e5b22:
	mov_s r13,r0
L_8e5b24:
	mov_s r15,0x0
L_8e5b26:
	st_s r15,[sp,0x0]
L_8e5b28:
	ld_s r0,[r14,0x14]
L_8e5b2a:
	mov_s r1,sp
L_8e5b2c:
	ld_s r3,[r0,0x44]
L_8e5b2e:
	mov_s r0,r13
L_8e5b30:
	ld_s r2,[r3,0x18]
L_8e5b32:
	bl.d L_8e9c7c
L_8e5b36:
	mov r4,0xd
L_8e5b3a:
	ld_s r0,[sp,0x0]
L_8e5b3c:
	ldb_s r1,[r14,0x10]
L_8e5b3e:
	add_s r0,r0,r13
L_8e5b40:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e5b42:
	extb_s r1,r1
L_8e5b44:
	ld r4,[r14, 0x1c]
L_8e5b48:
	stb_s r1,[r14,0x10]
L_8e5b4a:
	ldb r2,[r14, 0x20]
L_8e5b4e:
	bl.d L_8d80f4
L_8e5b52:
	ld_s r3,[r14,0x18]
L_8e5b54:
	ld_s r1,[sp,0x0]
L_8e5b56:
	add_s r0,r0,r1
L_8e5b58:
	st_s r0,[sp,0x0]
L_8e5b5a:
	ldw r4,[r14, 0x1c]
L_8e5b5e:
	mov_s r1,0x1002c94
L_8e5b64:
	ld_s r2,[r14,0x18]
L_8e5b66:
	mov_s r0,0x2e
L_8e5b68:
	bl.d L_8dcd00
L_8e5b6c:
	ldw_s r3,[r14,0x1e]
L_8e5b6e:
	mov_s r1,0x1002e14
L_8e5b74:
	mov_s r0,0x2e
L_8e5b76:
	bl.d L_8dcc10
L_8e5b7a:
	ldb_s r2,[r14,0x10]
L_8e5b7c:
	add_s r1,sp,0x4
L_8e5b7e:
	mov_s r0,r15
L_8e5b80:
	bl.d L_8e9900
L_8e5b84:
	mov_s r2,r15
L_8e5b86:
	ld_s r2,[sp,0x8]
L_8e5b88:
	mov_s r1,0x1002e30
L_8e5b8e:
	mov_s r0,0x2e
L_8e5b90:
	bl.d L_8dcc80
L_8e5b94:
	ld_s r3,[sp,0x4]
L_8e5b96:
	ld_s r0,[r14,0x14]
L_8e5b98:
	mov r5,0x21a20
L_8e5ba0:
	ldw r4,[sp]
L_8e5ba4:
	mov_s r1,r15
L_8e5ba6:
	ld_s r0,[r0,0x44]
L_8e5ba8:
	mov_s r2,0x1
L_8e5baa:
	mov_s r3,r13
L_8e5bac:
	bl.d L_8e5874
L_8e5bb0:
	mov_s r6,r15
L_8e5bb2:
	ldb_s r0,[r14,0x11]
L_8e5bb4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5bb6:
	stb_s r0,[r14,0x11]
L_8e5bb8:
	b.d L_8c024c
L_8e5bbc:
	add_s sp,sp,0xc
L_8e5bbe:
	nop_s
