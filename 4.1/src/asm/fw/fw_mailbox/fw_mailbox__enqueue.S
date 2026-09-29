/* fw_mailbox__enqueue @ 0x8c937c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_mailbox.cpp
 * Зовут его: fw_mailbox__write
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, mem_pool__free
 */
	.section .text.fw_mailbox__enqueue,"ax",@progbits
	.global fw_mailbox__enqueue
fw_mailbox__enqueue:
	.global L_8c937c
L_8c937c:
	push_s blink
L_8c937e:
	bl L_8c02c0
L_8c9382:
	ld_s r13,[r1,0x4]
L_8c9384:
	mov_s r14,r0
L_8c9386:
	mov_s r15,r1
L_8c9388:
	breq_s r13,0,L_8c93f0
L_8c938a:
	ld_s r0,[r15]
L_8c938c:
	brne_s r0,0,L_8c93f0
L_8c938e:
	ldw_s r0,[r13,0x6]
L_8c9390:
	bbit0 r0,0x1,L_8c93ba
L_8c9394:
	ld_s r0,[r14,0x18]
L_8c9396:
	add_s r13,r13,0x10
L_8c9398:
	breq_s r0,0,L_8c93a8
	.global L_8c939a
L_8c939a:
	ld_s r1,[r14,0x18]
L_8c939c:
	jl_s.d [r1]
L_8c939e:
	mov_s r0,r13
L_8c93a0:
	ldw_s r0,[r13,0x6]
L_8c93a2:
	bclr_s r0,r0,0x1
L_8c93a4:
	stw_s r0,[r13,0x6]
L_8c93a6:
	b_s L_8c93ec
	.global L_8c93a8
L_8c93a8:
	mov_s r0,blink
L_8c93aa:
	mov_s r2,0x1001aa0
L_8c93b0:
	mov_s r1,0xc8
L_8c93b2:
	bl.d L_8c82c0
L_8c93b6:
	mov_s r3,0x70
L_8c93b8:
	b_s L_8c939a
	.global L_8c93ba
L_8c93ba:
	bbit0 r0,0x2,L_8c93e4
L_8c93be:
	ld_s r0,[r14,0x1c]
L_8c93c0:
	add_s r13,r13,0x10
L_8c93c2:
	breq_s r0,0,L_8c93d2
	.global L_8c93c4
L_8c93c4:
	ld_s r1,[r14,0x1c]
L_8c93c6:
	jl_s.d [r1]
L_8c93c8:
	mov_s r0,r13
L_8c93ca:
	ldw_s r0,[r13,0x6]
L_8c93cc:
	bclr_s r0,r0,0x2
L_8c93ce:
	stw_s r0,[r13,0x6]
L_8c93d0:
	b_s L_8c93ec
	.global L_8c93d2
L_8c93d2:
	mov_s r0,blink
L_8c93d4:
	mov_s r2,0x1001aa0
L_8c93da:
	mov_s r1,0xc9
L_8c93dc:
	bl.d L_8c82c0
L_8c93e0:
	mov_s r3,0x79
L_8c93e2:
	b_s L_8c93c4
	.global L_8c93e4
L_8c93e4:
	ld_s r0,[r14,0x10]
L_8c93e6:
	bl.d L_8c9268
L_8c93ea:
	mov_s r1,r13
	.global L_8c93ec
L_8c93ec:
	mov_s r0,0x0
L_8c93ee:
	st_s r0,[r15,0x4]
	.global L_8c93f0
L_8c93f0:
	b L_8c032c
