/* uc_mailbox__init_rings @ 0x9359b8, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_send_evt__ucode_ready
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_mailbox__ring_reg_addr, uc_ring__init_desc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_mailbox__init_rings
uc_mailbox__init_rings:
	.global L_9359b8
L_9359b8:
	push_s blink
L_9359ba:
	bl L_920234
L_9359be:
	bl L_92a6dc
L_9359c2:
	ld_s r13,[r0,0x24]
L_9359c4:
	ld_s r0,[r13]
L_9359c6:
	breq_s r0,0,L_935a02
L_9359c8:
	add r3,r13,0x10
L_9359cc:
	mov r4,0x0
L_9359d0:
	mov_s r14,0x802470
L_9359d6:
	ld_s r1,[r3]
L_9359d8:
	add r0,r14,0x24
L_9359dc:
	ldw_s r2,[r3,0x6]
L_9359de:
	mov r5,r4
L_9359e2:
	bl.d L_92adf0
L_9359e6:
	mov r6,r4
L_9359ea:
	mov r4,0x0
L_9359ee:
	ld_s r1,[r13]
L_9359f0:
	add_s r0,r14,0x4
L_9359f2:
	ldw_s r2,[r13,0x6]
L_9359f4:
	mov_s r3,r13
L_9359f6:
	mov r5,r4
L_9359fa:
	bl.d L_92adf0
L_9359fe:
	mov r6,r4
	.global L_935a02
L_935a02:
	b L_9202a4
L_935a06:
	nop_s
