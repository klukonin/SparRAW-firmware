/* fw_mailbox__enqueue_msg @ 0x8c9468, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_mailbox.cpp
 * Зовут его: basic_if__send_msg
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__free
 */
	.section .text.fw_mailbox__enqueue_msg,"ax",@progbits
	.global fw_mailbox__enqueue_msg
fw_mailbox__enqueue_msg:
	.global L_8c9468
L_8c9468:
	push_s blink
L_8c946a:
	bl L_8c02c4
L_8c946e:
	mov_s r14,r0
L_8c9470:
	ld_s r0,[r0,0x14]
L_8c9472:
	mov_s r13,r1
L_8c9474:
	brne r0,0x1,L_8c94c0
L_8c9478:
	breq_s r2,0,L_8c949a
L_8c947a:
	ld_s r0,[r14,0x18]
L_8c947c:
	breq_s r0,0,L_8c9482
	.global L_8c947e
L_8c947e:
	ld_s r1,[r14,0x18]
L_8c9480:
	b_s L_8c9494
	.global L_8c9482
L_8c9482:
	mov_s r0,blink
L_8c9484:
	mov_s r2,0x1001aa0
L_8c948a:
	mov_s r1,0xcd
L_8c948c:
	bl.d L_8c82c0
L_8c9490:
	mov_s r3,0xc4
L_8c9492:
	b_s L_8c947e
	.global L_8c9494
L_8c9494:
	jl_s.d [r1]
L_8c9496:
	mov_s r0,r13
L_8c9498:
	b_s L_8c94c0
	.global L_8c949a
L_8c949a:
	breq_s r3,0,L_8c94b6
L_8c949c:
	ld_s r0,[r14,0x1c]
L_8c949e:
	breq_s r0,0,L_8c94a4
	.global L_8c94a0
L_8c94a0:
	ld_s r1,[r14,0x1c]
L_8c94a2:
	b_s L_8c9494
	.global L_8c94a4
L_8c94a4:
	mov_s r0,blink
L_8c94a6:
	mov_s r2,0x1001aa0
L_8c94ac:
	mov_s r1,0xce
L_8c94ae:
	bl.d L_8c82c0
L_8c94b2:
	mov_s r3,0xc9
L_8c94b4:
	b_s L_8c94a0
	.global L_8c94b6
L_8c94b6:
	sub r1,r13,0x10
L_8c94ba:
	bl.d L_8c9268
L_8c94be:
	ld_s r0,[r14,0x10]
	.global L_8c94c0
L_8c94c0:
	b L_8c0334
