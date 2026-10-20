/* conn_main_sm__action_8c3bf4 @ 0x8c3bf4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending mlme_sm::ASSOC_RESPONSE for direct STA PBSS member
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8c3bf4
conn_main_sm__action_8c3bf4:
	.global L_8c3bf4
L_8c3bf4:
	push_s blink
L_8c3bf6:
	push_s r13
L_8c3bf8:
	mov_s r13,r0
L_8c3bfa:
	ld_s r0,[r0,0x8]
L_8c3bfc:
	ld_s r0,[r0,0x18]
L_8c3bfe:
	ld_s r0,[r0,0x50]
L_8c3c00:
	cmp_s r0,0x1
L_8c3c02:
	mov_s r0,0x1
L_8c3c04:
	sub_s.ne r0,r0,r0
L_8c3c06:
	extb.f 0x0,r0
L_8c3c0a:
	beq_s L_8c3c2e
	.global L_8c3c0c
L_8c3c0c:
	ld_s r0,[r13,0x8]
L_8c3c0e:
	ld_s r0,[r0,0x24]
L_8c3c10:
	breq_s r0,0,L_8c3c3c
	.global L_8c3c12
L_8c3c12:
	ld_s r0,[r13,0x8]
L_8c3c14:
	ld_s r1,[r0,0x28]
L_8c3c16:
	breq_s r1,0,L_8c3c4a
L_8c3c18:
	mov_s r1,0x1011a94
L_8c3c1e:
	bl.d L_8dcba8
L_8c3c22:
	mov_s r0,0x2b
L_8c3c24:
	ld_s r0,[r13,0x8]
L_8c3c26:
	add r0,r0,0xf0
L_8c3c2a:
	mov_s r1,0x4
L_8c3c2c:
	b_s L_8c3c50
	.global L_8c3c2e
L_8c3c2e:
	mov_s r0,blink
L_8c3c30:
	mov_s r1,0x11c5
L_8c3c36:
	bl L_8c9b28
L_8c3c3a:
	b_s L_8c3c0c
	.global L_8c3c3c
L_8c3c3c:
	mov_s r0,blink
L_8c3c3e:
	mov_s r1,0x11c6
L_8c3c44:
	bl L_8c9b28
L_8c3c48:
	b_s L_8c3c12
	.global L_8c3c4a
L_8c3c4a:
	add r0,r0,0xf0
L_8c3c4e:
	mov_s r1,0x0
	.global L_8c3c50
L_8c3c50:
	mov_s r2,0x0
L_8c3c52:
	mov_s r3,r2
L_8c3c54:
	bl.d L_8d9b6c
L_8c3c58:
	mov_s r4,r2
L_8c3c5a:
	b L_8c025c
L_8c3c5e:
	nop_s
