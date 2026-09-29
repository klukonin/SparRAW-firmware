/* mailbox_debug_dump @ 0x8d9ba8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mailbox_debug_dump: m_ctrl->ring_tail_ptr - 0x%x, m_ctrl->ring_head_ptr - 0x%x
 *   mailbox_debug_dump: m_work_ptr - 0x%x, m_ring_base - 0x%x
 *   mailbox_debug_dump: sync entry
 *                      [0x%x]       [0x%x]
 * Зовут его: basic_if__mailbox_send
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit2
 */
	.section .text.mailbox_debug_dump,"ax",@progbits
	.global mailbox_debug_dump
mailbox_debug_dump:
	.global L_8d9ba8
L_8d9ba8:
	push_s blink
L_8d9baa:
	bl L_8c02c4
L_8d9bae:
	mov_s r13,r0
L_8d9bb0:
	ld_s r3,[r0,0xc]
L_8d9bb2:
	mov_s r2,0x1001ab0
L_8d9bb8:
	ld r4,[r3, 0xc]
L_8d9bbc:
	mov_s r0,0x0
L_8d9bbe:
	mov_s r1,r0
L_8d9bc0:
	bl.d L_8edff8
L_8d9bc4:
	ld_s r3,[r3,0x8]
L_8d9bc6:
	mov_s r2,0x1001b00
L_8d9bcc:
	ld r4,[r13, 0x4]
L_8d9bd0:
	mov_s r0,0x0
L_8d9bd2:
	mov_s r1,r0
L_8d9bd4:
	bl.d L_8edff8
L_8d9bd8:
	ld_s r3,[r13]
L_8d9bda:
	mov_s r2,0x1001b3c
L_8d9be0:
	mov_s r0,0x0
L_8d9be2:
	bl.d L_8edfb0
L_8d9be6:
	mov_s r1,r0
L_8d9be8:
	ld_s r14,[r13,0x4]
L_8d9bea:
	b_s L_8d9c02
	.global L_8d9bec
L_8d9bec:
	mov_s r2,0x1001b5c
L_8d9bf2:
	ld r4,[r14, 0x4]
L_8d9bf6:
	mov_s r0,0x0
L_8d9bf8:
	mov_s r1,r0
L_8d9bfa:
	bl.d L_8edff8
L_8d9bfe:
	ld.ab r3,[r14,0x8]
	.global L_8d9c02
L_8d9c02:
	ld_s r0,[r13,0x8]
L_8d9c04:
	brlo r14,r0,L_8d9bec
L_8d9c08:
	b L_8c0334
