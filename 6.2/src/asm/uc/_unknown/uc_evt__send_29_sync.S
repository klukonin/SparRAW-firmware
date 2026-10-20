/* uc_evt__send_29_sync @ 0x9277ac, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dti_worker__scheduled_dti_allocation_event
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, evt_queue__take_locked, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_29_sync
uc_evt__send_29_sync:
	.global L_9277ac
L_9277ac:
	push_s blink
L_9277ae:
	bl L_920230
L_9277b2:
	mov_s r15,r0
L_9277b4:
	mov_s r13,0x802470
L_9277ba:
	bl.d L_920d4c
L_9277be:
	mov_s r0,r13
L_9277c0:
	mov_s r14,r0
L_9277c2:
	ld_s r0,[r15]
L_9277c4:
	mov_s r1,0x29
L_9277c6:
	st_s r0,[r14]
L_9277c8:
	mov_s r0,r14
L_9277ca:
	mov_s r2,0x4
L_9277cc:
	bl.d L_927958
L_9277d0:
	mov_s r3,0x0
L_9277d2:
	mov_s r0,r13
L_9277d4:
	mov_s r1,r14
L_9277d6:
	mov_s r2,0x0
L_9277d8:
	bl.d L_926a3c
L_9277dc:
	mov_s r3,0x0
L_9277de:
	b L_92029c
L_9277e2:
	nop_s
