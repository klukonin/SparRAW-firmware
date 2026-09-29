/* mailbox_debug_dump @ 0x8ddab4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mailbox_debug_dump: m_ctrl->ring_tail_ptr - 0x%x, m_ctrl->ring_head_ptr - 0x%x
 *   mailbox_debug_dump: m_work_ptr - 0x%x, m_ring_base - 0x%x
 *   mailbox_debug_dump: sync entry
 *                      [0x%x]       [0x%x]
 * Зовут его: wmi_evt__build_and_post
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mailbox_debug_dump
mailbox_debug_dump:
	.global L_8ddab4
L_8ddab4:
	push_s blink
L_8ddab6:
	bl L_8c01e4
L_8ddaba:
	mov_s r13,r0
L_8ddabc:
	ld_s r3,[r0,0xc]
L_8ddabe:
	mov_s r1,0x1001aa8
L_8ddac4:
	ld_s r2,[r3,0x8]
L_8ddac6:
	mov_s r0,0x0
L_8ddac8:
	bl.d L_8dcc80
L_8ddacc:
	ld_s r3,[r3,0xc]
L_8ddace:
	mov_s r1,0x1001af8
L_8ddad4:
	ld_s r2,[r13]
L_8ddad6:
	mov_s r0,0x0
L_8ddad8:
	bl.d L_8dcc80
L_8ddadc:
	ld_s r3,[r13,0x4]
L_8ddade:
	mov_s r1,0x1001b34
L_8ddae4:
	bl.d L_8dcba8
L_8ddae8:
	mov_s r0,0x0
L_8ddaea:
	ld_s r14,[r13,0x4]
L_8ddaec:
	b_s L_8ddb00
	.global L_8ddaee
L_8ddaee:
	ld_s r2,[r14]
L_8ddaf0:
	mov_s r1,0x1001b54
L_8ddaf6:
	mov_s r0,0x0
L_8ddaf8:
	bl.d L_8dcc80
L_8ddafc:
	ld_s r3,[r14,0x4]
L_8ddafe:
	add_s r14,r14,0x8
	.global L_8ddb00
L_8ddb00:
	ld_s r0,[r13,0x8]
L_8ddb02:
	brlo r14,r0,L_8ddaee
L_8ddb06:
	b L_8c0254
L_8ddb0a:
	nop_s
