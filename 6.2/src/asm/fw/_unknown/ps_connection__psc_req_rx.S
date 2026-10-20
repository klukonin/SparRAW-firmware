/* ps_connection__psc_req_rx @ 0x8d9d2c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Received PSC REQ
 *   Received DPM 0
 * Зовут его: ps_connection__psc_req_rx_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, fw_log_emit0, ps_connection__copy_psc_req
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_connection__psc_req_rx
ps_connection__psc_req_rx:
	.global L_8d9d2c
L_8d9d2c:
	push_s blink
L_8d9d2e:
	bl L_8c01e0
L_8d9d32:
	mov_s r14,r0
L_8d9d34:
	mov_s r13,r1
L_8d9d36:
	mov_s r1,0x1002a10
L_8d9d3c:
	bl.d L_8dcba8
L_8d9d40:
	mov_s r0,0x2e
L_8d9d42:
	ldb_s r0,[r13,0x3]
L_8d9d44:
	ldb_s r15,[r13,0x2]
L_8d9d46:
	stb_s r0,[r14,0x1c]
L_8d9d48:
	brne_s r0,0,L_8d9d5e
L_8d9d4a:
	mov_s r1,0x1002a24
L_8d9d50:
	bl.d L_8dcba8
L_8d9d54:
	mov_s r0,0x2e
L_8d9d56:
	mov_s r0,r14
L_8d9d58:
	mov_s r1,0x0
L_8d9d5a:
	mov_s r2,0x1
L_8d9d5c:
	b_s L_8d9d98
	.global L_8d9d5e
L_8d9d5e:
	ldb_s r0,[r13,0x3]
L_8d9d60:
	cmp_s r0,0x0
L_8d9d62:
	mov_s r0,0x1
L_8d9d64:
	beq_s L_8d9d7a
L_8d9d66:
	ldb_s r1,[r13,0x4]
L_8d9d68:
	cmp r1,0x8f
L_8d9d6c:
	mov_s r0,0x0
L_8d9d6e:
	bne_s L_8d9d78
L_8d9d70:
	ldb_s r1,[r13,0x5]
L_8d9d72:
	cmp_s r1,0x8
L_8d9d74:
	mov.eq r0,0x1
	.global L_8d9d78
L_8d9d78:
	extb_s r0,r0
	.global L_8d9d7a
L_8d9d7a:
	breq_s r0,0,L_8d9d84
L_8d9d7c:
	mov_s r0,0x0
L_8d9d7e:
	st_s r0,[r14,0xc]
L_8d9d80:
	add_s r1,r13,0x6
L_8d9d82:
	b_s L_8d9d8a
	.global L_8d9d84
L_8d9d84:
	mov_s r0,0x1
L_8d9d86:
	st_s r0,[r14,0xc]
L_8d9d88:
	add_s r1,r13,0x4
	.global L_8d9d8a
L_8d9d8a:
	bl.d L_8e738c
L_8d9d8e:
	mov_s r0,r14
L_8d9d90:
	stb_s r15,[r14,0x1d]
L_8d9d92:
	mov_s r0,r14
L_8d9d94:
	mov_s r1,0x1
L_8d9d96:
	mov_s r2,0x0
	.global L_8d9d98
L_8d9d98:
	mov_s r3,0x0
L_8d9d9a:
	bl.d L_8d9b6c
L_8d9d9e:
	mov_s r4,r3
L_8d9da0:
	b L_8c024c
