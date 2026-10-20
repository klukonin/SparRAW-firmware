/* fwq_tx__request_flush @ 0x8c8f20, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx.cpp
 * Зовут его: TX_CTRL_API__flush_connection
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, u_schd__schedule
 */
	.section .text.fwq_tx__request_flush,"ax",@progbits
	.global fwq_tx__request_flush
fwq_tx__request_flush:
	.global L_8c8f20
L_8c8f20:
	push_s blink
L_8c8f22:
	bl L_8c02c4
L_8c8f26:
	mov_s r14,r0
L_8c8f28:
	mov_s r13,0x0
L_8c8f2a:
	ld_s r0,[r0,0x14]
L_8c8f2c:
	bset r13,r13,r1
L_8c8f30:
	tst_s r0,r13
L_8c8f32:
	bne_s L_8c8f60
	.global L_8c8f34
L_8c8f34:
	ld_s r0,[r14,0x14]
L_8c8f36:
	or_s r0,r0,r13
L_8c8f38:
	st_s r0,[r14,0x14]
L_8c8f3a:
	ld_s r0,[r14,0x10]
L_8c8f3c:
	brne_s r0,0,L_8c8f5c
L_8c8f3e:
	mov_s r0,0x90d8
L_8c8f44:
	mov_s r1,r14
L_8c8f46:
	mov_s r2,0x0
L_8c8f48:
	mov_s r3,r2
L_8c8f4a:
	mov r4,0x493e0
L_8c8f52:
	mov_s r5,r2
L_8c8f54:
	bl.d L_8dc92c
L_8c8f58:
	mov_s r6,r2
L_8c8f5a:
	st_s r0,[r14,0x10]
	.global L_8c8f5c
L_8c8f5c:
	b L_8c0334
	.global L_8c8f60
L_8c8f60:
	mov_s r0,blink
L_8c8f62:
	mov_s r2,0x1015730
L_8c8f68:
	mov_s r1,0x1210
L_8c8f6e:
	bl.d L_8c82c0
L_8c8f72:
	mov_s r3,0xb2
L_8c8f74:
	b_s L_8c8f34
L_8c8f76:
	nop_s
