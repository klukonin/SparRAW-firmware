/* ps_connection__psc_req_rx @ 0x8d6bf0, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Received PSC REQ
 *   Received DPM 0
 * Зовут его: ps_connection__psc_req_ignore
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, fw_log__emit0, psc__copy_req_params
 */
	.section .text.ps_connection__psc_req_rx,"ax",@progbits
	.global ps_connection__psc_req_rx
ps_connection__psc_req_rx:
	.global L_8d6bf0
L_8d6bf0:
	push_s blink
L_8d6bf2:
	bl L_8c02c0
L_8d6bf6:
	mov_s r14,r0
L_8d6bf8:
	mov_s r13,r1
L_8d6bfa:
	mov_s r2,0x1002c18
L_8d6c00:
	mov_s r0,0xe
L_8d6c02:
	bl.d L_8edfb0
L_8d6c06:
	mov_s r1,0x2
L_8d6c08:
	ldb_s r0,[r13,0x3]
L_8d6c0a:
	ldb_s r15,[r13,0x2]
L_8d6c0c:
	stb r0,[r14, 0x40]
L_8d6c10:
	brne_s r0,0,L_8d6c28
L_8d6c12:
	mov_s r2,0x1002c2c
L_8d6c18:
	mov_s r0,0xe
L_8d6c1a:
	bl.d L_8edfb0
L_8d6c1e:
	mov_s r1,0x2
L_8d6c20:
	mov_s r0,r14
L_8d6c22:
	mov_s r1,0x0
L_8d6c24:
	mov_s r2,0x1
L_8d6c26:
	b_s L_8d6c64
	.global L_8d6c28
L_8d6c28:
	ldb_s r0,[r13,0x3]
L_8d6c2a:
	cmp_s r0,0x0
L_8d6c2c:
	mov_s r0,0x1
L_8d6c2e:
	beq_s L_8d6c44
L_8d6c30:
	ldb_s r1,[r13,0x4]
L_8d6c32:
	cmp r1,0x8f
L_8d6c36:
	mov_s r0,0x0
L_8d6c38:
	bne_s L_8d6c42
L_8d6c3a:
	ldb_s r1,[r13,0x5]
L_8d6c3c:
	cmp_s r1,0x8
L_8d6c3e:
	mov.eq r0,0x1
	.global L_8d6c42
L_8d6c42:
	extb_s r0,r0
	.global L_8d6c44
L_8d6c44:
	breq_s r0,0,L_8d6c4e
L_8d6c46:
	mov_s r0,0x0
L_8d6c48:
	st_s r0,[r14,0x30]
L_8d6c4a:
	add_s r1,r13,0x6
L_8d6c4c:
	b_s L_8d6c54
	.global L_8d6c4e
L_8d6c4e:
	mov_s r0,0x1
L_8d6c50:
	st_s r0,[r14,0x30]
L_8d6c52:
	add_s r1,r13,0x4
	.global L_8d6c54
L_8d6c54:
	bl.d L_8e2270
L_8d6c58:
	mov_s r0,r14
L_8d6c5a:
	stb r15,[r14, 0x41]
L_8d6c5e:
	mov_s r0,r14
L_8d6c60:
	mov_s r1,0x1
L_8d6c62:
	mov_s r2,0x0
	.global L_8d6c64
L_8d6c64:
	mov_s r3,0x0
L_8d6c66:
	bl.d L_8d6a1c
L_8d6c6a:
	mov_s r4,r3
L_8d6c6c:
	b L_8c032c
