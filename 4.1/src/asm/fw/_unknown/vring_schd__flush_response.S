/* vring_schd__flush_response @ 0x8d9b58, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VR-Scheduler handles uCode Flush Response.
 * Зовут его: lmac_if_flush_q_done_handler
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, vring__reg_write_locked_3c
 */
	.section .text.vring_schd__flush_response,"ax",@progbits
	.global vring_schd__flush_response
vring_schd__flush_response:
	.global L_8d9b58
L_8d9b58:
	push_s blink
L_8d9b5a:
	push_s r13
L_8d9b5c:
	mov_s r13,r0
L_8d9b5e:
	mov_s r2,0x100a810
L_8d9b64:
	mov_s r0,0x7
L_8d9b66:
	bl.d L_8edfb0
L_8d9b6a:
	mov_s r1,0x2
L_8d9b6c:
	mov_s r0,0x0
L_8d9b6e:
	b_s L_8d9b72
	.global L_8d9b70
L_8d9b70:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d9b72
L_8d9b72:
	mov_s r2,0x804580
L_8d9b78:
	ld r1,[r2, 0x94]
L_8d9b7c:
	brhs r0,r1,L_8d9ba2
L_8d9b80:
	mul64 r0,0x38
L_8d9b84:
	add r1,r2,0x38
L_8d9b88:
	ld r1,[r1,mlo]
L_8d9b8c:
	breq_s r1,0,L_8d9b70
L_8d9b8e:
	ldb_s r1,[r1,0x9]
L_8d9b90:
	brne r13,r1,L_8d9b70
L_8d9b94:
	add_s r0,r0,0x8
L_8d9b96:
	mov_s r12,0x1
L_8d9b98:
	asl r0,r12,r0
L_8d9b9c:
	bl.d L_8cd6dc
L_8d9ba0:
	mov_s r1,0x1
	.global L_8d9ba2
L_8d9ba2:
	b L_8c033c
L_8d9ba6:
	nop_s
