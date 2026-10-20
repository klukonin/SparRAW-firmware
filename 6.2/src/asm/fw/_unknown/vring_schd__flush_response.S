/* vring_schd__flush_response @ 0x8dda68, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VR-Scheduler handles uCode Flush Response.
 * Зовут его: event_flush_q_done
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, vring__reg_write_locked_3c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__flush_response
vring_schd__flush_response:
	.global L_8dda68
L_8dda68:
	push_s blink
L_8dda6a:
	push_s r13
L_8dda6c:
	mov_s r13,r0
L_8dda6e:
	mov_s r1,0x100bc7c
L_8dda74:
	bl.d L_8dcba8
L_8dda78:
	mov_s r0,0x27
L_8dda7a:
	mov_s r0,0x0
L_8dda7c:
	b_s L_8dda80
	.global L_8dda7e
L_8dda7e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8dda80
L_8dda80:
	mov_s r2,0x804dbc
L_8dda86:
	ld r1,[r2, 0xa0]
L_8dda8a:
	brhs r0,r1,L_8ddab0
L_8dda8e:
	mul64 r0,0x3c
L_8dda92:
	add r1,r2,0x3c
L_8dda96:
	ld r1,[r1,mlo]
L_8dda9a:
	breq_s r1,0,L_8dda7e
L_8dda9c:
	ldb_s r1,[r1,0x9]
L_8dda9e:
	brne r13,r1,L_8dda7e
L_8ddaa2:
	add_s r0,r0,0x8
L_8ddaa4:
	mov_s r12,0x1
L_8ddaa6:
	asl r0,r12,r0
L_8ddaaa:
	bl.d L_8d0568
L_8ddaae:
	mov_s r1,0x1
	.global L_8ddab0
L_8ddab0:
	b L_8c025c
